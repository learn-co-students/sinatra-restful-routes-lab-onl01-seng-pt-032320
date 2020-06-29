class ChangeCookTimeDataType < ActiveRecord::Migration
  def change
    change_column :recipes, :cook_time, :integer
  end
end
