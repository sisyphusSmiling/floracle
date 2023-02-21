pub contract interface IFloracle {
  
  pub let serializationSeparator: String
  
  pub let RequestorStoragePath: StoragePath
  pub let OracleStoragePath: StoragePath

  pub event RequestMade(requestorID: UInt64, requestID: UInt64, requestBodyType: Type, requestBodyUTF8: [UInt8])
  pub event RequestFulfilled(requestorID: UInt64, requestID: UInt64, statusRawValue: UInt8)

  pub enum Status: UInt8 {
    pub case SENT
    pub case OK
    pub case BAD_REQUEST
  }

  pub struct interface RequestBody {
    pub fun toString(): String
    pub fun toUTF8(): [UInt8]
  }

  pub struct interface Request {
    pub let requestorID: UInt64
    pub let requestID: UInt64
    pub let body: AnyStruct{RequestBody}
    pub var status: Status
  }

  pub struct interface ResponseBody {
    pub fun toString(): String
  }

  pub struct interface Response {
    pub let requestorID: UInt64
    pub let requestID: UInt64
    pub let body: AnyStruct{ResponseBody}
    pub var status: Status
  }

  pub resource interface RequestorID {
    pub let id: UInt64
  }

  pub resource interface Requestor {
    pub let id: UInt64
    pub var requestCounter: UInt64
    pub let responses: {UInt64: AnyStruct{Response}}
    pub let badRequests: [UInt64]

    pub fun makeRequest(request: AnyStruct{Request})
  }

  pub resource interface Medium {
    access(contract) fun provideResponse(_ response: AnyStruct{Response})
  }

  pub resource interface OraclePublic {
    pub fun provideMediumCapability(requestorID: &{RequestorID}, mediumCap: Capability<&AnyResource{Medium}>)
  }

  pub resource interface Oracle {
    /// Requestor.id : Medium Capability
    pub let mediumCapabilities: {UInt64: Capability<&AnyResource{Medium}>}
    pub fun fulfillRequest(requestorID: UInt64, requestID: UInt64, response: AnyStruct{Response})
  }
}
 