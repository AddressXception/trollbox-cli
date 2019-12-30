import Foundation
import SwiftCLI
import UB

class ChatNode {

    let node: Node

    init() {
        self.node = Node()
        node.delegate = self

        var transport = try! PureSwiftBluetoothTransport()

        node.add(transport: transport)
    }

    func send(_ text: String) {
        guard let encodedText: Data = text.data(using: .utf8) else {
            return
        }

        self.node.send(
                Message(
                        service: UBID(repeating: 1, count: 1),
                        recipient: UBID(repeating: 0, count: 0),
                        from: UBID(repeating: 1, count: 1),
                        origin: UBID(repeating: 1, count: 1),
                        message: encodedText))
    }
}

extension ChatNode: NodeDelegate {
    func node(_: Node, didReceiveMessage message: UB.Message) {
        guard let text = String(data: message.message, encoding: .utf8) else {
            return
        }

        let hex = message.from.hex
        Term.stdout <<< "0x\(hex.prefix(5)): \(text)"
    }
}
