class KittensController < ApplicationController

  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.json { render json: @kittens }
    end
  end

  def show
    @kitten = Kitten.find(params[:id])

    respond_to do |format|
      format.json { render json: @kitten }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def create
    @kitten = Kitten.new(kitten_params)
    if @kitten.save
      flash[:success] = 'You created a kitten! :)'
    else
      flash[:danger] = 'No kitten has been made! :('
      render 'new'
    end
  end

  def update
    @kitten = Kitten.find(params[:id])
    if @kitten.update_attributes(kitten_params)
      flash[:success] = 'Kitten has been updated! ^_^'
      redirect_to @kitten 
    else
      flash[:danger] = 'Kitten has not been updated! -_-'
      render 'edit'
    end 
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy
    flash[:success] = 'No more kitten'
    redirect_to root_path
  end

  private

    def kitten_params
      params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    end
end
