require 'httparty'
require 'json'

class Kele
  include HTTParty
    @auth_token
    @id
    @mentor_id

    def initialize(email, password)
      url  = 'https://www.bloc.io/api/v1/sessions'

      response = self.class.post(url, body: {"email" => email, "password" => password})

      @auth_token = response.parsed_response["auth_token"]


      puts "code: #{response.code} message: #{response.parsed_response["message"]}" unless response.code === 200

    end

    def get_me
      url  = 'https://www.bloc.io/api/v1/users/me'
      response = self.class.get(url, headers: { "authorization" => @auth_token })

      puts response.body
      puts response.parsed_response["first_name"]
      puts response.parsed_response["last_name"]

      #I'm assuming the httparty parsed_response method is the same thing, but if not:
      jResponse = JSON.parse(response.to_s)
      @mentor_id = jResponse["current_enrollment"]["mentor_id"]

    end


    def get_mentor_availability
      url = "https://www.bloc.io/api/v1/mentors#{@mentor_id}/student_availability"
      response = self.class.get(url, headers: { "content_type" => 'application/json', "authorization" => @auth_token })
      puts response.body, response.code, response.message

    end


end
