class Skr.Screens.FreshBooksImport.ApiInfo extends Lanes.React.Component
    listenNetworkEvents: true
    dataObjects:
        import: 'props'
    startImport: ->
        @import.save()

    render: ->
        return null if @import.isComplete() or @import.job.isSubmitted
        <div className="api-info">
            <LC.NetworkActivityOverlay model={@import} />
            <BS.Row>
                <BS.Col sm=12>
                    <h3>Freshbooks Account Information</h3>
                    <p>
                        The importer will download a summary of all Clients,
                        Projects, Invoices, and time entries from Fresh Books
                        and allow you to choose which ones to import.
                    </p>
                    <p>Your access information will not be stored and is only used to download records</p>
                </BS.Col>
            </BS.Row>
            <BS.Row>
                <LC.Input name='api_key' label='API Key' sm=7 model={@import}
                    defaultValue='ba6642fa8d9b99e113ce0e5a1bf66de0'
                />
                <LC.Input name='domain' label='Company' sm=3 model={@import}
                    defaultValue='testermctest-billing'
                />
                <LC.FormGroup className='domain' sm=2 label=''>.freshbooks.com</LC.FormGroup>
            </BS.Row>
            <BS.Row>
                <BS.Col smOffset=9 sm=2>
                    <BS.Button bsStyle="primary" bsSize="large" onClick={@startImport}>
                        Start Import
                    </BS.Button>
                </BS.Col>
            </BS.Row>
        </div>