class ReportsController < ApplicationController
  before_action :require_login
  before_action :set_report, only: %i[edit update]

  def index
    @reports = current_user.reports.order(created_at: :desc)
  end

  def new
    @report = current_user.reports.new
  end

  def edit
  end

  def show
    @report = current_user.reports.find(params[:id])
  end

  def create
    @report = current_user.reports.new(report_params)
    if @report.save
      redirect_to reports_path, notice: '日報を登録しました'
    else
      flash.now[:alert] = '登録に失敗しました'
      render :new
    end
  end

  def update
    if @report.update(report_params)
      redirect_to report_path, notice: '日報を更新しました'
    else
      flash.now[:alert] = '更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    redirect_to reports_path, notice: '日報を削除しました'
  end

  private

  def set_report
    @report = current_user.reports.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :body)
  end
end
