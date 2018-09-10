<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
    <link rel="stylesheet" href="/static/login/login.css">
</head>
<body>

<div class="text-center mt-5 welcome">
    <h1 style="font-size: 122px; color: #525cff">Hello, guest!</h1>
    <h2 class="mt-5">Good to see you here</h2>
</div>

<div class="mt-5 text-center">
    <div class="desc">
        <h5>Login here using your username and password</h5>
        <h5>(Cookies must be enabled in your browser)</h5>
    </div>

    <form action="/login" class="logform mt-3" method="post" >
        <div class="err">
        <#if Session?? && Session.SPRING_SECURITY_LAST_EXCEPTION??>
        <div class="alert alert-danger col-sm-2 " role="alert">
            ${Session.SPRING_SECURITY_LAST_EXCEPTION.message}
        </div>
        </#if>
            <#if message??>
        <div class="alert alert-${messageType} " role="alert">
            ${message}
        </div>
    </#if>
        </div>

        <div class="container text-center">
            <div class="row">
                <div class="col col-sm-4">
                    <input type="text" class="form-control" id="username" name="username" data-validate = "Enter username"
                           placeholder="Login">
                </div>
            </div>
            <div class="row mt-2">
                <div class="col col-sm-4">
                    <input type="password" class="form-control" id="password" name="password" data-validate = "Enter password"
                           placeholder="Password">
                </div>
            </div>
            <div class="row mt-2 text-center">
                <div class="col">
                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                    <button type="submit" class="btn btn-primary">Sing In</button>
                </div>
            </div>
        </div>
    </form>

    <div class="text-center mt-5">
        <h4 style="color: rebeccapurple">
            Not registered? <a href="/registration">Create an account</a>
        </h4>
    </div>

    <div class="mt-3">
        <hr>
        <hr>
        <hr>
    </div>

    <div>

    </div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>

</body>
</html>