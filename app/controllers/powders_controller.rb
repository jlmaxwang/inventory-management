class PowdersController < ApplicationController
  before_action :set_powder, only:[:show, :select, :update, :edit, :destroy]

  def index
    @powders = policy_scope(Powder)
    if params[:query].present?
      @powders = Powder.search_by_name_and_pin_yin_and_location(params[:query])
    else
      @powders = Powder.order(params[:sort])
    end
    respond_to do |format|
      format.html { render :index }
      format.json { render json: { powders: @powders } }
      format.xls
      format.xlsx { response.headers['Content-Disposition'] = 'attachment; filename="powders.xlsx"' }
    end
  end

  def show
    authorize @powder
  end

  def edit
    authorize @powder
  end

  def update
    authorize @powder
    if @powder.update(powder_params)
      redirect_to powder_path(@powder.id), notice: "已成功更新#{@powder.name}"
    else
      render :edit
    end
  end

  def new
    @powder = Powder.new
    authorize @powder
  end

  def create
    @powder = Powder.new(powder_params)
    authorize @powder
    respond_to do |format|
      if @powder.save
        format.html { redirect_to powder_path(@powder), notice: "已新增#{@powder.name}" }
        format.json { render :show, status: :created, location: @powder }
      else
        format.html { render :new }
        format.json { render json: @powder.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @powder
    @powder.destroy
    redirect_to powders_path, notice: '已删除药品'
  end

  def import
  end

  def import_powder
    if params[:file].nil?
      redirect_to import_powders_path, notice: '请上传文件'
    else
      Powder.import(params[:file])
      redirect_to powders_path, notice: "已成功入库'#{params[:file].original_filename}'"
    end
  end

  def export
    @powders = Powder.all
    @export_list_ids = ExportList.new(params[:powders])
  end

  def export_powder
    if params[:file].nil?
      redirect_to export_powders_path, notice: '请上传文件' and return
    else
      spreadsheet = Powder.open_spreadsheet(params[:file])
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        powder = Powder.find_by_name(row['name'])
          # "未找到#{row['name']}"
        powder.attributes = row.to_hash
        if powder.qty_onhand < powder.qty_export
          redirect_to powders_path, notice: "'#{powder.name}'库存不足" and return
        else
          powder.qty_onhand -= powder.qty_export
          powder.save
        end
      end
      redirect_to powders_path, notice: "成功出库'#{params[:file].original_filename}'"
    end
  end

  private

  def set_powder
    @powder = Powder.find(params[:id])
  end

  def powder_params
    params.require(:powder).permit(:name, :pin_yin, :qty_onhand, :qty_import, :qty_export, :location, :price_retail, :price_bulk, :comment)
  end

end
