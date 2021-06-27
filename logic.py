import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import datetime
import smtplib
import requests





def send_mail(subject, content,user, old_time, current_time, choice, requesttime, toaddress, doc_id):
    print("connecting to email server")
    server = smtplib.SMTP('smtp.gmail.com',587)
    server.ehlo()
    server.starttls()
    server.ehlo()
    print("server connected")

    server.login('puramnihal','Nihalpuram2019')
    print("login successful")
    subject = subject
    body = content

    msg = f"Subject:{subject}\n\nYou recieved a message from {user}\n\n{body}"

    server.sendmail("puramnihal@pepisandbox.com",'nihalpuramgiis@gmail.com',msg)
    print("hey message has been sent!")
    server.quit()
    update_data(subject, content,user, old_time, current_time, choice, requesttime, toaddress, doc_id)
    exit()

def update_data(subject, content,user, old_time, current_time, choice, requesttime, toaddress, doc_id):
    doc_ref = db.collection(u'data').document(u'{doc_id}')
    doc_ref.set({
    u'user': user,
    u'time': u'Lovelace',
    u'address': 1815,
    u'subject': subject,
    u'choicet': 1815,
    u'content': content,
})

cred = credentials.Certificate('hackathon2021-d7195-c5d1dca8b35f.json')
firebase_admin.initialize_app(cred)

db = firestore.client()

users_ref = db.collection(u'data')
docs = users_ref.stream()
for doc in docs:
    flag = False
    print(f'{doc.id} => {doc.to_dict()}')
    data = doc.to_dict()

    user = data['user']
    old_time = datetime.datetime.timestamp(data['time'])
    current_time = datetime.datetime.timestamp(datetime.datetime.now())
    subject = data['subject']
    content = data['content']
    choice = data['choice'][0]
    requesttime = data['choice'][1]
    toaddress = data['address']
    doc_id = doc.id

    print (user, old_time, current_time, subject, content, choice, requesttime, toaddress)    

    if (choice == 'second'):
        if (current_time - old_time) > 30 :
            flag = True

    if (choice == 'weekly'):
        if (current_time - old_time) > 604800 :
            flag = True

    if (choice == 'monthly'):
        if (current_time - old_time) > 2592000:
            flag = True

    if (choice == 'yearly'):
        if (current_time - old_time) > 2419200 :
            flag = True

    if (choice == 'daily'):
        if (current_time - old_time) > 67700 :
            flag = True
    

    if flag:
        print('Found the flag')
        send_mail(subject, content,user, old_time, current_time, choice, requesttime, toaddress)
    


