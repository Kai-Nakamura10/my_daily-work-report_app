console.log("data_method.js が読み込まれました");
document.addEventListener("DOMContentLoaded", () => {
  document.body.addEventListener("click", (e) => {
    const link = e.target.closest("a[data-method]");
    if (!link) return;

    e.preventDefault();

    // 確認ダイアログ
    const confirmMessage = link.dataset.confirm;
    if (confirmMessage && !window.confirm(confirmMessage)) {
      return;
    }

    // フォームを作ってPOST送信（DELETEやPUT対応）
    const method = link.dataset.method.toUpperCase();
    const form = document.createElement("form");
    form.method = "POST";
    form.action = link.href;

    // CSRFトークン
    const csrfToken = document.querySelector('meta[name="csrf-token"]')?.content;
    if (csrfToken) {
      const csrfInput = document.createElement("input");
      csrfInput.type = "hidden";
      csrfInput.name = "authenticity_token";
      csrfInput.value = csrfToken;
      form.appendChild(csrfInput);
    }

    // _method hidden input (Rails用)
    const methodInput = document.createElement("input");
    methodInput.type = "hidden";
    methodInput.name = "_method";
    methodInput.value = method;
    form.appendChild(methodInput);

    document.body.appendChild(form);
    form.submit();
  });
});
