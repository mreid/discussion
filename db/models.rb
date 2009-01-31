
EMAIL_REGEX = /^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$/

class Sequel::Model
  def self.from_params(params)
      clean = {}
      params.each do |key,value|
        keysym = key.to_sym
        clean[keysym] = value if columns.include? keysym
      end
      create(clean)
  end
end

class Paper < Sequel::Model
  one_to_many     :comments
  many_to_many    :authors, :join_table => :authorships

  validates do
    presence_of   :title
  end

  set_schema do
    primary_key   :id
    text          :title
    text          :abstract
  end
end

class Author < Sequel::Model
  many_to_many  :papers, :join_table => :authorships
  
  set_schema do
    primary_key :id
    
    varchar     :email
    varchar     :surname
    varchar     :firstname
    text        :url
    text        :description
  end
end

# Join table for the many-many Author-Paper relationships
class Authorship < Sequel::Model
  many_to_one   :author
  many_to_one   :paper
  
  set_schema do
    primary_key :id
    
    foreign_key :paper_id
    foreign_key :author_id
  end
end

class Comment < Sequel::Model
  many_to_one :paper

  validates do
    format_of   :email, :with => EMAIL_REGEX
    presence_of :content
  end

  set_schema do
    primary_key :id
    
    varchar     :email
    text        :name
    text        :content
    date        :date
    
    foreign_key :paper_id
  end
end

# These record Paper-Email pairs identifying when a email address
# should not received notifications of comments for the given paper.
class Block < Sequel::Model
  many_to_one   :paper
  
  set_schema do
    primary_key :id
    varchar     :email
    foreign_key :paper_id
  end
end