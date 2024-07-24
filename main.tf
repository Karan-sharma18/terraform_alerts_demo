resource "newrelic_alert_policy" "policy_test" {
  name = "policy_test"
  incident_preference = "PER_POLICY"
}

resource "newrelic_nrql_alert_condition" "con_test" {
 policy_id = newrelic_alert_policy.policy_test
 name = var.alert_warning_critical


  nrql {
    query = "SELECT average(duration) FROM ProcessSample where entityGuid = '${var.entityGuid}'"
  }

  critical {
    operator              = "above"
    threshold             = 90
    threshold_duration    = 300
    threshold_occurrences = "ALL"
  }

  warning {
    operator              = "above"
    threshold             = 80
    threshold_duration    = 600
    threshold_occurrences = "ALL"
  }
}