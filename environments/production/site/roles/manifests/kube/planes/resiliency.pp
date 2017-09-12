class roles::kube::planes::resiliency(
  $resiliency_planes = 'compute,etcd'
  ) {

  $labels = $resiliency_planes.split(',').reduce( {} ) |Hash $memo, $plane| {
    $memo + { $plane => true }
  }
  notice($labels)
  validate_hash($labels)
  if $labels['etcd'] {
    include ::profiles::etcd
  }
  # profiles::rancher::agent::host_labels = $labels
}
