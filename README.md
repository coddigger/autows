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

## Setting up git
- Create a repository in your own Github account. Call it "autows"
- Create a "Projects" folder  
- Open the folder in VScode (add folder to workspace)
- Clone your newly created git repo into the Projects folder (git clone \<url\>)


## Ansible
### Using the builtin Ansible URL module
https://docs.ansible.com/ansible/latest/collections/ansible/builtin/uri_module.html 

Look for the "Create a JIRA issue" example and modify.  

```
- name: Deploy AS3 declaration
  ansible.builtin.uri:
    url: https://{{bigip_host}}/mgmt/shared/appsvcs/declare/
    user: your_username
    password: your_pass
    method: POST
    body: "{{ lookup('file','as3-declaration.json') }}"
    force_basic_auth: true
    status_code: 
      - 200
      - 204
    body_format: json
    validate_certs: false

```  

### Encrypting passwords
```
ansible-vault encrypt_string "<username"> --name "bigip-user"
ansible-vault encrypt_string "<password"> --name "bigip-pass"
```
Then run the playbook with  
```
ansible-playbook <playbook> --ask-vault-pass
```   
### F5 Ansible Declarative Collection  
https://clouddocs.f5.com/products/orchestration/ansible/devel/f5_bigip/f5_bigip.html  
https://galaxy.ansible.com/ui/repo/published/f5networks/f5_modules/docs/  

```
    - name: Create AS3
      f5networks.f5_bigip.bigip_as3_deploy:
        content: "{{ lookup('template', 'declarations/as3_templ.json') }}"
      tags: [ deploy ]
      when: state == "present"

    - name: Delete AS3
      f5networks.f5_bigip.bigip_as3_deploy:
        state: "{{ state }}"
        tenant: "{{ partition }}"
      when: state == "absent"
``` 

### F5 Ansible Imperative Collection  
https://galaxy.ansible.com/ui/repo/published/f5networks/f5_modules/docs/  
https://clouddocs.f5.com/products/orchestration/ansible/devel/f5_modules/getting_started.html  

## AS3 Best Practice
https://community.f5.com/t5/technical-articles/as3-best-practice/ta-p/287466

## Tidbits
**Three ways to delete a configuration**  
- method POST with an empty declaration (preferred)
- method POST  with action "remove" (removes all AS3 declarations from box)
- method DELETE using the tenant name as part of the URL 

**Per-app documentation**  
https://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/latest/userguide/per-app-declarations.html#perapp

**Per-app declaration**  
Per-app declaration is supported from AS3 version 3.50. In prior versions you must enable it manually via https://{bigip-host}/mgmt/shared/appsvcs/settings  
```
# Change settings to Per App API  
  {  
    "betaOptions": {  
      "perAppDeploymentAllowed": true  
    }  
}  
```
Per-app will be GA in AS3 release 3.50.  

**Per-app endpoint**  
https://{bigip-host}/mgmt/shared/appsvcs/declare/\<tenant\>/applications/
