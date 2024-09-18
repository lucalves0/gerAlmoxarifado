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

$(document).ready(function() {
    $('#id_category').change(function() {
        var category = $(this).val();
        $.ajax({
            url: '{% url "ajax-load-subcategories" %}',
            data: {'category': category},
            success: function(data) {
                var $subCategory = $('#id_sub_category');
                $subCategory.empty();
                // $subCategory.append('<option value="">Selecione</option>');
                $.each(data, function(index, value) {
                    $subCategory.append($('<option></option>').attr('value', value).text(value));
                });
            }
        });
    });

    var initialCategory = $('#id_category').val();
    if (initialCategory) {
        $.ajax({
            url: '{% url "ajax-load-subcategories" %}',
            data: {'category': initialCategory},
            success: function(data) {
                var $subCategory = $('#id_sub_category');
                $subCategory.empty();
                $subCategory.append('<option value="">Selecione</option>');
                $.each(data, function(index, value) {
                    $subCategory.append('<option value="' + value + '">' + value + '</option>');
                });
            }
        });
    }
});

function toggleDescription(itemId) {
  var descriptionElement = document.getElementById("descricao-" + itemId);
  var isVisible = descriptionElement.style.display === "block";
  descriptionElement.style.display = isVisible ? "none" : "block";
}

$(document).ready(function () {
  $("#id_category").change(function () {
    var category = $(this).val();
    $.ajax({
      url: '{% url "ajax-load-subcategories" %}',
      data: { category: category },
      success: function (data) {
        var $subCategory = $("#id_sub_category");
        $subCategory.empty();
        // $subCategory.append('<option value="">Selecione</option>');
        $.each(data, function (index, value) {
          $subCategory.append(
            $("<option></option>").attr("value", value).text(value)
          );
        });
      },
    });
  });

  var initialCategory = $("#id_category").val();
  if (initialCategory) {
    $.ajax({
      url: '{% url "ajax-load-subcategories" %}',
      data: { category: initialCategory },
      success: function (data) {
        var $subCategory = $("#id_sub_category");
        $subCategory.empty();
        $subCategory.append('<option value="">Selecione</option>');
        $.each(data, function (index, value) {
          $subCategory.append(
            '<option value="' + value + '">' + value + "</option>"
          );
        });
      },
    });
  }
});

document.addEventListener("DOMContentLoaded", function() {
  function toggleMenu() {
    const menuContent = document.getElementById("menu-content");
    menuContent.classList.toggle("open");
  }

  document.querySelector('.menu-button').addEventListener('click', toggleMenu);
});

document.addEventListener("DOMContentLoaded", function () {
  var ctx = document.getElementById("myChart").getContext("2d");

  // Obter os dados do script JSON
  var categoryData = JSON.parse(
    document.getElementById("category-data").textContent
  );

  // Processar os dados para Chart.js
  var categories = categoryData.map((item) => item.category);
  var counts = categoryData.map((item) => item.count);

  var myChart = new Chart(ctx, {
    type: "bar",
    data: {
      labels: categories,
      datasets: [
        {
          label: "# de Itens",
          data: counts,
          backgroundColor: "rgba(75, 192, 192, 0.2)",
          borderColor: "rgba(75, 192, 192, 1)",
          borderWidth: 1,
        },
      ],
    },
    options: {
      scales: {
        y: {
          beginAtZero: true,
        },
      },
    },
  });
});

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
