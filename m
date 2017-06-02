Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751475AbdFBVyp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Jun 2017 17:54:45 -0400
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: tj@kernel.org, gregkh@linuxfoundation.org, hch@lst.de,
        axboe@fb.com, rostedt@goodmis.org, lizefan@huawei.com,
        Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: [PATCH 05/11] kernfs: add exportfs operations
Date: Fri,  2 Jun 2017 14:53:58 -0700
Message-Id: <b839ad722a8879ec67248d2cf23b018c532cb38c.1496432591.git.shli@fb.com>
In-Reply-To: <cover.1496432591.git.shli@fb.com>
References: <cover.1496432591.git.shli@fb.com>
In-Reply-To: <cover.1496432591.git.shli@fb.com>
References: <cover.1496432591.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Shaohua Li <shli@fb.com>

Now we have the facilities to implement exportfs operations. The idea is
cgroup can export the fhandle info to userspace, then userspace uses
fhandle to find the cgroup name. Another example is userspace can get
fhandle for a cgroup and BPF uses the fhandle to filter info for the
cgroup.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c |  2 +-
 fs/kernfs/mount.c                        | 65 ++++++++++++++++++++++++++++++--
 fs/sysfs/mount.c                         |  2 +-
 include/linux/kernfs.h                   |  9 +++--
 kernel/cgroup/cgroup.c                   |  3 +-
 5 files changed, 71 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index f5af0cc..fee2126 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -854,7 +854,7 @@ static struct dentry *rdt_mount(struct file_system_type *fs_type,
 	}
 
 	dentry = kernfs_mount(fs_type, flags, rdt_root,
-			      RDTGROUP_SUPER_MAGIC, NULL);
+			      RDTGROUP_SUPER_MAGIC, NULL, false);
 	if (IS_ERR(dentry))
 		goto out_cdp;
 
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 462a40c..11c5aba 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -16,6 +16,7 @@
 #include <linux/pagemap.h>
 #include <linux/namei.h>
 #include <linux/seq_file.h>
+#include <linux/exportfs.h>
 
 #include "kernfs-internal.h"
 
@@ -64,6 +65,59 @@ const struct super_operations kernfs_sops = {
 	.show_path	= kernfs_sop_show_path,
 };
 
+static struct inode *kernfs_fh_get_inode(struct super_block *sb,
+		u64 ino, u32 generation)
+{
+	struct kernfs_super_info *info = kernfs_info(sb);
+	struct inode *inode;
+	struct kernfs_node *kn;
+
+	if (ino == 0)
+		return ERR_PTR(-ESTALE);
+
+	kn = kernfs_get_node_by_ino(info->root, ino);
+	if (!kn)
+		return ERR_PTR(-ESTALE);
+	inode = kernfs_get_inode(sb, kn);
+	kernfs_put(kn);
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
+
+	if (generation && inode->i_generation != generation) {
+		/* we didn't find the right inode.. */
+		iput(inode);
+		return ERR_PTR(-ESTALE);
+	}
+	return inode;
+}
+
+static struct dentry *kernfs_fh_to_dentry(struct super_block *sb, struct fid *fid,
+		int fh_len, int fh_type)
+{
+	return generic_fh_to_dentry(sb, fid, fh_len, fh_type,
+				    kernfs_fh_get_inode);
+}
+
+static struct dentry *kernfs_fh_to_parent(struct super_block *sb, struct fid *fid,
+		int fh_len, int fh_type)
+{
+	return generic_fh_to_parent(sb, fid, fh_len, fh_type,
+				    kernfs_fh_get_inode);
+}
+
+static struct dentry *kernfs_get_parent_dentry(struct dentry *child)
+{
+	struct kernfs_node *kn = kernfs_dentry_node(child);
+
+	return d_obtain_alias(kernfs_get_inode(child->d_sb, kn->parent));
+}
+
+static const struct export_operations kernfs_export_ops = {
+	.fh_to_dentry = kernfs_fh_to_dentry,
+	.fh_to_parent = kernfs_fh_to_parent,
+	.get_parent = kernfs_get_parent_dentry,
+};
+
 /**
  * kernfs_root_from_sb - determine kernfs_root associated with a super_block
  * @sb: the super_block in question
@@ -145,7 +199,8 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 	} while (true);
 }
 
-static int kernfs_fill_super(struct super_block *sb, unsigned long magic)
+static int kernfs_fill_super(struct super_block *sb, unsigned long magic,
+			     bool enable_expop)
 {
 	struct kernfs_super_info *info = kernfs_info(sb);
 	struct inode *inode;
@@ -159,6 +214,8 @@ static int kernfs_fill_super(struct super_block *sb, unsigned long magic)
 	sb->s_magic = magic;
 	sb->s_op = &kernfs_sops;
 	sb->s_xattr = kernfs_xattr_handlers;
+	if (enable_expop)
+		sb->s_export_op = &kernfs_export_ops;
 	sb->s_time_gran = 1;
 
 	/* get root inode, initialize and unlock it */
