
module Roadmap
  API_URL = 'https://www.bloc.io/api/v1/'

  def get_roadmap(roadmap_id)
    url  = "#{API_URL}roadmaps/#{roadmap_id}"
    response = self.class.get(url, headers: { "content_type" => 'application/json', "authorization" => @auth_token })
    jResponse = JSON.parse(response.to_s)

  end

  def get_checkpoint(checkpoint_id)
    url  = "#{API_URL}checkpoints/#{checkpoint_id}"
    response = self.class.get(url, headers: { "content_type" => 'application/json', "authorization" => @auth_token })
    jResponse = JSON.parse(response.to_s)

  end

end
