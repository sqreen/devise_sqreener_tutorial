class DeviseSqreenerAddToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :sqreened_email, :text
    if User.devise_modules.include?(:trackable)
      add_column :users, :current_sqreened_sign_in_ip, :text
      add_column :users, :last_sqreened_sign_in_ip, :text
    end
  end
end
