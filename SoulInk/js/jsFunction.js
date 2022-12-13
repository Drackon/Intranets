document.addEventListener("DOMContentLoaded", function(event) {
    document.getElementById('btnBuscarId').addEventListener("click", login);
});

function login() {
	console.log("Entra en la funcion login");	
	var usuario= document.getElementById('txtusername').value;	
    var contraseña= document.getElementById('txtPassword').value;	
	//Se pueden pasar varios parametros. Deben ir separados por comas, siguiendo la misma estructura clave:valor
    var dataJson = { 'user': usuario , 'pass': contraseña };
    //  console.log(idJson);
    $.ajax({
		url: "./get/conn.php",        
        type: "POST",		
        data: { param: JSON.stringify(dataJson) },
        dataType: 'json', 
        success: function(response) {
            //alert (response.status);
			console.log(response);         			
			if(response.length==0){ //Si el usuario y la contraseña NO estan en la base de datos, mostrara una alerta de error
                swal("", "El usuario o la contraseña no son correctas", "error");
			}else{ //Si el usuario y la contraseña estan en la base de datos redirigira la pagina de la APP-WEB
                window.location.replace("web/index.html");
			}
        },
        error: function(xhr) {
            alert("An AJAX error occured: " + xhr.status + " " + xhr.statusText);
        }
    });
};








