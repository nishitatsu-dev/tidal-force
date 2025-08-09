class RecordTitlesController < ApplicationController
  before_action :authenticate_user!, only: [ :show, :new, :edit ]

  def index
    @record_titles = make_record_titles
  end

  def show
    @record_title = RecordTitle.find(params[:id])
  end

  def new
    @record_title = RecordTitle.new(column_number: params[:column_number])
  end

  def create
    @record_title = RecordTitle.new(record_title_params)
    @record_title.user_id = current_user.id
    if @record_title.save
      redirect_to @record_title, notice: "作成に成功しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @record_title = RecordTitle.find(params[:id])
  end

  def update
    @record_title = RecordTitle.find(params[:id])
    if @record_title.update(record_title_params)
      redirect_to @record_title, notice: "更新に成功しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @record_title = RecordTitle.find(params[:id])
    @record_title.destroy
    redirect_to record_titles_url, notice: "Record was successfully destroyed."
  end

  private
  def record_title_params
    params.require(:record_title).permit(:column_number, :title)
  end
end
