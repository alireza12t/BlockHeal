// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: doctor.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct Bc_doctorAccount {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var publicKey: String = String()

  var label: [String] = []

  var sentPrescripts: [Bc_Prescript] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Bc_DoctorAccount_Container {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var entries: [Bc_doctorAccount] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "bc"

extension Bc_doctorAccount: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".doctorAccount"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "publicKey"),
    2: .same(proto: "label"),
    16: .same(proto: "sentPrescripts"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.publicKey)
      case 2: try decoder.decodeRepeatedStringField(value: &self.label)
      case 16: try decoder.decodeRepeatedMessageField(value: &self.sentPrescripts)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.publicKey.isEmpty {
      try visitor.visitSingularStringField(value: self.publicKey, fieldNumber: 1)
    }
    if !self.label.isEmpty {
      try visitor.visitRepeatedStringField(value: self.label, fieldNumber: 2)
    }
    if !self.sentPrescripts.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.sentPrescripts, fieldNumber: 16)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Bc_doctorAccount, rhs: Bc_doctorAccount) -> Bool {
    if lhs.publicKey != rhs.publicKey {return false}
    if lhs.label != rhs.label {return false}
    if lhs.sentPrescripts != rhs.sentPrescripts {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Bc_DoctorAccount_Container: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".DoctorAccount_Container"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "entries"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeRepeatedMessageField(value: &self.entries)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.entries.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.entries, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Bc_DoctorAccount_Container, rhs: Bc_DoctorAccount_Container) -> Bool {
    if lhs.entries != rhs.entries {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
