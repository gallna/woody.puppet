# This class exists solely to aggregate the set of information that tie
# together the MCollective middleware.
#
class mco::middleware {

  include mcollective

  # No resources are declared by this class. It should only be used to set
  # Hiera parameters to propagate to inheriting classes.

}
