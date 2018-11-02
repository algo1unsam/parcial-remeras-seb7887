object exceptionSucursalInvalida inherits Exception {}

class Empresa {
	
	var property sucursales = []
	
	method agregarPedido(pedido, sucursal) {
		if (sucursales.contains(sucursal)) {
			sucursal.pedidos().add(pedido)
		} else {
			throw exceptionSucursalInvalida
		}		
	}
	
	method facturacionEmpresa() = sucursales.sum{ sucursal => sucursal.facturacion() }
	
	method facturacionSucursal(sucursal) {
		if (sucursales.contains(sucursal)) {
			return sucursal.facturacion()
		} else {
			throw exceptionSucursalInvalida
		}
	}
	
	method sucursalQueMasFacturo() = sucursales.max{ sucursal => sucursal.facturacion() }
	
	method cantidadDePedidosDeColor(color) = sucursales.sum{
			sucursal => sucursal.pedidos().filter{ pedido => pedido.remera().color() == color }.size()
	}
	
	// Obtengo la sucursal que vendio el pedido mas caro y luego lo devuelvo
	method pedidoMasCaro() {
		var sucursalMayorPedido = sucursales.max{ sucursal => sucursal.pedidoMasCaro().valor() }
		return sucursalMayorPedido.pedidoMasCaro()
	}
	
	method sucursalesQueVendieronTodosLosTalles() = sucursales.filter{ sucursal => sucursal.vendioTodosLosTalles() }
		
}

class Pedido {
	
	var property remera = null
	var property cantidad = 0
	var property sucursal = null
	
	method valor() = (remera.costo() * cantidad) - sucursal.descuento(cantidad)
	
}


class Sucursal {
	
	var property pedidos = []
	var tallesPedidos = []
	var property cantidadMinimaParaDescuento = 100
		
	method descuento(remera, cantidad) = if (cantidad >= cantidadMinimaParaDescuento) remera.descuento() else 0
	 
	method facturacion() = pedidos.sum{ pedido => pedido.valor() }
	
	// 48 - 32 = 16 talles en total
	method vendioTodosLosTalles() = tallesPedidos.size() == 16
	
	method pedidoMasCaro() = pedidos.max{ pedido => pedido.valor() }
	 
}
