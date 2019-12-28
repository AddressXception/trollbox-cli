import Foundation
import SwiftCLI
import UB

class ChatCommand: Command {

    static let prompt = ">:"
    let name = "chat"
    var node: ChatNode?

    func execute() throws {

        node = ChatNode()
        waitForInput()
    }

    func waitForInput() {
        let message = Input.readLine(
                prompt: ChatCommand.prompt
        )

        node?.send(message)
        waitForInput()
    }
}
