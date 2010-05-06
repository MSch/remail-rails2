Remail is RESTful email for Rails.

Forget configuring SMTP servers and queues, just use Remail. 
Remail uses Google App Engine to send and receive emails RESTfully.

This gem (remail-rails2) only supports Rails 2.3

Google App Engine gives you a free quota of 2000 emails per day or, with the
paid version, 7,400,000 emails per day.

## Features
* ActionMailer POSTs emails to your Remail App Engine in order to send them
* Remail POSTs received emails back to a configurable URL
* Remail will retry the callback if the endpoint is not available

## Setup
* Configure and deploy the [Remail App Engine](http://github.com/maccman/remail-engine)
* Install the Remail gem (sudo gem install remail-rails2)

## Sending email
  Configure ActionMailer and Remail:
  
    config.action_mailer.delivery_method = :remail
    Remail.app_id  = "remail-appname"
    Remail.api_key = "changeme"
  
  The sender address of a message must be the email address of an administrator for the Remail App Engine.
  If you want to send email on behalf of the application but do not want to use a single administrator's personal Google Account as the sender, you can create a new Google Account for the application using any valid email address, then add the new account as an administrator for the application.
  
## Misc

To ensure your email doesn't get caught in spam filters, you should follow the tips in this tutorial I [wrote](http://madebymany.co.uk/getting-email-around-spam-filters-00221) - the important points being setting SPF and MX records.
