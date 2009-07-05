class ShippingsController < ApplicationController
  # GET /shippings
  # GET /shippings.xml
  def index
    @shippings = Shipping.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shippings }
    end
  end

  # GET /shippings/1
  # GET /shippings/1.xml
  def show
    @shipping = Shipping.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @shipping }
    end
  end

  # GET /shippings/new
  # GET /shippings/new.xml
  def new
    @shipping = Shipping.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @shipping }
    end
  end

  # GET /shippings/1/edit
  def edit
    @shipping = Shipping.find(params[:id])
  end

  # POST /shippings
  # POST /shippings.xml
  def create
    @shipping = Shipping.new(params[:shipping])

    respond_to do |format|
      if @shipping.save
        flash[:notice] = 'Shipping was successfully created.'
        format.html { redirect_to(@shipping) }
        format.xml  { render :xml => @shipping, :status => :created, :location => @shipping }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @shipping.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /shippings/1
  # PUT /shippings/1.xml
  def update
    @shipping = Shipping.find(params[:id])

    respond_to do |format|
      if @shipping.update_attributes(params[:shipping])
        flash[:notice] = 'Shipping was successfully updated.'
        format.html { redirect_to(@shipping) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shipping.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /shippings/1
  # DELETE /shippings/1.xml
  def destroy
    @shipping = Shipping.find(params[:id])
    @shipping.destroy

    respond_to do |format|
      format.html { redirect_to(shippings_url) }
      format.xml  { head :ok }
    end
  end
  
  
  
  # GET /shippings
  # GET /shippings.xml
  def shippingcenter
     @shippings = Shipping.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @shippings }
      end
  
  
  
  end
end
