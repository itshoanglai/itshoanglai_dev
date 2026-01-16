$ ->
  csrfToken = $('meta[name="csrf-token"]').attr('content')

  $.ajaxSetup
    headers:
      'X-CSRF-Token': csrfToken

  $('.toggle-password').on 'click', ->
    target = $($(this).data('target'))
    isPassword = target.attr('type') is 'password'

    newType = if isPassword then 'text' else 'password'
    $('#password').attr('type', newType)
    $('#confirm_password').attr('type', newType)

    # Toggle class để đổi icon (mở / đóng mắt)
    $('.toggle-password').toggleClass('active', isPassword)

  showError = (message) ->
    toastr.error(message, 'Validation Error',
      closeButton: true
      progressBar: true
      timeOut: 4000
    )

  showSuccess = (message) ->
    toastr.success(message, 'Success',
      closeButton: true
      progressBar: true
      timeOut: 3000
    )

  capitalizeWords = (str) ->
    str
      .trim()
      .replace(/\s+/g, ' ')
      .split(' ')
      .map (word) ->
        word.charAt(0).toUpperCase() + word.slice(1).toLowerCase()
      .join(' ')

  validateFullName = (name) ->
    name = name.trim()

    return { valid: false, message: 'Please enter your full name' } if name.length == 0
    return { valid: false, message: 'Full name cannot contain numbers' } if /\d/.test(name)
    return { valid: false, message: 'Full name cannot contain special characters' } if /[^a-zA-ZÀ-ỹ\s]/.test(name)

    words = name.split(/\s+/).filter((w) -> w.length > 0)
    return { valid: false, message: 'Full name must have at least 2 words (e.g., John Doe)' } if words.length < 2

    { valid: true, formatted: capitalizeWords(name) }

  validateEmail = (email) ->
    email = email.trim()
    return { valid: false, message: 'Please enter your email address' } if email.length == 0

    regex = /^[a-zA-Z0-9]([a-zA-Z0-9._-]*[a-zA-Z0-9])?@[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?(\.[a-zA-Z]{2,})+$/
    return { valid: false, message: 'Invalid email format' } unless regex.test(email)
    return { valid: false, message: 'Email cannot contain consecutive dots' } if email.includes('..')

    { valid: true }

  validatePassword = (password) ->
    return { valid: false, message: 'Please enter a password' } if password.length == 0
    return { valid: false, message: 'Password must be at least 8 characters' } if password.length < 8
    return { valid: false, message: 'Password cannot exceed 20 characters' } if password.length > 20

    hasUpper   = /[A-Z]/.test(password)
    hasLower   = /[a-z]/.test(password)
    hasNumber  = /\d/.test(password)
    hasSpecial = /[^a-zA-Z0-9]/.test(password)

    unless hasUpper
      return { valid: false, message: 'Password must contain at least one uppercase letter' }

    unless hasLower
      return { valid: false, message: 'Password must contain at least one lowercase letter' }

    unless hasNumber
      return { valid: false, message: 'Password must contain at least one number' }

    unless hasSpecial
      return { valid: false, message: 'Password must contain at least one special character' }

    { valid: true }

  validateConfirmPassword = (password, confirm) ->
    return { valid: false, message: 'Please confirm your password' } if confirm.length == 0
    return { valid: false, message: 'Passwords do not match' } if password != confirm
    { valid: true }


  validateGender = (gender) ->
    return { valid: false, message: 'Please select your gender' } unless gender
    { valid: true }

  validateDateOfBirth = (dateStr) ->
    return { valid: false, message: 'Please select your date of birth' } unless dateStr

    birth = new Date(dateStr)
    today = new Date()
    return { valid: false, message: 'Date of birth cannot be in the future' } if birth > today

    age = today.getFullYear() - birth.getFullYear()
    m = today.getMonth() - birth.getMonth()
    age-- if m < 0 or (m == 0 and today.getDate() < birth.getDate())

    return { valid: false, message: 'You must be at least 8 years old' } if age < 8
    return { valid: false, message: 'Invalid date of birth' } if age > 120

    { valid: true }

  validatePrivacy = (checked) ->
    return { valid: false, message: 'You must agree to the Terms of Service and Privacy Policy' } unless checked
    { valid: true }

  $('#register_form').on 'submit', (e) ->
    e.preventDefault()

    # Full name
    r = validateFullName($('#full_name').val())
    unless r.valid
      showError(r.message)
      $('#full_name').focus()
      return false
    $('#full_name').val(r.formatted)

    # Email
    r = validateEmail($('#email').val())
    unless r.valid
      showError(r.message)
      $('#email').focus()
      return false

    # Password
    r = validatePassword($('#password').val())
    unless r.valid
      showError(r.message)
      $('#password').focus()
      return false

    # Confirm password
    r = validateConfirmPassword($('#password').val(), $('#confirm_password').val())
    unless r.valid
      showError(r.message)
      $('#confirm_password').focus()
      return false

    # Gender
    r = validateGender($('#gender').val())
    unless r.valid
      showError(r.message)
      $('#gender').focus()
      return false

    # Date of birth
    r = validateDateOfBirth($('#date_of_birth').val())
    unless r.valid
      showError(r.message)
      $('#date_of_birth').focus()
      return false

    # Privacy
    r = validatePrivacy($('#privacy').is(':checked'))
    unless r.valid
      showError(r.message)
      $('#privacy').focus()
      return false

    $.ajax
      url: gon.create_registration
      method: 'POST'
      dataType: 'json'
      data:
        full_name: $('#full_name').val()
        email: $('#email').val()
        password: $('#password').val()
        gender: $('#gender').val()
        date_of_birth: $('#date_of_birth').val()
      success: (res) ->
        if res.success
          showSuccess('Registration successful!')
          setTimeout(->
            window.location.href = '/login'
          , 800)
        else
          showError(res.error || 'Registration failed')
      error: (xhr) ->
        msg = 'An error occurred. Please try again.'
        if xhr.responseJSON?.error?
          msg = xhr.responseJSON.error
        showError(msg)

    false
