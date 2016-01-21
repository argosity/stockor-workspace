class TimeEntries extends Skr.Models.TimeEntry.Collection

    constructor: (@projects) ->
        super()

    projectForEntry: (entry) ->
        @projects.get( entry.customer_project_id )

    load: (range, query = {}) ->
        query.end_at    = { op: 'gt', value: range.start.toISOString() }
        query.start_at  = { op: 'lt', value: range.end.toISOString() }
        @fetch({query})

    reset: (projectId, range) ->
        @projectId = projectId
        query = if @projectId and @projectId isnt -1
            {customer_project_id: @projectId}
        else {}
        @load(range, query)

class Skr.Screens.TimeTracking.Entries extends Lanes.Models.Base

    session:
        date:    { type: 'object', 'required': true, default: -> _.moment() }
        display: { type: 'string', values: ['day', 'week', 'month'], default: 'week' }
        isLoading: { type: 'boolean', default: false }
        customer_project_id: 'integer'

    derived:
        project:
            deps: ['customer_project_id'], fn: ->
                @available_projects.get(@customer_project_id)
        isMonth:
            deps: ['display'], fn: -> 'month' == @display
        range:
            deps: ['date', 'isMonth'], fn: ->
                _.moment.range(
                    @date.clone().startOf( @display ), @date.clone().endOf( @display )
                )

        calLegend:
            deps: ['range', 'display'], fn: ->
                if @display is 'month'
                    @date.format('MMMM YYYY')
                else if @display is 'week'
                    "#{@range.start.format('MMM Do')} - #{@range.end.format('MMM Do')}"
                else if @display is 'day'
                    @date.format('MMMM Do YYYY')

    events:
        'change:range': 'fetchEvents'
        'change:customer_project_id': 'fetchEvents'

    constructor: ->
        super
        @available_projects = Skr.Models.CustomerProject.Collection
            .fetch().whenLoaded (cp) =>
                cp.add({id:-1, code: 'ALL', options:{color: 1}}, at: 0)
                @set(customer_project_id: Lanes.current_user.options.project_id or -1 )
        @entries = new TimeEntries(@available_projects)
        @listenTo(@entries, 'request', @onRequest)
        @listenTo(@entries, 'sync', @onLoad)

    startEditing: (editingEvent) ->
        for event in @calEvents().events
            event.set(editing: (event is editingEvent))

    add: (attrs) ->
        attrs.customer_project = @project unless @project.id is -1
        @entries.add(attrs)

    onRequest: ->
        @isLoading = !!@entries.requestInProgress
        @trigger('change', @)

    onLoad: ->
        delete @_cachedEvents unless @entries.requestInProgress
        @isLoading = !!@entries.requestInProgress
        @trigger('change', @)

    reset: ->
        @entries.load(@range)

    fetchEvents: ->
        @entries.reset(@customer_project_id, @range)

    calEvents: ->
        @_cachedEvents ||= new LC.Calendar.Events( @entries.invoke('toCalEvent') )

    back: ->
        @date = @date.clone().subtract(1, @display)
        @trigger('change', @)

    forward: ->
        @date = @date.clone().add(1, @display)
        @trigger('change', @)

    totalHours: ->
        @entries.reduce( (sum, entry) =>
            sum.add( entry.lengthInRange(@range, 'hours') )
        , _.bigDecimal('0') )

    totalsForWeek: (week) ->
        days = _.moment.range(
            @range.start.clone().add(week - 1, 'week'),
            @range.start.clone().add(week, 'week')
        )
        entries = @entries.filter (entry) -> days.overlaps( entry.range )
        byProject = _.groupBy entries, (entry) -> entry.customer_project_id
        _.mapValues byProject, (entries, projectId) ->
            _.reduce( entries, (total, entry) ->
                total.plus(entry.lengthInRange(days, 'hours'))
            , _.bigDecimal('0'))
