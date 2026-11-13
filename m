Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794571062;
	b=XsHrl39slSvXuthlebPTwLtjKPiPSARx1vFtQWAti7IELtv5zfZ5L0O63YB62VGYpgbv
	 K92oTXzXro1Lo2ob4IjhG1TrLQY5CxF/1EZn96wP5VGGBmZBMHrb2Mb4sk5htq/3BoO1I
	 5p9EpEvDI7NXRxTIz1wGm8X0wsQV5UFjYJfxrm5nS+XarJnrezjHl5K7rXnmKZyRR5Qq2
	 lEi0KBo/tiazOmgHk9FbsNYhtoIPUL0fFENes8Cm3JKO8wt8gKboI7QdiwD5znmHb3ekk
	 Ixd8tULuU3QsNqaPO7Oj6Wj43IIwJ9O0CqerpyVJ2WZSvMMN0a6eA3WbFbHhe7qz27Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571062;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=JUuklSF5elXh1buwkOMD+9THXq+X3Fc15cWAkC1bQ+g=;
	b=mamBMRBBrlyfw0yCOszb29sUNORcANy4xZZIZYdE6rxjmvxJeY/AlTUl5Pn672YOUv1Q
	 rQvyLMFE6wvBWKfHGvvNY/ODB9fUKVmyHRYiG2PyAJibDDzqnrENOsOuRppLGRymg4Tzk
	 ITVwvrxRJe2Xp7mxBpuYpE3uW6PLNS61HGTAa8m7KjnoMoxytaOshouoF1UXbA+DEAlk3
	 I7w/DMu0UxGeyi3Ur2XHz+A7y8B+UicL8FffKMibRQ3DvMXJzOCQwKvaq6bELkNcOR2kM
	 SU9UjomjHopLyDd0SzPJudU9vwYs1ZCBF74m2vmktgTPLcriHxn4L2VYj06E25vhkxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C530606A321;
	Fri, 13 Nov 2026 11:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C530606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jQwjn2LcbzVcBF;
	Fri, 13 Nov 2026 19:57:33 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jQwjk6szYzVcBF;
	Fri, 13 Nov 2026 19:57:30 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 5F39730004D3;
	Fri, 13 Nov 2026 19:56:40 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 13 Nov 2026 19:57:29 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: <axboe@kernel.dk>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<jack@suse.cz>
CC: <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>,
	<agruenba@redhat.com>, <mic@digikod.net>, <gnoack@google.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<aleksa@amutable.com>, <legion@kernel.org>, <david@kernel.org>,
	<sandeen@redhat.com>, <ebiggers@kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<gfs2@lists.linux.dev>, <linux-security-module@vger.kernel.org>,
	<sunjunchao@bytedance.com>, <shijie8@gmail.com>, Huang Shijie
	<huangsj@hygon.cn>
Subject: [PATCH v2 2/3] vfs: convert inode iterators to super_iter_inodes_unsafe()
Date: Fri, 13 Nov 2026 19:57:01 +0800
Message-ID: <20261113115702.586594-3-huangsj@hygon.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113115702.586594-1-huangsj@hygon.cn>
References: <20261113115702.586594-1-huangsj@hygon.cn>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

Convert VFS internal superblock inode iterators that cannot use
referenced inodes to super_iter_inodes_unsafe():
  - Dquot removal
  - inode eviction
  - The nr_blockdev_pages()
  - generic_shutdown_super()

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 block/bdev.c     | 19 +++++++----
 fs/inode.c       | 83 ++++++++++++++++++++++++++++--------------------
 fs/quota/dquot.c | 73 ++++++++++++++++++++++++++----------------
 fs/super.c       | 23 ++++++++------
 4 files changed, 121 insertions(+), 77 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index f20f91b3176e..3d8dd36b76df 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -558,16 +558,23 @@ void bdev_drop(struct block_device *bdev)
 	iput(BD_INODE(bdev));
 }
 
+static int bdev_pages_count(struct inode *inode, struct inode_iter_context *ctx)
+{
+	long *pages = ctx->priv;
+
+	*pages += inode->i_mapping->nrpages;
+	return INO_ITER_RET_NEXT;
+}
+
 long nr_blockdev_pages(void)
 {
-	struct inode *inode;
 	long ret = 0;
+	struct inode_iter_context ctx = {
+		.iter_fn = bdev_pages_count,
+		.priv = &ret,
+	};
 
-	spin_lock(&blockdev_superblock->s_inode_list_lock);
-	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list)
-		ret += inode->i_mapping->nrpages;
-	spin_unlock(&blockdev_superblock->s_inode_list_lock);
-
+	super_iter_inodes_unsafe(blockdev_superblock, &ctx);
 	return ret;
 }
 
