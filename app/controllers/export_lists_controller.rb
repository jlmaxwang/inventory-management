class ExportListsController < ApplicationController
  before_action :set_export_list, only: [:update, :edit, :destroy]
  before_action :set_export_lists, only: [:index, :export_current_list]
  def index
    @export_lists = policy_scope(ExportList)
    @export_list = ExportList.new
    @powders = Powder.all
    respond_to do |format|
      format.html { render :index }
      format.json { render json: { powders: @powders } }
      format.xls
      format.xlsx { response.headers['Content-Disposition'] = 'attachment; filename="出库单.xlsx"' }
    end
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

  def export_current_list
    authorize @export_lists
    @export_lists.each do |item|
      @powder = Powder.find(item.powder_id)
      if @powder.qty_onhand < item.export_qty; redirect_to export_lists_path, alert: "#{@powder.name}库存不足" and return false
      end

      @powder.qty_onhand -= item.export_qty
      @powder.save
    end
    redirect_to powders_path, notice: '成功出库'
    ExportList.find_each(&:destroy)
  end

  private

  def set_export_lists
    @export_lists = ExportList.all
  end

  def set_export_list
    @export_list = ExportList.find(params[:id])
  end

  def export_list_params
    params.require(:export_list).permit(:powder_id, :export_qty)
  end
end
