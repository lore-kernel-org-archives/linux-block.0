Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794571062;
	b=pnbU7TIrxwKMwdiJNbRQimsr7fyBin16/omT6Jif2bdZa1RcaQJrrQK1bhreGtaNQRkO
	 9X8NcAni1NKpX1ZlK43zIUdkEktjFuLHpp02k0Yght8srmBavJIeDRwZqUeoEwmNVgE9E
	 WBJ4i3Nn3zQMpKrxalbjtyvApkPR9TSgTfCOgujq/09UPPG2GgH+l88gzIS2XL2GAG7Eh
	 VJQ3IJ8fZwOTa7mXpylB6pXD4tg9ZFYcNJl+tAfCDyoTdytoG3m8XI2b5oYoMxa6YqsmN
	 MvxkfwcwDj2vDXHAJrc92kf8iEo6zLkRk5fynVCdeWvFyqyFQvxocRyenPcGDfey7Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571062;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=INwmnsFASdl+CJH5RPf/lpWEGx+Pnucp7Uad3gfajlc=;
	b=h7DJLI57nGTApTbdk+0SjwswkRRSqLQMk7I0NeGq/94HdKSXBnm43/mx9STfUUwNVpKT
	 gCKiMnHazG/dwVpAJAM4MR0b9s3fnRUY10aYD5yp7AgSBWBmcgskBopqoiG3CDFTKC7o9
	 A9zCKiKzNiDMvyJRO3kng46o2dN2VwKaqgxpJ8A83IJYzqYqxT5QEl0+qenrnf4PCii4H
	 naRoegIt6HOTb0uk+CrXh+Nq9AuTsscIlzKrn3WwQFgpzlctL4OV0jwo2hHiSlwTDiovW
	 gq8UuvcD3GB1wwIdAQjxzi2Mb4BQz0AnzdXWqruunqMfeRcl9orpjNhnMuNOhKnJv5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D17606A330;
	Fri, 13 Nov 2026 11:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88D17606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jQwjr2Ld5zVcBH;
	Fri, 13 Nov 2026 19:57:36 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jQwjn33CmzVcBJ;
	Fri, 13 Nov 2026 19:57:33 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 9C23C13A5C;
	Fri, 13 Nov 2026 19:57:24 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 13 Nov 2026 19:57:31 +0800
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
Subject: [PATCH v2 3/3] vfs: convert sb->s_inodes iteration to super_iter_inodes()
Date: Fri, 13 Nov 2026 19:57:02 +0800
Message-ID: <20261113115702.586594-4-huangsj@hygon.cn>
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

Convert all the remaining superblock inode iterators to use
super_iter_inodes(). These are mostly straight forward conversions
for the iterations that use referenced inodes:
 - sync_bdevs
 - drop_pagecache_sb
 - gfs2_kill_sb
 - add_dquot_ref
 - hook_sb_delete

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 block/bdev.c           |  92 +++++++++++--------------
 fs/drop_caches.c       |  49 ++++++-------
 fs/gfs2/ops_fstype.c   |  33 +++------
 fs/quota/dquot.c       |  76 +++++++++-----------
 security/landlock/fs.c | 153 +++++++++++++++++------------------------
 5 files changed, 168 insertions(+), 235 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 3d8dd36b76df..8ef6cdad0cec 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1343,66 +1343,54 @@ void bdev_mark_dead(struct block_device *bdev, bool surprise)
  */
 EXPORT_SYMBOL_GPL(bdev_mark_dead);
 
-void sync_bdevs(bool wait)
+static bool sync_bdev_eligible(struct inode *inode,
+				struct inode_iter_context *ctx)
 {
-	struct inode *inode, *old_inode = NULL;
+	return inode->i_mapping->nrpages != 0;
+}
 
-	spin_lock(&blockdev_superblock->s_inode_list_lock);
-	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list) {
-		struct address_space *mapping = inode->i_mapping;
-		struct block_device *bdev;
+static int sync_bdev_fn(struct inode *inode, struct inode_iter_context *ctx)
+{
+	bool wait = *(bool *)ctx->priv;
+	struct block_device *bdev;
 
-		spin_lock(&inode->i_lock);
-		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW) ||
-		    mapping->nrpages == 0) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
-		spin_unlock(&blockdev_superblock->s_inode_list_lock);
-		/*
-		 * We hold a reference to 'inode' so it couldn't have been
-		 * removed from s_inodes list while we dropped the
-		 * s_inode_list_lock  We cannot iput the inode now as we can
-		 * be holding the last reference and we cannot iput it under
-		 * s_inode_list_lock. So we keep the reference and iput it
-		 * later.
-		 */
-		iput(old_inode);
-		old_inode = inode;
-		bdev = I_BDEV(inode);
+	bdev = I_BDEV(inode);
+	/*
+	 * The inode does not keep the gendisk of a partition alive, the
+	 * device does.
+	 */
+	if (!kobject_get_unless_zero(&bdev->bd_device.kobj))
+		return INO_ITER_RET_NEXT;
 
