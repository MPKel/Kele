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






end
