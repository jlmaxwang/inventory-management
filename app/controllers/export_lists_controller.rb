class ExportListsController < ApplicationController
  before_action :set_export_list, only:[:update, :edit, :destroy]

  def index
    @export_lists = policy_scope(ExportList)
    @export_lists = ExportList.all
    @export_list = ExportList.new
    @powders = Powder.all
  end

  def create
    @export_list = ExportList.new(export_list_params)
    authorize @export_list
    @export_list.save
    redirect_to export_lists_path
  end

  def destroy
    authorize @export_list
    @export_list.destroy
    redirect_back(fallback_location: export_lists_path)
  end

  def edit
    authorize @export_list
  end

  def update
    authorize @export_list
    redirect_to export_lists_path if @export_list.update(export_list_params)
  end

  def run

  end

  private

  def set_export_list
    @export_list = ExportList.find(params[:id])
  end

  def export_list_params
    params.require(:export_list).permit(:powder_id, :export_qty)
  end
end