+	mutex_lock(&bdev->bd_disk->open_mutex);
+	if (!atomic_read(&bdev->bd_openers)) {
+		; /* skip */
+	} else if (wait) {
 		/*
-		 * The inode does not keep the gendisk of a partition alive, the
-		 * device does.
+		 * We keep the error status of individual mapping so
+		 * that applications can catch the writeback error using
+		 * fsync(2). See filemap_fdatawait_keep_errors() for
+		 * details.
 		 */
-		if (!kobject_get_unless_zero(&bdev->bd_device.kobj)) {
-			spin_lock(&blockdev_superblock->s_inode_list_lock);
-			continue;
-		}
+		filemap_fdatawait_keep_errors(inode->i_mapping);
+	} else {
+		filemap_fdatawrite(inode->i_mapping);
+	}
+	mutex_unlock(&bdev->bd_disk->open_mutex);
+	put_device(&bdev->bd_device);
 
-		mutex_lock(&bdev->bd_disk->open_mutex);
-		if (!atomic_read(&bdev->bd_openers)) {
-			; /* skip */
-		} else if (wait) {
-			/*
-			 * We keep the error status of individual mapping so
-			 * that applications can catch the writeback error using
-			 * fsync(2). See filemap_fdatawait_keep_errors() for
-			 * details.
-			 */
-			filemap_fdatawait_keep_errors(inode->i_mapping);
-		} else {
-			filemap_fdatawrite(inode->i_mapping);
-		}
-		mutex_unlock(&bdev->bd_disk->open_mutex);
-		put_device(&bdev->bd_device);
+	return INO_ITER_RET_NEXT;
+}
 
-		spin_lock(&blockdev_superblock->s_inode_list_lock);
-	}
-	spin_unlock(&blockdev_superblock->s_inode_list_lock);
-	iput(old_inode);
+void sync_bdevs(bool wait)
+{
+	struct inode_iter_context ctx = {
+		.iter_fn = sync_bdev_fn,
+		.eligible = sync_bdev_eligible,
+		.priv = &wait,
+	};
+
+	super_iter_inodes(blockdev_superblock, &ctx);
 }
 
 /*
diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 28c5fb9c7357..8b286a595d12 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -17,39 +17,34 @@
 /* A global variable is a bit ugly, but it keeps the code simple */
 static int sysctl_drop_caches;
 
+static bool invalidate_inode_eligible(struct inode *inode,
+			struct inode_iter_context *ctx)
+{
+	/*
+	 * We skip inodes without pages but we deliberately won't
+	 * in case we need to reschedule to avoid softlockups.
+	 */
+	return !mapping_empty(inode->i_mapping) || need_resched();
+}
+
+static int invalidate_inode_fn(struct inode *inode,
+			struct inode_iter_context *ctx)
+{
+	invalidate_mapping_pages(inode->i_mapping, 0, -1);
+	return INO_ITER_RET_NEXT;
+}
+
 static void drop_pagecache_sb(struct super_block *sb, void *unused)
 {
-	struct inode *inode, *toput_inode = NULL;
+	struct inode_iter_context ctx = {
+		.iter_fn = invalidate_inode_fn,
+		.eligible = invalidate_inode_eligible,
+	};
 
 	if (sb->s_bdi == &noop_backing_dev_info)
 		return;
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		spin_lock(&inode->i_lock);
-		/*
-		 * We must skip inodes in unusual state. We may also skip
-		 * inodes without pages but we deliberately won't in case
-		 * we need to reschedule to avoid softlockups.
-		 */
-		if ((inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) ||
-		    (mapping_empty(inode->i_mapping) && !need_resched())) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
-
-		invalidate_mapping_pages(inode->i_mapping, 0, -1);
-		iput(toput_inode);
-		toput_inode = inode;
-
-		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
-	}
-	spin_unlock(&sb->s_inode_list_lock);
-	iput(toput_inode);
+	super_iter_inodes(sb, &ctx);
 }
 
 static int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 6ec47376aecf..e27b0bdf1dbf 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1717,6 +1717,13 @@ static int gfs2_meta_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+/* Nothing to do because we just want to bounce the inode through iput() */
