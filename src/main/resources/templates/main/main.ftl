<#import "../parts/common.ftl" as c>
<#include "../parts/security.ftl">
<@c.page>
<style>
    body{
        background: #a6cdff;
    }
</style>
<div class="text-center mt-5">
    <h1>Welcome to our community, </h1> <h1 style="font-family: cursive;"><#if username??>${username}! <#else> ${usr}! </#if></h1>
</div>

<div class=" text-center mt-5 ml-5">
    <h2 style="color: ">You can:</h2>

    <ul class="list-group" style="display: flex;
    justify-content: center;
    align-items: center;">
        <li class="list-group-item list-group-item-secondary" style="width: 400px">Upload own photos</li>
        <li class="list-group-item list-group-item-secondary" style="width: 400px">Watch your friends</li>
        <li class="list-group-item list-group-item-secondary" style="width: 400px">Have subscription and subscribers</li>
        <li class="list-group-item list-group-item-secondary" style="width: 400px">Make your own page</li>
        <li class="list-group-item list-group-item-secondary" style="width: 400px">Search other users</li>
    </ul>
</div>

<div class="text-center mt-5">
    <h2>Let`s start! Good luck!</h2>
</div>

</@c.page>