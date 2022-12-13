document.addEventListener("DOMContentLoaded", function(event) {
    mostrarPassword();
    document.getElementById('btnRest').addEventListener("click", mostrarPassword);
  });
  function mostrarPassword(){
    var cambio = document.getElementById("txtPassword");
    if(cambio.type == "text"){
      cambio.type = "password";
      $('.icon').removeClass('fa fa-eye-slash').addClass('fa fa-eye');
    }else{
      cambio.type = "text";
      $('.icon').removeClass('fa fa-eye').addClass('fa fa-eye-slash');
    }
  } 
  
  $(document).ready(function () {
  //CheckBox mostrar contraseña
    $('#ShowPassword').click(function () {
      $('#Password').attr('type', $(this).is(':checked') ? 'password' : 'text');
    });
  });









  