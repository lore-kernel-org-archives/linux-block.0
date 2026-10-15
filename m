Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCD14A262C;
	Thu, 15 Oct 2026 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057256; cv=none; b=gbwQrBRIBn9r8ek49uzriGGyVQQgk5k0dc+JhTt5tAHRYwTZZhMZtpMn30HnsPoiHn35NaAW9d2usBlhfYQC8P0qbDBcFd4kEUefmj7YAQ1vFcHSPyIrTM5JIRJVEUDkP+OQBp75imAHKUuSoYT2mDyMtrG7QW875kQWkGKibXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057256; c=relaxed/simple;
	bh=oO5P3EyDNIjmA1OYPv2gXSn0IF7rkYj/4HQ+3XqRQi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTZFJcxb5zC1ReuJ3lAc0+A9Qno8xyHz1Vpp6WsxL2+SBR6sm49g40H24KD7Xjg0mFqN/Eolo6aFYxQ9WISDeXsmhTyr6jsUOSmf46tXAJhmtFokVP+nYkfizzyXPoM7XF3iOUBzti3np82ZmET6kFwFWUs6Wi5RTMCayOU/m7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4j53316DsGzCWwYK;
	Thu, 15 Oct 2026 17:40:29 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4j532z5Nn3zCWwYK;
	Thu, 15 Oct 2026 17:40:27 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 10AA330004E2;
	Thu, 15 Oct 2026 17:35:18 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 15 Oct 2026 17:40:26 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: <axboe@kernel.dk>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>
CC: <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>,
	<jack@suse.cz>, <agruenba@redhat.com>, <mic@digikod.net>,
	<gnoack@google.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <aleksa@amutable.com>, <legion@kernel.org>,
	<david@kernel.org>, <sandeen@redhat.com>, <ebiggers@kernel.org>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <gfs2@lists.linux.dev>,
	<linux-security-module@vger.kernel.org>, <sunjunchao@bytedance.com>, Huang
 Shijie <huangsj@hygon.cn>
Subject: [PATCH 2/3] vfs: convert inode iterators to the unsafe super_iter_inodes()
Date: Thu, 15 Oct 2026 17:38:53 +0800
Message-ID: <20261015093854.2082600-3-huangsj@hygon.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015093854.2082600-1-huangsj@hygon.cn>
References: <20261015093854.2082600-1-huangsj@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

Convert VFS internal superblock inode iterators that cannot use
referenced inodes to super_iter_inodes() with INO_ITER_F_UNSAFE set:
  - Dquot removal
  - inode eviction
  - The nr_blockdev_pages()
  - generic_shutdown_super()

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 block/bdev.c     | 16 +++++++-----
 fs/inode.c       | 68 +++++++++++++++++++++++-------------------------
 fs/quota/dquot.c | 66 ++++++++++++++++++++++++++--------------------
 fs/super.c       | 20 +++++++-------
 4 files changed, 92 insertions(+), 78 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index cd8323083740..18b4423b4e61 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -558,16 +558,20 @@ void bdev_drop(struct block_device *bdev)
 	iput(BD_INODE(bdev));
 }
 
+static int bdev_pages_count(struct inode *inode, void *data)
+{
+	long *pages = data;
+
+	*pages += inode->i_mapping->nrpages;
+	return INO_ITER_RET_DONE;
+}
+
 long nr_blockdev_pages(void)
 {
-	struct inode *inode;
 	long ret = 0;
 
-	spin_lock(&blockdev_superblock->s_inode_list_lock);
-	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list)
-		ret += inode->i_mapping->nrpages;
-	spin_unlock(&blockdev_superblock->s_inode_list_lock);
-
+	super_iter_inodes(blockdev_superblock, bdev_pages_count,
+			  &ret, INO_ITER_F_UNSAFE);
 	return ret;
 }
 
diff --git a/fs/inode.c b/fs/inode.c
index a9d37be390a1..139c56ee9d11 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -853,8 +853,11 @@ static void evict(struct inode *inode)
  * Dispose-list gets a local list with local inodes in it, so it doesn't
  * need to worry about list corruption and SMP locks.
  */
