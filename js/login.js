// Ao carregar o DOM, marca inputs .input100 com a classe has-val quando têm conteúdo, para efeitos visuais no formulário de login.
// Valida os campos do formulário .validate-form à submissão, mostrando/ocultando erros com funções auxiliares internas
// (showValidate, hideValidate, validate).
// Liga eventos focus aos inputs para limpar o estado de erro assim que o utilizador volta a escrever.
// Implementa uma pequena lógica de recuperação de password: ao clicar no link de “esqueci-me”, valida o email introduzido
// e mostra uma mensagem de feedback.
// Não envia efectivamente emails, mas prepara a UX e validação para uma futura integração de recuperação de password.

document.addEventListener("DOMContentLoaded", function () {
  "use strict";
  var allInputs = document.querySelectorAll(".input100");
  allInputs.forEach(function (input) {
    input.addEventListener("blur", function () {
      if (input.value.trim() !== "") {
        input.classList.add("has-val");
      } else {
        input.classList.remove("has-val");
      }
    });
  });
  var form = document.querySelector(".validate-form");
  var input = document.querySelectorAll(".validate-input .input100");
  if (form) {
    form.addEventListener("submit", function (event) {
      var check = true;
      for (var i = 0; i < input.length; i++) {
        if (validate(input[i]) === false) {
          showValidate(input[i]);
          check = false;
        }
      }
      if (!check) {
        event.preventDefault();
      }
    });
    var formInputs = form.querySelectorAll(".input100");
    formInputs.forEach(function (el) {
      el.addEventListener("focus", function () {
        hideValidate(this);
      });
    });
  }
  function isEmailValido(value) {
    var emailRegex =
      /^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{1,5}|[0-9]{1,3})(\]?)$/;
    return emailRegex.test(value);
  }
  function validate(inputEl) {
    var type = inputEl.getAttribute("type");
    var name = inputEl.getAttribute("name");
    var value = inputEl.value.trim();
    if (type === "email" || name === "email") {
      if (!isEmailValido(value)) {
        return false;
      }
    } else {
      if (value === "") {
        return false;
      }
    }
    return true;
  }
  function showValidate(inputEl) {
    var thisAlert = inputEl.parentNode;
    if (thisAlert) {
      thisAlert.classList.add("alert-validate");
    }
  }
  function hideValidate(inputEl) {
    var thisAlert = inputEl.parentNode;
    if (thisAlert) {
      thisAlert.classList.remove("alert-validate");
    }
  }
  var forgotLink = document.getElementById("link-esqueci");
  var emailInput = document.querySelector('input[name="email"]');
  var msgBox = document.getElementById("recuperacao-msg");
  if (forgotLink && emailInput && msgBox) {
    forgotLink.addEventListener("click", function (e) {
      e.preventDefault();
      var email = emailInput.value.trim();
      msgBox.style.display = "block";
      msgBox.style.marginTop = "10px";
      if (email === "") {
        msgBox.className = "alert alert-danger";
        msgBox.textContent =
          "Digite um email no campo de e-mail para que possamos enviar um email de recuperação de password.";
      } else if (!isEmailValido(email)) {
        msgBox.className = "alert alert-danger";
        msgBox.textContent = "Email inválido.";
      } else {
        msgBox.className = "alert alert-success";
        msgBox.textContent =
          "Email de recuperação de password enviado para " + email + ".";
      }
    });
  }
});
