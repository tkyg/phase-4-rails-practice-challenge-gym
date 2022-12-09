class MembershipsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  def index
    memberships = Membership.all
    render json: memberships, status: :ok
  end

  def create
    membership = Membership.create!(membership_params)
    render json: membership, status: :accepted
  end

  private

  def membership_params
    params.permit(:gym_id, :client_id, :charge)
  end

  def render_unprocessable_entity(invalid)
    render json:{error: invalid.record.errors}, status: :unprocessable_entity
  end

end
