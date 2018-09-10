<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Registration</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
    <link rel="stylesheet" href="/static/registration/registration.css">
</head>
<body>

<div class="container my-5 text-center">
    <h1 style="font-family: cursive; font-size: 72px" >Register</h1>
</div>

<div class="mt-5">
    <form action="/registration" method="post" enctype="multipart/form-data">
        <h4 class="ml-5">Name *</h4>
        <div class="form-group row">
            <div class="col-sm-2 ml-5">
                <input type="text" name="firstname"
                       class="form-control ${(firstnameError??)?string('is-invalid', '')}"
                       placeholder="First name"/>
                 <#if firstnameError??>
                    <div class="invalid-feedback">
                    ${firstnameError}
                     </div>
                 </#if>

            </div>
            <div class="col-sm-2 ml-2">
                <input type="text" name="lastname"
                       class="form-control"
                       placeholder="Last name"/>
            </div>
        </div>

        <h4 class="ml-5">Username *</h4>
        <div class="form-group row">
            <div class="col-sm-4 ml-5">
                <input type="text" name="username"
                       class="form-control ${(usernameError??)?string('is-invalid', '')}"
                       placeholder="Username"/>
                 <#if usernameError??>
                <div class="invalid-feedback">
                    ${usernameError}
                </div>
                 </#if>
            </div>
        </div>

        <h4 class="ml-5">Password *</h4>
        <div class="form-group row">
            <div class="col-sm-4 ml-5">
                <input type="text" name="password"
                       class="form-control ${(passwordError??)?string('is-invalid', '')}"
                       placeholder="Password"/>
                 <#if passwordError??>
                <div class="invalid-feedback">
                    ${passwordError}
                </div>
                 </#if>
            </div>
        </div>

        <h4 class="ml-5">Password *</h4>
        <div class="form-group row">
            <div class="col-sm-4 ml-5">
                <input type="text" name="password2"
                       class="form-control ${(password2Error??)?string('is-invalid', '')}"
                       placeholder="Repeat password"/>
                <#if password2Error??>
                    <div class="invalid-feedback">
                        ${password2Error}
                    </div>
                </#if>
            </div>
        </div>

        <h4 class="ml-5">Email *</h4>
        <div class="form-group row">
            <div class="col-sm-4 ml-5">
                <input type="text" name="email"
                       class="form-control ${(emailError??)?string('is-invalid', '')}"
                       placeholder="Email"/>
                <#if emailError??>
                <div class="invalid-feedback">
                    ${emailError}
                </div>
                </#if>
            </div>
        </div>

        <h4 class="ml-5">Photo (png/jpg) </h4>
        <div class="form-group row">
            <div class="custom-file col-sm-4 ml-5">
                <input type="file" name="file"
                       class="form-control"
                       placeholder="Image"/>
            </div>
        </div>



       <input type="hidden" name="_csrf" value="${_csrf.token}" />

        <button type="submit" class="btn btn-primary ml-5 btn-lg">Submit</button>

    </form>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>

</body>
</html>