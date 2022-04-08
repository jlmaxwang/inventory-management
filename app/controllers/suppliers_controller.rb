class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:show, :update, :destroy, :edit]

  def index
    @suppliers = policy_scope(Supplier)
    @suppliers = Supplier.all
  end

  def show
    authorize @supplier
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.create(supplier_params)
    authorize @supplier
    if @supplier.save
      redirect_to suppliers_path, notice: "供应商已添加"
    else
      render :new
    end
  end

  def edit
    authorize @supplier
  end

  def update
    authorize @supplier
    if @supplier.update(supplier_params)
      redirect_to suppliers_path, notice: "#{@supplier.title}已更新"
    else
      render :edit
    end
  end

  def destroy
    authorize @supplier
    @supplier.destroy
    redirect_to powders_path, notice: '已删除供应商'
  end

  private

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def supplier_params
    params.require(:supplier).permit(:name)
  end
end
