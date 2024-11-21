class MedioDePago{
    var dinero
    method gastar(cantidad){dinero-=cantidad}
    method puedeComprar(cantidad) = dinero>=cantidad
    method ganar(cantidad){dinero += cantidad}
}

class Efectivo inherits MedioDePago{
    method medio() = "efectivo"
}

class Debito inherits MedioDePago{
    method medio() = "debtio"
}

class Credito{
    method medio() = "credito"
    const bancoEmisor
    const property cuotas = []

    method gastar(cantidad){self.aniadirCuotas(self.cuotaIndividual(cantidad))}
    method puedeComprar(cantidad) = bancoEmisor.tope() >= cuotas.sum() + cantidad 

    method puedePagarCuota(dinero, cuota) = cuota/bancoEmisor.cuotas() <= dinero


    method montoTotal(pago) = pago+ pago*bancoCentral.interes() / 100
    method cuotaIndividual(cantidad) = self.montoTotal(cantidad)/bancoEmisor.cuotas()


    method aniadirCuotas(cuota) {
        (mes.mes() .. mes.mes()+bancoEmisor.cuotas()).forEach{x=> cuotas.add(new Cuota(mes = x, valor = cuota))}
    }

}

class Cuota{
    const property mes
    const property valor
}

class Banco{
    var property tope
    var property cuotas
}

object bancoCentral{
    var property interes = 50
}

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

    method cuotasAPagar() = self.cuotas().filter{x => x.mes() == mes.mes() || x.mes() == mes.mes()-1}
    
    

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

object mes{
    var mes = 0
    method mes() = mes
    method pasarMes(){mes+=1}
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

object universo{
    const personas = []
    method transcurreMes(){
        mes.pasarMes()
        personas.forEach{persona => persona.cobrarSueldo()}
    }

    method personaConMasCosas() = personas.max{persona => persona.cantidadCosas()}
}

class Empleo{
    var salario
    method cobrar() = salario
    method aumento(monto) {salario+=monto}
}

class Articulo{
    const nombre
    const property precio
}