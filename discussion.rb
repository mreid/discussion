require 'sinatra'
require 'sequel'

require 'maruku'
require 'maruku/ext/math'

require 'md5'

# Salt used to scramble the encoding of emails
enable :sessions

configure do
  require 'db/init'

  SALT = "sekret"

  # Switch off MathML output
  MaRuKu::Globals[:html_math_output_mathml] = false
  MaRuKu::Globals[:html_math_engine] = 'none'

  # Turn on math to PNG support with blahtex
  # Resulting PNGs stored in `images/latex`
  MaRuKu::Globals[:html_math_output_png] = true
  MaRuKu::Globals[:html_png_engine] =  'blahtex'
  MaRuKu::Globals[:html_png_dir] = 'public/latex'
  MaRuKu::Globals[:html_png_url] = '/latex/'
end

helpers do
  def encode(email)
    MD5.hexdigest(email + SALT)[8..16]
  end
  
  def markup(text)
    begin
      Maruku.new(text).to_html
    rescue RuntimeError => err
      "Error marking up text: #{err}"
    end
  end
end

# General pages
get '/' do
  erb :index
end

# Session management
get '/login/:key' do
  session[:key] = params[:key]
end

# Papers
load 'lib/paper_routes.rb'