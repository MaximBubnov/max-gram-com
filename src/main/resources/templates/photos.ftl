<#import "parts/common.ftl" as c>

<@c.page>

<style>
    body{
        background: #dffaff;
    }
</style>
<div class="text-center mt-5">
    <h1 style="font-family: cursive">Maxyyygram</h1>
</div>


        <div class="mx-5 my-5 text-center">
    <#include "messages/messageEdit.ftl"/>
        </div>



<div class="mx-5 my-5">
<#include "messages/messageList.ftl"/>
</div>
</@c.page>