@@ -219,6 +276,7 @@ const void *kernfs_super_ns(struct super_block *sb)
  * @magic: file system specific magic number
  * @new_sb_created: tell the caller if we allocated a new superblock
  * @ns: optional namespace tag of the mount
+ * @enable_expop: if adding fhandle support
  *
  * This is to be called from each kernfs user's file_system_type->mount()
  * implementation, which should pass through the specified @fs_type and
@@ -229,7 +287,8 @@ const void *kernfs_super_ns(struct super_block *sb)
  */
 struct dentry *kernfs_mount_ns(struct file_system_type *fs_type, int flags,
 				struct kernfs_root *root, unsigned long magic,
-				bool *new_sb_created, const void *ns)
+				bool *new_sb_created, const void *ns,
+				bool enable_expop)
 {
 	struct super_block *sb;
 	struct kernfs_super_info *info;
@@ -255,7 +314,7 @@ struct dentry *kernfs_mount_ns(struct file_system_type *fs_type, int flags,
 	if (!sb->s_root) {
 		struct kernfs_super_info *info = kernfs_info(sb);
 
-		error = kernfs_fill_super(sb, magic);
+		error = kernfs_fill_super(sb, magic, enable_expop);
 		if (error) {
 			deactivate_locked_super(sb);
 			return ERR_PTR(error);
diff --git a/fs/sysfs/mount.c b/fs/sysfs/mount.c
index 20b8f82..d1a3336b 100644
--- a/fs/sysfs/mount.c
+++ b/fs/sysfs/mount.c
@@ -37,7 +37,7 @@ static struct dentry *sysfs_mount(struct file_system_type *fs_type,
 
 	ns = kobj_ns_grab_current(KOBJ_NS_TYPE_NET);
 	root = kernfs_mount_ns(fs_type, flags, sysfs_root,
-				SYSFS_MAGIC, &new_sb, ns);
+				SYSFS_MAGIC, &new_sb, ns, false);
 	if (IS_ERR(root) || !new_sb)
 		kobj_ns_drop(KOBJ_NS_TYPE_NET, ns);
 	else if (new_sb)
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 61668d1..15c805f 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -332,7 +332,8 @@ void kernfs_notify(struct kernfs_node *kn);
 const void *kernfs_super_ns(struct super_block *sb);
 struct dentry *kernfs_mount_ns(struct file_system_type *fs_type, int flags,
 			       struct kernfs_root *root, unsigned long magic,
-			       bool *new_sb_created, const void *ns);
+			       bool *new_sb_created, const void *ns,
+			       bool enable_expop);
 void kernfs_kill_sb(struct super_block *sb);
 struct super_block *kernfs_pin_sb(struct kernfs_root *root, const void *ns);
 
@@ -435,7 +436,7 @@ static inline const void *kernfs_super_ns(struct super_block *sb)
 static inline struct dentry *
 kernfs_mount_ns(struct file_system_type *fs_type, int flags,
 		struct kernfs_root *root, unsigned long magic,
-		bool *new_sb_created, const void *ns)
+		bool *new_sb_created, const void *ns, bool enable_expop)
 { return ERR_PTR(-ENOSYS); }
 
 static inline void kernfs_kill_sb(struct super_block *sb) { }
@@ -516,10 +517,10 @@ static inline int kernfs_rename(struct kernfs_node *kn,
 static inline struct dentry *
 kernfs_mount(struct file_system_type *fs_type, int flags,
 		struct kernfs_root *root, unsigned long magic,
-		bool *new_sb_created)
+		bool *new_sb_created, bool enable_expop)
 {
 	return kernfs_mount_ns(fs_type, flags, root,
-				magic, new_sb_created, NULL);
+				magic, new_sb_created, NULL, enable_expop);
 }
 
 #endif	/* __LINUX_KERNFS_H */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c3c9a0e..206d8df 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1749,7 +1749,8 @@ struct dentry *cgroup_do_mount(struct file_system_type *fs_type, int flags,
 	struct dentry *dentry;
 	bool new_sb;
 
-	dentry = kernfs_mount(fs_type, flags, root->kf_root, magic, &new_sb);
+	dentry = kernfs_mount(fs_type, flags, root->kf_root, magic, &new_sb,
+			      true);
 
 	/*
 	 * In non-init cgroup namespace, instead of root cgroup's dentry,
-- 
2.9.3