-static void dispose_list(struct list_head *head)
+static bool dispose_list(struct list_head *head)
 {
+	if (list_empty(head))
+		return false;
+
 	while (!list_empty(head)) {
 		struct inode *inode;
 
@@ -864,6 +867,29 @@ static void dispose_list(struct list_head *head)
 		evict(inode);
 		cond_resched();
 	}
+	return true;
+}
+
+static int evict_inode_fn(struct inode *inode, void *data)
+{
+	struct list_head *dispose = data;
+
+	spin_lock(&inode->i_lock);
+	if (icount_read(inode) ||
+	    (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE))) {
+		spin_unlock(&inode->i_lock);
+		return INO_ITER_RET_DONE;
+	}
+
+	inode_state_set(inode, I_FREEING);
+	inode_lru_list_del(inode);
+	spin_unlock(&inode->i_lock);
+	list_add(&inode->i_lru, dispose);
+
+	/* Abort so evict_inodes() can dispose of the queued inodes first. */
+	if (need_resched())
+		return INO_ITER_RET_ABORT;
+	return INO_ITER_RET_DONE;
 }
 
 /**
@@ -877,44 +903,16 @@ static void dispose_list(struct list_head *head)
  */
 void evict_inodes(struct super_block *sb)
 {
-	struct inode *inode;
 	LIST_HEAD(dispose);
 
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
-
+	do {
 		/*
-		 * Keep this inode out of dispose so it stays on s_inodes while
-		 * the list lock is dropped. I_FREEING prevents new references
-		 * and leaves eviction to us, so we can resume the walk from it.
+		 * Taking references would keep the inodes we are trying to
+		 * evict alive, so use the unsafe iterator and let
+		 * evict_inode_fn() do the state checks and queue them.
 		 */
-		if (need_resched()) {
-			spin_unlock(&sb->s_inode_list_lock);
-			cond_resched();
-			dispose_list(&dispose);
-			spin_lock(&sb->s_inode_list_lock);
-		}
-		list_add(&inode->i_lru, &dispose);
-	}
-	spin_unlock(&sb->s_inode_list_lock);
-
-	dispose_list(&dispose);
+		super_iter_inodes(sb, evict_inode_fn, &dispose, INO_ITER_F_UNSAFE);
+	} while (dispose_list(&dispose));
 }
 EXPORT_SYMBOL_GPL(evict_inodes);
 
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 1c78c695d0dd..f9d7ee4dffcd 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -165,6 +165,11 @@ static struct kmem_cache *dquot_cachep;
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
@@ -1101,41 +1106,46 @@ static int add_dquot_ref(struct super_block *sb, int type)
 	return err;
 }
 
-static void remove_dquot_ref(struct super_block *sb, int type)
+static int remove_dquot_ref_fn(struct inode *inode, void *data)
 {
-	struct inode *inode;
-#ifdef CONFIG_QUOTA_DEBUG
-	int reserved = 0;
-#endif
+	struct dquot_ref_data *ref = data;
 
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
+	return INO_ITER_RET_DONE;
+}
+
+static void remove_dquot_ref(struct super_block *sb, int type)
+{
+	struct dquot_ref_data ref = {
+		.type = type,
+	};
+
+	/*
+	 * We have to scan I_NEW inodes because they can already
+	 * have quota pointer initialized. Luckily, we need to touch
+	 * only quota pointers and these have separate locking
+	 * (dq_data_lock) so the existence guarantee that
+	 * super_iter_inodes(..., INO_ITER_F_UNSAFE) provides inodes passed to
+	 * remove_dquot_ref_fn() is sufficient for this operation.
+	 */
+	super_iter_inodes(sb, remove_dquot_ref_fn, &ref, INO_ITER_F_UNSAFE);
 #ifdef CONFIG_QUOTA_DEBUG
-	if (reserved) {
+	if (ref.reserved) {
 		printk(KERN_WARNING "VFS (%s): Writes happened after quota"
 			" was disabled thus quota information is probably "
 			"inconsistent. Please run quotacheck(8).\n", sb->s_id);
diff --git a/fs/super.c b/fs/super.c
index 3f7df0bcb642..aacb1ba67544 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -817,6 +817,15 @@ void retire_super(struct super_block *sb)
 }
 EXPORT_SYMBOL(retire_super);
 
+static int inode_poison_fn(struct inode *inode, void *data)
+{
+	inode->i_op = VFS_PTR_POISON;
+	inode->i_sb = VFS_PTR_POISON;
+	inode->i_mapping = VFS_PTR_POISON;
+
+	return INO_ITER_RET_DONE;
+}
+
 /**
  *	generic_shutdown_super	-	common helper for ->kill_sb()
  *	@sb: superblock to kill
@@ -875,15 +884,8 @@ void generic_shutdown_super(struct super_block *sb)
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
+			super_iter_inodes(sb, inode_poison_fn, NULL,
+					  INO_ITER_F_UNSAFE);
 		}
 	}
 	/*
-- 
2.34.1


