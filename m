Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753354AbdGLSuf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jul 2017 14:50:35 -0400
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: tj@kernel.org, gregkh@linuxfoundation.org, hch@lst.de,
        axboe@fb.com, rostedt@goodmis.org, lizefan@huawei.com,
        Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: [PATCH V5 06/11] kernfs: add exportfs operations
Date: Wed, 12 Jul 2017 11:49:51 -0700
Message-Id: <b561f6428daba9aeeac7e5f6ffe91bb3cb2cc781.1499884836.git.shli@fb.com>
In-Reply-To: <cover.1499884836.git.shli@fb.com>
References: <cover.1499884836.git.shli@fb.com>
In-Reply-To: <cover.1499884836.git.shli@fb.com>
References: <cover.1499884836.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Shaohua Li <shli@fb.com>

Now we have the facilities to implement exportfs operations. The idea is
cgroup can export the fhandle info to userspace, then userspace uses
fhandle to find the cgroup name. Another example is userspace can get
fhandle for a cgroup and BPF uses the fhandle to filter info for the
cgroup.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 fs/kernfs/mount.c      | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/kernfs.h | 12 +++++++++++
 kernel/cgroup/cgroup.c |  3 ++-
 3 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index acd5426..fa32358 100644
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
+	kn = kernfs_find_and_get_node_by_ino(info->root, ino);
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
+	.fh_to_dentry	= kernfs_fh_to_dentry,
+	.fh_to_parent	= kernfs_fh_to_parent,
+	.get_parent	= kernfs_get_parent_dentry,
+};
+
 /**
  * kernfs_root_from_sb - determine kernfs_root associated with a super_block
  * @sb: the super_block in question
@@ -159,6 +213,8 @@ static int kernfs_fill_super(struct super_block *sb, unsigned long magic)
 	sb->s_magic = magic;
 	sb->s_op = &kernfs_sops;
 	sb->s_xattr = kernfs_xattr_handlers;
+	if (info->root->flags & KERNFS_ROOT_SUPPORT_EXPORTOP)
+		sb->s_export_op = &kernfs_export_ops;
 	sb->s_time_gran = 1;
 
 	/* get root inode, initialize and unlock it */
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 06a0c59..d149361 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -69,6 +69,12 @@ enum kernfs_root_flag {
 	 * following flag enables that behavior.
 	 */
 	KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK	= 0x0002,
+
+	/*
+	 * The filesystem supports exportfs operation, so userspace can use
+	 * fhandle to access nodes of the fs.
+	 */
+	KERNFS_ROOT_SUPPORT_EXPORTOP		= 0x0004,
 };
 
 /* type-specific structures for kernfs_node union members */
@@ -98,6 +104,12 @@ struct kernfs_elem_attr {
 /* represent a kernfs node */
 union kernfs_node_id {
 	struct {
+		/*
+		 * blktrace will export this struct as a simplified 'struct
+		 * fid' (which is a big data struction), so userspace can use
+		 * it to find kernfs node. The layout must match the first two
+		 * fields of 'struct fid' exactly.
+		 */
 		u32		ino;
 		u32		generation;
 	};
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index cc53111..8f88aac 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1737,7 +1737,8 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask, int ref_flags)
 		&cgroup_kf_syscall_ops : &cgroup1_kf_syscall_ops;
 
 	root->kf_root = kernfs_create_root(kf_sops,
-					   KERNFS_ROOT_CREATE_DEACTIVATED,
+					   KERNFS_ROOT_CREATE_DEACTIVATED |
+					   KERNFS_ROOT_SUPPORT_EXPORTOP,
 					   root_cgrp);
 	if (IS_ERR(root->kf_root)) {
 		ret = PTR_ERR(root->kf_root);
-- 
2.9.3
