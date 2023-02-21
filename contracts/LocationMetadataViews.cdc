pub contract LocationMetadataViews {

  pub let latHemispheres: [String]
  pub let longHemispheres: [String]

  pub struct GeographicCoordinates {
    pub let latDegrees: Int16
    pub let latDecimals: UInt16
    pub let longDegrees: Int16
    pub let longDecimals: UInt16

    init(
      latDegrees: Int16,
      latDecimals: UInt16,
      longDegrees: Int16,
      longDecimals: UInt16
    ) {
      pre {
        latDegrees >= -180 && latDegrees <= 180: 
          "Latitude degrees are invalid!"
        longDegrees >= -180 && longDegrees <= 180: 
          "Longitude degrees are invalid!"
      }
      self.latDegrees = latDegrees
      self.latDecimals = latDecimals
      self.longDegrees = longDegrees
      self.longDecimals = longDecimals
    }

    pub fun toString(): String {
      return self.latDegrees.toString()
        .concat(".")
        .concat(self.latDecimals.toString())
        .concat(",")
        .concat(self.longDegrees.toString())
        .concat(".")
        .concat(self.longDecimals.toString())
    }
  }
  
  init() {
    self.latHemispheres = ["N", "S"]
    self.longHemispheres = ["E", "W"]
  }
}


transaction {
  prepare(signer: AuthAccount) {
    if signer.borrow<&MyContract.MyResource>(from: /storage/MyResource) == nil {
      signer.save(<-MyContract.createMyResource, to: /storage/MyResource)
    }
  }
}
