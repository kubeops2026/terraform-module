module "rg_module" {
    source = "../../../modules/rg_module"
    rg-var = var.rgvar-p
}


module "vnet_module" {
    depends_on = [module.rg_module]
    source = "../../../modules/vnet_module"
    vnet_var = var.vnet_p
}