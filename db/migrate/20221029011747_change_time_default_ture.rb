class ChangeTimeDefaultTure < ActiveRecord::Migration[5.1]
  def change
    change_column_default :users, :basic_time, from: nil, to:true
    change_column_default :users, :work_time, from: nil, to:true
  end
end
