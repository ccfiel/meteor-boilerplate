@AppController = RouteController.extend(layoutTemplate: 'appLayout')
@AppController.events 'click [data-action=logout]': ->
  AccountsTemplates.logout()
  return
