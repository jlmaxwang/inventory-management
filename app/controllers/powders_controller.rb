class PowdersController < ApplicationController
  before_action :set_powder, only:[:show, :select, :update, :edit, :destroy, :export]

  def index
    @powders = Powder.all
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
      redirect_to root_path, notice: "已成功更新#{@powder.name}"
    else
      render :edit
    end
  end

  def new
    @powder = Powder.new
  end

  def create
    @powder = Powder.new(powder_params)
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
    @powder.destroy
    redirect_to root_path, notice: "已删除药品"
  end

  def import
    Powder.import(params[:file])
    redirect_to root_path, notice: "已成功入库'#{params[:file].original_filename}'"
  end

  def export
    # 出库
    # Powder.export(params[:file])
    # 选出要出库的货品

    # 规定好格式，download csv
    # respond_to do |format|
    #   format.html
    #   format.csv { send_data @powders.to_csv }
    # end
  end

  def select

  end

  private

  def set_powder
    @powder = Powder.find(params[:id])
  end

  def powder_params
    params.require(:powder).permit(:name, :pinyin, :botanical_name, :qty, :location, :price_retail, :price_bulk, :supplier_id)
  end
end
