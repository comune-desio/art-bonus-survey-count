require "json"

votes_path = ARGV[0]
data = JSON.parse(File.read(votes_path))
users = {}
data["votes"].each do |key, vote|
  uid = vote["user"]["uid"]
  users[uid] ||= []
  users[uid] << vote["project"]
end
votes_count_by_project = users.map do |key, list|
  list.last
end.group_by do |item|
  item
end.each_with_object({}) do |group, memo|
  memo[group.first] = group.last.count
end
puts votes_count_by_project.inspect
