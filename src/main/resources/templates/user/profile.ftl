<#import "../parts/common.ftl" as c>

<@c.page>
<br>
    <div class="container">
        <h1>Edit Profile</h1>
        <hr>
        <div class="row">
            <!-- left column -->
            <div class="col-md-3">
                <div class="text-center">
                    <img src="/jpg/${user.filename}" class="rounded-circle" alt="avatar" width="100" height="100">
                    <h6><em>${user.firstname} ${user.lastname}</em></h6>
                </div>
            </div>

            <div class="col-md-8 personal-info">
                <h3>Personal info</h3>
                <form action="/user/profile" method="post" enctype="multipart/form-data">
                    <div class="form-group row">
                        <label class="col-lg-3 control-label">First name:</label>
                        <div class="col-lg-8">
                            <input class="form-control ${(firstnameError??)?string('is-invalid', '')}"
                                   name="firstname"
                                   type="text"
                                   value="${user.firstname}">
                             <#if firstnameError??>
                                 <div class="invalid-feedback">
                                     ${firstnameError}
                                 </div>
                             </#if>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-lg-3 control-label">Last name:</label>
                        <div class="col-lg-8">
                            <input class="form-control" name="lastname" type="text" value="<#if user.lastname??>${user.lastname} <#else> </#if>">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-lg-3 control-label">Email:</label>
                        <div class="col-lg-8">
                            <input class="form-control" name="email" type="text" value="<#if user.email??>${user.email}</#if>">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-3 control-label">Username:</label>
                        <div class="col-md-8">
                            <input class="form-control" name="username" type="text" value="${user.username}">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-3 control-label">Old Password:</label>
                        <div class="col-md-8">
                            <input name="password"
                                   class="form-control"
                                   type="password">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-3 control-label">New password:</label>
                        <div class="col-md-8">
                            <input class="form-control"
                                   name="password2"
                                   type="password">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-3 control-label">New Photo:</label>
                        <div class="col-md-8">
                            <input type="file" class="form-control" name="file" value="/jpg/${user.filename}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-3 control-label"></label>
                        <div class="col-md-8">
                            <input type="hidden" name="_csrf" value="${_csrf.token}" />
                            <input type="submit" class="btn btn-primary" value="Save Changes">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</@c.page>


