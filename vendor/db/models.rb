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
    text        :surname
    text        :firstname
    text        :email
  end
end