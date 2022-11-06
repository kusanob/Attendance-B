class ChangeDataTitleToBasicTime < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :basic_time, :datetime
  end
end
