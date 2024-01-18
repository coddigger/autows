# Using the F5 ansible declarative collection

## Official documentation
https://galaxy.ansible.com/ui/repo/published/f5networks/f5_bigip/docs/

### Installing the collection

In order not to clutter up your ansible installation, you can define the following line in the local .ansible.cfg to have collections installed local to your code.  

```
collections_paths = ./collections  
```

Install the F5 declarative module.   

```
ansible-galaxy collection install f5networks.f5_bigip -p ./collections  
```



