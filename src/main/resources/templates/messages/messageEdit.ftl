<a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
    Message Editor
</a>

<div class="collapse <#if message??>show</#if>" id="collapseExample">
    <div class="form-group mt-3">
        <form method="post" enctype="multipart/form-data">
            <div class="form-group">
                <input type="text" name="text" class="form-control ${(textError??)?string('is-invalid', '')} col col-sm-4"
                       value="<#if message??>${message.text}</#if>" placeholder="Введите сообщение">
                <#if textError??>
                <div class="invalid-feedback">
                    ${textError}
                </div>
                </#if>
            </div>
            <div class="form-group ">
                <input type="text" name="tag" class="form-control col col-sm-4 "
                       value="<#if message??>${message.tag}</#if>" placeholder="Тэг">
                <#if tagError??>
                <div class="invalid-feedback">
                    ${tagError}
                </div>
                </#if>
            </div>
            <div class="form-group">
                <div class="custom-file">
                    <input type="file" name="file" id="customFile" class="col col-sm-4">
                    <label class="custom-file-label" for="customFile">Choose file</label>
                </div>
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <input type="hidden" name="id" value="<#if message??>${message.id}</#if>"/>
            <div class="form-group">
                <button type="submit" class="btn btn-primary">Save Message</button>
            </div>
        </form>
    </div>
</div>