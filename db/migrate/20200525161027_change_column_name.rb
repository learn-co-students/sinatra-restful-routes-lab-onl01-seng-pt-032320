class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :recipes, :cooktime, :cook_time
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
