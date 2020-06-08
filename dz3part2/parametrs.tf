locals {
	env = {
	   default  = {
	       region                    = var.region
	       instance_type             = var.instance_type
	       instance_root_volume_size = "8"         
	       keyfile_name              = var.key_file
               tags = {
                 Name                    = terraform.workspace
               }
	   }

	   dev      = {
               region                    = var.region
               instance_type             = var.instance_type
	       instance_root_volume_size = "10"
               keyfile_name              = var.key_file
               tags = {
                 Name                    = terraform.workspace
               }               
	   }

	   stage    = {
               region                    = var.region
               instance_type             = var.instance_type
	       instance_root_volume_size = "5"
               keyfile_name              = var.key_file
               tags = {
                 Name                    = terraform.workspace
               }
	   }

	   prod     = {
               region                    = var.region
               instance_type             = var.instance_type
	       instance_root_volume_size = "7"
               keyfile_name              = var.key_file
               tags = {
                 Name                    = terraform.workspace
               }
	   }
	}
        
	enviromentvars = "${contains(keys(local.env), terraform.workspace) ? terraform.workspace : "default"}"
	workspace  = "${merge(local.env["default"], local.env[local.enviromentvars])}"
}
