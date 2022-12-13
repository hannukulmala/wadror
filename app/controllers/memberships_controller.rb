class MembershipsController < ApplicationController
  before_action :set_membership, only: %i[show edit update destroy]

  # GET /memberships or /memberships.json
  def index
    @memberships = Membership.all
  end

  # GET /memberships/1 or /memberships/1.json
  def show
  end

  # GET /memberships/new
  def new
    @user = current_user
    @valid_beer_clubs = BeerClub.all.reject { |e| @user.beer_club_ids.include?(e.id) }
    @membership = Membership.new
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships or /memberships.json
  def create
    @user = current_user
    @membership = Membership.new(membership_params)
    @membership.user_id = current_user.id
    respond_to do |format|
      if @membership.save
        format.html { redirect_to beer_club_path(@user), notice: "#{@user.username} welcome to the club." }
        format.json { render :show, status: :created, location: @membership }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memberships/1 or /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to membership_url(@membership), notice: "Membership was successfully updated." }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1 or /memberships/1.json
  def destroy
    @user = current_user
    deleted_beer_club_id = (Membership.find_by id: params[:id].to_i).beer_club_id
    deleted_beer_club_name = (BeerClub.find_by id: deleted_beer_club_id).name

    # binding.pry
    @membership.destroy

    respond_to do |format|
      format.html { redirect_to user_path(@user), notice: "Membership in #{deleted_beer_club_name} has ended." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_membership
    @membership = Membership.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def membership_params
    params.require(:membership).permit(:beer_club_id, :user_id)
  end

  private :membership_params
end
