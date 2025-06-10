class RecordsController < ApplicationController
  def index
    Time.use_zone(session[:timezone]) do
      db_records = get_db_records(params[:date])
      @records = make_hourly_records(params[:date], db_records)
    end
  end

  def show
    @record = Record.find(params[:id])
  end

  def new
    @record = Record.new(recorded_at: params[:recorded_at])
  end

  def create
    @record = Record.new(record_params)
    @record.user_id = current_user.id
    if @record.save
      redirect_to @record, notice: "作成に成功しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @record = Record.find(params[:id])
  end

  def update
    @record = Record.find(params[:id])
    if @record.update(record_params)
      redirect_to @record, notice: "更新に成功しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @record = Record.find(params[:id])
    date = @record.recorded_at.in_time_zone(session[:timezone]).strftime("%Y-%m-%d")
    @record.destroy
    redirect_to records_url(date: date), notice: "Record was successfully destroyed."
  end

  private
  def record_params
    params.require(:record).permit(:recorded_at, :column_0, :column_1, :column_2, :column_3, :column_4, :column_5, :memo)
  end
end
