Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753027AbdGLSuc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jul 2017 14:50:32 -0400
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: tj@kernel.org, gregkh@linuxfoundation.org, hch@lst.de,
        axboe@fb.com, rostedt@goodmis.org, lizefan@huawei.com,
        Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: [PATCH V5 02/11] kernfs: implement i_generation
Date: Wed, 12 Jul 2017 11:49:47 -0700
Message-Id: <238c2dc9ae0fc798859de266226d1a1e486a3f46.1499884836.git.shli@fb.com>
In-Reply-To: <cover.1499884836.git.shli@fb.com>
References: <cover.1499884836.git.shli@fb.com>
In-Reply-To: <cover.1499884836.git.shli@fb.com>
References: <cover.1499884836.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Shaohua Li <shli@fb.com>

Set i_generation for kernfs inode. This is required to implement
exportfs operations. The generation is 32-bit, so it's possible the
generation wraps up and we find stale files. To reduce the posssibility,
we don't reuse inode numer immediately. When the inode number allocation
wraps, we increase generation number. In this way generation/inode
number consist of a 64-bit number which is unlikely duplicated. This
does make the idr tree more sparse and waste some memory. Since idr
manages 32-bit keys, idr uses a 6-level radix tree, each level covers 6
bits of the key. In a 100k inode kernfs, the worst case will have around
300k radix tree node. Each node is 576bytes, so the tree will use about
~150M memory. Sounds not too bad, if this really is a problem, we should
find better data structure.

Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 fs/kernfs/dir.c        | 10 +++++++++-
 fs/kernfs/inode.c      |  1 +
 include/linux/kernfs.h |  2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 8ad7a17..33f711f 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -623,6 +623,8 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 					     unsigned flags)
 {
 	struct kernfs_node *kn;
+	u32 gen;
+	int cursor;
 	int ret;
 
 	name = kstrdup_const(name, GFP_KERNEL);
@@ -635,12 +637,17 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&kernfs_idr_lock);
-	ret = idr_alloc(&root->ino_idr, kn, 1, 0, GFP_ATOMIC);
+	cursor = idr_get_cursor(&root->ino_idr);
+	ret = idr_alloc_cyclic(&root->ino_idr, kn, 1, 0, GFP_ATOMIC);
+	if (ret >= 0 && ret < cursor)
+		root->next_generation++;
+	gen = root->next_generation;
 	spin_unlock(&kernfs_idr_lock);
 	idr_preload_end();
 	if (ret < 0)
 		goto err_out2;
 	kn->ino = ret;
+	kn->generation = gen;
 
 	atomic_set(&kn->count, 1);
 	atomic_set(&kn->active, KN_DEACTIVATED_BIAS);
@@ -884,6 +891,7 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 
 	idr_init(&root->ino_idr);
 	INIT_LIST_HEAD(&root->supers);
+	root->next_generation = 1;
 
 	kn = __kernfs_new_node(root, "", S_IFDIR | S_IRUGO | S_IXUGO,
 			       KERNFS_DIR);
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index fb4b4a7..79cdae4 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -220,6 +220,7 @@ static void kernfs_init_inode(struct kernfs_node *kn, struct inode *inode)
 	inode->i_private = kn;
 	inode->i_mapping->a_ops = &kernfs_aops;
 	inode->i_op = &kernfs_iops;
+	inode->i_generation = kn->generation;
 
 	set_default_inode_attr(inode, kn->mode);
 	kernfs_refresh_inode(kn, inode);
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 5f5d602..8c00d28 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -135,6 +135,7 @@ struct kernfs_node {
 	umode_t			mode;
 	unsigned int		ino;
 	struct kernfs_iattrs	*iattr;
+	u32			generation;
 };
 
 /*
@@ -164,6 +165,7 @@ struct kernfs_root {
 
 	/* private fields, do not use outside kernfs proper */
 	struct idr		ino_idr;
+	u32			next_generation;
 	struct kernfs_syscall_ops *syscall_ops;
 
 	/* list of kernfs_super_info of this root, protected by kernfs_mutex */
-- 
2.9.3
