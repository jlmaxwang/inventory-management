class ExportListsController < ApplicationController

  def index
    @export_lists = policy_scope(ExportList)
    @export_lists = ExportList.all
  end

  def new
    @export_list = ExportList.new
    authorize @export_list
    @powders = Powder.all
  end

  def create
    @export_list = ExportList.new(export_list_params)
    authorize @export_list
    @export_list.save
    redirect_to powders_path
    # if @export_list.save
    #   redirect_to powders_path
    # else
    #   render :new, notice:"没写"
    # end
  end

  private

  def export_list_params
    params.require(:export_list).permit(powder_id: [], export_qty: [])
  end
end
