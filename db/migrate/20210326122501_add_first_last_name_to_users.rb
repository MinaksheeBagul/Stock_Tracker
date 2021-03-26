class AddFirstLastNameToUsers < ActiveRecord::Migration[6.1]
  def change
    # first will be table name i.e users & type:string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
