function toggleContent(element) {
  var content = element.nextElementSibling;
  var arrow = element.querySelector('.arrow');
  
  if (content.classList.contains('open')) {
      content.classList.remove('open');
      arrow.style.transform = 'rotate(0deg)';
  } else {
      content.classList.add('open');
      arrow.style.transform = 'rotate(90deg)';
  }
}

function toggleDescription(itemId) {
    var descriptionElement = document.getElementById('descricao-' + itemId);
    var isVisible = descriptionElement.style.display === 'block';
    descriptionElement.style.display = isVisible ? 'none' : 'block';
}

function toggleDescription(itemId) {
  var descriptionElement = document.getElementById("descricao-" + itemId);
  var isVisible = descriptionElement.style.display === "block";
  descriptionElement.style.display = isVisible ? "none" : "block";
}

// Campos de ações nas pag-sub-category
function toggleMenuPagSub(event) {
  event.preventDefault(); // Evita o comportamento padrão do botão, se necessário

  const menuContent = event.target.nextElementSibling;
  if (menuContent.style.display === "block") {
    menuContent.style.display = "none";
  } else {
    menuContent.style.display = "block";
  }
}

// Seleciona todos os botões de menu
const menuButtons = document.querySelectorAll('.menu-btn');

menuButtons.forEach(button => {
  button.addEventListener('click', function(e) {
    // Fecha todos os menus
    document.querySelectorAll('.menu-content').forEach(menu => {
      menu.style.display = 'none';
    });

    // Mostra o menu relacionado ao botão clicado
    const menuContent = e.target.nextElementSibling;
    if (menuContent) {
      menuContent.style.display = 'block';
    }
  });
})

// Evita que o clique dentro do menu feche ele
document.addEventListener('click', function(e) {
  if (!e.target.matches('.menu-btn') && !e.target.matches('.menu-content')) {
    document.querySelectorAll('.menu-content').forEach(menu => {
      menu.style.display = 'none';
    });
  }
});

// Prevenir propagação de cliques dentro do menu
document.querySelectorAll('.menu-content').forEach(function(menu) {
  menu.addEventListener('click', function(e) {
    e.stopPropagation();
  });
});