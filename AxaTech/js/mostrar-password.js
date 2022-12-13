document.addEventListener("DOMContentLoaded", function(event) {
    document.getElementById('btnRest').addEventListener("click", mostrarPassword);
});
function mostrarPassword(){
  var cambio = document.getElementById("txtPassword");
  if(cambio.type == "text"){
    cambio.type = "password";
  }else{
    cambio.type = "text";
  }
} 
$(document).ready(function () {
//CheckBox mostrar contraseña
  $('#ShowPassword').click(function () {
    $('#Password').attr('type', $(this).is(':checked') ? 'password' : 'text');
  });
});









  