class DataParserController < ApplicationController
  def index
    @gross = 0.0 #FIX ME!
  end

  def new
    @parser = DataParser.new
  end

  def create
    @parser = DataParser.new(params[:data_parser])
    
    if @parser.valid?
      flash[:notice] = "Processed #{@parser.process} rows"
      redirect_to root_path
    else
      render :new
    end
  end
end