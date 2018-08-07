class Api::V1::EventsController < Api::V1::BaseController
  before_action :set_event, only: [ :show, :edit, :update, :destroy ]
  def index
    @events = Event.all
  end

  def show
  end

  def edit
  end

  def update
    if @event.update(event_params)
      render :show
    else
      render_error
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @event.destroy
    head :no_content
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:address, :description, :start_time, :end_time, :capacity, :completed)
  end


  def render_error
    render json: { errors: @event.errors.full_messages },
      status: :unprocessable_entity
  end
end