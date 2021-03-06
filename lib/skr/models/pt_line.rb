module Skr

    class PtLine < Skr::Model

        acts_as_uom
        is_sku_loc_line parent: 'pick_ticket'

        attr_accessor :qty_to_ship

        belongs_to :pick_ticket, export: true
        belongs_to :sku_loc,     export: true
        belongs_to :so_line

        has_one :inv_line, inverse_of: :pt_line, listen: { save: :update_from_inv_line }
        has_one :sales_order, :through=>:pick_ticket, export: true
        has_one :sku,         :through => :sku_loc, export: true

        scope :picking, ->{ where({ :is_complete=>false }) }

        delegate_and_export_field  :pick_ticket, :visible_id
        delegate_and_export_field  :sales_order, :visible_id

        before_create :set_defaults

        def cancel!
            self.update_attributes! :is_complete=>true
            self.pick_ticket.maybe_cancel
        end

        def is_invoiceable?
            ! self.is_complete? && self.qty_to_ship.to_i > 0
        end

        def total
            self.price * ( self.qty_to_ship || self.qty )
        end

        # Should only be called before saving, once all setting is done.
        # Will be called in a :before_save, but may be called earlier if
        # price or other calculated values are needed
        def set_defaults
            if self.so_line.blank?
                self.so_line = self.pick_ticket.sales_order.lines.where({ sku_loc_id: self.sku_loc_id }).first
            end
            if self.so_line
                self.sku_loc     ||= so_line.sku_loc
                self.bin         ||= sku_loc.bin
                self.price       ||= so_line.price
                self.sku_code    = sku_loc.sku.code
                self.description = so_line.description if self.description.blank?
                self.uom         = so_line.uom         if self.uom.blank?
            end
            true
        end

      private

        def update_from_inv_line( inv_line )
            self.update_attributes( qty_invoiced: inv_line.qty )
        end


    end


end # Skr module
