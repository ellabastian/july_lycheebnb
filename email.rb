     require 'sendgrid-ruby'
     require 'dotenv/load'
     include SendGrid
     
     class Email
      def initialize()
       from = SendGrid::Email.new(email: ENV['FROM'])
       to = SendGrid::Email.new(email: ENV['TO'])
       subject = ENV['SUBJECT']
       content = SendGrid::Content.new(type: 'text/plain', value: ENV['MESSAGE'])
       mail = SendGrid::Mail.new(from, subject, to, content)

       sg = SendGrid::API.new(api_key: ENV['KEY'])
       response = sg.client.mail._('send').post(request_body: mail.to_json)
     end
    end