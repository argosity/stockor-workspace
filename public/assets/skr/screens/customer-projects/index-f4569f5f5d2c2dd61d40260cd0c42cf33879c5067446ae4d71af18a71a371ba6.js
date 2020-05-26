!function(e,t,o,r,n,s,a,l,i,c){t.Screens.CustomerProjects=function(){function i(){}return i.prototype.displayName="Skr.Screens.CustomerProjects",i.prototype.FILE=l,i.prototype.getInitialState=function(){return{commands:new t.Screens.Commands(this,{modelName:"project"})}},i.prototype.modelBindings={project:function(){return this.loadOrCreateModel({klass:t.Models.CustomerProject,prop:"project",attribute:"code"})}},i.prototype.modelForAccess="customer-project",i.prototype.getHourlyRate=function(){var e;return null!=(e=this.project.rates)?e.hourly:void 0},i.prototype.setHourlyRate=function(e){return this.project.rates=o.extend({},this.project.rates,{hourly:e.replace(/[^0-9.]/g,"")})},i.prototype.ColorOption=function(e){return s.createElement("div",{className:"color-"+e.item.id},e.item.name)},i.prototype.setColor=function(e){return this.project.options=o.extend({},this.project.options,{color:e.id}),this.forceUpdate()},i.prototype.getColorReadOnly=function(){var e,r;return r=this.getColor(),e=o.find(t.Models.CustomerProject.COLORS,{id:r}),s.createElement("div",{className:"ro color-"+r},(null!=e?e.name:void 0)||"")},i.prototype.getColor=function(){var e;return null!=(e=this.project.options)?e.color:void 0},i.prototype.render=function(){return s.createElement(n.ScreenWrapper,{identifier:"customer-projects"},s.createElement(r.ScreenControls,{commands:this.state.commands}),s.createElement(a.Row,null,s.createElement(r.CustomerProjectFinder,{ref:"finder",commands:this.state.commands,model:this.project,autoFocus:!0,editOnly:!0,sm:3}),s.createElement(r.CustomerFinder,{selectField:!0,sm:3,label:"Customer",model:this.project,name:"customer"}),s.createElement(r.SkuFinder,{selectField:!0,sm:3,model:this.project,name:"sku"}),s.createElement(n.Input,{name:"po_num",model:this.project,sm:3})),s.createElement(a.Row,null,s.createElement(n.Input,{sm:2,name:"rates",label:"Hourly Rate",model:this.project,setValue:this.setHourlyRate,getValue:this.getHourlyRate}),s.createElement(n.FieldWrapper,{sm:2,label:"Entry Color",model:this.project,name:"color",className:"color-selection",displayComponent:this.getColorReadOnly},s.createElement(e.Vendor.ReactWidgets.DropdownList,{className:"colors",data:t.Models.CustomerProject.COLORS,valueField:"id",textField:"name",value:this.getColor(),onChange:this.setColor,valueComponent:this.ColorOption,disabled:!this.state.commands.isEditing(),itemComponent:this.ColorOption})),s.createElement(n.Input,{name:"name",model:this.project,sm:8})),s.createElement(a.Row,null,s.createElement(n.Input,{name:"description",model:this.project,sm:12})))},i}(),t.Screens.CustomerProjects=t.Screens.Base.extend(t.Screens.CustomerProjects)}(window.Lanes=window.Lanes||{},window.Lanes?window.Lanes.Skr:null,(window.Lanes.Vendor=window.Lanes.Vendor||{}).ld,window.Lanes.Skr.Components,window.Lanes.Components,window.Lanes.Vendor.React,window.Lanes.Vendor.ReactBootstrap,{namespace:window.Lanes.Skr,extension:{name:"Skr",identifier:"skr"},path:["skr","screens","customer-projects","CustomerProjects"]},window);