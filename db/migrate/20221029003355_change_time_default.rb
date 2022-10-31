class ChangeTimeDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :users, :basic_time, from: "2022-10-28 23:00:00", to: nil
    change_column_default :users, :work_time, from: "2022-10-29", to: nil
  end
end