+static int gfs2_evict_inode_fn(struct inode *inode,
+			struct inode_iter_context *ctx)
+{
+	return INO_ITER_RET_NEXT;
+}
+
 /**
  * gfs2_evict_inodes - evict inodes cooperatively
  * @sb: the superblock
@@ -1739,31 +1746,13 @@ static int gfs2_meta_init_fs_context(struct fs_context *fc)
  */
 static void gfs2_evict_inodes(struct super_block *sb)
 {
-	struct inode *inode, *toput_inode = NULL;
 	struct gfs2_sbd *sdp = sb->s_fs_info;
+	struct inode_iter_context ctx = {
+		.iter_fn = gfs2_evict_inode_fn,
+	};
 
 	set_bit(SDF_EVICTING, &sdp->sd_flags);
-
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		spin_lock(&inode->i_lock);
-		if ((inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) &&
-		    !need_resched()) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
-
-		iput(toput_inode);
-		toput_inode = inode;
-
-		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
-	}
-	spin_unlock(&sb->s_inode_list_lock);
-	iput(toput_inode);
+	super_iter_inodes(sb, &ctx);
 }
 
 static void gfs2_kill_sb(struct super_block *sb)
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 1b374a0c347a..25ea8f176363 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1066,56 +1066,46 @@ static int dqinit_needed(struct inode *inode, int type)
 	return 0;
 }
 