diff --git a/fs/inode.c b/fs/inode.c
index f63535ee3629..f4a2a13a30b2 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -865,6 +865,42 @@ static void dispose_list(struct list_head *head)
 	}
 }
 
+static int evict_inode_fn(struct inode *inode, struct inode_iter_context *ctx)
+{
+	struct list_head *dispose = ctx->priv;
+
+	if (ctx->prev) {
+		list_add(&ctx->prev->i_lru, dispose);
+		ctx->prev = NULL;
+	}
+
+	if (icount_read_once(inode))
+		return INO_ITER_RET_NEXT;
+
+	spin_lock(&inode->i_lock);
+	if (icount_read(inode) ||
+	    (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE))) {
+		spin_unlock(&inode->i_lock);
+		return INO_ITER_RET_NEXT;
+	}
+
+	inode_state_set(inode, I_FREEING);
+	inode_lru_list_del(inode);
+	spin_unlock(&inode->i_lock);
+
+	/*
+	 * Keep this inode out of dispose so it stays on s_inodes while the
+	 * list lock is dropped. I_FREEING prevents new references and leaves
+	 * eviction to us, so the next walk can resume from it.
+	 */
+	if (need_resched()) {
+		ctx->prev = inode;
+		return INO_ITER_RET_ABORT;
+	}
+	list_add(&inode->i_lru, dispose);
+	return INO_ITER_RET_NEXT;
+}
+
 /**
  * evict_inodes	- evict all evictable inodes for a superblock
  * @sb:		superblock to operate on
@@ -876,44 +912,23 @@ static void dispose_list(struct list_head *head)
  */
 void evict_inodes(struct super_block *sb)
 {
-	struct inode *inode;
+	int ret;
 	LIST_HEAD(dispose);
+	struct inode_iter_context ctx = {
+		.iter_fn = evict_inode_fn,
+		.priv = &dispose,
+	};
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		if (icount_read_once(inode))
-			continue;
-
-		spin_lock(&inode->i_lock);
-		if (icount_read(inode)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		if (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-
-		inode_state_set(inode, I_FREEING);
-		inode_lru_list_del(inode);
-		spin_unlock(&inode->i_lock);
+	do {
+		ret = super_iter_inodes_unsafe(sb, &ctx);
 
-		/*
-		 * Keep this inode out of dispose so it stays on s_inodes while
-		 * the list lock is dropped. I_FREEING prevents new references
-		 * and leaves eviction to us, so we can resume the walk from it.
-		 */
-		if (need_resched()) {
-			spin_unlock(&sb->s_inode_list_lock);
-			cond_resched();
-			dispose_list(&dispose);
-			spin_lock(&sb->s_inode_list_lock);
-		}
-		list_add(&inode->i_lru, &dispose);
-	}
-	spin_unlock(&sb->s_inode_list_lock);
+		/* Handle the loop end carefully */
+		if (ret == INO_ITER_RET_DONE && ctx.prev)
+			list_add(&ctx.prev->i_lru, &dispose);
 
-	dispose_list(&dispose);
+		cond_resched();
+		dispose_list(&dispose);
+	} while (ret != INO_ITER_RET_DONE);
 }
 EXPORT_SYMBOL_GPL(evict_inodes);
 
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index a3d503591871..1b374a0c347a 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -83,6 +83,8 @@
 
 #include <linux/uaccess.h>
 
+#include "../internal.h"
+
 /*
  * There are five quota SMP locks:
  * * dq_list_lock protects all lists with quotas and quota formats.
@@ -165,6 +167,11 @@ static struct kmem_cache *dquot_cachep;
 /* workqueue for work quota_release_work*/
 static struct workqueue_struct *quota_unbound_wq;
 
+struct dquot_ref_data {
+	int type;
+	int reserved;
+};
+
 void register_quota_format(struct quota_format_type *fmt)
 {
 	spin_lock(&dq_list_lock);
@@ -1117,41 +1124,51 @@ static int add_dquot_ref(struct super_block *sb, int type)
 	return err;
 }
 
-static void remove_dquot_ref(struct super_block *sb, int type)
+static int remove_dquot_ref_fn(struct inode *inode,
+				struct inode_iter_context *ctx)
 {
-	struct inode *inode;
-#ifdef CONFIG_QUOTA_DEBUG
-	int reserved = 0;
-#endif
+	struct dquot_ref_data *ref = ctx->priv;
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		/*
-		 *  We have to scan also I_NEW inodes because they can already
-		 *  have quota pointer initialized. Luckily, we need to touch
-		 *  only quota pointers and these have separate locking
-		 *  (dq_data_lock).
-		 */
-		spin_lock(&dq_data_lock);
-		if (!IS_NOQUOTA(inode)) {
-			struct dquot __rcu **dquots = i_dquot(inode);
-			struct dquot *dquot = srcu_dereference_check(
-				dquots[type], &dquot_srcu,
-				lockdep_is_held(&dq_data_lock));
+	spin_lock(&dq_data_lock);
+	if (!IS_NOQUOTA(inode)) {
+		struct dquot __rcu **dquots = i_dquot(inode);
+		struct dquot *dquot = srcu_dereference_check(
+			dquots[ref->type], &dquot_srcu,
+			lockdep_is_held(&dq_data_lock));
 
 #ifdef CONFIG_QUOTA_DEBUG
-			if (unlikely(inode_get_rsv_space(inode) > 0))
-				reserved = 1;
+		if (unlikely(inode_get_rsv_space(inode) > 0))
+			ref->reserved++;
 #endif
-			rcu_assign_pointer(dquots[type], NULL);
-			if (dquot)
-				dqput(dquot);
-		}
-		spin_unlock(&dq_data_lock);
+		rcu_assign_pointer(dquots[ref->type], NULL);
+		if (dquot)
+			dqput(dquot);
 	}
-	spin_unlock(&sb->s_inode_list_lock);
+	spin_unlock(&dq_data_lock);
+	return INO_ITER_RET_NEXT;
+}
+
+static void remove_dquot_ref(struct super_block *sb, int type)
+{
+	struct dquot_ref_data ref = {
+		.type = type,
+	};
+	struct inode_iter_context ctx = {
+		.iter_fn = remove_dquot_ref_fn,
+		.priv = &ref,
+	};
+
+	/*
+	 * We have to scan I_NEW inodes because they can already
+	 * have quota pointer initialized. Luckily, we need to touch
+	 * only quota pointers and these have separate locking
+	 * (dq_data_lock) so the existence guarantee that
+	 * super_iter_inodes_unsafe() provides inodes passed to
+	 * remove_dquot_ref_fn() is sufficient for this operation.
+	 */
+	super_iter_inodes_unsafe(sb, &ctx);
 #ifdef CONFIG_QUOTA_DEBUG
-	if (reserved) {
+	if (ref.reserved) {
 		printk(KERN_WARNING "VFS (%s): Writes happened after quota"
 			" was disabled thus quota information is probably "
 			"inconsistent. Please run quotacheck(8).\n", sb->s_id);
diff --git a/fs/super.c b/fs/super.c
index 32137422df35..f2a93bdc4a81 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -743,6 +743,15 @@ void retire_super(struct super_block *sb)
 }
 EXPORT_SYMBOL(retire_super);
 
+static int inode_poison_fn(struct inode *inode, struct inode_iter_context *ctx)
+{
+	inode->i_op = VFS_PTR_POISON;
+	inode->i_sb = VFS_PTR_POISON;
+	inode->i_mapping = VFS_PTR_POISON;
+
+	return INO_ITER_RET_NEXT;
+}
+
 /**
  *	generic_shutdown_super	-	common helper for ->kill_sb()
  *	@sb: superblock to kill
@@ -796,20 +805,16 @@ void generic_shutdown_super(struct super_block *sb)
 		if (CHECK_DATA_CORRUPTION(!list_empty(&sb->s_inodes), NULL,
 				"VFS: Busy inodes after unmount of %s (%s)",
 				sb->s_id, sb->s_type->name)) {
+			struct inode_iter_context ctx = {
+				.iter_fn = inode_poison_fn,
+			};
+
 			/*
 			 * Adding a proper bailout path here would be hard, but
 			 * we can at least make it more likely that a later
 			 * iput_final() or such crashes cleanly.
 			 */
-			struct inode *inode;
-
-			spin_lock(&sb->s_inode_list_lock);
-			list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-				inode->i_op = VFS_PTR_POISON;
-				inode->i_sb = VFS_PTR_POISON;
-				inode->i_mapping = VFS_PTR_POISON;
-			}
-			spin_unlock(&sb->s_inode_list_lock);
+			super_iter_inodes_unsafe(sb, &ctx);
 		}
 	}
 	/*
-- 
2.53.0


