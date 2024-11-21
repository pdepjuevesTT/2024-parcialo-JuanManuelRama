import abstractos.*
class Persona{
    const formasDePago = #{}
    var pagoPreferido
    const objetos = []
    var trabajo
    
    method pagoPreferido () = pagoPreferido
    method cantidadCosas() = objetos.length()

    method efectivo() = formasDePago.find{x => x.medio() == "efectivo"}

    method comprar(objeto){
        if(pagoPreferido.puedeComprar(objeto.precio())){
            objetos.add(objeto)
            pagoPreferido.gastar(objeto.precio())
        }
    }
    method tarjetasCredito() = formasDePago.filter{x => x.medio() == "credito"}

    method cuotas() = self.tarjetasCredito().flatMap{x => x.cuotas()}

    method cuotasAPagar() = self.cuotas().filter{x => x.mes() <= mes.mes()}
    
    

    method cobrarSueldo(){
        var sueldo = trabajo.sueldo()

        self.efectivo().ganar(sueldo)
        
    }

    method cambiarPagoPreferido(otro){
        if(formasDePago.contains(otro))
            pagoPreferido = otro
        else
            throw new Exception(message ="Método de pago disponible")
    }
}


class CompradorCompulsivo inherits Persona{
    override method comprar(objeto){
       super(objeto)
        const pago = formasDePago.find{x=>x.puedeComprar(objeto.costo())}
        if(pago!=null)
            pago.comprar(objeto)
    }
}

class PagadorCompulsivo inherits Persona{
    override method cobrarSueldo(){
        super()
        //self.pagarCuotas(formasDePago.find{x => x.medio() == "efectivo"})
    }
}
