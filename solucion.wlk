class MedioDePago{
    method gastar(cantidad){self.S}
}

class Efectivo{
    var dinero
    method gastar(cantidad){dinero-=cantidad}
    method puedeComprar(cantidad) = dinero>=cantidad
}

class Debito{
    var saldo
    method gastar(cantidad){saldo-=cantidad}
}

class Credito{
    const bancoEmisor
    const cuotas = []

    method gastar(cantidad){cuotas.add(cantidad)}
    method puedeComprar(cantidad) = cuotas.sum() + cantidad <= bancoEmisor.tope()
}

class Persona{
    const formasDePago = #{}
    var pagoPreferido

    method comprar()

    method nuevoMes(){

    }

    


    method cambiarPagoPreferido(otro){
        if(formasDePago.contains(otro))
            pagoPreferido = otro
        else
            throw new Exception(message ="Método de pago disponible")
    }
}