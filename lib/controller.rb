require "bundler"
require "gossip"
Bundler.require

class ApplicationController < Sinatra::Base
  get "/" do
    erb :index, locals: { gossips: Gossip.all }
  end

  get "/gossips/new/" do
    erb :new_gossip
  end

  post "/gossips/new/" do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect "/"
  end

  get "/gossip/:id" do
    # matches "GET /hello/foo" and "GET /hello/bar"
    # params['name'] is 'foo' or 'bar'
    puts "Voici le numéro du potin que tu veux : #{params["id"]}!"
    # Gossip.find(params["id"])
    erb :show, locals: { gossip: Gossip.find(params["id"]) }
  end

  post "/gossip/:id" do
    puts "Voici le numéro du potin à commenter : #{params["id"]}!"
    #Gossip.update(params["id"])
    Gossip.comment(params["id"], params["gossip_comment"])
    # erb :edit, locals: { gossip: Gossip.find(params["id"]) }
    # Gossip.update(params["gossip_author"], params["gossip_content"]).save
    redirect "/gossip/#{params["id"]}"
  end

  get "/gossips/:id/edit/" do
    erb :edit
  end

  post "/gossips/:id/edit/" do
    puts "Voici le numéro du potin que tu veux mettre à jour : #{params["id"]}!"
    #Gossip.update(params["id"])
    Gossip.update(params["id"], params["gossip_author"], params["gossip_content"])
    # erb :edit, locals: { gossip: Gossip.find(params["id"]) }
    # Gossip.update(params["gossip_author"], params["gossip_content"]).save
    redirect "/"
  end
  # run! if app_file == $0
end
