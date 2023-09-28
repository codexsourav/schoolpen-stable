from flask import Flask, jsonify, render_template, request, redirect, session, url_for,flash
from flask_socketio import SocketIO, emit
from datetime import datetime
from db import add_friend, add_messages, create_user, delete_request, get_friends, get_message, get_messages,messages_collection, get_requests, get_user, get_users, send_request,block_user,is_user_blocked,unblock_user
from flask_pymongo import PyMongo
from bson import ObjectId

app = Flask(__name__)
app.config['SECRET_KEY'] = 'secretkey'
socketio = SocketIO(app)

users = {}

app.config["MONGO_URI"] = "mongodb://localhost:27017/Students"
mongo_s = PyMongo(app)

app.config['MONGO_URI'] = 'mongodb://localhost:27017/Teachers'
mongo_t = PyMongo(app)

app.config['MONGO_URI'] = 'mongodb://localhost:27017/Parents'
mongo_p = PyMongo(app)

# users = {}

#return all user except the sender
# def chatted_with(loggedin_user):
#     recipients = messages_collection.distinct("recipient", {"sender": loggedin_user})
#     senders = messages_collection.distinct("sender", {"recipient": loggedin_user})
#     users_with_previous_chat = list(set(recipients).union(set(senders)))
#     # Retrieve user data from the parent database
#     parent_users_data = mongo_p.db.parent_profile.find({"parent_useridname": {"$in": users_with_previous_chat}})
    
#     # Retrieve user data from the student database
#     student_users_data = mongo_s.db.student_profile.find({"user_id": {"$in": users_with_previous_chat}})
    
#     # Retrieve user data from the teacher database
#     teacher_users_data = mongo_t.db.teacher_profile.find({"profile.useridname_password.userid_name": {"$in": users_with_previous_chat}})
    
#     # Combine the results from all three databases into a single list
#     all_users_data = list(parent_users_data) + list(student_users_data) + list(teacher_users_data)
    
#     return all_users_data


#return all user except the sender
# def chatted_with(loggedin_user):
#     recipients = messages_collection.distinct("recipient", {"sender": loggedin_user})
#     senders = messages_collection.distinct("sender", {"recipient": loggedin_user})
#     users_with_previous_chat = list(set(recipients).union(set(senders)))
#     # Retrieve user data from the parent database
#     parent_users_data = mongo_p.db.parent_profile.find({"parent_useridname": {"$in": users_with_previous_chat}})
    
#     # Retrieve user data from the student database
#     student_users_data = mongo_s.db.student_profile.find({"user_id": {"$in": users_with_previous_chat}})
    
#     # Retrieve user data from the teacher database
#     teacher_users_data = mongo_t.db.teacher_profile.find({"profile.useridname_password.userid_name": {"$in": users_with_previous_chat}})
    
  
#     all_users_data = list(parent_users_data) + list(student_users_data) + list(teacher_users_data)
#     if all_users_data:
#         for user in all_users_data:
#             user['_id'] = str(user['_id'])

#     return all_users_data

#return all user except the sender
def chatted_with(loggedin_user):
    recipients = messages_collection.distinct("recipient", {"sender": loggedin_user})
    senders = messages_collection.distinct("sender", {"recipient": loggedin_user})
    users_with_previous_chat = list(set(recipients).union(set(senders)))
    # Retrieve user data from the parent database
    parent_users_data = mongo_p.db.parent_profile.find({"parent_useridname": {"$in": users_with_previous_chat}})
    
    # Retrieve user data from the student database
    student_users_data = mongo_s.db.student_profile.find({"user_id": {"$in": users_with_previous_chat}})
    
    # Retrieve user data from the teacher database
    teacher_users_data = mongo_t.db.teacher_profile.find({"profile.useridname_password.userid_name": {"$in": users_with_previous_chat}})
    
    # Combine the results from all three databases into a single list
    all_users_data = list(parent_users_data) + list(student_users_data) + list(teacher_users_data)
    if all_users_data:
        for user in all_users_data:
            user['_id'] = str(user['_id'])

    return all_users_data


def pending_users(username): # spidy, batman
    user = mongo_p.db.parent_profile.find_one({"parent_useridname": username})
    if not user:
        user = mongo_t.db.teacher_profile.find_one({"profile.useridname_password.userid_name": username})
    if not user:
        user = mongo_s.db.student_profile.find_one({"user_id": username})

    if user:
        user['_id'] = str(user['_id'])
        return user
    else:
        None


