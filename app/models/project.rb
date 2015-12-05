class Project < ActiveRecord::Base
  def self.iron_find(id)
    where(id: id).first
  end

  def iron_print
    "Project: #{name} - #{description}"
  end
end
