class GymsController < ApplicationController

  wrap_parameters format: []
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  def index
    render json: Gym.all, status: :ok
  end

  def show
    gym = Gym.find_by(id:params[:id])
    if gym
      render json: gym, status: :ok
    else
      render json: {error: "Gym not found"}, status: :not_found
    end
  end

  def update 
    gym = Gym.find_by(id:params[:id])
    if gym
      gym.update(gym_params)
      render json: gym, status: :accepted
    else
      render json: {error: "Gym not found"}, status: :not_found
    end
  end

  def create
    gym = Gym.create!(gym_params)
    render json: gym, status: :accepted
  end

  def destroy
    gym = Gym.find_by(id: params[:id])
    if gym
      gym.destroy
      head :no_content
    else
      render json: {error: "Gym not found"}, status: :not_found
    end
  end

  private

  def gym_params
    params.permit(:name, :address)
  end

  def render_unprocessable_entity(invalid)
    render json:{error: invalid.record.errors}, status: :unprocessable_entity
  end
end
