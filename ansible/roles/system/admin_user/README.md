Creates the admin user accounts and deploys their SSH keys. Admin users are sudo-enabled
maintenance accounts for the TripleA team. Also creates the limited `deploy` service
account and sets the root password (for Lish/Glish console recovery).

`defaults/main.yml` is the source of truth for the admin roster.
