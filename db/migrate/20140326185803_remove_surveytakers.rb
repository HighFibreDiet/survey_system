class RemoveSurveytakers < ActiveRecord::Migration
  def change
    drop_table :survey_takers
  end
    remove_column :responses, :survey_taker_id
end
