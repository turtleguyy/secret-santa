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
        Member.create(user: current_user, family: @family)

        format.html { redirect_to @family, notice: 'Congrats! You just started a family.' }
        format.json { render :show, status: :created, location: @family }
      else
        format.html { redirect_to new_family_path, alert: 'Whoops, something went wrong. Did you name your family?' }
        format.json { render json: @family.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /families/1
  # PATCH/PUT /families/1.json
  def update
    respond_to do |format|
      if @family.update(family_params)
        format.html { redirect_to @family, notice: 'Family info updated.' }
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

  def assign
    @family = Family.find(params[:family_id])
    @family.members.each do |member|
      next if member.assignment != nil

      member.member = get_random_member member.id
      member.save
    end

    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: 'Yeah! Everyone is Santa now!' }
      format.json { render :show, status: :ok, location: @family }
    end
  end

  def join
    family = Family.find_by code: params[:family][:invitation_code]
    member = Member.find params[:family][:member]
    
    respond_to do |format|
      if family.present? && member.update_attributes(user: current_user)
        format.html { redirect_to dashboard_path, notice: 'Welcome to the family!' }
      else
        format.html { redirect_to family_new_member_path, alert: 'Woes! Are you sure you have the right invitation code?' }
      end
    end
  end

  def new_member
    @family = Family.find params[:family_id]
  end

  private

    def set_code
      family_name  = family_params[:name].parameterize
      @family.code = "#{family_name}-#{@family.id}-#{rand(99999)}"
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

    def get_random_member(id)
      member = @family.unassigned_members.where.not(id: id).all.shuffle.first
      if member.assignment.try(:id) == id
        get_random_member id
      else
        member
      end
    end

end
