<#macro logout>
<form action="#" method="post">
    <input type="hidden" name="_csrf" value="${_csrf.token}" />
    <button type="submit" class="btn btn-primary">Log Out</button>
</form>
</#macro>