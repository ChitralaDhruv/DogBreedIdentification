//
//  Prediction.swift
//  DogBreedPrediction
//
//  Created by Jarrod Parkes on 6/7/17.
//  Copyright © 2017 Udacity. All rights reserved.
//


struct Prediction {
    
    let category: String
    let probability: Double
    
    
    static func predictionString(predictions: [Prediction]) -> String {
        var s: [String] = []
        for (i, prediction) in predictions.enumerated() {
            s.append(String(format: "%d: %@ (%3.2f%%)", i + 1, prediction.category, prediction.probability * 100))
        }
        return s.joined(separator: "\n\n")
    }
}
