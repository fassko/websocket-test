//
//  ViewController.swift
//  WebServerTest
//
//  Created by Kristaps Grinbergs on 23/08/2017.
//  Copyright © 2017 qminder. All rights reserved.
//

import UIKit
import Starscream

class ViewController: UIViewController, WebSocketDelegate, WebSocketPongDelegate {
  
  var socket = WebSocket(url: URL(string: "ws://echo.websocket.org")!)
  
  let queue = DispatchQueue(label: "pingPongQueue")
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    socket.delegate = self
    socket.connect()
  }
  
  func websocketDidConnect(socket: WebSocketClient) {
    print("websocket is connected")
  }
  
  func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
    print("websocket is disconnected: \(String(describing: error))")
  }
  
  func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
    print("got some text: \(text)")
  }
  
  func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
    print("got some text: \(String(describing: String(data: data, encoding: .utf8)))")
  }
  
  func websocketDidReceivePong(socket: WebSocketClient, data: Data?) {
    print("got PONG")
  }
  
  func sendPing() {
    guard socket.isConnected else { return }
    
    socket.write(ping: "PING".data(using: .utf8)!)
  }
}
