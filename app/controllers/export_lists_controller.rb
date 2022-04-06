class ExportListsController < ApplicationController
  def new
    @powders = Powder.all
    @export_list = ExportList.new
  end
  def create

  end

end
