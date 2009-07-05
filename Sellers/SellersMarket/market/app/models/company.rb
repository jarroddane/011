class Company < ActiveRecord::Base
  
 # This model belongs to
  
	belongs_to :method_of_billing
	belongs_to :customer
	belongs_to :company_status

	# This model has many

	has_many :jobs, :order => 'date DESC', :dependent => :destroy
	has_many :billable_jobs, :conditions => ['is_billable = ? AND invoice_id IS ? ', true, nil], :class_name => 'Job'
	has_many :invoices, :dependent => :destroy
	
	
	
	# skip the named scopes section for now


	# data validations

	validates_presence_of :name
	validates_numericality_of :method_of_billing_id, :employee_id, :company_status_id, :only_integer => true, :allow_nil => false

	 # delegations

	def_delegator :employee, :name, :employee_name
	def_delegator :employee, :employee_short_name, :name_of_status
	def_delegator :currency, :to => :employee
	
	
	named_scope :active,
	  :order => 'employees.short_name, companies.name', 
	  :conditions => ['company_statuses.is_active = ? ', true],
	  :include => [:employee, :company_status]

  named_scope :billable,
  	:conditions => 'jobs.is_billable = ? AND jobs.slip_id IS ? ', true, nil], 
  	:order => ['employees.short_name, jobs.name',
  	:include => [:jobs, :employee]
  	
  named_scope :all_with_employee,
    :conditions => ['employees.id IS NOT ?', nil], 
    :order => 'lower(employees.name), lower(jobs.name)',
    :include => [:employee]
    
	# accessor methods
	
	
  def employee_and_name
    self.employee.short_name.to_s + ' | ' + self.name.to_s
  end

  def hired_date
    self.jobs.find(:first, :order => 'date ASC').date rescue Date.today
  end

  def fired_date
    self.jobs.find(:first, :order => 'date DESC').date rescue Date.today
  end
	
	
	# calculate time
	
	# percentage calculations of every hour worked for each cycle that are spent at the company
	
	def time_percentage
    (self.total_hours_worked * 100.0 / Job.for_date_range([self.hiring_date, self.firing_date]).sum(:duration).to_f).try(:round) || 0
  end

  #  sum of all of the hours that were worked for the whole company, billings and non-billings
  def total_hours_worked
    self.jobs.sum(:duration).try(:round) || 0
  end

  def working_billable_hours
    self.jobs.sum(:duration, :conditions => ['is_billable = ?', true]).try(:round) || 0
  end

  def hours_worked_and_not_slipped
    self.jobs.sum(:duration, :conditions => ['is_billable = ? AND slip_id IS ?', true, nil]).try(:round) || 0
  end

  def hours_not_worked_yet
    self.estimated_hours ? self.estimated_hours - self.actual_billable_hours : 0
  end

  # calculations for the revenue

  def revenue_estimation
    self.price_quote
  end

  def amount_invoiced
    self.slips.inject(0.0){|sum, slip| sum + slip.cost_sum}
  end
	

end
