class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.column :name, :string

      t.timestamps
    end

    create_table :questions do |t|
      t.column :survey_id, :integer
      t.column :description, :string

      t.timestamps
    end
  end
end
