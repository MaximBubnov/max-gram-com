<#include "../parts/security.ftl">
<div class="card-columns">
        <#list messages as message>
             <div class="card border-default mb-3 mx-3" style="width: 18rem;">
                 <div class="card-body">
                     <#if message.filename??>
                         <img src="/jpg/${message.filename}" class="card-img-top">
                     </#if>

                     <div class="m-2">
                         <span>${message.text}</span> <br/>
                         <i>#${message.tag}</i>
                     </div>

                     <div class="card-footer text-muted" style="font: 180% serif">
                         <img src="/jpg/${message.author.filename}" alt="" width="30" height="30" class="rounded-circle">
                         <a href="/photos/user-messages/${message.author.id}">${message.authorName}</a>
                     </div>

                     <hr>

                     <div>
                         <#if message.author.id=currentUserId>
                             <a class="btn btn-primary" href="/photos/user-messages/${message.author.id}?message=${message.id}">
                                 Edit Message
                             </a>
                         </#if>
                     </div>

                     <div class="mt-2">
                         <#if message.author.id=currentUserId>
                             <form action="/photos/delete/${message.id}" method="post">
                                 <input type="hidden" value="${message.id}" name="messageId">
                                 <input type="hidden" value="${_csrf.token}" name="_csrf">
                                 <button type="submit" class="btn btn-primary">Delete</button>
                             </form>
                         </#if>
                     </div>
                 </div>
             </div>
            <#else>
            No messages
        </#list>
</div>
