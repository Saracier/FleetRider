class TripsController < ApplicationController

  before_action :find_trip, only: [:show, :destroy, :edit, :update]
  def index
    @trips = Trip.all
  end

  def show
  end

  def destroy
    if @trip.destroy
      flash[:notice] = 'Trip deleted successfully'
    else
      flash[:notice] = @trip.errors.full_messages.join(", ")
    end
    redirect_to trips_path
  end

  def edit
  end

  def new
    @trip = Trip.new
  end

  def update
      if @trip.update(trip_params)
        flash[:notice] = 'Trip updated successfully'
        redirect_to trip_path(@trip)
      else
        respond_to do |format|
          format.html { render :new, status: :unprocessable_entity }
          format.turbo_stream {render turbo_stream: turbo_stream.replace('trips_feedback', partial: 'trips_feedback', locals: { trip: @trip })}
        end
      end
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      flash[:notice] = 'Trip created successfully'
      redirect_to trip_path(@trip)
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream {render turbo_stream: turbo_stream.replace('trips_feedback', partial: 'trips_feedback', locals: { trip: @trip })}
      end
    end
  end

  def find_trip
    @trip = Trip.find_by id: params[:id]
    unless @trip
      flash[:notice] = "Trip not found"
      redirect_to trips_path
    end
  end

  def trip_params
    params.require(:trip).permit(:from, :to, :pitstop, :distance, :date_beginning, :date_end, :user_id, :car_id)
  end
end
