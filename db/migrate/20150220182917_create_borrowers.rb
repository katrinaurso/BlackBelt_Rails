class CreateBorrowers < ActiveRecord::Migration
  def change
    create_table :borrowers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.integer :money
      t.string :purpose
      t.text :description
      t.integer :raised

      t.timestamps
    end
  end
end
