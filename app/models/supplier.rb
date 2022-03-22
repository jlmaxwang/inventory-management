class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:show, :update, :destroy, :edit]

  def index
    @suppliers = Supplier.all
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.create(supplier_params)
    if @supplier.save
      redirect_to suppliers_path, notice: "供应商已添加"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @supplier.update(supplier_params)
      redirect_to suppliers_path, notice: "#{@supplier.title}已更新"
    else
      render :edit
    end
  end

  private

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def supplier_params
    params.require(:supplier).permit(:title, :contact_number, :address)
  end
end
