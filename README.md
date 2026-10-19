# EC2 Assignment

This Terraform configuration is incomplete and won't deploy as it is. Complete the tasks below, then run `terraform init`, `terraform plan` and `terraform apply`.

## Tasks

1. **Terraform version constraint.** The `terraform` block in `main.tf` doesn't say which Terraform versions can run it. Add a constraint so that only Terraform versions **greater than 1.6.0** can run this configuration.

2. **VPC and subnet.** In `main.tf`, the VPC and subnet IDs are placeholders (`vpc-xxxxxxxxxxxxxxxxx` and `subnet-xxxxxxxxxxxxxxxxx`). Replace them with the IDs of the Devscale real VPC and a Devscale public subnet in `us-east-2`.

3. **User data.** Update `templates/user-data.sh.tpl` so that, after Docker is installed, the instance runs a container from the image `devscalecloud/devscale-bank-test:v2`, published on port **8080**.

4. **Security group.** Update the `ec2_sg` security group in `main.tf` to allow inbound TCP traffic on port **8080** from `0.0.0.0/0`.

5. **Project name.** In `variables.tf`, set the default value of `project_name` to your own name.

6. **terraform.tfvars.** Do **not** edit `key_name` or `instance_type` in `variables.tf`. Instead, create a `terraform.tfvars` file in this folder that:
   - sets `key_name` to the name of your own AWS key pair
   - sets `instance_type` to `t3.small`

## Check your work

- `terraform plan` runs without errors.
- After `terraform apply`, open `http://<public_ip>:8080` in a browser and confirm the app loads.
- Run `terraform destroy` when you're done so you don't keep paying for the instance.
