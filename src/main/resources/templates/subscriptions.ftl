<#import "parts/common.ftl" as c>
<@c.page>

<style>
    body{
        background: #ffdbc8;
    }
</style>
<div class="text-center mt-5" style="font-family: cursive;">
<h3>${userChannel.username}</h3>
</div>
<div class="text-center mt-5" style="font-family: cursive;">
    <h1>
<div>${type}</div>
    </h1>
</div>
<div class="d-flex justify-content-center mt-5">
<ul class="list-group text-center">
    <#list users as user>
        <li class="list-group-item list-group-item-info" style="width: 300px">
            <a href="/photos/user-messages/${user.id}">${user.getUsername()}</a>
        </li>
    </#list>
</ul>
</div>
</@c.page>