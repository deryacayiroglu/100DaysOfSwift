import UIKit

let name = "Taylor"

for letter in name {
    print("Give me a \(letter)!")
}

//print(name[3]) (We can't read individual letters from the string)
let letter = name[name.index(name.startIndex, offsetBy: 3)]

//After this
extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}
//We can now read name[3]
let letter2 = name[3]
