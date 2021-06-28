# MAIL MANAGER

We were assigned to work on a mail manager app. We have built an
app which has a signup and login page and also login through google
sync feature . Then we have a compose mail page with textfield for
From ,To, Subject, Body , a send button on the top and a calender
button which on tapping we get a bottom sheet to schedule mail
according to our requirement.
We can schedule mails weekly , monthly , yearly and also we have
set a recurring schedule feature where we can send a mail
recurringly on constant intervals. We also have an option of
deleting the mails sent previously .
We have made this app using flutter , firebase and backend is
done using python and we have attached it for reference.

The backend which is run google's cloud platform using a python instance.

![WhatsApp Image 2021-06-27 at 21 49 26](https://user-images.githubusercontent.com/70462967/123552737-19ed1980-d795-11eb-8f41-4feaa62a7e6f.jpeg =250x)

The above screen is what greets you when you first open the app, it helps us to identify if you are a new or returning customer.

![WhatsApp Image 2021-06-27 at 21 49 24](https://user-images.githubusercontent.com/70462967/123552744-22455480-d795-11eb-9da8-e2b5e4e02662.jpeg)

Just provide your email and password, else you can login in with google.

![WhatsApp Image 2021-06-27 at 21 49 21](https://user-images.githubusercontent.com/70462967/123552748-24a7ae80-d795-11eb-8970-60c6e3cf9c4d.jpeg)

This is your compose screen, it is where you can create new mails. Click on the calender icon to open a bottomscreen containing the options for the mail. You can choose the recurring mail to send an email approximately once every 30 sec. You can also choose the weekly ,monthly or yearly options where you can specify the exact date and time. The initial mail will be sent regardless of future reccurance.  

![WhatsApp Image 2021-06-27 at 21 49 20](https://user-images.githubusercontent.com/70462967/123552750-27a29f00-d795-11eb-8ca9-9f41fcd1ddb6.jpeg)

The mails that you send will be now visible in the home screen. initially it will show that it is waiting. this delay is just for the backend to recognise you email. Within the next few seconds your email will be sent. you can delete you email using the delete icon.

