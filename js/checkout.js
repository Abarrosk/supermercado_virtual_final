// Quando o DOM está pronto, inicializa tooltips Bootstrap em elementos com data-bs-toggle="tooltip".
// Liga eventos aos botões .cart-remove para remover itens via fetch("api/cart_remove.php"), actualizando subtotal, desconto, portes e total na página.
// Define a função actualizarPortes() que envia a morada de facturação para api/shipping_quote.php e actualiza os valores de portes e total em tempo real.
// Valida campos obrigatórios do formulário de checkout e faz uma validação básica do email antes de submeter.
// Se existir uma .alert-success (por exemplo, após encomenda criada), redirecciona automaticamente para homepage.php passado um pequeno atraso.

document.addEventListener("DOMContentLoaded", function () {
  var tooltipTriggerList = [].slice.call(
    document.querySelectorAll('[data-bs-toggle="tooltip"]')
  );
  tooltipTriggerList.forEach(function (tooltipTriggerEl) {
    new bootstrap.Tooltip(tooltipTriggerEl);
  });
  var csrfMeta = document.querySelector('meta[name="csrf-token"]');
  var csrfToken = csrfMeta ? csrfMeta.getAttribute("content") : "";
  document.querySelectorAll(".cart-remove").forEach(function (btn) {
    btn.addEventListener("click", function (e) {
      e.preventDefault();
      var produtoId = this.getAttribute("data-id");
      if (!produtoId) return;
      var row = this.closest("tr");
      fetch("api/cart_remove.php", {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
          "X-Requested-With": "XMLHttpRequest",
          "X-CSRF-Token": csrfToken,
        },
        body: "produto_id=" + encodeURIComponent(produtoId),
      })
        .then(function (resp) {
          return resp.json();
        })
        .then(function (data) {
          if (!data.ok) {
            alert(data.erro || "Não foi possível remover o produto.");
            return;
          }
          if (row) row.remove();
          if (data.subtotal_formatado) {
            var el = document.getElementById("checkout-subtotal");
            if (el) el.textContent = data.subtotal_formatado;
          }
          if (data.desconto_formatado) {
            var el = document.getElementById("checkout-desconto");
            if (el) el.textContent = data.desconto_formatado;
          }
          if (data.portes_formatado) {
            var el = document.getElementById("checkout-portes");
            if (el) el.textContent = data.portes_formatado;
          }
          if (data.total_formatado) {
            var el = document.getElementById("checkout-total");
            if (el) el.textContent = data.total_formatado;
          }
        })
        .catch(function () {
          alert("Ocorreu um erro ao remover o produto.");
        });
    });
  });
  function actualizarPortes() {
    var addr1El = document.getElementById("billing-address1");
    var addr2El = document.getElementById("billing-address2");
    var morada1 = addr1El ? addr1El.value : "";
    var morada2 = addr2El ? addr2El.value : "";
    var morada = (morada1 + " " + morada2).trim();
    var distrito = document.getElementById("billing-distrito")?.value || "";
    var localidade = document.getElementById("billing-localidade")?.value || "";
    var codPostal = document.getElementById("zip-code")?.value || "";
    if (!morada1.trim() || !localidade.trim()) {
      return;
    }
    fetch("api/shipping_quote.php", {
      method: "POST",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
        "X-Requested-With": "XMLHttpRequest",
        "X-CSRF-Token": csrfToken,
      },
      body:
        "morada=" +
        encodeURIComponent(morada) +
        "&distrito=" +
        encodeURIComponent(distrito) +
        "&localidade=" +
        encodeURIComponent(localidade) +
        "&cod_postal=" +
        encodeURIComponent(codPostal),
    })
      .then(function (resp) {
        return resp.json();
      })
      .then(function (data) {
        if (!data.ok) return;
        var elPortes = document.getElementById("checkout-portes");
        if (elPortes && data.portes_formatado) {
          elPortes.textContent = data.portes_formatado;
        }
        var elTotal = document.getElementById("checkout-total");
        if (elTotal && data.total_formatado) {
          elTotal.textContent = data.total_formatado;
        }
      })
      .catch(function () {});
  }
  var addr1 = document.getElementById("billing-address1");
  var addr2 = document.getElementById("billing-address2");
  var dist = document.getElementById("billing-distrito");
  var loc = document.getElementById("billing-localidade");
  var zip = document.getElementById("zip-code");
  [addr1, addr2, dist, loc, zip].forEach(function (el) {
    if (!el) return;
    el.addEventListener("blur", actualizarPortes);
    el.addEventListener("change", actualizarPortes);
  });
  var form = document.getElementById("checkout-form");
  var btnFinalizar = document.getElementById("btn-finalizar");
  if (form && btnFinalizar) {
    btnFinalizar.addEventListener("click", function (e) {
      e.preventDefault();
      var camposObrig = [
        { id: "billing-name", nome: "Nome" },
        { id: "billing-email-address", nome: "Endereço de email" },
        { id: "billing-phone", nome: "Telefone" },
        { id: "billing-address1", nome: "Morada (linha 1)" },
        { id: "billing-distrito", nome: "Distrito" },
        { id: "billing-localidade", nome: "Localidade" },
        { id: "zip-code", nome: "Código Postal" },
      ];
      var emFalta = [];
      camposObrig.forEach(function (c) {
        var el = document.getElementById(c.id);
        if (!el || !el.value.trim()) {
          emFalta.push(c.nome);
        }
      });
      if (emFalta.length) {
        alert("Preenche os seguintes campos: " + emFalta.join(", "));
        return;
      }
      var emailEl = document.getElementById("billing-email-address");
      if (emailEl && emailEl.value) {
        var reEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!reEmail.test(emailEl.value.trim())) {
          alert("O email não é válido.");
          return;
        }
      }
      form.submit();
    });
  }
  var successAlert = document.querySelector(".alert-success");
  if (successAlert) {
    setTimeout(function () {
      window.location.href = "homepage.php";
    }, 2000);
  }
});
