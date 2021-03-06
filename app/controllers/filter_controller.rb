class FilterController < ApplicationController
  def create
    @filter = Filter.new(filter_params)
    if @filter.save
      FilterProcessJob.perform_later(@filter)
      notice_message = 'Your filter is being created. Please refresh the page after a while'
      redirect_to dataset_path(filter_params[:dataset_id]), notice: notice_message
    else
      redirect_to dataset_path(filter_params[:dataset_id]), alert: 'Your filter not created'
    end
  end

  private

  def filter_params
    params.require(:filter).permit(:condition, :value, :column_name, :dataset_id)
  end
end
