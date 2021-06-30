import CreateML
import Foundation

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/Kacper/Desktop/output.json"))
let (trainingData, testingData) = data.randomSplit(by: 0.8)

//let classifier = try MLClassifier(trainingData: trainingData, targetColumn: "rslt")
//let classifier2 = try MLBoostedTreeClassifier(trainingData: trainingData, targetColumn: "rslt")
let classifier3 = try MLBoostedTreeClassifier(trainingData: trainingData, targetColumn: "rslt", parameters: .init(maxIterations: 1200))

//let evaluation = classifier3.evaluation(on: testingData)
//print(evaluation)

let classifierMetaData = MLModelMetadata(author: "Kacper Wybranski", shortDescription: "Recommends an outfit according to the current weather", version: "1.0")

try classifier3.write(to: URL(fileURLWithPath: "/Users/Kacper/Desktop/OutfitRecommender.mlmodel"), metadata: classifierMetaData)
