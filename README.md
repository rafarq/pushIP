# pushIP

Get a push notification via PushOver when your computer changes its public IP.

## 1. Why?
Because I have a Raspbery Pi in my home where I have some tools. I want them to be accesible from the internet. I can't use ddns, so, I want to be notified when it changes in my phone.

## 2. What do you need?
* An account on [PushOver.net](http://pushover.net)
* A linux/mac computer
* An android/iOS device with pushover App.
 
## 3. How to make it work
Put all the files on your home directory, in my case it was `/home/pi/`. This is going to be yours if you use a raspberry pi like me.

Make the script executable and the file `currentIP.txt`accesible with the command:

    chmod 777 currentIP.txt script.sh

### 3.1 Edit the script
First of all you have to edit the script file in te repository to match your personal data:
#### 3.1.1 Paths
You have to give the script the path to the currentIP.txt file on lines #14 and #35
Note that the user that runs the script must give write access to the file.

#### 3.1.2 PushOver
Make an account on pushOver and create a new application to hold all the push notifications.
You have to write in the script these:
* token: line #31. Write here the app token
* user: line #32.

Customize the message that you will reicive with the notification on line #33 changing the string `la nueva IP es`for your text.

    --form-string "message=la nueva IP es $IP" \

Now if you fire it with `sh script.sh`it will send you the current IP but we want this to be done by itself when we are not at home so we are going to use **crontab**.

### 4. Automating the script
To make your linux box to check IP changes you can use crontab.
    crontab -e

You get the file where you cron jobs are listed. Add a new line at the end of the file like this:
    */30 * * * * sh /home/pi/script.sh

It will run the `script.sh`at hour:30 minutes and at o'clock hours: 12:00-12:30-13:00-13:30-----and so on.

If the IP changes you will reicive the notification with the new IP, if not it will wait for another 30 minutes.

If you want to know more about crontab to setup another configuration, please refer to: 
* [Explanation 1](http://www.adminschoice.com/crontab-quick-reference)
* [Explanation 2](http://crontab.org)

### 5. Me
I'm [@rafarq](http://twitter.com/rafarq) on twitter. I would appreciate to know about you If you find this script useful for you.
