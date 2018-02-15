require 'httparty'
require 'json'
require_relative 'roadmap'

class Kele
  include HTTParty
  include Roadmap
  API_URL = 'https://www.bloc.io/api/v1/'


    def initialize(email, password)
      url  = "#{API_URL}sessions"
      response = self.class.post(url, body: {"email" => email, "password" => password})
      @auth_token = response.parsed_response["auth_token"]

      puts "code: #{response.code} message: #{response.parsed_response["message"]}" unless response.code === 200
    end

    def get_me

      url  = "#{API_URL}users/me"
      response = self.class.get(url, headers: { "authorization" => @auth_token })
      j_response = JSON.parse(response.to_s)

      @mentor_id = j_response["current_enrollment"]["mentor_id"]
      @enrollment_id = j_response["current_enrollment"]["id"]

    end


    def get_mentor_availability(mentor_id = nil)
      mentor_id ||= @mentor_id
      url  = "#{API_URL}mentors/#{mentor_id}/student_availability"
      response = self.class.get(url, headers: { "content_type" => 'application/json', "authorization" => @auth_token })
      j_response = JSON.parse(response.to_s)



    end


    def get_messages(page = nil)
      url  = "#{API_URL}message_threads"
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
      j_response = JSON.parse(response.to_s)

    end

    def create_message (r_id, subject, text )
      url  = "#{API_URL}messages"

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
      j_response = JSON.parse(response.to_s)

    end


    def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment)
      values = {
        headers: { "authorization" => @auth_token },
        body:{
          "checkpoint_id" => checkpoint_id,
          "enrollment_id" => @enrollment_id,
          "assignment_branch" => assignment_branch,
          "assignment_commit_link" => assignment_commit_link,
          "comment" => comment
        }
      }

      url  = "#{API_URL}checkpoint_submissions"
      response = self.class.post(url, values)

      j_response = JSON.parse(response.to_s)

    end


end
