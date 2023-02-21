pub contract LocationMetadataViews {

  pub let latHemispheres: [String]
  pub let longHemispheres: [String]

  pub struct GeographicCoordinates {
    pub let latDegrees: UInt8
    pub let latMinutes: UInt8
    pub let latHemisphere: String
    pub let longDegrees: UInt8
    pub let longMinutes: UInt8
    pub let longHemisphere: String

    init(
      latDegrees: UInt8,
      latMinutes: UInt8,
      latHemisphere: String,
      longDegrees: UInt8,
      longMinutes: UInt8,
      longHemisphere: String
    ) {
      pre {
        LocationMetadataViews.latHemispheres.contains(latHemisphere) &&
        LocationMetadataViews.longHemispheres.contains(longHemisphere):
          "Hemispheres are invalid!"
        latDegrees <= 180 && longDegrees <= 180: 
          "Latitude & longitude degrees are invalid!"
        latMinutes < 60 && longMinutes < 60:
          "Latitude & longitude minutes are invalid!"
      }
      self.latDegrees = latDegrees
      self.latMinutes = latMinutes
      self.latHemisphere = latHemisphere
      self.longDegrees = longDegrees
      self.longMinutes = longMinutes
      self.longHemisphere = longHemisphere
    }

    pub fun toString(): String {
      return self.latDegrees.toString()
        .concat("˚")
        .concat(self.latMinutes.toString())
        .concat("'")
        .concat(self.latHemisphere)
        .concat(",")
        .concat(self.longDegrees.toString())
        .concat("˚")
        .concat(self.longMinutes.toString())
        .concat("'")
        .concat(self.longHemisphere)
    }
  }
  
  init() {
    self.latHemispheres = ["N", "S"]
    self.longHemispheres = ["E", "W"]
  }
}
