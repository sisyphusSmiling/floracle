import LocationMetadataViews from "../contracts/LocationMetadataViews.cdc"
import WeatherData from "../contracts/WeatherData.cdc"

pub fun main(): String {
  let body = WeatherData.WeatherRequestBody(
    geoCoordinates: LocationMetadataViews.GeographicCoordinates(
      latDegrees: 42,
      latMinutes: 42,
      latHemisphere: "N",
      longDegrees: 42,
      longMinutes: 42,
      longHemisphere: "W"
    ),
    time: getCurrentBlock().timestamp
  )
  return body.toSring()
}