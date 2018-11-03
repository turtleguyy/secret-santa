class FamiliesController < ApplicationController

  before_action :set_family, only: [:show, :edit, :update, :destroy]
  after_action :set_code, only: [:create]

  # GET /families
  # GET /families.json
  def index
    @families = Family.all
  end

  # GET /families/1
  # GET /families/1.json
  def show
  end

  # GET /families/new
  def new
    @family = Family.new
  end

  # GET /families/1/edit
  def edit
  end

  # POST /families
  # POST /families.json
  def create
    @family = Family.new(family_params)
    @family.user = current_user

    respond_to do |format|
      if @family.save
        Relationship.create(user: current_user, family: @family)

        format.html { redirect_to dashboard_path, notice: 'Congrats! You just started a family.' }
        format.json { render :show, status: :created, location: @family }
      else
        format.html { render :new }
        format.json { render json: @family.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /families/1
  # PATCH/PUT /families/1.json
  def update
    respond_to do |format|
      if @family.update(family_params)
        format.html { redirect_to dashboard_path, notice: 'Family info updated.' }
        format.json { render :show, status: :ok, location: @family }
      else
        format.html { render :edit }
        format.json { render json: @family.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /families/1
  # DELETE /families/1.json
  def destroy
    @family.destroy

    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: 'You successfully tore your family apart.' }
      format.json { head :no_content }
    end
  end

  private

    def set_code
      @family.code = "#{family_params[:name].parameterize}-#{@family.id}"
      @family.save
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_family
      @family = Family.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def family_params
      params.require(:family).permit(:name, :event_date)
    end

end
