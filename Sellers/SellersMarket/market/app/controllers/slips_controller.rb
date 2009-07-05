class SlipsController < ApplicationController
  # GET /slips
  # GET /slips.xml
  def index
    @slips = Slip.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @slips }
    end
  end

  # GET /slips/1
  # GET /slips/1.xml
  def show
    @slip = Slip.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @slip }
    end
  end

  # GET /slips/new
  # GET /slips/new.xml
  def new
    @slip = Slip.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @slip }
    end
  end

  # GET /slips/1/edit
  def edit
    @slip = Slip.find(params[:id])
  end

  # POST /slips
  # POST /slips.xml
  def create
    @slip = Slip.new(params[:slip])

    respond_to do |format|
      if @slip.save
        flash[:notice] = 'Slip was successfully created.'
        format.html { redirect_to(@slip) }
        format.xml  { render :xml => @slip, :status => :created, :location => @slip }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @slip.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /slips/1
  # PUT /slips/1.xml
  def update
    @slip = Slip.find(params[:id])

    respond_to do |format|
      if @slip.update_attributes(params[:slip])
        flash[:notice] = 'Slip was successfully updated.'
        format.html { redirect_to(@slip) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @slip.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /slips/1
  # DELETE /slips/1.xml
  def destroy
    @slip = Slip.find(params[:id])
    @slip.destroy

    respond_to do |format|
      format.html { redirect_to(slips_url) }
      format.xml  { head :ok }
    end
  end
end
