Session.setDefault("currentHash", null)

Meteor.startup ->
  $("body").addClass("loaded")

UI.body.helpers
  fileAnalyseClassName: ->
    "hidden" if Meteor.Router.page() is "home"

UI.body.events
  dragover: (evt) ->
    evt.preventDefault()
  drop: (evt) ->
    evt.preventDefault()
    evt.stopPropagation()

    file = evt.originalEvent.dataTransfer.files[0]
    reader = new FileReader
    reader.onload = (evt) ->
      Meteor.Router.to("/" + CryptoJS.SHA256(evt.target.result).toString())
    reader.readAsBinaryString(file)

Template.analyseHash.date = ->
  date = getDateFromHash(Session.get "currentHash")
  return false unless date?
  year = date.getFullYear()
  if year is new Date().getFullYear() then year = ""
  month = ["January", "February", "March", "April", "May", "June", "July", "August",
           "September", "October", "November", "December"][date.getMonth()]
  hours = date.getHours()
  minutes = date.getMinutes()
  if hours < 10 then hours = "0#{hours}"
  if minutes < 10 then minutes = "0#{minutes}"
  "#{month} #{year} #{date.getDate()} at #{hours}:#{minutes}"

Template.analyseHash.events
  "click .create": ->
    registerHash(Session.get("currentHash"))
    Meteor.Router.to("/done")

Template.thisFile.hash = ->
  Session.get("currentHash")
