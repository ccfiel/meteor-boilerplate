@DashboardController = AppController.extend(
  waitOn: ->
    @subscribe 'items'
  data: items: @Items.find({})
  onBeforeAction: (pause) ->
    AccountsTemplates.ensureSignedIn.call this, pause
    return
  onAfterAction: ->
    Meta.setTitle 'Dashboard'
    return
)
@DashboardController.events 'click [data-action=doSomething]': (event, template) ->
  event.preventDefault()
  return
