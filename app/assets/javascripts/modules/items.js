$(document).on('turbolinks:load', ()=> {
  const buildFileField = (index)=> {
    const html = `<div data-index="${index}" class="js-file_group">
                    <input class="js-file" type="file"
                    name="item[images_attributes][${index}][src]"
                    id="item_images_attributes_${index}_src"><br>
                    <div class="js-remove">削除</div>
                  </div>`;
    return html;
  }

  let fileIndex = [1,2,3,4,5,6,7,8,9,10];

  $('#item-image').on('change', '.js-file', function(e) {
    $('#item-image').append(buildFileField(fileIndex[0]));
    fileIndex.shift();
    fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
  });

  $('#item-image').on('click', '.js-remove', function() {
    $(this).parent().remove();
    if ($('.js-file').length == 0) $('#item-image').append(buildFileField(fileIndex[0]));
  });
});