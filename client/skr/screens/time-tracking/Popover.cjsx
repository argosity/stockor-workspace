##= require ./PopoverMiniControls
##= require ./EditEntry

class Skr.Screens.TimeTracking.Popover extends Lanes.React.Component

    componentWillReceiveProps: (nextProps) ->
        if @state.editing
            @onCancel()
        else
            @setState(isCanceled: false)

    onCancel: ->
        if @state.editing?.get('entry').isNew()
            @state.editing.remove()
        @props.entries.stopEditing()
        @setState(isCanceled: true, editing: null)

    onAddEntry: ->
        event = @props.entries.addEvent(@props.date)
        @setState(editing: event)

    onEditEvent: (event) ->
        @setState(editing: event)

    EditEntry: ->
        return null unless @state.editing
        <Skr.Screens.TimeTracking.EditEntry
            event={@state.editing}
            date={@props.date}
            onCancel={@onCancel}
        />

    MiniControls: ->
        return null if @state.editing
        <Skr.Screens.TimeTracking.MiniControls
            date={@props.date}
            event={@props.event}
            onCancel={@onCancel}
            onAddEntry={@onAddEntry}
            onEditEvent={@onEditEvent}
        />

    render: ->
        return null if @state.isCanceled or not @props.date

        classes = _.classnames('edit-control', 'in')
        {x, y} = @props.position
        [width, height] = if @state.editing
            [320, 320]
        else
            [175, 60]

        # expand to show edit button
        width += 60 if @props.event and not @state.editing

        placement = if x > (this.props.bounds.width / 2) then 'left' else 'right'

        x -= width if placement is 'left'

        <BS.Popover className={classes}
            style={{width}}
            id='edit-controls'
            placement={placement}
            positionLeft={x}
            positionTop={y - (height / 2)}
        >
            <@MiniControls />
            <@EditEntry />
        </BS.Popover>