class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.string :title
      t.text :body
      t.date :worked_on

      t.timestamps
    end
  end
end
