import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import datetime
import smtplib
import requests


def send_mail(subject, content,user, choice, requesttime, toaddress,  doc_id, month, day, date, cc):
    print("connecting to email server")
    server = smtplib.SMTP('smtp.gmail.com',587)
    server.ehlo()
    server.starttls()
    server.ehlo()
    print("server connected")

    server.login('noreplymailmanagerapp@gmail.com','Nihalpuram2019')
    print("login successful")
    subject = subject
    body = content

    msg = f"Subject:{subject}\n\nYou recieved a message from {user}\n\n{body}"

    server.sendmail("noreplymailmanagerapp@gmail.com",'nihalpuramgiis@gmail.com',msg)
    print("hey message has been sent!")
    server.quit()
    update_data(subject, content,user, choice, requesttime, toaddress, doc_id, month, day, date, cc)
    exit()

def update_data(subject, content,user, choice, requesttime, toaddress, doc_id, month, day, date, cc):
    doc_ref = db.collection(u'data').document(doc_id)
    doc_ref.set({
    u'user': user,
    u'time': datetime.datetime.now(),
    u'address': toaddress,
    u'subject': subject,
    u'choice': choice, 
    u'content': content,
    u'status' : True,
    u'month' : month,
    u'day' : day,
    u'date' : date,
    u'cc' : cc,
    u'specific_time' : requesttime,
})  
    print('variables pushed')


cred = credentials.Certificate('hackathon2021-d7195-c5d1dca8b35f.json')
firebase_admin.initialize_app(cred)

db = firestore.client()

users_ref = db.collection(u'data')
docs = users_ref.stream()
for doc in docs:
    flag = False
    print(f'{doc.id}')
    data = doc.to_dict()
    time = datetime.datetime.now()
    print(time)

    user = data['user']
    old_time = datetime.datetime.timestamp(data['time'])
    current_time = datetime.datetime.timestamp(time)
    subject = data['subject']
    content = data['content']
    choice = data['choice']
    toaddress = data['address']
    doc_id = f'{doc.id}'
    status = data['status']
    month = data['month']
    day = data['day']  #monday is 0, sunday is 7
    date = data['date']
    requesttime = data['specific_time']
    cc = data['cc']

    print (user, old_time, current_time, subject, content, choice, requesttime, toaddress, doc_id, status, month, day, date, cc) 

    if status == False:
        flag = True

    if (choice == 'reccurent'):
        if (current_time - old_time) > 30 :
            flag = True

    if (choice == 'weekly'):
        today_day = int(time.weekday())
        if (today_day == day):
            current_hour = int(time.strftime('%H'))
            if (current_hour >= requesttime):
                flag = True

    if (choice == 'monthly'):
        current_date = int(time.strftime('&d'))
        if (current_date == date):
            current_hour = int(time.strftime('%H'))
            if (current_hour >= requesttime):
                flag = True


    if (choice == 'yearly'):
        current_month = int(time.strftime('&m'))
        if (current_month == month):
            current_date = int(time.strftime('&d'))
            if (current_date == date):
                current_hour = int(time.strftime('%H'))
                if (current_hour >= requesttime):
                    flag = True

    
    if flag:
        print('Found the flag')
        send_mail(subject, content,user, choice, requesttime, toaddress, doc_id, month, day, date, cc)
    


