(load "./bootstrap.gauche/compat-gauche.scm")
(load "./bootstrap.gauche/mosh-stubs.scm")
(load "./runtime.scm")
(load "./runtime-cache.scm")
(load "./expander.scm")
(load "./r6rs.exp")
(ex:expand-file "system.scm" "system.gexp")