# Modify By Sourev 

@socketio.on('connect')
def get_username():
    print("Users:", users)



@socketio.on('initConnect')
def initConnect(data):
    username = data['sender']
    print(username)
    user = get_user(username)

    if user:
        users[username] = request.sid
        recipient = data['recipient']
        if recipient:
            messages = get_messages(username, recipient)
            print(messages)
            for message in messages:
                message['created_at'] = message['created_at'].isoformat()

            emit('getoldmessage', {"messages": messages})
    else:
        print("not found")
        create_user(username)
        emit('getoldmessage', {"messages": []})



@socketio.on('load_message')
def handle_message_count(data):
    sender = data['sender']
    recipient = data['recipient']
    page = data.get('page', 0)
    try:
        recipient_session_id = users[recipient]
    except:
        print("Recipient is offline!!")
    # data = {page=1,2,3....}

    messages = get_messages(sender, recipient, page)
    emit('new_private_message', messages, room=recipient_session_id)



@socketio.on('private_message')
def private_message(data):
    recipient_session_id = None

    try:
        recipient_session_id = users[data['recipient']]
    except:
        print("Recipient is not online!!")

    message = data['message']
    sender = data['sender']
    recipient = data['recipient']

    # Check if sender has blocked the recipient
    blocked_message = is_user_blocked(sender, recipient)

    if blocked_message:
        print("haaa")
        print(blocked_message)  # Log the blocked message
        if recipient_session_id:
            emit('new_private_message', {"message": f"{sender} has blocked you"}, room=recipient_session_id)
    else:
        # Add code here to block the recipient from sending a message to the sender
        sender_blocked_message = is_user_blocked(recipient, sender)
        
        if sender_blocked_message:
            print("Sender has blocked recipient.")
            # Emit a JSON response indicating that the sender has blocked the recipient
            if recipient_session_id:
                emit('new_private_message', {"message": "Sender has blocked the recipient."}, room=recipient_session_id)
        else:
            # If neither is blocked, proceed with sending the message and storing it
            add_messages(sender, recipient, message)
            print("Message sent.")
            
            new_data = {
                'message': message,
                'recipient': recipient,
                'sender': sender,
                'created_at' : str(datetime.now())
            }
            print("////////////////////////////////")
            print(new_data)
    
            if recipient_session_id:
                emit('new_private_message', new_data, room=recipient_session_id)



@app.route('/<recipient>', methods=['GET', 'POST'])
def home(recipient):
    
    try:
        sender = session['username']
        recipient = recipient

        messages = get_messages(sender, recipient)
        return render_template('index.html', user=sender, recipient=recipient, messages=messages)
    except:
        return redirect(url_for('login'))

@app.route('/login', methods=['GET', 'POST'])
def login():

    if request.method == 'POST':
        username = request.form.get('username')
        print(username)
        user = get_user(username)

        if user:
            session['username'] = username
        else:
            create_user(username)
            session['username'] = username

        return jsonify({"user":username})
        
    return render_template('login.html')

# @app.route('/users/<id>', methods=['GET', 'POST'])
# def connect_to_user(id):
#     print(id)
#     current_user =id
#     users = get_users(str(id))
#     print(users)
#     requests = get_requests(current_user)
#     if not requests:
#         requests = []
#     for user in users:
#         print("YES")
#         print(users)
#         if user in requests:
#             user = str(user)
#             users.remove(user)
#     friends = get_friends(current_user)
#     if not friends:
#         friends = []
#     print("Users:", users)
#     print("Requests:", requests)
#     print("Friends:", friends)
#     return jsonify({
#         "requests":requests,
#         "friends":friends,
#         "users":users,
#     })

@app.route("/last_message/<sender>/<recipient>", methods=['GET', 'POST'])
def last_message_function(sender, recipient):

    messages = get_message(sender, recipient)

    if messages:
        messages['created_at'] = messages['created_at'].isoformat()
        print("MESSAGE:", messages)
        return jsonify(messages)
    else:
        return jsonify({'msg': 'No msg were found!!'})



