class CustomersController < ApplicationController
  before_action :set_supplier, only: [:show, :update, :destroy, :edit]

  def index
    @customers = policy_scope(Customer)
    @customers = Customer.all
  end

  def show
    authorize @customer
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.create(customer_params)
    authorize @customer
    if @customer.save
      redirect_to customers_path, notice: "供应商已添加"
    else
      render :new
    end
  end

  def edit
    authorize @customer
  end

  def update
    authorize @customer
    if @customer.update(customer_params)
      redirect_to customers_path, notice: "#{@customer.title}已更新"
    else
      render :edit
    end
  end

  def destroy
    authorize @customer
    @customer.destroy
    redirect_to powders_path, notice: '已删除供应商'
  end

  private

  def set_customer
    @customer = customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name)
  end
end
