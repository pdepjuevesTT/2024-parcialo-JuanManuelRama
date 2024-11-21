class MedioDePago{
    var dinero
    method gastar(cantidad){dinero-=cantidad}
    method puedeComprar(cantidad) = dinero>=cantidad
}

class Efectivo inherits MedioDePago{
    method medio() = "efectivo"
}

class Debito inherits MedioDePago{
    method medio() = "debtio"
}

class Credito{
    const bancoEmisor
    const cuotas = []

    method gastar(cantidad){self.aniadirCuotas(self.cuotaIndividual(cantidad))}
    method puedeComprar(cantidad) = bancoEmisor.tope() >= cuotas.sum() + cantidad 

    method puedePagarCuota(dinero, cuota) = cuota/bancoEmisor.cuotas() <= dinero


    method montoTotal(pago) = pago*bancoEmisor.interes() / 100
    method cuotaIndividual(cantidad) = self.montoTotal(cantidad)/bancoEmisor.cuotas()


    method aniadirCuotas(cuota) {
        (mes.mes()..mes.mes()+bancoEmisor.cuotas()).forEach{x=> cuotas.add(new Cuota(mes = x, valor = cuota))}
    }

}

class Cuota{
    const property mes
    const property valor
}

class Banco{
    var property tope
    var property interes
    var property cuotas
}

class Persona{
    const formasDePago = #{}
    var pagoPreferido
    const objetos = []

    method comprar(objeto){
        if(pagoPreferido.puedeComprar(objeto.precio())){
            objetos.add(objeto)
            pagoPreferido.gastar(objeto.precio())
        }
    }
    method pagarCuotas(medio)
    method cobrarSueldo(){
        
    }




    method cambiarPagoPreferido(otro){
        if(formasDePago.contains(otro))
            pagoPreferido = otro
        else
            throw new Exception(message ="Método de pago disponible")
    }
}

object mes{
    var mes = 0
    method mes() = mes
    method pasarMes(){mes+=1}
}

class CompradorCompulsivo inherits Persona{
    override method comprar(objeto){
       // super()
        const pago = formasDePago.find{x=>x.puedeComprar(objeto.costo())}
        if(pago!= null)
            pago.comprar(objeto)
    }
}

class PagadorCompulsivo inherits Persona{
    override method cobrarSueldo(){
        super()
        self.pagarCuotas(formasDePago.find{x => x.medio() == "efectivo"})
    }
}