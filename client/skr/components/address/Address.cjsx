class Skr.Components.Address extends Lanes.React.Component

    propTypes:
        model: Lanes.PropTypes.State.isRequired

    renderTitle: ->
        <BS.Row>
            <BS.Col xs=12>
                <h3 className="address-title">{@props.title}</h3>
            </BS.Col>
        </BS.Row>

    render: ->
        colProps = _.omit(@props, 'name')
        colProps.className = _.classnames("address", @props.className)

        <BS.Col {...colProps}>
            {@renderTitle() if @props.title}
            <BS.Row>
                <BS.Col xs=12>
                    <LC.TextField name="name" model={@model} />
                </BS.Col>
            </BS.Row>
            <BS.Row>
                <BS.Col sm=6>
                    <LC.TextField name="phone" model={@model} />
                </BS.Col>
                <BS.Col sm=6>
                    <LC.TextField name="email" model={@model} />
                </BS.Col>
            </BS.Row>
            <BS.Row>
                <BS.Col md=6>
                    <LC.TextField name="line1" model={@model} />
                </BS.Col>
                <BS.Col md=6>
                    <LC.TextField name="line2" model={@model} />
                </BS.Col>
            </BS.Row>
            <BS.Row>
                <BS.Col md=7>
                    <LC.TextField name="city" model={@model} />
                </BS.Col>
                <BS.Col sm=8 md=3>
                    <LC.TextField name="state" model={@model} />
                </BS.Col>
                <BS.Col sm=4 md=2>
                    <LC.TextField name="postal_code" model={@model} />
                </BS.Col>
            </BS.Row>
        </BS.Col>
