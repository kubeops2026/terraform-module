terraform{
    required_providers {
        azurerm={
            source = "hashicorp/azurerm"
            version = "4.1.0"
        }
    }
}
provider "azurerm" {
    subscription_id = "8b4b39cc-778c-4d6a-812f-4c140c9c6e0f"
    features {}
}