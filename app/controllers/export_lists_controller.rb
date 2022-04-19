class ExportListsController < ApplicationController
  before_action :set_export_list, only:[:update, :edit, :destroy]

  def index
    @export_lists = policy_scope(ExportList)
    @export_lists = ExportList.all
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
    @export_lists = ExportList.all
    authorize @export_lists
    @export_lists.each do |item|
      @powder = Powder.find(item.powder_id)
      if @powder.qty_onhand < item.export_qty
        redirect_to export_lists_path, notice: "#{@powder.name}库存不足" and return
      else
        @powder.qty_onhand -= item.export_qty
        @powder.save
        ExportList.find_each(&:destroy)
        redirect_to powders_path, notice: '成功出库'
      end
    end
  end

  private

  def set_export_list
    @export_list = ExportList.find(params[:id])
  end

  def export_list_params
    params.require(:export_list).permit(:powder_id, :export_qty)
  end
end
