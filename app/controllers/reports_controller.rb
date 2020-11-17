class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  before_action :validates_user, only: [:edit, :update, :destroy]

  def index
    @reports = Report.all.page params[:page]
  end

  def show; end

  def new
    @report = Report.new
  end

  def edit; end

  def create
    @report = Report.new(report_params)
    @report.user_id = current_user.id

    if @report.save
      redirect_to @report, notice: t('notice_create_report')
    else
      render :new
    end
  end

  def update
    if @report.update(report_params)
      redirect_to @report, notice: t('notice_update_report')
    else
      render :edit
    end
  end

  def destroy
    @report.destroy
    redirect_to reports_url, notice: t('notice_destroy_report')
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :body)
  end

  def validates_user
    redirect_to report_comments_path(@report), alert: t('validates_user_alert') if @report.user_id != current_user.id
  end
end
