class Project < ActiveRecord::Base
  def self.iron_find(id)
    where(id: id).first
  end

  def self.clean_old(too_old = Time.now.midnight - 1.week)
    where("created_at < ?", too_old).destroy_all
  end

  def self.last_created_projects(limit = 10)
    order(created_at: :desc).limit(limit)
  end

  def iron_print
    "Project: #{name} - #{description}"
  end
end
