class Task < ApplicationRecord
  belongs_to :assignee, class_name: "User", foreign_key: 'assignee_id', optional: true


  validates :title, presence: true, length: {maximum: 50}

  validates :description, presence: true

  validates :due_date, presence: true
  validates :priority, presence: true

  validates :remind_before_at, presence: true


end
