class AddUsersCustomCss < ActiveRecord::Migration[6.1]
  def change
    create_table :user_stylesheets do |t|
      t.references :user
      t.text :custom_css
      t.timestamps null: false
    end
  end
end
