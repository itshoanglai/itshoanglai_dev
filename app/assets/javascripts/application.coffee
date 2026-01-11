#= require jquery
#= require popper
#= require jquery_ujs
#= require_tree .

$ ->
  # config toastr dialog
  toastr.options = {
    'closeButton': true,
    'progressBar': true,
    'positionClass': 'toast-top-right',
    'preventDuplicates': true,
    'timeOut': '4000',
    'extendedTimeOut': '1000',
    'showEasing': 'swing',
    'hideEasing': 'linear',
    'showMethod': 'slideDown',
    'hideMethod': 'slideUp'
  }
