Meteor.startup ->
  alert "This application must be run in a ethereum client,
         not a classical web browser." unless window.eth?

chronosAddress = key.addressOf("edbc86dc2255a043a60812797e6fad14ebc8ba79")

@getDateFromHash = (hash) ->
  timestamp = u256.toValue(eth.storageAt(chronosAddress, u256.fromHex(hash)))
  if timestamp == 0 then null else new Date(timestamp*1000)

@registerHash = (hash) ->
  eth.transact(
    key.secret(eth.keys()[0]),
    u256.ether(0),
    chronosAddress,
    u256.bytesOf(u256.fromHex(hash)),
    u256.value(10000),
    eth.gasPrice()
  )
