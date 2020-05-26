!function(e,n,t,o,r,s,i,a,c,d){var l,u;l=function(e){var n;return n=t.map(e.value,function(e,n){return s.createElement("span",{className:"posting",key:n},e.account_number,s.createElement(o.Currency,{amount:e.amount}))}),s.createElement("div",null,n)},u=function(){function t(){t.__super__.constructor.apply(this,arguments)}return t.prototype.FILE=a,t.prototype.query=new e.Models.Query({title:"Lines",src:n.Models.GlTransaction,syncOptions:{"with":["with_details"]},fields:[{id:"id",visible:!1},{id:"created_at",title:"Date",format:e.u.format.shortDate,fixedWidth:100},{id:"debit_details",title:"Debit",component:l},{id:"credit_details",title:"Credit",component:l},{id:"source_type",fixedWidth:180},{id:"description"}]}),t.prototype.associations={account:{model:"GlAccount"}},t.prototype.events={"change:account":"onAccountChange"},t.prototype.onAccountChange=function(e){var n,t;return n=(null!=(t=this.account)?t.number:void 0)?this.account.number+"%":"",this.query.syncOptions={"with":{with_details:n}},this.query.results.reload()},t}(),n.Models.Base.extend(u),n.Screens.GlTransactions=function(){function e(){}return e.prototype.displayName="Skr.Screens.GlTransactions",e.prototype.FILE=a,e.prototype.modelForAccess="gl-transaction",e.prototype.modelBindings={transactions:function(){return new u({account:this.props.account})}},e.prototype.render=function(){return s.createElement(r.ScreenWrapper,{flexVertical:!0,identifier:"gl-transactions"},s.createElement("h3",null,"GL Transactions"),s.createElement(o.GlAccountChooser,{model:this.transactions,name:"account",editOnly:!0,sm:4}),s.createElement(r.Grid,{query:this.transactions.query}))},e}(),n.Screens.GlTransactions=n.Screens.Base.extend(n.Screens.GlTransactions)}(window.Lanes,window.Lanes?window.Lanes.Skr:null,window.Lanes.Vendor.ld,window.Lanes.Skr.Components,window.Lanes.Components,window.Lanes.Vendor.React,window.Lanes.Vendor.ReactBootstrap,{namespace:window.Lanes.Skr,extension:{name:"Skr",identifier:"skr"},path:["skr","screens","gl-transactions","GlTransactions"]},window);