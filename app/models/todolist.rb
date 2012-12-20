class Todolist < ActiveRecord::Base
  attr_accessible :name, :user_id
  has_many :items
  belongs_to :user
  require 'will_paginate'
  def to_csv
    CSV.generate do |csv|
      csv << column_names
      self.all.collect {|a| csv << t.name.to_s}.flatten
    end
  end


end
