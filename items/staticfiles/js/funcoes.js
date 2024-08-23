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

function toggleMenu() {
  const menuContainer = document.getElementById('menu-content');
  menuContainer.classList.toggle('open');
}
