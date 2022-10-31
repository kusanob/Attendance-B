class RenameMoteToNoteInAttendances < ActiveRecord::Migration[5.1]
  def change
    rename_column :attendances, :mote, :note
  end
end
