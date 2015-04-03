class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
    t.belongs_to :deck
    t.string :language_one
    t.string :language_two
    t.timestamps null: false
    end
  end
end