@app.route('/users/<username>', methods=['GET', 'POST'])
def connect_to_user(username):
    users = chatted_with(username) # users talked to

    print("Users:", users)

    if users:
        return jsonify({"users":users})
    else:
        return jsonify({"users":[]})

# @app.route('/users/<id>', methods=['GET', 'POST'])
# def connect_to_user(id):
#     current_user = id
#     print(id)
#     try:
#         user_list = get_users(current_user)  # Rename the variable to user_list
#         requests = get_requests(current_user)
#         friends = get_friends(current_user)
#         if not requests:
#             requests = []

#         for user in user_list:  # Use the renamed variable here
#             print("YES")
#             if user in requests:
#                 user_list.remove(user)  # Use the renamed variable here

        
#         if not friends:
#             friends = []
#     except Exception as error:  # Catch the exception using "Exception" and assign it to "error"
#         print("error===========================>")
    
        
#     print("Users:", user_list)  # Use the renamed variable here
#     print("Requests:", requests)
#     print("Friends:", friends)

#     try:
#         return jsonify({"newrequests": requests, "allfriends": friends,"users":user_list})
#     except Exception as error:
#         print(error)


    # return render_template('users.html', users=users, requests=requests, friends=friends, current_user=current_user)

@app.route('/send_friend_request/<sendering>/<recipient>', methods=['GET', 'POST'])
def send_friend_request(sendering,recipient):
    sender = sendering
    send_request(sender, recipient)
    return jsonify(res=True)

@app.route('/accept_friend_request/<sendering>/<recipient>', methods=['GET', 'POST'])
def accept_friend_request(sendering,recipient):
    sender = sendering
    add_friend(recipient, sender)
    print(f'{sender} and {recipient} are friends now!')
    return redirect(url_for('connect_to_user'))
    
@app.route('/reject_friend_request/<sendering>/<recipient>', methods=['GET', 'POST'])
def reject_friend_request(sendering,recipient):
    sender = sendering
    delete_request(sender, recipient)
    return redirect(url_for('connect_to_user'))

# @socketio.on('connect')
# def get_username():
#     users[session['username']] = request.sid
#     print("Users:", users)



@socketio.on('private_message2')
def private_message(data):
    recipient_session_id = None

    try:
        recipient_session_id = users[data['username']]
    except:
        print("Recipient is not online!!")

    message = data['message']
    sender = session['username']
    recipient = data['username']

    # Check if sender has blocked the recipient
    blocked_message = is_user_blocked(sender, recipient)

    if blocked_message:
        print("haaa")
        print(blocked_message)  # Log the blocked message
        # Emit a JSON response indicating that the user is blocked
        if recipient_session_id:
            emit('new_private_message', {"message": f"{sender} has blocked you"}, room=recipient_session_id)
    else:
        # Add code here to block the recipient from sending a message to the sender
        sender_blocked_message = is_user_blocked(recipient, sender)
        
        if sender_blocked_message:
            print("Sender has blocked recipient.")
            # Emit a JSON response indicating that the sender has blocked the recipient
            if recipient_session_id:
                emit('new_private_message', {"message": "Sender has blocked the recipient."}, room=recipient_session_id)
        else:
            # If neither is blocked, proceed with sending the message and storing it
            add_messages(sender, recipient, message)
            print("Message sent.")
            
            new_data = {
                'message': message,
                'recipient': recipient,
                'sender': sender
            }

            if recipient_session_id:
                emit('new_private_message', new_data, room=recipient_session_id)







# Update the route to accept both GET and POST requests
@app.route('/block_user/<user>/<recipient>', methods=['GET', 'POST'])
def block_user_route(user,recipient):
    current_user = user
    if current_user:
        block_user(current_user, recipient)
        return jsonify(f'You have blocked {recipient}.', 'success')
    return redirect(url_for('connect_to_user'))


# Route to unblock another user
@app.route('/unblock_user/<user>/<recipient>', methods=['POST'])
def unblock_user_route(user,recipient):
    print(user,recipient)
    current_user = user
    if current_user:
        unblock_user(current_user, recipient)
        return jsonify(f'You have unblocked {recipient}.', 'success')
    else:
        return jsonify("User Not Unblock")

    

if __name__ == '__main__':
    socketio.run(app,host="0.0.0.0",port=7000, debug=True)