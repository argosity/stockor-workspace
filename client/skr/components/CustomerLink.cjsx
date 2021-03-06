class Skr.Components.CustomerLink extends Lanes.React.Component
    propTypes:
        onClick: React.PropTypes.func
        customer: React.PropTypes.instanceOf(Skr.Models.Customer)

    onClick: ->
        @props.onClick?()
        @props.customer.withAssociations(['billing_address', 'shipping_address']).then =>
            Lanes.Screens.Definitions.all.get('customer-maint')
                .display(props: {customer: @props.customer})

    render: ->
        <a href='#' onClick={@onClick}>{@props.customer.code}</a>
