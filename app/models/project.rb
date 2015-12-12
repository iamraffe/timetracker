class Project < ActiveRecord::Base
  has_many :entries
  validates :name, presence: true, length: { in: 6..30 }, uniqueness: true, format: { with: /\A[a-zA-Z0-9_ ]*+\z/ }
  validates :description, presence: true, length: { maximum: 140 }

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



  # def find_entries_from(month, year)
  #   # entries.select do |entry|
  #   #   entry.date.month == month && entry.date.year == year
  #   # end
  #   date = Date.new(year,month)
  #   date_range = date.to_s..date.end_of_month.to_s
  #   entries.where(date: date_range)
  # end

  # def sum_up_hours(filtered_entries)
  #   filtered_entries.reduce(0) do |sum, entry|
  #     entry.hours + sum + (entry.minutes/60.0)
  #   end
  # end
  #

  def total_hours_in_month(month, year)
    # filtered_entries = find_entries_from(month, year)
    # sum_up_hours(filtered_entries)
    date = Date.new(year,month)
    # date_range = date.to_s..date.end_of_month.to_s
    filtered_entries = entries.where(date: date.all_month)
    hours = filtered_entries.sum(:hours)
    minutes = filtered_entries.sum(:minutes)
    hours += (minutes/60)
  end
end
