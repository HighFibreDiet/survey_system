class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.column :choice_id, :integer
      t.column :survey_taker_id, :integer

      t.timestamps
    end

    create_table :survey_takers do |t|
      t.column :survey_id, :integer

      t.timestamps
    end
  end
end
