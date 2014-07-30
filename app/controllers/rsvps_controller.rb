class RsvpsController < ApplicationController
  # GET /rsvps
  # GET /rsvps.json
  def index
    @rsvps = Rsvp.all
  end

  # GET /rsvps/new
  def new
    @rsvp = Rsvp.new
  end
  # POST /rsvps
  # POST /rsvps.json
  def create
    @rsvp = Rsvp.new(rsvp_params)

    respond_to do |format|
      if @rsvp.valid? && @rsvp.save!
        format.html { redirect_to root_path, notice: 'Thank you for your RSVP!' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @rsvp.errors, status: :unprocessable_entity }
      end
    end
  end

  def login
    if params[:month].to_i == Date.today.month &&
       params[:day].to_i   == Date.today.day
      redirect_to rsvps_url
    else
      redirect_to root_path
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def rsvp_params
      params['rsvp'].permit(:invited_guest_name, :plus_one_name, :num_beef, :num_chicken, :num_veg, :declined, :notes)
    end
end
