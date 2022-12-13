document.addEventListener("DOMContentLoaded", function(event) {
    cargar_productos(); //al cargar la pagina devolvera la tablageneral de productos
    document.getElementById('btnRest').addEventListener("click", cargar_productos); //al pulsar el boton devolvera la tabla inicial
    document.getElementById('btnUpPrec').addEventListener("click", UpPrecio); //al pulsar el boton, activara la función de actualizar los datos (UPDATE)
    document.getElementById('btnUpCant').addEventListener("click", UpCant);
    document.getElementById('btnInData').addEventListener("click", Insertar_datos);//al pulsar el boton, activara la función de insertar los datos en la base de datos (INSERT)
    document.getElementById('btnDelData').addEventListener("click", Eliminar_datos); //al pulsar el boton, activara la función de eliminar los datos de la base de datos (DELETE)
}); 
function cargar_productos() {
	console.log("Entra en la funcion de cargar productos");	
    $.ajax({
		url: "./get/index.php",  //hace la peticion de conectarse a la base de datos y la busqueda en ella,      
        dataType: 'json', 
        success: function (response) {            
			console.log(response);         			
            var myHtml = "<thead class='table-dark'><tr><th scope='col'>Nombre Producto</th><th scope='col'>Marca</th><th scope='col'>Precio €</th><th scope='col'>Cantidad</th></tr></thead><tbody class='tbody'>";	
			document.getElementById("tabody").innerHTML = myHtml;
            for ( i = 0; i < response.length; i++) {
                myHtml = "<td>" + response[i].Nombre + "</td>";
				myHtml += "<td>" +response[i].Marca + "</td>";
				myHtml += "<td>" +response[i].Precio + "</td>";
                myHtml += "<td>" +response[i].Cantidad + "</td>";
                myHtml += "</tr>";
                document.getElementById("tabody").innerHTML += myHtml;
            }        			
        },
        error: function (xhr) {
            //alert("An AJAX error occured: " + xhr.status + " " + xhr.statusText);
        }
    });
}
function UpPrecio(){ // Esta función actualizara los datos de la base de datos, con los datos introducidos desde la pagina
    console.log("Entra en la funcion UpPrecio");  
    var UpNombProd = document.getElementById("upPrecProduct").value ;
    var UpPrec = document.getElementById("upPrec").value ;
    var UpJson = { 'producto': UpNombProd, 'precio': UpPrec }; //nombre parametros
    if(UpNombProd == 0 || UpPrec == 0 ){ //Si alguno de los 2 campos esta vacio dara error.
        swal({
            title: "Error!",
            text: "Los datos introducidos no pueden estar vacios!",
            icon: "error",
            button: "Continuar.",
        });
   }else{ //Si alguien le da al boton introduciendo algun dato saltara una alerta de confirmación.
    swal({
        title:"Estas seguro",
        text:"Una vez eliminado no podras recuperarlo",
        icon:"warning",
        buttons:true,
        dangerMode:true,
        })
    .then((willDelete)=>{
        if(willDelete){
            swal("La acción se ha completado con exito!","Pulsa en 'tabla general' para ver los precios actualizados.",{
                icon:"success",
            });
            $.ajax({
                url: "./get/getUpdates/UpPrecio.php", //conectara con el archivo php dedicado a actualizar de datos.
                type: "POST",
                data: { UpParam: JSON.stringify(UpJson) },
                dataType: 'json',
                success: function (response) {            
                    cargar_productos();
                },
                error: function (xhr) {
                   // alert("An AJAX error occured: " + xhr.status + " " + xhr.statusText);
                }
            });
            }else{ //Aviso de que no se ha efectuado ningun cambio.
                swal("La acción no se ha completado!","Los datos de la base de datos no se han actualizado.",{
                    icon:"success",
                });
            } 
        });
    }
}
function UpCant(){ // Esta función actualizara los datos de la base de datos, con los datos introducidos desde la pagina
    console.log("Entra en la funcion UpCant");  
    var UpNombCant = document.getElementById("upCantProduct").value ;
    var UpCant = document.getElementById("upCant").value ;
    var UpCantJson = { 'producto': UpNombCant,'Cantidad': UpCant }; //nombre parametros
    if(UpNombCant == 0 || UpCant == 0 ){ //Si alguno de los 2 campos esta vacio dara error.
        swal({
            title: "Error!",
            text: "Los datos introducidos no pueden estar vacios!",
            icon: "error",
            button: "Continuar.",
        });
   }else{ //Si alguien le da al boton introduciendo algun dato saltara una alerta de confirmación.
    swal({
        title:"Estas seguro",
        text:"Una vez eliminado no podras recuperarlo",
        icon:"warning",
        buttons:true,
        dangerMode:true,
        })
    .then((willDelete)=>{
        if(willDelete){
            swal("La acción se ha completado con exito!","Pulsa en 'tabla general' para ver los precios actualizados.",{
                icon:"success",
            });
            $.ajax({
                url: "./get/getUpdates/UpCantidad.php", //conectara con el archivo php dedicado a actualizar de datos.
                type: "POST",
                data: { UpCantParam: JSON.stringify(UpCantJson) },		
                dataType: 'json',
                success: function (response) {            
                    cargar_productos();
                },
                error: function (xhr) {
                   // alert("An AJAX error occured: " + xhr.status + " " + xhr.statusText);
                }
            });
            }else{ //Aviso de que no se ha efectuado ningun cambio.
                swal("La acción no se ha completado!","Los datos de la base de datos no se han actualizado.",{
                    icon:"success",
                });
            } 
        });
    }
}
function Insertar_datos(){ // Esta función insertara nuevos datos de la base de datos, con los datos introducidos desde la pagina
    console.log("Entra en la funcion insertar datos");  
    var ProdNomb =  document.getElementById("InNomb").value ;
    var ProdMarc =  document.getElementById("InMarc").value ;
    var ProdPrec =  document.getElementById("InPrec").value ;
    var ProdCant =  document.getElementById("InCant").value ;
    var InsJson = { 'Nombre': ProdNomb,'Marca': ProdMarc,'Precio':ProdPrec,'Cantidad':ProdCant }; //nombre parametros
    if (ProdNomb == 0 || ProdMarc == 0 || ProdPrec == 0 || ProdCant == 0){ //Si alguno de los 4 campos esta vacio dara error.
        swal({
            title: "Error!",
            text: "Los datos introducidos no pueden estar vacios!",
            icon: "error",
            button: "Continuar.",
            });
    }else{
        swal({
            title:"¿Estas seguro?",
            text:"Una vez insertado los datos no habrá vuelta atras!",
            icon:"warning",
            buttons:true,
            dangerMode:true,
        })
        .then((willDelete)=>{
        if(willDelete){ //Si alguien le da al boton introduciendo algun dato saltara una alerta de confirmación.
            swal("La acción se ha completado con exito!","Pulsa en 'tabla general' para ver los precios actualizados.",{
                icon:"success",
                });
            $.ajax({
                url: "./get/getUpdates/insert.php", //conectara con el archivo php dedicado a insertar de datos.
                type: "POST",
                data: { InsertParam: JSON.stringify(InsJson) },		
                dataType: 'json',
                success: function (response) {           
                },
                error: function (xhr) {
                    //alert("An AJAX error occured: " + xhr.status + " " + xhr.statusText);
                }
            });
            }else{ //Aviso de que no se ha efectuado ningun cambio.
                swal("La acción no se ha completado!","Los datos no se han guardado en la base de datos.",{
                    icon:"success",
                });
            }           
        });
    }
}
function Eliminar_datos(){ // Esta función eliminara los datos de la base de datos, con los datos introducidos desde la pagina
    console.log("Entra en la funcion eliminar datos");  
    var DelNomb =  document.getElementById("DelNomb").value ;
    var DelJson = { 'Nombre': DelNomb }; //nombre parametros
    if(DelNomb == 0){ //Si alguien le da al boton sin introducir ningun dato dara error.
        swal({
            title: "Error!",
            text: "Los datos introducidos no pueden estar vacios!",
            icon: "error",
            button: "Continuar.",
            });
    }else{ //Si alguien le da al boton introduciendo algun dato saltara una alerta de confirmación.
        swal({
            title:"¿Estas seguro?",
            text:"Una vez eliminados los datos no habrá vuelta atras!",
            icon:"warning",
            buttons:true,
            dangerMode:true,
        })
        .then((willDelete)=>{
            if(willDelete){ //Si aceptamos seguir adelante seguira con su funcion.
                swal("La acción se ha completado con exito!","Pulsa en 'tabla general' para ver los precios actualizados.",{
                    icon:"success",
                    });
                $.ajax({
                    url: "./get/getUpdates/delete.php", //conectara con el archivo php dedicado a la eliminación.
                    type: "POST",
                    data: { DeleteParam: JSON.stringify(DelJson) },		
                    dataType: 'json',
                    success: function (response) {            
                        },
                    error: function (xhr) {
                        //alert("An AJAX error occured: " + xhr.status + " " + xhr.statusText);
                    }
                });
            }else{ //Aviso de que no se ha efectuado ningun cambio.
                swal("La acción no se ha completado!","Los datos siguen sin borrar.",{
                    icon:"success",
                });
            }          
        });
    }
}