import SwiftCLI
import Foundation

let chat = CLI(singleCommand: ChatCommand())
let _ = chat.go()
