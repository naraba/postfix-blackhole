#!/usr/bin/env python3

import smtplib
from email.mime.text import MIMEText

msg = MIMEText("hello world", "html")
msg["Subject"] = "test mail"
msg["To"] = "recv@example.com"
msg["From"] = "send@example.com"

#with smtplib.SMTP_SSL(host="localhost", port=465) as smtp:
#    smtp.login('user', 'pass')
with smtplib.SMTP(host="127.0.0.1", port=25) as smtp:
    smtp.send_message(msg)
    smtp.quit()

