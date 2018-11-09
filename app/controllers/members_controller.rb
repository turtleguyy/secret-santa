class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  # GET /members
  # GET /members.json
  def index
    @members = Member.all
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member.family, notice: 'And the family gets that much more crowded.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { redirect_to @member.family }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_members_by_family_code
    code   = params[:member][:invitation_code]
    alert  = ''
    family = Family.new

    if code.present?
      family = Family.find_by code: code
      if family.present?
        if current_user.is_member_of family
          alert = 'You\'re already a member of this family.'
        end
      else
        alert = 'Family not found.'
      end
    else
      alert = 'Invitation code required.'
    end


    respond_to do |format|
      if alert.blank?
        format.html { redirect_to family_new_member_path(family) }
        format.json { render @family }
      else
        @member = Member.new
        format.html { redirect_to new_member_path, alert: alert }
        format.json { render @family }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:name, :user_id, :family_id)
    end
end
