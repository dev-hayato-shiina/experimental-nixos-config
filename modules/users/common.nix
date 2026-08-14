{
  name,
  extraGroups ? [ ],
}:

{
  users.users.${name} = {
    isNormalUser = true;
    inherit extraGroups;

    hashedPassword = "$6$eUzcZCQLFHu1GwgI$d4KfduxILHeA2JPoTwUbpSaMOKG.71GHePaJ0ovexBITGHi.vNJOEILYG95zS0yTTGqV4YtLVSsnXVk6vxXr.0";
  };
}
