class CreatePrivateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :private_messages do |t|

      t.timestamps
    end
  end
end
