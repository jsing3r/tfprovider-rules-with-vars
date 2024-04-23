terraform {
  required_providers {
    wiz = {
      version = " ~> 1.8"
      source = "tf.app.wiz.io/wizsec/wiz"
    }
  }
}

provider "wiz" {
  client_id = var.WIZ_CLIENT_ID
  secret = var.WIZ_CLIENT_SECRET
}