class window.PersistentWebsocket
  

  constructor: (url) ->
    @WS = if window['MozWebSocket'] then MozWebSocket else WebSocket
    @status = "TRYING"
    @url = url
    @numRetry = 0
    @timestamp = 999
    @scope = "[WS]"

    @connect()

  isConnected:() ->
    @status == "CONNECTED"

  connect: ()=>
    console.info(@scope, "Retrying to connect... ", @numRetry) if @numRetry > 0 
    @socket = new @WS(@url + "?timestamp=#{@timestamp}")
    @socket.onopen = @onOpen
    @socket.onerror = @onError
    @socket.onclose = @onClose


  send: (msg) ->
    @socket.send(msg)

  close: ()->
    @socket.close()

  onReceive: (e) =>
    data = JSON.parse(e.data)
    console.log(@scope, data)

  onOpen: (e) =>
    @status = "CONNECTED"
    @numRetry = 0
    @socket.onmessage = @onReceive
    @socket.onclose = @onClose
    console.info(@scope, "connection established: ", e)

  onClose: (e) =>
    @status = "TRYING"
   
    @socket.onclose = null
    @socket.onopen = null
    @socket.onmessage = null
    @socket.onerror = null

    setTimeout(@connect, Math.pow(2, @numRetry) * 1000)
    @numRetry += 1 if @numRetry < 5
    console.warn(@scope, "connection closed: ", e, "Retrying connection")

  onError: (e) =>
    if @status == "TRYING"
      console.warn(@scope, "cannot establish connnection: ", e)
      #setTimeout(@connect, Math.pow(2, @numRetry) * 1000) 
      #@numRetry += 1 if @numRetry < 5
    else
      console.error(@scope, "chat connection caught error: ", e)