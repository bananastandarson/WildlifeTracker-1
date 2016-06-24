class SightingsController < ApplicationController
  before_action :set_sighting, only: [:show, :edit, :update, :destroy]

  # GET /sightings
  # GET /sightings.json
  def index
    regions_for_select
    @sightings = Sighting.all
  end

  # GET /sightings/1
  # GET /sightings/1.json
  def show
    regions_for_select
  end

  # GET /sightings/new
  def new
    regions_for_select
    @sighting = Sighting.new
    @sighting.region = Region.first
  end

  # GET /sightings/1/edit
  def edit
    regions_for_select
  end

  # POST /sightings
  # POST /sightings.json
  def create
    @sighting = Sighting.new(sighting_params)

    respond_to do |format|
      if @sighting.save
        format.html { redirect_to @sighting, notice: 'Sighting was successfully created.' }
        format.json { render :show, status: :created, location: @sighting }
      else
        regions_for_select
        format.html { render :new }
        format.json { render json: @sighting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sightings/1
  # PATCH/PUT /sightings/1.json
  def update
    respond_to do |format|
      if @sighting.update(sighting_params)
        format.html { redirect_to @sighting, notice: 'Sighting was successfully updated.' }
        format.json { render :show, status: :ok, location: @sighting }
      else
        regions_for_select
        format.html { render :edit }
        format.json { render json: @sighting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sightings/1
  # DELETE /sightings/1.json
  def destroy
    @sighting.destroy
    respond_to do |format|
      format.html { redirect_to sightings_url, notice: 'Sighting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_sightings
    @sightings = Sighting.all
    sightings = []
    @sightings.each do |sighting|
      sightings << {
        id: sighting.id,
        title: sighting.animal.name,
        start: convert_datetime(sighting),
        url: Rails.application.routes.url_helpers.sighting_path(sighting.id)
      }
    end
    render :json => sightings.to_json
  end

  def convert_datetime(sighting)
    date = sighting.date
    time = sighting.time
    sighting_datetime = DateTime.new(date.year, date.month, date.day, time.hour, time.min, time.sec, time.zone)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def regions_for_select
      @regions_for_select = Region.all.map do |region|
        [region.name, region.id]
      end
    end

    def set_sighting
      @sighting = Sighting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sighting_params
      params.require(:sighting).permit(:date, :time, :latitude, :longitude, :animal_id, :region_id)
    end
end
