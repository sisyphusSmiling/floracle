import LocationMetadataViews from "../contracts/LocationMetadataViews.cdc"

pub fun main(
    latDegrees: Int16,
    latDecimals: UInt16,
    longDegrees: Int16,
    longDecimals: UInt16
): String {
    return LocationMetadataViews.GeographicCoordinates(
        latDegrees: latDegrees,
        latDecimals: latDecimals,
        longDegrees: longDegrees,
        longDecimals: longDecimals
    ).toString()
}
