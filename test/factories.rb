Factory.define :admin_role, :class => :role do |r|
  r.name {'admin'}
  r.display_name {'Administrator'}
end

Factory.define :leader_role, :class => :role do |r|
  r.name {'leader'}
  r.display_name {'Leader'}
end

Factory.define :staff_role, :class => :role do |r|
  r.name {'staff'}
  r.display_name {'Staff'}
end

#This creates an external client instance
Factory.define :eclient_role, :class => :role do |r|
  r.name {'eclient'}
  r.display_name {'External Client'}
end

# This will guess the User class
Factory.define :admin_user, :class => :user do |u|
  u.username {'system'}
  u.display_name {'Administrator'}
  u.email {'system@example.com'}
  u.password {'important'}
  u.password_confirmation {'important'}
  u.association :role, :factory => :admin_role
end

# This will create a lead user instance
Factory.define :lead_user, :class => :user do |u|
  u.username {'lead'}
  u.display_name {'Lead User'}
  u.email {'lead@example.com'}
  u.password {'lead'}
  u.password_confirmation {'lead'}
  u.association :role, :factory => :leader_role
end

# This will create a lead user instance
Factory.define :staff_user, :class => :user do |u|
  u.username {'staff'}
  u.display_name {'Staff User'}
  u.email {'staff@example.com'}
  u.password {'staff'}
  u.password_confirmation {'staff'}
  u.association :role, :factory => :staff_role
end

# This will create an external client user instance
Factory.define :eclient_user, :class => :user do |u|
  u.username {'external'}
  u.display_name {'External User'}
  u.email {'external@example.com'}
  u.password {'external'}
  u.password_confirmation {'external'}
  u.association :role, :factory => :eclient_role
  u.association :client, :factory => :client
end

# This creates an inactive_user instance
Factory.define :inactive_user, :parent => :admin_user do |u|
  u.active { false }
end

# This will guess the ClientStatus class
Factory.define :client_status do |ps|
  ps.name {'Active'}
end

# This will guess the Client class
Factory.define :client do |pr|
  pr.client_name { 'Super Group of Companies'}
  pr.contact_name { 'Super Man'}
  pr.address1 {'1100 Main Street'}
  pr.city {'Newton'}
  pr.state {'Massachusetts'}
  pr.zip {'02459'}
  pr.phone {'111-111-1111'}
  pr.mobile {'222-222-2222'}
  pr.fax {'333-333-3333'}
  pr.comment {'This is a test client'}
  pr.association :client_status
end

# This will guess the ClientComment class
Factory.define :client_comment do |pc|
  pc.content { 'This is a test comment'}
  pc.delta { false }
  pc.association :client
  pc.association :user, :factory => :lead_user
end

# This will guess the ClientPerm class
Factory.define :client_perm do |pp|
  pp.association :client
  pp.association :user, :factory => :lead_user
end

Factory.define :base_folder do |f|
  f.name "base folder1"
end

# This will guess the Folder class
Factory.define :folder do |f|
  f.name {'Referrals'}
  f.eclient_flag { false }
  f.association :client
end

# This will guess the FolderPerm class
Factory.define :folder_perm do |fp|
  fp.association :user, :factory => :lead_user
  #fp.association :client
  fp.association :folder
end

# This will guess the Document class
Factory.define :document do |d|
  d.title { 'Important Picture'}
  d.description { 'This is a test document description'}
  d.doc_file_name { "#{Rails.root}/public/images/bl.png" }
  d.doc_content_type { 'image/jpeg' }
  d.association :document_status
  d.association :folder
end

# This will guess the DocumentStatus class
Factory.define :document_status do |ds|
  ds.name {'Verified'}
end
