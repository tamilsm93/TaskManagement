require 'rails_helper'


RSpec.describe Task, type: :model do

	describe 'validations' do
		it 'valid with title and description'  do
			category = create(:category)
			task = Task.new(title: "tamil", description: "welcome to page", category_id: category.id,  due_date: "28.12.2024")
			expect(task).to be_valid
		end

		it 'valid without title and description'  do
			task = Task.new(title: " ", description: "welcome to page", category_id: 2)
			expect(task).not_to be_valid
		end

		# it 'valid with task all fields'  do 
		# 	task = Task.new(title: "welcome dude", description: "hello", due_date: "27.12.2014", priority: 2, category_id: 1, completion_status: false)
		# 	expect(task).to be_valid
		# end
			
	end
end