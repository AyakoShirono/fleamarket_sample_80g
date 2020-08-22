$(document).on('turbolinks:load', ()=> {
  const buildFileField = (index)=> {
    const html = `<div data-index="${index}" class="js-file_group">
                    <input class="js-file" type="file"
                    name="item[images_attributes][${index}][src]"
                    id="item_images_attributes_${index}_src"><br>
                    <span class="js-remove">削除</span>
                  </div>`;
    return html;
  }
  const buildImg = (index, url)=> {
    const html = `<img data-index="${index}" src="${url}" width="100px" height="100px">`;
    return html;
  }

  var fileIndex = [1,2,3,4,5];
  lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0, lastIndex);

  $('.hidden-destroy').hide();

  $('#item-image').on('change', '.js-file', function(e) {
    const targetIndex = $(this).parent().data('index');
    const file = e.target.files[0];
    if(!file){
      $(`.js-file_group[data-index=${targetIndex}]`).find(".js-remove").trigger("click");
      return false;
    }
    const blobUrl = window.URL.createObjectURL(file);
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {
      $('#previews').append(buildImg(targetIndex, blobUrl));
      $('#item-image').append(buildFileField(fileIndex[0]));
      fileIndex.shift();
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1) 
    }
  });
  
  $('#item-image').on('click', '.js-remove', function() {
    const targetIndex = $(this).parent().data('index');
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    if (hiddenCheck) hiddenCheck.prop('checked', true);

    $(this).parent().remove();
    $(`img[data-index="${targetIndex}"]`).remove();

    if ($('.js-file').length == 0) $('#item-image').append(buildFileField(fileIndex[0]));
  });
});

// jQuery(window).load(function() {
//   $('.fixBox').each(function(i, box) {
//       var maxHeight = 0;
//       $(box).find('.fixItem').each(function() {
//           if ($(this).height() > maxHeight) maxHeight = $(this).height();
//       });
//       $(box).find('.fixItem').height(maxHeight);
//   });
// });
