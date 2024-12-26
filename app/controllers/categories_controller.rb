class CategoriesController < ApplicationController

	def index
    	@tasks = Category.all
    end

	def create
		category = Category.create(category_params)

		if category.save
			render json: {message: "category successfully created", category: category}, status: :ok
		else
			render json: {message: category.errors.full_messages}, status: :unprocessable_entity
		end
	end


	private
	def category_params
		params.require(:category).permit(:name, :description)
	end
end
