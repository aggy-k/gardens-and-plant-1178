class PlantTagsController < ApplicationController
  before_action :set_plant, only: [:new, :create]
  
  def new
    @plant_tag = PlantTag.new
  end

  def create
    puts "params #{params}"
    @plant_tag = PlantTag.new #initializing empty, so it doesn't throw an error when render :new
    array = params[:plant_tag][:tag_id].reject{|x| x.blank?}

    if array.present?
      array.each do |tag_id|
        PlantTag.create!(tag_id: tag_id, plant: @plant)
      end

      redirect_to garden_path(@plant.garden)
    else
      render :new
    end

    # @plant_tag = PlantTag.new(plant_tag_params)
    # @plant_tag.plant = @plant

    # if @plant_tag.save
    #   # dosomething
    #   redirect_to garden_path(@plant.garden)
    # else
    #   puts "errors #{@plant_tag.errors.messages}"
    #   render :new
    # end
  end

  private
    def plant_tag_params
      params.require(:plant_tag).permit(:tag_id)
    end

    def set_plant
      @plant = Plant.find(params[:plant_id])
    end
end
