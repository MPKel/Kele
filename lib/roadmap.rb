module Roadmap

  def get_roadmap(roadmap_id)
    url = "https://www.bloc.io/api/v1/roadmaps/#{roadmap_id}"
    response = self.class.get(url, headers: { "content_type" => 'application/json', "authorization" => @auth_token })
    jResponse = JSON.parse(response.to_s)
    puts jResponse
  end

  def get_checkpoint(checkpoint_id)
    url = "https://www.bloc.io/api/v1/checkpoints/#{checkpoint_id}"
    response = self.class.get(url, headers: { "content_type" => 'application/json', "authorization" => @auth_token })
    jResponse = JSON.parse(response.to_s)
    puts jResponse

  end

end
