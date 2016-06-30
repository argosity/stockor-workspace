require 'lanes/access'
require_relative "model"

# Access control
module Lanes::Access

    # Roles specific to Stockor
    module Roles

        # re-open the exising Support role
        class Support
            read Skr::Invoice,
                 Skr::Customer,
                 Skr::Sku

            grant Skr::SalesOrder,
                  Skr::TimeEntry
        end

        # Accounting role for members who deal with finance
        class Accounting < Lanes::Access::Role
            grant Skr::Customer,
                  Skr::PaymentTerm,
                  Skr::CustomerProject,
                  Skr::Sku,
                  Skr::SalesOrder,
                  Skr::TimeEntry,
                  Skr::GlTransaction,
                  Skr::BankAccount,
                  Skr::Payment

            lock_writes Skr::Customer, :terms
            lock Skr::Sku, :gl_asset_account
            lock Skr::Customer, :gl_receivables_account
        end

        # Purchase (PO's, Vendors)
        class Purchasing < Lanes::Access::Role
            read Skr::Customer
            grant Skr::Sku,
                  Skr::SalesOrder
        end

        # Standard employee role
        class Workforce < Lanes::Access::Role
            read Skr::Customer,
                 Skr::Sku
            grant Skr::SalesOrder,
                  Skr::Invoice,
                  Skr::TimeEntry
        end
    end

    Role.grant_global_access(Skr::Address)
    Role.grant_global_access(:read, Skr::PaymentTerm)

end
