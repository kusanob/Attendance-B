class ChangeTimeDefaultNew < ActiveRecord::Migration[5.1]
  def change
    change_column_default :users, :basic_time, from: true, to: Time.current.change(hour: 8, min: 0, sec: 0)
    change_column_default :users, :work_time, from: true, to: Time.current.change(hour: 7, min: 30, sec: 0)
  end
end
