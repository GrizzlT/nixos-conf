{ pkgs, ... }:
{
  services.openvpn.servers = {
    HTBStartPoint = { config = '' config /home/grizz/DATA/00_Projects/Education/HackTheBox/starting_point_GrizzlT.ovpn''; };
    HTBlab = { config = '' config /home/grizz/DATA/00_Projects/Education/HackTheBox/lab_GrizzlT.ovpn''; };
  };
}