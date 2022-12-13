document.addEventListener("DOMContentLoaded", function(event) {
    cargar_productos(); // al cargar la pagina devolvera la tablageneral de productos
    document.getElementById('btnRest').addEventListener("click", cargar_productos); //al pulsar el boton devolvera la tabla inicial
    document.getElementById('btnBuscarNom').addEventListener("click", sel_Nombre); //al pulsar el boton buscara por nombre los productos y los devolvera en una tabla
    document.getElementById('btnBuscarMarc').addEventListener("click", sel_Marca); //al pulsar el boton buscara por nombre de la marca los productos y los devolvera en una tabla
    document.getElementById('btnBuscarPrec').addEventListener("click", sel_Precio); //al pulsar el boton buscara por precio los productos y los devolvera en una tabla
});
//Saca una tabla general de todos los productos
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
            alert("An AJAX error occured: " + xhr.status + " " + xhr.statusText);
        }
    });
}
//Busca por nombre del producto y saca una tabla de dicho producto
function sel_Nombre() {
	console.log("Entra en la funcion sel_Nombre");	
	var NomBuscar= document.getElementById('inNom').value;	
	//Se pueden pasar varios parametros. Deben ir separados por comas, siguiendo la misma estructura clave:valor
    var NameJson = { 'nombre': NomBuscar };
    //  console.log(idJson);
    $.ajax({
		url: "./get/getBusquedas/nombre.php",        
        type: "POST",		
        data: { NomParam: JSON.stringify(NameJson) },
        dataType: 'json', 
        success: function(response) {
            // alert (response.status);
			console.log(response);         			
            var myHtml = "<thead class='table-dark'><tr><th scope='col'>Nombre Producto</th><th scope='col'>Marca</th><th scope='col'>Precio €</th><th scope='col'>Cantidad</th></tr></thead><tbody class='tbody'>";	
			document.getElementById("tabody").innerHTML = myHtml;
			if(response.length==0){
				swal({
                    title: "Error!",
                    text: "Los datos introducidos no se encuentran en la base de datos.",
                    icon: "error",
                    button: "Continuar.",
                    });
                cargar_productos();
			}else{
				//ES NECESARIO ESTE FOR??		
				for ( i = 0; i < response.length; i++) {
                    //myHtml = "<td scope='row'>" + response[i].idProducto + "</td>";
                    myHtml = "<td>" + response[i].Nombre + "</td>";
                    myHtml += "<td>" +response[i].Marca + "</td>";
                    myHtml += "<td>" +response[i].Precio + "</td>";
                    myHtml += "<td>" +response[i].Cantidad + "</td>";
                    myHtml += "</tr>";
                    document.getElementById("tabody").innerHTML += myHtml;
                }
				//load_data();
			}
        },
        error: function(xhr) {
            alert("An AJAX error occured: " + xhr.status + " " + xhr.statusText);
        }
    });
} 
//Busca por marcas y saca una tabla de la marca buscada
function sel_Marca() {
	console.log("Entra en la funcion sel_Marca");	
	var MarcBuscar= document.getElementById('inMarc').value;	
	//Se pueden pasar varios parametros. Deben ir separados por comas, siguiendo la misma estructura clave:valor
    var MarJson = { 'marca': MarcBuscar };
    //  console.log(idJson);
    $.ajax({
		url: "./get/getBusquedas/marca.php",        
        type: "POST",		
        data: { MarcParam: JSON.stringify(MarJson) },
        dataType: 'json', 
        success: function(response) {
            // alert (response.status);
			console.log(response);         			
            var myHtml = "<thead class='table-dark'><tr><th scope='col'>Nombre Producto</th><th scope='col'>Marca</th><th scope='col'>Precio €</th><th scope='col'>Cantidad</th></tr></thead><tbody class='tbody'>";	
            document.getElementById("tabody").innerHTML = myHtml;
			if(response.length==0){
				swal({
                    title: "Error!",
                    text: "Los datos introducidos no se encuentran en la base de datos.",
                    icon: "error",
                    button: "Continuar.",
                    });
                cargar_productos();
			}else{
				//ES NECESARIO ESTE FOR??		
				for ( i = 0; i < response.length; i++) {
                    //myHtml = "<td scope='row'>" + response[i].idProducto + "</td>";
                    myHtml = "<td>" + response[i].Nombre + "</td>";
                    myHtml += "<td>" +response[i].Marca + "</td>";
                    myHtml += "<td>" +response[i].Precio + "</td>";
                    myHtml += "<td>" +response[i].Cantidad + "</td>";
                    myHtml += "</tr>";
                    document.getElementById("tabody").innerHTML += myHtml;
                }
				//load_data();
			}
        },
        error: function(xhr) {
            alert("An AJAX error occured: " + xhr.status + " " + xhr.statusText);
        }
    });
} 
//Busca por precio y saca una tabla de los productos con dicho precio
function sel_Precio() {
	console.log("Entra en la funcion sel_Precio");	
	var PreBuscar= document.getElementById('inPrec').value;	
	//Se pueden pasar varios parametros. Deben ir separados por comas, siguiendo la misma estructura clave:valor
    var PrecJson = { 'prec': PreBuscar };
    //  console.log(idJson);
    $.ajax({
		url: "./get/getBusquedas/precio.php",        
        type: "POST",		
        data: { preParam: JSON.stringify(PrecJson) },
        dataType: 'json', 
        success: function(response) {
            // alert (response.status);
			console.log(response);         			
            var myHtml = "<thead class='table-dark'><tr><th scope='col'>Nombre Producto</th><th scope='col'>Marca</th><th scope='col'>Precio €</th><th scope='col'>Cantidad</th></tr></thead><tbody class='tbody'>";	
			document.getElementById("tabody").innerHTML = myHtml;
			if(response.length==0){
				swal({
                    title: "Error!",
                    text: "Los datos introducidos no se encuentran en la base de datos.",
                    icon: "error",
                    button: "Continuar.",
                    });
                cargar_productos();
			}else{
				//ES NECESARIO ESTE FOR??			
				for ( i = 0; i < response.length; i++) {
                    //myHtml = "<td scope='row'>" + response[i].idProducto + "</td>";
                    myHtml = "<td>" + response[i].Nombre + "</td>";
                    myHtml += "<td>" +response[i].Marca + "</td>";
                    myHtml += "<td>" +response[i].Precio + "</td>";
                    myHtml += "<td>" +response[i].Cantidad + "</td>";
                    myHtml += "</tr>";
                    document.getElementById("tabody").innerHTML += myHtml;
                }
				//load_data();
			}
        },
    });
} 
//En caso de fallo o de una busqueda en blanco todas las funciones devolveran la tabla inicial que se encuentra en la funcion "cargar_productos"