class MembershipsController < ApplicationController
	before_action :authenticate_user!

    def index
    	binding.pry
    	memberships = Membership.all
    		render json: {memberships: memberships }
    end

	def create
		membership = Membership.new(member_params)
		if membership.save
			render json: {message: 'membership created successfully', membership: membership}, status: :created
		else
			render json: {errors: membership.errors.full_messages}, status: :unprocessable_entity
		end
	end


	private
	def member_params
		params.require(:membership).permit(:user_id, :workspace_id, :role)
	end
end
