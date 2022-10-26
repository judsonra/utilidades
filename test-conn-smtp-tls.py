import smtplib
from email.mime.text import MIMEText

SMTPserver = 'smtp.office365.com'
destination = 'login@domain.com'
USERNAME = "login@domain.com"
PASSWORD = "password"


# typical values for text_subtype are plain, html, xml
text_subtype = 'plain'

content="""\
Test message
"""

subject="TEST - teste email"
msg = MIMEText(content, text_subtype)
msg['Subject']=       subject
msg['From']   = USERNAME # some SMTP servers will do this automatically, not all


# initialize connection to our email server, we will use Outlook here
smtp = smtplib.SMTP(SMTPserver, port='587')

smtp.ehlo()  # send the extended hello to our server
smtp.starttls()  # tell server we want to communicate with TLS encryption

smtp.login(USERNAME, PASSWORD)  # login to our email server

# send our email message 'msg' to our boss
smtp.sendmail(USERNAME,
              destination,
              msg.as_string())
              
smtp.quit()  # finally, don't forget to close the connection
