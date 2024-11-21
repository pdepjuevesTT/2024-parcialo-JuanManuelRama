object mes{
    var mes = 0
    method mes() = mes
    method pasarMes(){mes+=1}
}


object universo{
    const property personas = []
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