-/* This routine is guarded by s_umount semaphore */
-static int add_dquot_ref(struct super_block *sb, int type)
+static bool add_dquot_ref_eligible(struct inode *inode,
+				struct inode_iter_context *ctx)
 {
-	struct inode *inode, *old_inode = NULL;
-#ifdef CONFIG_QUOTA_DEBUG
-	int reserved = 0;
-#endif
-	int err = 0;
+	struct dquot_ref_data *ref = ctx->priv;
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		spin_lock(&inode->i_lock);
-		if ((inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) ||
-		    !atomic_read(&inode->i_writecount) ||
-		    !dqinit_needed(inode, type)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
+	return atomic_read(&inode->i_writecount) &&
+	       dqinit_needed(inode, ref->type);
+}
+
+static int add_dquot_ref_fn(struct inode *inode, struct inode_iter_context *ctx)
+{
+	struct dquot_ref_data *ref = ctx->priv;
+	int ret;
 
 #ifdef CONFIG_QUOTA_DEBUG
-		if (unlikely(inode_get_rsv_space(inode) > 0))
-			reserved = 1;
+	if (unlikely(inode_get_rsv_space(inode) > 0))
+		ref->reserved++;
 #endif
-		iput(old_inode);
-		err = __dquot_initialize(inode, type);
-		if (err) {
-			iput(inode);
-			goto out;
-		}
+	ret = __dquot_initialize(inode, ref->type);
+	if (ret)
+		return ret;
+	return INO_ITER_RET_NEXT;
+}
 
-		/*
-		 * We hold a reference to 'inode' so it couldn't have been
-		 * removed from s_inodes list while we dropped the
-		 * s_inode_list_lock. We cannot iput the inode now as we can be
-		 * holding the last reference and we cannot iput it under
-		 * s_inode_list_lock. So we keep the reference and iput it
-		 * later.
-		 */
-		old_inode = inode;
-		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
-	}
-	spin_unlock(&sb->s_inode_list_lock);
-	iput(old_inode);
-out:
+/* This routine is guarded by s_umount semaphore */
+static int add_dquot_ref(struct super_block *sb, int type)
+{
+	struct dquot_ref_data ref = {
+		.type = type,
+	};
+	struct inode_iter_context ctx = {
+		.iter_fn = add_dquot_ref_fn,
+		.eligible = add_dquot_ref_eligible,
+		.priv = &ref,
+	};
+	int err;
+
+	err = super_iter_inodes(sb, &ctx);
 #ifdef CONFIG_QUOTA_DEBUG
-	if (reserved) {
+	if (ref.reserved) {
 		quota_error(sb, "Writes happened before quota was turned on "
 			"thus quota information is probably inconsistent. "
 			"Please run quotacheck(8)");
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 2ab67bcad198..f4385d5606c5 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1375,110 +1375,81 @@ static void hook_inode_free_security_rcu(void *inode_security)
 
 /* Super-block hooks */
 
-/*
- * Release the inodes used in a security policy.
- *
- * Cf. fsnotify_unmount_inodes() and evict_inodes()
- */
-static void hook_sb_delete(struct super_block *const sb)
+static bool release_inode_eligible(struct inode *inode,
+				struct inode_iter_context *ctx)
 {
-	struct inode *inode, *prev_inode = NULL;
+	bool ret;
 
-	if (!landlock_initialized)
-		return;
+	rcu_read_lock();
+	ret = !!rcu_dereference(landlock_inode(inode)->object);
+	rcu_read_unlock();
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		struct landlock_object *object;
+	return ret;
+}
 
-		/* Only handles referenced inodes. */
-		if (!icount_read_once(inode))
-			continue;
+static int release_inode_fn(struct inode *inode, struct inode_iter_context *ctx)
+{
+	struct landlock_object *object;
+
+	rcu_read_lock();
+	object = rcu_dereference(landlock_inode(inode)->object);
+	if (!object) {
+		rcu_read_unlock();
+		return INO_ITER_RET_NEXT;
+	}
+
+	/*
+	 * If there is no concurrent release_inode() ongoing, then we
+	 * are in charge of calling iput() on this inode, otherwise we
+	 * will just wait for it to finish.
+	 */
+	spin_lock(&object->lock);
+	if (object->underobj == inode) {
+		object->underobj = NULL;
+		spin_unlock(&object->lock);
+		rcu_read_unlock();
 
 		/*
-		 * Protects against concurrent modification of inode (e.g.
-		 * from get_inode_object()).
+		 * Because object->underobj was not NULL,
+		 * release_inode() and get_inode_object() guarantee
+		 * that it is safe to reset
+		 * landlock_inode(inode)->object while it is not NULL.
+		 * It is therefore not necessary to lock inode->i_lock.
 		 */
-		spin_lock(&inode->i_lock);
+		rcu_assign_pointer(landlock_inode(inode)->object, NULL);
 		/*
-		 * Checks I_FREEING and I_WILL_FREE  to protect against a race
-		 * condition when release_inode() just called iput(), which
-		 * could lead to a NULL dereference of inode->security or a
-		 * second call to iput() for the same Landlock object.  Also
-		 * checks I_NEW because such inode cannot be tied to an object.
+		 * At this point, we own the ihold() reference that was
+		 * originally set up by get_inode_object() and the
+		 * __iget() reference that we just set in this loop
+		 * walk.  Therefore there are at least two references
+		 * on the inode.
 		 */
-		if (inode_state_read(inode) &
-		    (I_FREEING | I_WILL_FREE | I_NEW)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-
-		rcu_read_lock();
-		object = rcu_dereference(landlock_inode(inode)->object);
-		if (!object) {
-			rcu_read_unlock();
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		/* Keeps a reference to this inode until the next loop walk. */
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
+		iput_not_last(inode);
+	} else {
+		spin_unlock(&object->lock);
+		rcu_read_unlock();
+	}
+	return INO_ITER_RET_NEXT;
+}
 
-		/*
-		 * If there is no concurrent release_inode() ongoing, then we
-		 * are in charge of calling iput() on this inode, otherwise we
-		 * will just wait for it to finish.
-		 */
-		spin_lock(&object->lock);
-		if (object->underobj == inode) {
-			object->underobj = NULL;
-			spin_unlock(&object->lock);
-			rcu_read_unlock();
+/*
+ * Release the inodes used in a security policy.
+ *
+ * Cf. fsnotify_unmount_inodes() and evict_inodes()
+ */
+static void hook_sb_delete(struct super_block *const sb)
+{
+	struct inode_iter_context ctx = {
+		.iter_fn = release_inode_fn,
+		.eligible = release_inode_eligible,
+		.flags = INO_ITER_F_REFERENCED,
+	};
 
-			/*
-			 * Because object->underobj was not NULL,
-			 * release_inode() and get_inode_object() guarantee
-			 * that it is safe to reset
-			 * landlock_inode(inode)->object while it is not NULL.
-			 * It is therefore not necessary to lock inode->i_lock.
-			 */
-			rcu_assign_pointer(landlock_inode(inode)->object, NULL);
-			/*
-			 * At this point, we own the ihold() reference that was
-			 * originally set up by get_inode_object() and the
-			 * __iget() reference that we just set in this loop
-			 * walk.  Therefore there are at least two references
-			 * on the inode.
-			 */
-			iput_not_last(inode);
-		} else {
-			spin_unlock(&object->lock);
-			rcu_read_unlock();
-		}
+	if (!landlock_initialized)
+		return;
 
-		if (prev_inode) {
-			/*
-			 * At this point, we still own the __iget() reference
-			 * that we just set in this loop walk.  Therefore we
-			 * can drop the list lock and know that the inode won't
-			 * disappear from under us until the next loop walk.
-			 */
-			spin_unlock(&sb->s_inode_list_lock);
-			/*
-			 * We can now actually put the inode reference from the
-			 * previous loop walk, which is not needed anymore.
-			 */
-			iput(prev_inode);
-			cond_resched();
-			spin_lock(&sb->s_inode_list_lock);
-		}
-		prev_inode = inode;
-	}
-	spin_unlock(&sb->s_inode_list_lock);
+	super_iter_inodes(sb, &ctx);
 
-	/* Puts the inode reference from the last loop walk, if any. */
-	if (prev_inode)
-		iput(prev_inode);
 	/* Waits for pending iput() in release_inode(). */
 	wait_var_event(&landlock_superblock(sb)->inode_refs,
 		       !atomic_long_read(&landlock_superblock(sb)->inode_refs));
-- 
2.53.0


