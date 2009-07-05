class Survey < ActiveRecord::Base

  has_many :responses, :dependent => :destroy
  has_many :questions

  acts_as_state_machine :initial => :q10

  state :q10, :after => :present_question  
  state :q20, :after => :present_question
  state :q30, :after => :present_question


  event :next do

  transitions :to => :q20, :from => :q10
  transitions :to => :q30, :from => :q20
  end


  event :previous do
  transitions :to => :q10, :from => :q20
  transitions :to => :q20, :from => :q30
  end

  def present_question
     @present_question ||= find_question(self.present_state)
  end
  
  
  private


  def find_question(state)
     Question.find_by_tag(state.to_s)
  end

end
