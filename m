Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751341AbdFBVy3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Jun 2017 17:54:29 -0400
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: tj@kernel.org, gregkh@linuxfoundation.org, hch@lst.de,
        axboe@fb.com, rostedt@goodmis.org, lizefan@huawei.com,
        Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: [PATCH 01/11] kernfs: implement i_generation
Date: Fri,  2 Jun 2017 14:53:54 -0700
Message-Id: <b7c17173ade56502121bbc13860e293f84e704c6.1496432591.git.shli@fb.com>
In-Reply-To: <cover.1496432591.git.shli@fb.com>
References: <cover.1496432591.git.shli@fb.com>
In-Reply-To: <cover.1496432591.git.shli@fb.com>
References: <cover.1496432591.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Shaohua Li <shli@fb.com>

Set i_generation for kernfs inode. This is required to implement exportfs
operations.

Note, the generation is 32-bit, so it's possible the generation wraps up
and we find stale files. The possiblity is low, since fhandle matches
both inode number and generation. In most fs, the generation is 32-bit.
fhandle only export 32-bit generation for most fs. So unless we have
solid reason, we'd live with the possible conflict.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 fs/kernfs/dir.c        | 2 ++
 fs/kernfs/inode.c      | 1 +
 include/linux/kernfs.h | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index db5900aaa..09d093e 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -634,6 +634,7 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	if (ret < 0)
 		goto err_out2;
 	kn->ino = ret;
+	kn->generation = atomic_inc_return(&root->next_generation);
 
 	atomic_set(&kn->count, 1);
 	atomic_set(&kn->active, KN_DEACTIVATED_BIAS);
@@ -877,6 +878,7 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 
 	ida_init(&root->ino_ida);
 	INIT_LIST_HEAD(&root->supers);
+	atomic_set(&root->next_generation, 0);
 
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
index a9b11b8..c5f0fa7 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -135,6 +135,7 @@ struct kernfs_node {
 	umode_t			mode;
 	unsigned int		ino;
 	struct kernfs_iattrs	*iattr;
+	u32			generation;
 };
 
 /*
@@ -170,6 +171,7 @@ struct kernfs_root {
 	struct list_head	supers;
 
 	wait_queue_head_t	deactivate_waitq;
+	atomic_t		next_generation;
 };
 
 struct kernfs_open_file {
-- 
2.9.3
