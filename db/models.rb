class Paper < Sequel::Model
  set_schema do
    primary_key :id
    text        :title
    text        :abstract
    foreign_key :author_id
  end
  
  def to_s 
    "Paper[#{id}]: '#{title}'"
  end
end

class Author < Sequel::Model
  set_schema do
    primary_key :id
    text        :email
    text        :surname
    text        :firstname
    text        :description
  end
end

class Comment < Sequel::Model
  set_schema do
    primary_key :id
    text        :email
    text        :content
    foreign_key :paper_id
  end
end

# These record Paper-Email pairs identifying when a email address
# should not received notifications of comments for the given paper.
class Blocks < Sequel::Model
  set_schema do
    primary_key :id
    
  end
end