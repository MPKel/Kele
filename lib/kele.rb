require 'httparty'

class Kele
  include HTTParty


    def initialize(email, password)
      url  = 'https://www.bloc.io/api/v1/sessions'


      response = self.class.post(url, body: {"email" => email, "password" => password})

      @auth_token = response.parsed_response["auth_token"]


      puts "code: #{response.code} message: #{response.parsed_response["message"]}" unless response.code === 200

    end

end
