
function ChatSocket(url) {
	var WS = window['MozWebSocket'] ? MozWebSocket : WebSocket
	var socket = new WS(url)

	function onReceive(e) {
		
		var data = JSON.parse(e.data);
		if(data.error) {
			console.log('disconnected: ' + data.error)
			socket.close();
			return;
		}

		$("#log").prepend("<p>" + "<span>" + data.username + "</span>" + "<span> " + data.message + "</span>" + "</p>")
	
	}

	function onError(e) {
		console.log(e);
	}

	socket.onmessage = onReceive
	socket.onerror = onError
	socket.onclose = onError

	$(function() {
		$('#talk').keyup(function(event) {
			
			if(event.keyCode == 13)
			{
				$('#sendBtn').click()
			}
		})
		
		$('#sendBtn').click(function() {
			var msg = $('#talk').val()
			
			if(msg.charAt(msg.length-1) == '\n')
				msg = msg.substr(0,msg.length-1)
				
			
			if(msg.length == 0 || /^(\s)+$/.test(msg))  {
				$('#talk').val("")
				return
			}
				
			socket.send(JSON.stringify({text: msg}))
			$('#talk').val("")
		})
		
	})
	
	this.socket = socket
}