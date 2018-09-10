<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>maxGram.com</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
    <link rel="stylesheet" href="/static/greeting/greeting.css">
</head>
<body>

<div class="text-center mt-5">
    <h1 style="color: black; font-family: cursive">Maxyyygram.com</h1>
</div>

<div class="container mt-5 main">

    <div class="mt-3 text-center">
        <img src="/static/greeting/images/inst.jpg" alt="" width="150" height="130">
    </div>

    <div id="demo" class="carousel slide mt-3" data-ride="carousel">

        <!-- Indicators -->
        <ul class="carousel-indicators">
            <li data-target="#demo" data-slide-to="0" class="active"></li>
            <li data-target="#demo" data-slide-to="1"></li>
            <li data-target="#demo" data-slide-to="2"></li>
        </ul>

        <!-- The slideshow -->
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img class="d-block w-100" src="/static/greeting/images/first.jpg" alt="Los Angeles">
                <div class="carousel-caption d-none d-md-block">
                    <h5>FRIENDS</h5>
                    <p>Meeting your friends</p>
                </div>
            </div>
            <div class="carousel-item">
                <img class="d-block w-100" src="/static/greeting/images/sec.jpg" alt="Chicago" >
                <div class="carousel-caption d-none d-md-block">
                    <h5>COMMUNICATION</h5>
                    <p>Communication with peoples</p>
                </div>
            </div>
            <div class="carousel-item">
                <img class="d-block w-100" src="/static/greeting/images/third.jpg" alt="New York" >
                <div class="carousel-caption d-none d-md-block">
                    <h5>PHOTOS</h5>
                    <p>Deploy your photos</p>
                </div>
            </div>
        </div>

        <!-- Left and right controls -->
        <a class="carousel-control-prev" href="#demo" data-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </a>
        <a class="carousel-control-next" href="#demo" data-slide="next">
            <span class="carousel-control-next-icon"></span>
        </a>
    </div>

</div>

<div class="mt-2 text-center develop">
    <div style=" display: flex;
         justify-content: center;
         align-items: center;">
        <a href="/main">LET`S START</a>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
<script src="../../static/greeting/greeting.js"></script>
</body>
</html>