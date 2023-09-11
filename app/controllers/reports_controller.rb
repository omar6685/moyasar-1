class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]
  
  # GET /reports or /reports.json
  def index
    if current_user && current_user.admin?
      @reports = Report.all
    elsif current_user
      @reports = current_user.reports
    else
      @reports = []
    end
  end
  # GET /reports/1 or /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    if current_user && current_user.subscription_status == "paid"
      @report = Report.new
      @users = User.all # Load all users for admin to select from
      @users = current_user.admin? ? User.all : [current_user] # Load all users for admin, current user for regular users

    else
      flash[:alert] = "You must have a paid subscription to create reports."
      redirect_to reports_url
    end
  end
  # GET /reports/1/edit
  def edit
    @users = current_user.admin? ? User.all : [current_user] # Load all users for admin, current user for regular users
  end

  # POST /reports or /reports.json
  def create
    @report = Report.new(report_params)


    if current_user.admin? && params[:report][:user_id].present?
      # Admins can create reports for other users
      @report.user_id = params[:report][:user_id]
    else
      # Regular users can only create reports for themselves
      @report.user_id = current_user.id
    end

    respond_to do |format|
      if @report.save
        format.html { redirect_to report_url(@report), notice: "Report was successfully created." }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1 or /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to report_url(@report), notice: "Report was successfully updated." }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1 or /reports/1.json
  def destroy
    @report.destroy

    respond_to do |format|
      format.html { redirect_to reports_url, notice: "Report was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report = Report.find(params[:id])
    
    # Check if the user has permission to access this report
    unless current_user&.admin? || @report.user == current_user
      flash[:alert] = "You don't have permission to access this report."
      redirect_to reports_url
    end
  end
    # Only allow a list of trusted parameters through.
    def report_params
      params.require(:report).permit(:name, :number, :user_id)
    end
end
