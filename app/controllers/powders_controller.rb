class PowdersController < ApplicationController
  before_action :set_powder, only:[:show, :select, :update, :edit, :destroy]

  def index
    @powders = Powder.all
    @powders = policy_scope(Powder)
    respond_to do |format|
      format.xls
      format.xlsx { response.headers['Content-Disposition'] = 'attachment; filename="powders.xlsx"' }
      format.html { render :index }
    end
  end

  def show
  end

  def edit
  end

  def update
    if @powder.update(powder_params)
      redirect_to powders_path, notice: "已成功更新#{@powder.name}"
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
  end

  def export_powder
    if params[:file].nil?
      redirect_to export_powders_path, notice: '请上传文件'
    else
      spreadsheet = Powder.open_spreadsheet(params[:file])
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        powder = Powder.find_by_name(row['name'])
        powder.attributes = row.to_hash
        if powder.qty_onhand < powder.qty_export
          break redirect_to powders_path, notice: 'kucunbuzu'
        else
          powder.qty_onhand -= powder.qty_export
          powder.save
        end
      end
    end
    redirect_to powders_path
  end

  # def spreadsheet
  #   spreadsheet = Powder.open_spreadsheet(params[:file])
  #   header = spreadsheet.row(1)
  #   (2..spreadsheet.last_row).each do |i|
  #     row = Hash[[header, spreadsheet.row(i)].transpose]
  #     @powder = Powder.find_by_name(row['name'])
  #     @powder.attributes = row.to_hash
  #   end
  # end

  def select
  end

  private

  def set_powder
    @powder = Powder.find(params[:id])
  end

  def powder_params
    params.require(:powder).permit(:name, :pinyin, :botanical_name, :qty_init, :qty_import, :qty_export, :location, :price_retail, :price_bulk, :qty_onhand)
  end
end
