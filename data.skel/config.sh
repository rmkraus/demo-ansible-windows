# PROJECT CONFIGURATION
export DEMO_PREFIX="mydemo"

# AWS CONFIGURATION
export AWS_ACCESS_KEY_ID="ABCDEFG"
export AWS_SECRET_ACCESS_KEY="ABCDEFG1234567HIJKLMNOP"
export AWS_DEFAULT_REGION="us-east-1"
export AWS_AVAILABILITY_ZONE="us-east-1a"
export AWS_R53_ZONE_ID="ABCDEFG12345"
export AWS_R53_DOMAIN="example.com"
export AWS_WIN_PASS_KEY="key_name"

# TOWER CONFIGURATION
export TOWER_VERSION='3.5.1-1'
export TOWER_ADMIN_PASSWORD='demopass'
export TOWER_PG_PASSWORD='demopass'
export TOWER_RABBITMQ_PASSWORD='demopass'


###############################################################################
###### DO NOT CHANGE ANYTHING BELOW THIS LINE #################################
###############################################################################

# Setup Tarraform
export TF_DATA_DIR=/data/terraform
export TF_INPUT=0
export TF_IN_AUTOMATION=1
export TF_LOG_PATH=/data/terraform.${DEMO_PREFIX}.log
export TF_VAR_ami_id_rhel='ami-011b3ccf1bd6db744'  # RHEL 7.6
export TF_VAR_ami_id_win='ami-09ef280df1a6a5330'  # Windows Server Datacenter 2019
export TF_VAR_app_instance_type="t2.small"
export TF_VAR_rhel_node_count=3
export TF_VAR_win_node_count=3
export TF_VAR_aws_availability_zone=${AWS_AVAILABILITY_ZONE}
export TF_VAR_aws_r53_zone_id=${AWS_R53_ZONE_ID}
export TF_VAR_demo_prefix="${DEMO_PREFIX}"
export TF_VAR_tower_instance_type="t3.medium"
export TF_VAR_win_pass_key="${AWS_WIN_PASS_KEY=}"
