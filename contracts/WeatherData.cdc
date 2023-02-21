import IFloracle from "./IFloracle.cdc"
import LocationMetadataViews from "./LocationMetadataViews.cdc"

pub contract WeatherData : IFloracle {

  pub let requestBodySeparator: String

  pub let RequestorStoragePath: StoragePath
  pub let OracleStoragePath: StoragePath
  pub let OraclePublicPath: PublicPath
  pub let RequestorPrivatePath: PrivatePath

  pub event RequestMade(requestorID: UInt64, requestID: UInt64, requestBodyType: Type, requestBodyUTF8: [UInt8])
  pub event RequestFulfilled(requestorID: UInt64, requestID: UInt64, statusRawValue: UInt8)

  pub enum Status: UInt8 {
    pub case SENT
    pub case OK
    pub case BAD_REQUEST
  }

  // Payload for WeatherData related requests
  // TODO: Generalize for other types of request payloads
  pub struct WeatherLocationRequestBody : IFloracle.RequestBody {
    // pub let city: String
    // pub let country: String
    pub let geoCoordinates: LocationMetadataViews.GeographicCoordinates
    pub let time: UInt64

    init(
      geoCoordinates: LocationMetadataViews.GeographicCoordinates,
      time: UInt64
    ) {
      // self.city = city
      // self.country = country
      self.geoCoordinates = geoCoordinates
      self.time = time
    }

    pub fun toString(): String {
      // return self.city
      //   .concat(WeatherData.requestBodySeparator)
      //   .concat(self.country)
      //   .concat(WeatherData.requestBodySeparator)
      //   .concat(self.time.toString())
      return self.geoCoordinates.toString()
        .concat(WeatherData.requestBodySeparator)
        .concat(self.time.toString())
    }

    pub fun toUTF8(): [UInt8] {
      return self.toString().utf8
    }
  }

  pub struct WeatherLocationResponseBody: IFloracle.ResponseBody {
    pub let temperature: UInt8
    pub let humidity: UInt8
    pub let precipitation: UInt8
    pub let wind: UInt8
    // pub fun toString(): String {

    // }
  }

  // Struct representing a weather data request
  pub struct WeatherRequest : IFloracle.Request {
    pub let requestorID: UInt64
    pub let requestID: UInt64
    pub let body: AnyStruct{IFloracle.RequestBody}
    pub var status: IFloracle.Status

    init(
      requestorID: UInt64,
      requestID: UInt64,
      body: AnyStruct{IFloracle.RequestBody}
    ) {
      self.requestorID = requestorID
      self.requestID = requestID
      self.body = body
      self.status = WeatherData.Status.SENT
    }
  }

  pub struct WeatherResponse : IFloracle.Response {
    pub let requestorID: UInt64
    pub let requestID: UInt64
    pub let body: AnyStruct{IFloracle.ResponseBody}
    pub var status: IFloracle.Status

    init(
      requestorID: UInt64,
      requestID: UInt64,
      body: AnyStruct{IFloracle.ResponseBody},
      status: WeatherData.Status
    ) {
      self.requestorID = requestorID
      self.requestID = requestID
      self.body = body
      self.status = WeatherData.Status.SENT
    }
  }

  pub resource WeatherRequestor : IFloracle.Requestor, IFloracle.Medium {
    pub let id: UInt64
    pub var requestCounter: UInt64
    pub let responses: {UInt64: AnyStruct{IFloracle.Response}}
    pub let badRequests: [UInt64]

    init() {
      self.id = self.uuid
      self.requestCounter = 0
      self.responses = {}
      self.badRequests = []
    }

    /* Requestor */
    pub fun makeRequest(request: AnyStruct{IFloracle.Request}) {
      // TODO
      emit RequestMade(
        requestorID: self.id,
        requestID: self.requestCounter,
        requestBodyType: request.body.getType(),
        requestBodyUTF8: request.body.toUTF8()
      )
      self.requestCounter = self.requestCounter + 1
    }

    /* Medium */
    // Need way to let Oracle provide response data & store response
    access(contract) fun provideResponse(_ response: AnyStruct{IFloracle.Response}) {
      // TODO
    }
  }

  pub resource WeatherOracle : IFloracle.Oracle, IFloracle.OraclePublic {
    pub let mediumCapabilities: {UInt64: Capability<&AnyResource{IFloracle.Medium}>}
    init() {
      self.mediumCapabilities = {}
    }

    /* OraclePublic */
    pub fun provideMediumCapability(requestorID: &{IFloracle.RequestorID}, mediumCap: Capability<&{IFloracle.Medium}>) {
      // TODO
    }
    /* Oracle */
    pub fun fulfillRequest(requestorID: UInt64, requestID: UInt64) {
      // TODO
    }
  }

  pub fun createNewWeatherRequestor(): @WeatherRequestor {
    // let oracleCap = self.account.getCapabilty<
    //     &{IFloracle.Oracle}
    //   >(self.OraclePublicPath)
    // assert(oracleCap.check(), message: "Problem with OraclePublic Capability")
    return <-create WeatherRequestor()
  }

  init() {
    self.requestBodySeparator = "|"

    self.RequestorStoragePath = /storage/WeatherDataRequestor
    self.OracleStoragePath = /storage/WeatherDataOracle
    self.OraclePublicPath = /public/WeatherDataOracle
    self.RequestorPrivatePath = /private/WeatherDataMedium

    self.account.save(<-create WeatherOracle(), to: self.OracleStoragePath)
  }
}
 