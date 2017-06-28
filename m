Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751901AbdF1QaJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 12:30:09 -0400
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: tj@kernel.org, gregkh@linuxfoundation.org, hch@lst.de,
        axboe@fb.com, rostedt@goodmis.org, lizefan@huawei.com,
        Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: [PATCH V4 05/12] kernfs: introduce kernfs_node_id
Date: Wed, 28 Jun 2017 09:29:55 -0700
Message-Id: <094edc476ec5e726e5834f14e479036e0e478e37.1498666964.git.shli@fb.com>
In-Reply-To: <cover.1498666964.git.shli@fb.com>
References: <cover.1498666964.git.shli@fb.com>
In-Reply-To: <cover.1498666964.git.shli@fb.com>
References: <cover.1498666964.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Shaohua Li <shli@fb.com>

inode number and generation can identify a kernfs node. We are going to
export the identification by exportfs operations, so put ino and
generation into a separate structure. It's convenient when later patches
use the identification.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 fs/kernfs/dir.c                  | 10 +++++-----
 fs/kernfs/file.c                 |  4 ++--
 fs/kernfs/inode.c                |  4 ++--
 include/linux/cgroup.h           |  2 +-
 include/linux/kernfs.h           | 12 ++++++++++--
 include/trace/events/writeback.h |  2 +-
 6 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index b61a7ef..89d1dc1 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -539,7 +539,7 @@ void kernfs_put(struct kernfs_node *kn)
 	}
 	kfree(kn->iattr);
 	spin_lock(&kernfs_idr_lock);
-	idr_remove(&root->ino_idr, kn->ino);
+	idr_remove(&root->ino_idr, kn->id.ino);
 	spin_unlock(&kernfs_idr_lock);
 	kmem_cache_free(kernfs_node_cache, kn);
 
@@ -645,8 +645,8 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	idr_preload_end();
 	if (ret < 0)
 		goto err_out2;
-	kn->ino = ret;
-	kn->generation = gen;
+	kn->id.ino = ret;
+	kn->id.generation = gen;
 
 	/*
 	 * set ino first. This barrier is paired with atomic_inc_not_zero in
@@ -721,7 +721,7 @@ struct kernfs_node *kernfs_find_and_get_node_by_ino(struct kernfs_root *root,
 	 * before 'count'. So if 'count' is uptodate, 'ino' should be uptodate,
 	 * hence we can use 'ino' to filter stale node.
 	 */
-	if (kn->ino != ino)
+	if (kn->id.ino != ino)
 		goto out;
 	rcu_read_unlock();
 
@@ -1654,7 +1654,7 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 		const char *name = pos->name;
 		unsigned int type = dt_type(pos);
 		int len = strlen(name);
-		ino_t ino = pos->ino;
+		ino_t ino = pos->id.ino;
 
 		ctx->pos = pos->hash;
 		file->private_data = pos;
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 7f90d4d..7441925 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -895,7 +895,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		 * have the matching @file available.  Look up the inodes
 		 * and generate the events manually.
 		 */
-		inode = ilookup(info->sb, kn->ino);
+		inode = ilookup(info->sb, kn->id.ino);
 		if (!inode)
 			continue;
 
@@ -903,7 +903,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		if (parent) {
 			struct inode *p_inode;
 
-			p_inode = ilookup(info->sb, parent->ino);
+			p_inode = ilookup(info->sb, parent->id.ino);
 			if (p_inode) {
 				fsnotify(p_inode, FS_MODIFY | FS_EVENT_ON_CHILD,
 					 inode, FSNOTIFY_EVENT_INODE, kn->name, 0);
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 4c8b510..a343039 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -220,7 +220,7 @@ static void kernfs_init_inode(struct kernfs_node *kn, struct inode *inode)
 	inode->i_private = kn;
 	inode->i_mapping->a_ops = &kernfs_aops;
 	inode->i_op = &kernfs_iops;
-	inode->i_generation = kn->generation;
+	inode->i_generation = kn->id.generation;
 
 	set_default_inode_attr(inode, kn->mode);
 	kernfs_refresh_inode(kn, inode);
@@ -266,7 +266,7 @@ struct inode *kernfs_get_inode(struct super_block *sb, struct kernfs_node *kn)
 {
 	struct inode *inode;
 
-	inode = iget_locked(sb, kn->ino);
+	inode = iget_locked(sb, kn->id.ino);
 	if (inode && (inode->i_state & I_NEW))
 		kernfs_init_inode(kn, inode);
 
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 710a005..30c6877 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -543,7 +543,7 @@ static inline bool cgroup_is_populated(struct cgroup *cgrp)
 /* returns ino associated with a cgroup */
 static inline ino_t cgroup_ino(struct cgroup *cgrp)
 {
-	return cgrp->kn->ino;
+	return cgrp->kn->id.ino;
 }
 
 /* cft/css accessors for cftype->write() operation */
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 8c00d28..06a0c59 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -95,6 +95,15 @@ struct kernfs_elem_attr {
 	struct kernfs_node	*notify_next;	/* for kernfs_notify() */
 };
 
+/* represent a kernfs node */
+union kernfs_node_id {
+	struct {
+		u32		ino;
+		u32		generation;
+	};
+	u64			id;
+};
+
 /*
  * kernfs_node - the building block of kernfs hierarchy.  Each and every
  * kernfs node is represented by single kernfs_node.  Most fields are
@@ -131,11 +140,10 @@ struct kernfs_node {
 
 	void			*priv;
 
+	union kernfs_node_id	id;
 	unsigned short		flags;
 	umode_t			mode;
-	unsigned int		ino;
 	struct kernfs_iattrs	*iattr;
-	u32			generation;
 };
 
 /*
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 7bd8783..9b57f01 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -136,7 +136,7 @@ DEFINE_EVENT(writeback_dirty_inode_template, writeback_dirty_inode,
 
 static inline unsigned int __trace_wb_assign_cgroup(struct bdi_writeback *wb)
 {
-	return wb->memcg_css->cgroup->kn->ino;
+	return wb->memcg_css->cgroup->kn->id.ino;
 }
 
 static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *wbc)
-- 
2.9.3
