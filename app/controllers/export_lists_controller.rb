class ExportListsController < ApplicationController

  def index
    @export_lists = policy_scope(ExportList)
    @export_lists = ExportList.all
    @export_list = ExportList.new
    @powders = Powder.all
  end

  def new
    @export_list = ExportList.new
    authorize @export_list
    @powders = Powder.all
  end


  def create
    @powders = Powder.all
    @export_lists = ExportList.all
    @export_list = ExportList.new(export_list_params)
    authorize @export_list
    respond_to do |format|
      format.html { render :index }
      if @export_list.save
        format.js
      else
        format.html { render :index }
      end
    end
  end
  private

  def export_list_params
    params.require(:export_list).permit(:powder_id, :export_qty)
  end
end
