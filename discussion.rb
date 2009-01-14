require 'rubygems'
require 'sinatra'
require 'sequel'

configure do
  require 'vendor/db/init'
end

# General pages
get '/' do
  erb :index
end

get '/about' do
  "I'm running on Sinatra (" + Sinatra::VERSION + ")" +
  " and Sequel"
end

# Papers
get '/papers' do
  @papers = Paper.all
  erb :paper_list
end

get '/paper/:id' do
  key = params[:id]
  paper = Paper[key]
  "Paper #{key} = " + paper.to_s
end

get '/paper/' do
  erb :paper_new
end

put '/paper' do
  paper = Paper.create(:title => params[:title], :abstract => params[:abstract])
  "params = " + paper.to_s
end
