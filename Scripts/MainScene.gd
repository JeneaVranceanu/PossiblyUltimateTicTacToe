extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_New_Game_button_pressed():
	$HTTPRequest.request("http://localhost:8080/toe")
	connect_to_url("0.0.0.0:8080/chat/tetettsetset", PoolStringArray())
	#Global.start_new_game()
	
var _client = WebSocketClient.new()
var _write_mode = WebSocketPeer.WRITE_MODE_BINARY
var _use_multiplayer = true
var last_connected_client = 0

func _init():
	_client.connect("connection_established", self, "_client_connected")
	_client.connect("connection_error", self, "_client_disconnected")
	_client.connect("connection_closed", self, "_client_disconnected")
	_client.connect("server_close_request", self, "_client_close_request")
	_client.connect("data_received", self, "_client_received")

	_client.connect("peer_packet", self, "_client_received")
	_client.connect("peer_connected", self, "_peer_connected")
	_client.connect("connection_succeeded", self, "_client_connected", ["multiplayer_protocol"])
	_client.connect("connection_failed", self, "_client_disconnected")

func _client_close_request(code, reason):
	Utils._log(self, "Close code: %d, reason: %s" % [code, reason])

func _peer_connected(id):
	Utils._log(self, "%s: Client just connected" % id)
	last_connected_client = id

func _exit_tree():
	_client.disconnect_from_host(1001, "Bye bye!")

func _process(delta):
	if _client.get_connection_status() == WebSocketClient.CONNECTION_DISCONNECTED:
		return

	_client.poll()

func _client_connected(protocol):
	Utils._log(self, "Client just connected with protocol: %s" % protocol)
	_client.get_peer(1).set_write_mode(_write_mode)

func _client_disconnected(clean=true):
	Utils._log(self, "Client just disconnected. Was clean: %s" % clean)

func _client_received(p_id = 1):
	if _use_multiplayer:
		#var peer_id = _client.get_packet_peer()
		var packet = _client.get_peer(p_id).get_packet()
		#Utils._log(self, "MPAPI: From %s Data: %s" % [str(peer_id), Utils.decode_data(packet, false)])
		print(packet.get_string_from_ascii())
		print(packet.get_string_from_utf8())
		print(packet)
		#Utils._log(self, "MPAPI: From %s Data: %s" % packet)
	else:
		var packet = _client.get_peer(1).get_packet()
		var is_string = _client.get_peer(1).was_string_packet()
		Utils._log(self, "Received data. BINARY: %s: %s" % [not is_string, Utils.decode_data(packet, is_string)])

func connect_to_url(host, protocols):
	#_use_multiplayer = multiplayer
	#if _use_multiplayer:
	#	_write_mode = WebSocketPeer.WRITE_MODE_BINARY
	return _client.connect_to_url(host, protocols, false)

func disconnect_from_host():
	_client.disconnect_from_host(1000, "Bye bye!")

func send_data(data, dest):
	_client.get_peer(1).set_write_mode(_write_mode)
	if _use_multiplayer:
		_client.set_target_peer(dest)
		_client.put_packet(Utils.encode_data(data, _write_mode))
	else:
		_client.get_peer(1).put_packet(Utils.encode_data(data, _write_mode))

func set_write_mode(mode):
	_write_mode = mode