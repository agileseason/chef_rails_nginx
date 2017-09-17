resource_name :mkfile

property :path, name_property: true
property :source
property :cookbook
property :owner

action :create do
  cookbook_file path do
    source new_resource.source
    cookbook new_resource.cookbook
    owner new_resource.owner
    group 'apps'
    mode '0640'
  end
end
