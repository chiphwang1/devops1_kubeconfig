resource "time_sleep" "wait_5min" {
  depends_on = [oci_devops_deploy_stage.test_deploy_stage,oci_devops_deploy_pipeline.test_deploy_pipeline]
  create_duration = "420s"
}


resource "null_resource" "example1" {
   depends_on = [time_sleep.wait_5min]
  provisioner "local-exec" {
    command = "/bin/bash ./generated/kube.sh > /tmp/ip_addr" 
    
  }
}

data "local_file" "ip_addr" {
    depends_on = [null_resource.example1]
    filename = "/tmp/ip_addr"
}

output "ip_endpoint" {
  value       = "Endpoint is ${data.local_file.ip_addr.content} "
  description = "Endpoint for website"
}