class CreateResponses < ActiveRecord::Migration
  def self.up
    create_table :responses do |t|
    
      t.string :value
      t.integer :question_id, :survey_id

      t.timestamps
    end
  end

  def self.down
    drop_table :responses
  end
end
