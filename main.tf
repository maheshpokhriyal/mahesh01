data "aws_region" "current" {}


resource "aws_cloudformation_stack" "appstream" {
  count = var.enable_appstream == true ? 1 : 0
  name  = "appstream-${var.stack_name}"
  tags  = var.tags
#  parameters = {
    StackName                      = var.stack_name
    FleetName                      = var.fleet_name
    FleetType                      = var.fleet_type
    FleetRoleArn                   = var.fleet_role_arn
    ImageArn                       = var.appstream_image_arn
    InstanceType                   = var.instance_type
    DesiredInstances               = var.no_of_instance
    MinCapacity                    = var.min_capacity
    MaxCapacity                    = var.max_capacity
    SubnetIds                      = var.subnet_ids
    SecurityGroupIds               = var.security_group_ids
    StreamView                     = var.stream_view
    DisconnectTimeoutInSeconds     = var.disconnect_timeout_in_seconds
    IdleDisconnectTimeoutInSeconds = var.idle_disconnect_timeout_in_seconds
    OrganizationalUnitName         = var.organizational_unit_name
    DirectoryName                  = var.directory_name

    ScaleInPolicyCooldown           = var.scalein_policy_cooldown
    ScaleInPolicyScalingAdjustment  = var.scalein_policy_adjustment
    ScaleOutPolicyCooldown          = var.scaleout_policy_cooldown
    ScaleOutPolicyScalingAdjustment = var.scaleout_policy_adjustment
    ScaleInAlarmPeriod              = var.scalein_alarm_period
    ScaleInAlarmThreshold           = var.scalein_alarm_threshold
    ScaleOutAlarmPeriod             = var.scaleout_alarm_period
    ScaleOutAlarmThreshold          = var.scaleout_alarm_threshold
    ScheduledMinCapacity            = var.scheduled_min_capacity
    ScheduledMaxCapacity            = var.scheduled_max_capacity
    ScheduledCronInterval           = var.schedule_cron_interval

  }

  template_body = templatefile("${path.module}/template/appstream-cf.yaml", { mytags = var.tags, stack_name = var.stack_name, aws_account_id = var.aws_account_id,
                               enable_scheduled_scaling = var.enable_scheduled_scaling, enable_ad_join = var.enable_ad_join })
}
