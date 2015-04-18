class CreateCommentHierarchies < ActiveRecord::Migration
  def change
    create_table :comment_hierarchies, :id => false do |t|
      t.integer :ancestor_id, null: false # id of the parent/grandparent/great-gandparent...comments
      t.integer :descendant_id, null: false # id of the target comment
      t.integer :generations, null: false # number of generation between the ancestors and the descendants. parent/child = 1
    end
    add_index :comment_hierarchies, [:ancestor_id, :descendant_id, :generations], unique: true, name: 'comment_anc_desc_udx'
    add_index :comment_hierarchies, [:descendant_id], name: 'comment_desc_idx'
  end
end
