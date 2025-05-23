//
//  Vector4f+nosimd.swift
//  SwiftMath
//
//  Created by Andrey Volodin on 07.10.16.
//
//
#if NOSIMD
    
#if (os(OSX) || os(iOS) || os(tvOS) || os(watchOS))
import Darwin
#elseif os(Linux) || os(Android)
import Glibc
#elseif canImport(WASILibc)
import WASILibc
#endif

@frozen
public struct Vector4f: Hashable {
    public var x: Float = 0.0
    public var y: Float = 0.0
    public var z: Float = 0.0
    public var w: Float = 0.0
    
    public var r: Float { get { return x } set { x = newValue } }
    public var g: Float { get { return y } set { y = newValue } }
    public var b: Float { get { return z } set { z = newValue } }
    public var a: Float { get { return w } set { w = newValue } }
    
    public var s: Float { get { return x } set { x = newValue } }
    public var t: Float { get { return y } set { y = newValue } }
    public var p: Float { get { return z } set { z = newValue } }
    public var q: Float { get { return w } set { w = newValue } }
    
    public subscript(x: Int) -> Float {
        get {
            if x == 0 { return self.x }
            if x == 1 { return self.y }
            if x == 2 { return self.z }
            if x == 3 { return self.w }
            fatalError("Index outside of bounds")
        }
        
        set {
            if x == 0 { self.x = newValue; return }
            if x == 1 { self.y = newValue; return }
            if x == 2 { self.z = newValue; return }
            if x == 3 { self.w = newValue; return }
            fatalError("Index outside of bounds")
        }
    }
    
    //MARK: - initializers
    
    public init() {}
    
    public init(_ scalar: Float) {
        self.x = scalar
        self.y = scalar
        self.z = scalar
        self.w = scalar
    }
    
    public init(_ x: Float, _ y: Float, _ z: Float, _ w: Float) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }
    
    public init(x: Float, y: Float, z: Float, w: Float) {
        self.init(x, y, z, w)
    }
}

extension Vector4f: Equatable {

    public var lengthSquared: Float {
        return x * x + y * y + z * z + w * w
    }
    
    public var length: Float {
        return sqrt(self.lengthSquared)
    }
    
    public func dot(_ v: Vector4f) -> Float {
        return x * v.x + y * v.y + z * v.z + w * v.w
    }
    
    public var normalized: Vector4f {
        let lengthSquared = self.lengthSquared
        if lengthSquared ~= 0 || lengthSquared ~= 1 {
            return self
        }
        return self / sqrt(lengthSquared)
    }
    
    public func interpolated(with v: Vector4f, by t: Float) -> Vector4f {
        return self + (v - self) * t
    }
    
    public static prefix func -(v: Vector4f) -> Vector4f {
        return Vector4f(-v.x, -v.y, -v.z, -v.w)
    }
    
    public static func +(lhs: Vector4f, rhs: Vector4f) -> Vector4f {
        return Vector4f(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z, lhs.w + rhs.w)
    }
    
    public static func -(lhs: Vector4f, rhs: Vector4f) -> Vector4f {
        return Vector4f(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z, lhs.w - rhs.w)
    }
    
    public static func *(lhs: Vector4f, rhs: Vector4f) -> Vector4f {
        return Vector4f(lhs.x * rhs.x, lhs.y * rhs.y, lhs.z * rhs.z, lhs.w * rhs.w)
    }
    
    public static func *(lhs: Vector4f, rhs: Float) -> Vector4f {
        return Vector4f(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs, lhs.w * rhs)
    }
    
    public static func *=(lhs: inout Vector4f, rhs: Float) {
        lhs.x *= rhs
        lhs.y *= rhs
        lhs.z *= rhs
        lhs.w *= rhs
    }
    
    public static func *(lhs: Vector4f, rhs: Matrix4x4f) -> Vector4f {
        return Vector4f(
            lhs.x * rhs.m11 + lhs.y * rhs.m12 + lhs.z * rhs.m13 + lhs.w * rhs.m14,
            lhs.x * rhs.m21 + lhs.y * rhs.m22 + lhs.z * rhs.m23 + lhs.w * rhs.m24,
            lhs.x * rhs.m31 + lhs.y * rhs.m32 + lhs.z * rhs.m33 + lhs.w * rhs.m34,
            lhs.x * rhs.m41 + lhs.y * rhs.m42 + lhs.z * rhs.m43 + lhs.w * rhs.m44
        )
    }
    
    public static func *(lhs: Matrix4x4f, rhs: Vector4f) -> Vector4f {
        return Vector4f(
            rhs.x * lhs.m11 + rhs.y * lhs.m21 + rhs.z * lhs.m31 + rhs.w * lhs.m41,
            rhs.x * lhs.m12 + rhs.y * lhs.m22 + rhs.z * lhs.m32 + rhs.w * lhs.m42,
            rhs.x * lhs.m13 + rhs.y * lhs.m23 + rhs.z * lhs.m33 + rhs.w * lhs.m43,
            rhs.x * lhs.m14 + rhs.y * lhs.m24 + rhs.z * lhs.m34 + rhs.w * lhs.m44
        )
    }
    
    public static func /(lhs: Vector4f, rhs: Vector4f) -> Vector4f {
        return Vector4f(lhs.x / rhs.x, lhs.y / rhs.y, lhs.z / rhs.z, lhs.w / rhs.w)
    }
    
    public static func /(lhs: Vector4f, rhs: Float) -> Vector4f {
        return Vector4f(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs, lhs.w / rhs)
    }
    
    public static func ==(lhs: Vector4f, rhs: Vector4f) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z && lhs.w == rhs.w
    }
    
    public static func ~=(lhs: Vector4f, rhs: Vector4f) -> Bool {
        return lhs.x ~= rhs.x && lhs.y ~= rhs.y && lhs.z ~= rhs.z && lhs.w ~= rhs.w
    }
}

#endif
