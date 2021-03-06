class CreatePublicSkus < ActiveRecord::Migration[4.2]
    def change
        add_column :skr_skus, :is_public, :boolean, default: 't'
        Skr::Sku.update_all(is_public: true)
        change_column :skr_skus, :is_public, :boolean, :null => false
    end
end
