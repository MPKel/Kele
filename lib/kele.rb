require 'httparty'
require 'json'
require_relative 'roadmap'

class Kele
  include HTTParty
  include Roadmap


    def initialize(email, password)
      url  = 'https://www.bloc.io/api/v1/sessions'
      response = self.class.post(url, body: {"email" => email, "password" => password})
      @auth_token = response.parsed_response["auth_token"]
      puts "code: #{response.code} message: #{response.parsed_response["message"]}" unless response.code === 200
    end

    def get_me
      url  = 'https://www.bloc.io/api/v1/users/me'
      response = self.class.get(url, headers: { "authorization" => @auth_token })
      jResponse = JSON.parse(response.to_s)
      @mentor_id = jResponse["current_enrollment"]["mentor_id"]
      puts response.body
    end


    def get_mentor_availability(mentor_id = nil)
      mentor_id ||= @mentor_id
      url = "https://www.bloc.io/api/v1/mentors/#{mentor_id}/student_availability"
      response = self.class.get(url, headers: { "content_type" => 'application/json', "authorization" => @auth_token })
      jResponse = JSON.parse(response.to_s)
      @mentor_availability = jResponse

    end


    def get_messages(page = nil)
      url  = 'https://www.bloc.io/api/v1/message_threads'
      page ||= nil
      values = {
        headers: { "authorization" => @auth_token },
        body:{
          "page" => page
        }
      }

      if page
        response = self.class.get(url, values)
      else
        response = self.class.get(url, headers: { "authorization" => @auth_token })
      end
      jResponse = JSON.parse(response.to_s)

    end

    def create_message (r_id, subject, text )
      url = 'https://www.bloc.io/api/v1/messages'

      values = {
        headers: { "authorization" => @auth_token },
        body:{
          "sender" => "mpkelley08@gmail.com",
          "recipient_id" => r_id,
          "subject" => subject,
          "stripped-text" => text
        }
      }

      response = self.class.post(url, values)
      jResponse = JSON.parse(response.to_s)

    end


end
