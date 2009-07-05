class Job < ActiveRecord::Base
 
 # This model belongs to
  
  	  belongs_to :job_type
  	  belongs_to :invoice
  	  belongs_to :person
  	  belongs_to :company


  # This model has many 

  	  has_many :data_entries, :order => 'created_at DESC',  :dependent => :destroy
	  
	# Named Scopes
	
	named_scope :billable, :conditions => ['is_billable = ?', true]
  named_scope :for_date_range, lambda{ |dates| { :conditions => ['date <= ? AND date >= ?', dates.max, dates.min]}}
  named_scope :for_company, lambda{ |company| company ? {:conditions => ['company_id = ?', company.id]} : {}}
  named_scope :most_recent, :order => 'date DESC, updated_at DESC', :limit => 20
  
  # Data Validations
  
  validates_presence_of :person_id
  
  # Delegations
  
  delegate :employee, :to => :company
  def_delegator :company, :employee_and_name, :employee_and_company
  
  # Method Filters 
  
  after_create :record_creation_data_entry
  before_destroy :stop_clocking
 
 
 # This method returns an array with the hours that have been worked for each week in the year, separately for billings and non-billings 
  
  	def self.weekly_hours_getter(year)
  	  hiring_date = Date.new(year).start_of_year
  	  firing_date = Date.new(year).end_of_the_year
  	  present_date = hiring_date.start_of_the_week
  	  present_month = nil
  	  hours_per_week = []

  # Next add a while / if - else conditional to check and make sure that the employee has not been fired( by checking the present date against the fired date)

  	while present_date < firing_date
  	   start_of_the_week = [present_date, hiring_date].max
  	   end_of_the_week = [(present_date.end_of_the_week), firing_date].min
  	   
  # add a label for the month only on the first week of the month
  
  	if present_month != end_of_the_week.month
  	     present_month = end_of_the_week.month
  	   label_for_month = end_of_the_week.strftime('%b')

  	else
  	   label_for_month = ''

  	end
  	
  	billing_hours = Job.sum(:duration, :conditions => ['is_billable = ? AND date BETWEEN ? AND ?', true, start_of_the_week, end_of_the_week])/3600.0

  	non_billing_hours = Job.sum(:Duration, :conditions => ['is_billable = ? AND date BETWEEN ? AND ?', false, start_of_the_week, end_of_the_week])/3600.0

  	hours_per_week << { 
  	    :billable => billing_hours.round,
  	     :non_billable => non_billing_hours.round,
  	    :month => label_for_month 
  	 }
  	 
  	 present_date = start_of_the_week.the_next_week
  	end
  	
  	return hours_per_week
  end
  
  
  
    def self.problems_per_hour_getter(year)
  	   hiring_date = Date.new(year)start_of_year
  	   firing_date = Date.new(year).end_of_the_year
  	   present_date = hiring_date.start_of_the_week
  	   problems_per_week = []

 # Now add the while conditional statement (do this while the present_date is less than the firing_date)

  	while present_date < firing_date
  	  start_of_the_week = [present_date, hiring_date].max
  	  end_of_the_week = [(present_date.the_next_week), firing_date].min
  	  working_hours = Job.sum(:duration, :conditions => ['date BETWEEN ? AND ?', start_of_the_week, end_of_the_week])/3600.0
  	  problems = DataEntry.count(:conditions => ['created_at BETWEEN ? AND ?', start_of_the_week, end_of_the_week])
      problems_per_week << ((problems > 0 && working_hours > 0) ? ((problems / working_hours.to_f).round_to(1)) : -1)
      present_date = end_of_the_week
    end

  	return problems_per_week

   end
   
   	def duration
   	  case value

   # entered in the form as hh:mm  - hours and minutes
   	  when String && /\d*\:\d*/
   	    hours, minutes = value.split(':')
   	    seconds = (hours.to_i.hours + minutes.to_i.minutes)

   # data entered into the form as a decimal value
   	  when String && /\d*\.?\d*/
   	    seconds = (value.to_f * 3600).round

   # number assignment (assumed in seconds)

    	else
   	     seconds = value.to_i
      end

   	write_attribute(:duration, seconds)

   end

   def is_slipped
   	   self.slip_id.not.blank?
   	end

	
  	def data_entry_addition
  	  data_entries << DataEntry.new(
  	    :new_duration => self.duration,
  	    :action => action,
  	    :changes => changes)
  	end
  	
  	
  	  
end
