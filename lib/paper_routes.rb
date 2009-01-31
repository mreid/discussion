get '/papers' do
  @papers = Paper.all
  erb :paper_list
end

get '/paper/:num' do
  paper = Paper[ params[:num] ]
  erb :paper, :locals => { :paper => paper }
end

put '/paper/:num/comment' do
  paper = Paper[params[:num]]
  
  begin
    comment = Comment.from_params( params )
    paper.add_comment(comment)
  rescue Sequel::ValidationFailed => err
    session[:err] = err.to_s
  end

  redirect "/paper/#{params[:num]}"
end

get '/paper/' do
  erb :paper_new
end

put '/paper' do
  paper = Paper.from_params( params )

  redirect "/paper/#{paper.id}"  
end
