class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.references :user
      t.references :project
      t.string :title
      t.text :content
      t.string :status

      t.timestamps
    end
  end
end
