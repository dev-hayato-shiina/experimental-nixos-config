{
  pkgs,
  name,
  extraGroups ? [ ],
}:

{
  users.users.${name} = {
    isNormalUser = true;
    inherit extraGroups;

    shell = pkgs.zsh;

    hashedPassword = "$6$eUzcZCQLFHu1GwgI$d4KfduxILHeA2JPoTwUbpSaMOKG.71GHePaJ0ovexBITGHi.vNJOEILYG95zS0yTTGqV4YtLVSsnXVk6vxXr.0";
  };
}
