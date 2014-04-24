Meteor.Router.add
  '/': 'home'
  '/done': 'done'
  '/:hash': (hash) ->
    Session.set "currentHash", hash
    "analyseHash"
