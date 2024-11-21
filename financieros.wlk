import abstractos.mes
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
        (mes.mes()+1 .. 1+mes.mes()+bancoEmisor.cuotas()).forEach{x=> cuotas.add(new Cuota(mes = x, valor = cuota))}
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





