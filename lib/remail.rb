require "active_resource"

module Remail
  def site=(site)
    Email.site = site
  end
  module_function :site=

  def app_id=(name)
    self.site = "http://#{name}.appspot.com"
  end
  module_function :app_id=

  def api_key=(key)
    Email.headers["Authorization"] = key
  end
  module_function :api_key=

  class Email < ActiveResource::Base
    self.timeout = 5
    self.format  = :json
    self.element_name = "email"

    cattr_accessor :headers
    @@headers = {}

    #schema do
    #  string :sender, :to, :cc, :bcc,
    #         :reply_to, :subject,
    #         :body, :html
    #end

    #validates_presence_of :sender, :to, :subject
    #validates_presence_of :body, :unless => :html?

    # The sender address must be the email address of a
    # registered administrator for the application
    def from=(address)
      self.sender = address
    end
  end
end

begin
  require "action_mailer"
  require 'ruby-debug'
  module ActionMailer
  class Base
    def perform_delivery_remail(mail)
      remail = Remail::Email.new

      %w{to from cc bcc reply_to}.each {|attr|
        value = mail.send(attr)
        next unless value
        remail.send("#{attr}=", value.join(", "))
      }

      remail.subject  = mail.subject

      debugger
      text_body   = select_mail_body(mail, 'text/plain')
      html_body   = select_mail_body(mail, 'text/html')
      remail.body = text_body
      remail.html = html_body
      remail.save
    end
    def select_mail_body(mail, content_type)
      mail.parts.select { |p| p.content_type == content_type }.try(:first).try(:body)
    end
  end
  end
rescue LoadError
end
