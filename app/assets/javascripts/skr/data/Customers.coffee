class Skr.Data.Customer extends Skr.Data.Model
    name: 'Customer'
    @include Skr.Data.mixins.HasCodeField

    associations:[
        {
            name : 'billing_address'
            model: 'Address'

        },{
            name  : 'shipping_address'
            model : 'Address'
        }
    ]

class Skr.Data.Customers extends Skr.Data.Collection
    model: Skr.Data.Customer
