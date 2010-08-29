# users' roles
[['admin','Administrator'],['leader','Leader'],['staff','Staff'],['eclient','External Client']].
    each { |r| Role.find_or_create_by_name(:name => r[0], :display_name => r[1]) }
# client statuses
['Active','Inactive'].each { |s| ClientStatus.find_or_create_by_name(:name => s) }
# document statuses
['Uploaded','Downloaded','Archived'].each { |s| DocumentStatus.find_or_create_by_name(:name => s) }
# Base folders
['Requirements','Specifications','Design', 'Invoices', 'Payments'].each { |t| BaseFolder.find_or_create_by_name(:name => t) }
# Start-up user accounts - Note that we cannot create the 'euser' = 'External Client User' account yet since
# it is dependent upon the existence of a client account who the 'euser' account can be assigned to.  Therefore,
# the 'euser' account will need to be created after running db:populate rake task which creates a number of clients
[['system','System User','system@example.com',1,'important'],
 ['leader','Leader User','leader@example.com',2,'leader'],
 ['staff','Staff User','staff@example.com',3,'staff']
].each do |u|
    User.find_or_create_by_username({:username => u[0], :display_name => u[1], :email => u[2],
                                     :role_id => u[3],
                                     :password => u[4],  :password_confirmation => u[4]})
  end
