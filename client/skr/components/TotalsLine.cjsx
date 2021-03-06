class Skr.Components.TotalsLine extends Lanes.React.Component

    propTypes:
        model: Lanes.PropTypes.Model.isRequired
        attribute: React.PropTypes.string
        label: React.PropTypes.string


    getDefaultProps: ->
        attribute: 'total', label: 'Total:'

    render: ->
        <BS.Row className='totals'>
            <BS.Col lg=10 sm=9 xs=8 className="text-right">
                {@props.extraInfo}
            </BS.Col>
            <BS.Col xs=1 className="text-right">
                <h4>{@props.label}</h4>
            </BS.Col>
            <BS.Col lg=1 sm=2 xs=3 className="total">
                <h4>
                    <Skr.Components.Currency amount={@model[@props.attribute]} />
                </h4>
            </BS.Col>
        </BS.Row>
