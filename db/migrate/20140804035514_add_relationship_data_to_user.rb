class AddRelationshipDataToUser < ActiveRecord::Migration
  def change
    add_column    :users, :met_when, :string
    add_column    :users, :met_how, :string
  end
end
