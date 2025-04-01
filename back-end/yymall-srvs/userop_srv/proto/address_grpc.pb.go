// Code generated by protoc-gen-go-grpc. DO NOT EDIT.
// versions:
// - protoc-gen-go-grpc v1.5.1
// - protoc             v5.28.3
// source: yymall-srvs/userop_srv/proto/address.proto

package proto

import (
	context "context"
	grpc "google.golang.org/grpc"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
	emptypb "google.golang.org/protobuf/types/known/emptypb"
)

// This is a compile-time assertion to ensure that this generated file
// is compatible with the grpc package it is being compiled against.
// Requires gRPC-Go v1.64.0 or later.
const _ = grpc.SupportPackageIsVersion9

const (
	Address_GetAddressList_FullMethodName = "/Address/GetAddressList"
	Address_CreateAddress_FullMethodName  = "/Address/CreateAddress"
	Address_DeleteAddress_FullMethodName  = "/Address/DeleteAddress"
	Address_UpdateAddress_FullMethodName  = "/Address/UpdateAddress"
)

// AddressClient is the client API for Address service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
type AddressClient interface {
	GetAddressList(ctx context.Context, in *AddressRequest, opts ...grpc.CallOption) (*AddressListResponse, error)
	CreateAddress(ctx context.Context, in *AddressRequest, opts ...grpc.CallOption) (*AddressResponse, error)
	DeleteAddress(ctx context.Context, in *AddressRequest, opts ...grpc.CallOption) (*emptypb.Empty, error)
	UpdateAddress(ctx context.Context, in *AddressRequest, opts ...grpc.CallOption) (*emptypb.Empty, error)
}

type addressClient struct {
	cc grpc.ClientConnInterface
}

func NewAddressClient(cc grpc.ClientConnInterface) AddressClient {
	return &addressClient{cc}
}

func (c *addressClient) GetAddressList(ctx context.Context, in *AddressRequest, opts ...grpc.CallOption) (*AddressListResponse, error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	out := new(AddressListResponse)
	err := c.cc.Invoke(ctx, Address_GetAddressList_FullMethodName, in, out, cOpts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *addressClient) CreateAddress(ctx context.Context, in *AddressRequest, opts ...grpc.CallOption) (*AddressResponse, error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	out := new(AddressResponse)
	err := c.cc.Invoke(ctx, Address_CreateAddress_FullMethodName, in, out, cOpts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *addressClient) DeleteAddress(ctx context.Context, in *AddressRequest, opts ...grpc.CallOption) (*emptypb.Empty, error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	out := new(emptypb.Empty)
	err := c.cc.Invoke(ctx, Address_DeleteAddress_FullMethodName, in, out, cOpts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *addressClient) UpdateAddress(ctx context.Context, in *AddressRequest, opts ...grpc.CallOption) (*emptypb.Empty, error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	out := new(emptypb.Empty)
	err := c.cc.Invoke(ctx, Address_UpdateAddress_FullMethodName, in, out, cOpts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// AddressServer is the server API for Address service.
// All implementations must embed UnimplementedAddressServer
// for forward compatibility.
type AddressServer interface {
	GetAddressList(context.Context, *AddressRequest) (*AddressListResponse, error)
	CreateAddress(context.Context, *AddressRequest) (*AddressResponse, error)
	DeleteAddress(context.Context, *AddressRequest) (*emptypb.Empty, error)
	UpdateAddress(context.Context, *AddressRequest) (*emptypb.Empty, error)
	mustEmbedUnimplementedAddressServer()
}

// UnimplementedAddressServer must be embedded to have
// forward compatible implementations.
//
// NOTE: this should be embedded by value instead of pointer to avoid a nil
// pointer dereference when methods are called.
type UnimplementedAddressServer struct{}

func (UnimplementedAddressServer) GetAddressList(context.Context, *AddressRequest) (*AddressListResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method GetAddressList not implemented")
}
func (UnimplementedAddressServer) CreateAddress(context.Context, *AddressRequest) (*AddressResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method CreateAddress not implemented")
}
func (UnimplementedAddressServer) DeleteAddress(context.Context, *AddressRequest) (*emptypb.Empty, error) {
	return nil, status.Errorf(codes.Unimplemented, "method DeleteAddress not implemented")
}
func (UnimplementedAddressServer) UpdateAddress(context.Context, *AddressRequest) (*emptypb.Empty, error) {
	return nil, status.Errorf(codes.Unimplemented, "method UpdateAddress not implemented")
}
func (UnimplementedAddressServer) mustEmbedUnimplementedAddressServer() {}
func (UnimplementedAddressServer) testEmbeddedByValue()                 {}

// UnsafeAddressServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to AddressServer will
// result in compilation errors.
type UnsafeAddressServer interface {
	mustEmbedUnimplementedAddressServer()
}

func RegisterAddressServer(s grpc.ServiceRegistrar, srv AddressServer) {
	// If the following call pancis, it indicates UnimplementedAddressServer was
	// embedded by pointer and is nil.  This will cause panics if an
	// unimplemented method is ever invoked, so we test this at initialization
	// time to prevent it from happening at runtime later due to I/O.
	if t, ok := srv.(interface{ testEmbeddedByValue() }); ok {
		t.testEmbeddedByValue()
	}
	s.RegisterService(&Address_ServiceDesc, srv)
}

func _Address_GetAddressList_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(AddressRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(AddressServer).GetAddressList(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: Address_GetAddressList_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(AddressServer).GetAddressList(ctx, req.(*AddressRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _Address_CreateAddress_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(AddressRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(AddressServer).CreateAddress(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: Address_CreateAddress_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(AddressServer).CreateAddress(ctx, req.(*AddressRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _Address_DeleteAddress_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(AddressRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(AddressServer).DeleteAddress(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: Address_DeleteAddress_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(AddressServer).DeleteAddress(ctx, req.(*AddressRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _Address_UpdateAddress_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(AddressRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(AddressServer).UpdateAddress(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: Address_UpdateAddress_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(AddressServer).UpdateAddress(ctx, req.(*AddressRequest))
	}
	return interceptor(ctx, in, info, handler)
}

// Address_ServiceDesc is the grpc.ServiceDesc for Address service.
// It's only intended for direct use with grpc.RegisterService,
// and not to be introspected or modified (even as a copy)
var Address_ServiceDesc = grpc.ServiceDesc{
	ServiceName: "Address",
	HandlerType: (*AddressServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "GetAddressList",
			Handler:    _Address_GetAddressList_Handler,
		},
		{
			MethodName: "CreateAddress",
			Handler:    _Address_CreateAddress_Handler,
		},
		{
			MethodName: "DeleteAddress",
			Handler:    _Address_DeleteAddress_Handler,
		},
		{
			MethodName: "UpdateAddress",
			Handler:    _Address_UpdateAddress_Handler,
		},
	},
	Streams:  []grpc.StreamDesc{},
	Metadata: "yymall-srvs/userop_srv/proto/address.proto",
}
