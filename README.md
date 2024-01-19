# F5 Automation Workshop 101

## Login
BIG-IP URL: *\<provided by instructor\>*  
Username: *\<provided by instructor\>*  
Password: *\<provided by instructor\>*  

Desktop URL:  *\<provided by instructor\>*  
Username: *\<provided by instructor\>*  
Password: *\<provided by instructor\>*  

## AS3 declaration with Postman
**Sample AS3 declaration**  
Use this declaration as a starting point for your own personalised declaration.  
https://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/latest/userguide/quick-start.html#quick-start-example-declaration

**Validating a declaration**  
This defines the JSON schema. VSCode will assist you with the syntax when added to your declaration.  
https://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/latest/userguide/validate.html#validate

## Postman workshop flow  
- Go to Quick Start on CloudDocs: https://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/latest/userguide/quick-start.html#quick-start  
- Follow steps 4 thru 7 with Postman. Change tenant name to "Student_XX"
- Add a 2nd application within the same declaration (hint: copy A1)  
- read the configuration (GET)
- discuss DELETE operations

## Ansible
### Encrypting passwords
```
ansible-vault encrypt_string "<username"> --name "bigip-user"
ansible-vault encrypt_string "<password"> --name "bigip-pass"
```
  
## AS3 Best Practice
https://community.f5.com/t5/technical-articles/as3-best-practice/ta-p/287466

## Tidbits
**Three ways to delete a configuration**  
- method POST with an empty declaration (preferred)
- method POST  with action "remove"  
- method DELETE  

**Per-app documentation**  
https://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/latest/userguide/per-app-declarations.html#perapp

**Per-app activation**  
https://{bigip-host}/mgmt/shared/appsvcs/settings  
```
# Change settings to Per App API  
  {  
    "betaOptions": {  
      "perAppDeploymentAllowed": true  
    }  
}  
```

**Per-app endpoint**  
https://{bigip-host}/mgmt/shared/appsvcs/declare/\<tenant\>/applications/
