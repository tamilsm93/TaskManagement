class Task < ApplicationRecord
  belongs_to :assignee, class_name: "User", foreign_key: 'assignee_id', optional: true


  validates :title, presence: true, length: {maximum: 50}

  validates :description, presence: true

  validates :due_date, presence: true
  validates :priority, presence: true
  validates :remind_before_at, presence: true
  belongs_to :category

  before_save :set_remind_before_at

  after_save :schedule_remainder_job


  def set_remind_before_at
    self.remind_before_at = due_date - 1.day if due_date.present?
  end

  def schedule_remainder_job
    TaskNotifierJob.set(wait_until: remind_before_at).perform_later(self.id)
  end


end
