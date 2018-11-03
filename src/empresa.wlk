object exceptionSucursalInvalida inherits Exception {}

class Empresa {
	
	var property sucursales = []
	
	method agregarPedido(pedido, sucursal) {
		if (sucursales.contains(sucursal)) {
			sucursal.agregarPedido(pedido)
		} else {
			throw exceptionSucursalInvalida
		}		
	}
	
	method facturacion() = sucursales.sum{ sucursal => sucursal.facturacion() }
	
	method facturacionSucursal(sucursal) {
		if (sucursales.contains(sucursal)) {
			return sucursal.facturacion()
		} else {
			throw exceptionSucursalInvalida
		}
	}
	
	method sucursalQueMasFacturo() = sucursales.max{ sucursal => sucursal.facturacion() }
	
	method cantidadDePedidosDeColor(color) = sucursales.sum{
			sucursal => sucursal.pedidos().filter{ pedido => pedido.remera().colorBase() == color }.size()
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
	var property descuento = false
	
	method valorBase() = (remera.costo() * cantidad)
	
	method valorDescuento() = if (descuento) remera.descuento() * cantidad else 0
	
	method valor() = self.valorBase() - self.valorDescuento()
	
}


class Sucursal {
	
	var property pedidos = []
	var tallesPedidos = []
	var property cantidadMinimaParaDescuento = 100
		
	method hayDescuento(cantidad) = cantidad >= cantidadMinimaParaDescuento
	
	// Aplico descuento si cumple la condicion y lo agrego
	method agregarPedido(pedido) {
		if (self.hayDescuento(pedido.cantidad())) {
			pedido.descuento(true)
		}
		tallesPedidos.add(pedido.remera().talle())
		pedidos.add(pedido)
	}
	 
	method facturacion() = pedidos.sum{ pedido => pedido.valor() }
	
	// 48 - 32 = 16 talles en total
	method vendioTodosLosTalles() = tallesPedidos.asSet().size() == (32..42).asList().size()
	
	method pedidoMasCaro() = pedidos.max{ pedido => pedido.valor() }
	 
}
