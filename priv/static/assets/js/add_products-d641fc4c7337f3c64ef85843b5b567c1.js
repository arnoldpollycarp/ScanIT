// Add and remove for proforma
$(document).ready(function(e){

    // Add new element
    $("#add_proforma").on('click', function(e){
     e.preventDefault();
     // Finding total number of elements added
     var total_element = $(".element").length;



     // last <div> with element class id
     var lastid = $(".element:last").attr("id");
     var split_id = lastid.split("_");
     var nextindex = Number(split_id[1]) + 1;

     var max = 10;
     // Check total number elements
     if(total_element < max ){
      // Adding new div container after last occurance of element class
      $(".element:last").after("<div class='element' id='div_"+ nextindex +"'></div>");

      // Adding element to <div>
      $("#div_" + nextindex).append("  <div class='col-lg-4 col-md-4 col-sm-3 col-xs-6'><div class='form-group form-float'><div class='form-line'><label>Item_" + nextindex + "</label><select class='form-control' id='select-single' name='coa[]'><%= for chart <- Sub_items.list_sub_items() do %><option value='<%=chart.id%>'><%= chart.description %></option><% end %></select></div></div></div><div class='col-lg-2 col-md-2 col-sm-2 col-xs-6'><div class='form-group form-float'><div class='form-line'><label>Quantity_" + nextindex + "</label><input type='number' name='qty[]' class= 'form-control'></input></div></div></div><div class='col-lg-3 col-md-3 col-sm-2 col-xs-6'><div class='form-group form-float'><div class='form-line'><label>Rate_" + nextindex + "</label><input type='text' name='rate[]' class= 'form-control'></input></div></div></div><div class='col-lg-3 col-md-3 col-sm-2 col-xs-6'><div class='form-group form-float'><label>VAT_" + nextindex + "</label><select name='vat[]'><option value='1.16'>true</option><option value='1.0'>false</option></select></div></div>&nbsp;<div class='col-md-1'><span id='remove_" + nextindex + "' class='remove fa fa-close' style='font-size: 18px;margin-top: 35px;color:#f44336 !important'></span></div>");


     }

    });


     // Remove element
     $('.containers').on('click','.remove',function(){

      var id = this.id;
      var split_id = id.split("_");
      var deleteindex = split_id[1];

      // Remove <div> with id
      $("#div_" + deleteindex).remove();

     });
    });