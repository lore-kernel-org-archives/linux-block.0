Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751395AbdFBVyc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Jun 2017 17:54:32 -0400
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: tj@kernel.org, gregkh@linuxfoundation.org, hch@lst.de,
        axboe@fb.com, rostedt@goodmis.org, lizefan@huawei.com,
        Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: [PATCH 03/11] kernfs: add an API to get kernfs node from inode number
Date: Fri,  2 Jun 2017 14:53:56 -0700
Message-Id: <41d336f7006d63c6dd5bddf407c16de8064debc3.1496432591.git.shli@fb.com>
In-Reply-To: <cover.1496432591.git.shli@fb.com>
References: <cover.1496432591.git.shli@fb.com>
In-Reply-To: <cover.1496432591.git.shli@fb.com>
References: <cover.1496432591.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Shaohua Li <shli@fb.com>

Add an API to get kernfs node from inode number. We will need this to
implement exportfs operations.

To make the API lock free, kernfs node is freed in RCU context. And we
depend on kernfs_node count/ino number to filter stale kernfs nodes.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 fs/kernfs/dir.c             | 35 +++++++++++++++++++++++++++++++++++
 fs/kernfs/kernfs-internal.h |  2 ++
 fs/kernfs/mount.c           |  4 +++-
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 8e8545a..4c86e4c 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -643,6 +643,7 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	kn->ino = ret;
 	kn->generation = atomic_inc_return(&root->next_generation);
 
+	/* set ino first. Above atomic_inc_return has a barrier */
 	atomic_set(&kn->count, 1);
 	atomic_set(&kn->active, KN_DEACTIVATED_BIAS);
 	RB_CLEAR_NODE(&kn->rb);
@@ -674,6 +675,40 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 	return kn;
 }
 
+/*
+ * kernfs_get_node_by_ino - get kernfs_node from inode number
+ * @root: the kernfs root
+ * @ino: inode number
+ *
+ * RETURNS:
+ * NULL on failure. Return a kernfs node with reference counter incremented
+ */
+struct kernfs_node *kernfs_get_node_by_ino(struct kernfs_root *root,
+					   unsigned int ino)
+{
+	struct kernfs_node *kn;
+
+	rcu_read_lock();
+	kn = idr_find(&root->ino_idr, ino);
+	if (!kn)
+		goto out;
+	/* kernfs_put removes the ino after count is 0 */
+	if (!atomic_inc_not_zero(&kn->count)) {
+		kn = NULL;
+		goto out;
+	}
+	/* If this node is reused, __kernfs_new_node sets ino before count */
+	if (kn->ino != ino)
+		goto out;
+	rcu_read_unlock();
+
+	return kn;
+out:
+	rcu_read_unlock();
+	kernfs_put(kn);
+	return NULL;
+}
+
 /**
  *	kernfs_add_one - add kernfs_node to parent without warning
  *	@kn: kernfs_node to be added
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 2d5144a..3534cfe 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -98,6 +98,8 @@ int kernfs_add_one(struct kernfs_node *kn);
 struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 				    const char *name, umode_t mode,
 				    unsigned flags);
+struct kernfs_node *kernfs_get_node_by_ino(struct kernfs_root *root,
+					   unsigned int ino);
 
 /*
  * file.c
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index d5b149a..343dfeb 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -332,5 +332,7 @@ void __init kernfs_init(void)
 {
 	kernfs_node_cache = kmem_cache_create("kernfs_node_cache",
 					      sizeof(struct kernfs_node),
-					      0, SLAB_PANIC, NULL);
+					      0,
+					      SLAB_PANIC | SLAB_TYPESAFE_BY_RCU,
+					      NULL);
 }
-- 
2.9.3
