class CarsController < ApplicationController

  before_action :find_car, only: [:show, :destroy, :edit, :update]

  def index
    @pagy, @cars = pagy(Car.all)
  end

  def destroy
    if @car.destroy
      flash[:notice] = 'Car deleted successfully'
    else
      flash[:notice] = @car.errors.full_messages.join(", ")
    end
    redirect_to cars_path
  end

  def show
  end

  def edit
  end

  def new
    @car = Car.new
  end

  def update
    if @car.update(car_params)
      flash[:notice] = 'Car updated successfully'
      redirect_to car_path(@car)
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream {render turbo_stream: turbo_stream.replace('cars_feedback', partial: 'cars_feedback', locals: { car: @car })}
      end
    end
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      flash[:notice] = 'Car created successfully'
      redirect_to car_path(@car)
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream {render turbo_stream: turbo_stream.replace('cars_feedback', partial: 'cars_feedback', locals: { car: @car })}
      end
    end
  end

  def find_car
    @car = Car.find_by id: params[:id]
    unless @car
      flash[:notice] = "Car not found"
      redirect_to cars_path
    end
  end

  def car_params
    params.require(:car).permit(:brand, :model, :picture, :run, :fuel_consumption)
  end
end
