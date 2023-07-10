variable "region" {
    type = string
    default = "us-east-1"
}

variable "cidr" {
    type = string
    cidr = "10.0.0.0/16"
}

variable "subnetcidr" {
    type = list(string)
    subnetcidr = [ "10.0.1.0/24", "10.0.2.0/24" ]

}

variable "azs" {
    type = list(string)  
    azs = [ "us-west-1a", "us-west-1b"]
}

variable "instance_type" {
    type = string
    default = "t2.small"
}