class Item < ActiveRecord::Base
  attr_accessible :done, :name, :position, :todolist_id
end
