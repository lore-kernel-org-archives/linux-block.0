Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751899AbdF1QaR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 12:30:17 -0400
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: tj@kernel.org, gregkh@linuxfoundation.org, hch@lst.de,
        axboe@fb.com, rostedt@goodmis.org, lizefan@huawei.com,
        Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: [PATCH V4 03/12] kernfs: add an API to get kernfs node from inode number
Date: Wed, 28 Jun 2017 09:29:53 -0700
Message-Id: <39b16490e3f39fb0f576a0b72d2458d164296766.1498666964.git.shli@fb.com>
In-Reply-To: <cover.1498666964.git.shli@fb.com>
References: <cover.1498666964.git.shli@fb.com>
In-Reply-To: <cover.1498666964.git.shli@fb.com>
References: <cover.1498666964.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Shaohua Li <shli@fb.com>

Add an API to get kernfs node from inode number. We will need this to
implement exportfs operations.

This API will be used in blktrace too later, so it should be as fast as
possible. To make the API lock free, kernfs node is freed in RCU
context. And we depend on kernfs_node count/ino number to filter out
stale kernfs nodes.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 fs/kernfs/dir.c             | 57 +++++++++++++++++++++++++++++++++++++++++++++
 fs/kernfs/kernfs-internal.h |  2 ++
 fs/kernfs/mount.c           | 11 ++++++++-
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 33f711f..7be37c8 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -508,6 +508,10 @@ void kernfs_put(struct kernfs_node *kn)
 	struct kernfs_node *parent;
 	struct kernfs_root *root;
 
+	/*
+	 * kernfs_node is freed with ->count 0, kernfs_find_and_get_node_by_ino
+	 * depends on this to filter reused stale node
+	 */
 	if (!kn || !atomic_dec_and_test(&kn->count))
 		return;
 	root = kernfs_root(kn);
@@ -649,6 +653,11 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	kn->ino = ret;
 	kn->generation = gen;
 
+	/*
+	 * set ino first. This barrier is paired with atomic_inc_not_zero in
+	 * kernfs_find_and_get_node_by_ino
+	 */
+	smp_mb__before_atomic();
 	atomic_set(&kn->count, 1);
 	atomic_set(&kn->active, KN_DEACTIVATED_BIAS);
 	RB_CLEAR_NODE(&kn->rb);
@@ -680,6 +689,54 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 	return kn;
 }
 
+/*
+ * kernfs_find_and_get_node_by_ino - get kernfs_node from inode number
+ * @root: the kernfs root
+ * @ino: inode number
+ *
+ * RETURNS:
+ * NULL on failure. Return a kernfs node with reference counter incremented
+ */
+struct kernfs_node *kernfs_find_and_get_node_by_ino(struct kernfs_root *root,
+						    unsigned int ino)
+{
+	struct kernfs_node *kn;
+
+	rcu_read_lock();
+	kn = idr_find(&root->ino_idr, ino);
+	if (!kn)
+		goto out;
+
+	/*
+	 * Since kernfs_node is freed in RCU, it's possible an old node for ino
+	 * is freed, but reused before RCU grace period. But a freed node (see
+	 * kernfs_put) or an incompletedly initialized node (see
+	 * __kernfs_new_node) should have 'count' 0. We can use this fact to
+	 * filter out such node.
+	 */
+	if (!atomic_inc_not_zero(&kn->count)) {
+		kn = NULL;
+		goto out;
+	}
+
+	/*
+	 * The node could be a new node or a reused node. If it's a new node,
+	 * we are ok. If it's reused because of RCU (because of
+	 * SLAB_TYPESAFE_BY_RCU), the __kernfs_new_node always sets its 'ino'
+	 * before 'count'. So if 'count' is uptodate, 'ino' should be uptodate,
+	 * hence we can use 'ino' to filter stale node.
+	 */
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
index 2d5144a..e9c226f 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -98,6 +98,8 @@ int kernfs_add_one(struct kernfs_node *kn);
 struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 				    const char *name, umode_t mode,
 				    unsigned flags);
+struct kernfs_node *kernfs_find_and_get_node_by_ino(struct kernfs_root *root,
+						    unsigned int ino);
 
 /*
  * file.c
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index d5b149a..69c48be 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -330,7 +330,16 @@ struct super_block *kernfs_pin_sb(struct kernfs_root *root, const void *ns)
 
 void __init kernfs_init(void)
 {
+
+	/*
+	 * the slab is freed in RCU context, so kernfs_find_and_get_node_by_ino
+	 * can access the slab lock free. This could introduce stale nodes,
+	 * please see how kernfs_find_and_get_node_by_ino filters out stale
+	 * nodes.
+	 */
 	kernfs_node_cache = kmem_cache_create("kernfs_node_cache",
 					      sizeof(struct kernfs_node),
-					      0, SLAB_PANIC, NULL);
+					      0,
+					      SLAB_PANIC | SLAB_TYPESAFE_BY_RCU,
+					      NULL);
 }
-- 
2.9.3
