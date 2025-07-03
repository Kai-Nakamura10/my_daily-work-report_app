import "@hotwired/turbo-rails"
import "./controllers"
import "./custom/data_method"
document.addEventListener("DOMContentLoaded", () => {
  const deleteLinks = document.querySelectorAll(".js-confirm-delete");

  deleteLinks.forEach(link => {
    link.addEventListener("click", function(event) {
      const confirmed = confirm("本当に削除してもよろしいですか？");
      if (!confirmed) {
        event.preventDefault(); // 送信キャンセル
      }
    });
  });
});