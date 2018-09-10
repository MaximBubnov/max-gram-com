<#include "security.ftl">
<#import "login.ftl" as l>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="#">
        <img src="/static/greeting/images/inst.jpg" width="30" height="30" class="d-inline-block align-top" alt="">
        Maxyyygram
    </a>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item ">
                <a class="nav-link disabled" href="#">${name}</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="/main">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/photos/main">Photos</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/photos/user-messages/${currentUserId}">My Photos</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Settings
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="/user/profile">Profile</a>
                    <#if isAdmin>
                    <a class="dropdown-item" href="/user">User List</a>
                    </#if>
                    <div class="dropdown-divider"></div>
                    <div class="text-center">
                        <@l.logout/>
                    </div>
                </div>
            </li>

        </ul>
        <form class="form-inline my-2 my-lg-0" method="get" action="/photos/main">
            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" type="text" name="filter" value="${filter?ifExists}">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
        </form>
    </div>
</nav>