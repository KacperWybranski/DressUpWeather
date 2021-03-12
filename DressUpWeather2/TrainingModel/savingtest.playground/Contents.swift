import Cocoa

var wholeString: String = "{"

for _ in 0...10000 {
    let temp = Int.random(in: -20...40)
    let weatherOptions = ["Clear", "Clouds", "Rain", "Snow", "Drizzle"]
    var wthr = weatherOptions.randomElement()!
    var top: String
    var hat: String
    var pants: String
    var jacket: String
    
    var i = 0
    var h = 2
    var p = 0
    var j = 0
    var jyesorno = 0
    switch temp {
    case -20...5:
        i = 0
        h = 0
        p = 0
        j = 1
    case 6...15:
        i = 2
        p = 1
        j = 4
    case 16...20:
        i = 3
        p = 4
        j = 6
        jyesorno = 3
    default:
        i = 4
        h = 1
        p = 8
        j = 8
        jyesorno = 8
    }

    if Int.random(in: 0...5) > h {
        hat = "yes"
    } else {
        hat = "no"
    }

    if Int.random(in: 0...5) > i {
        top = "long"
    } else {
        top = "short"
    }

    if Int.random(in: 0...9) > p {
        pants = "long"
    } else {
        pants = "short"
    }

    if Int.random(in: 0...9) > j {
        jacket = "thick"
    } else {
        jacket = "thin"
    }

    if Int.random(in: 0...9) > jyesorno {
        if Int.random(in: 0...9) > j {
            jacket = "thick"
        } else {
            jacket = "thin"
        }
    } else {
        jacket = "no"
    }

    if temp > 5 {
        while wthr == "Snow" {
            wthr = weatherOptions.randomElement()!
        }
    }

    let str = """

        {
            "temperature": \(temp),
            "weather": "\(String(describing: wthr))",
            "rslt": "\(hat) hat, \(top) top, \(pants) pants, \(jacket) jacket"
        },
    """
    
    wholeString.append(str)
}

wholeString.removeLast()
wholeString.append("\n}")

print(wholeString)

let filename = getDocumentsDirectory().appendingPathComponent("output.json")

do {
    try wholeString.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
} catch {
    print("failed to write file")
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
