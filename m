Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95652449EB2;
	Thu, 15 Oct 2026 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057261; cv=none; b=RghKIPglsWM6LumQsORP/ZYsqTV+urKAse3Zk5T+LHrZ72A5U69OurqhqgKHhGAxgIbPIwb23vBpLfRD/HTg+juAfJwIUZuMJPkzR9InNNzxUzRCE8+AUkkXqgaC253GmEqMrFDwdZa+HyPiDB0cQxuf6FBes+vGWVGdwUvHRQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057261; c=relaxed/simple;
	bh=q3Sr/MbF/bcdwQVZ1rannOiULzsKfI8fDO5Pj55cIhY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZRFIwnvQHO7vPtmxT40r6NGqzvmT1kcyK2qet/Twunp+EmYGgHg/e0uy1mRPXbaMUtAshbPvOmch8iJABJW4OYgQI1NTiGUMjrVXlz+fvigSspCUmmk22T83kLqejHxz0LbJFDYagS/8T2N8Sxazgn7ZIN7Lc4jLRHKKLtRD+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4j53346DqlzCWwYW;
	Thu, 15 Oct 2026 17:40:32 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4j53323Q92zCWwYP;
	Thu, 15 Oct 2026 17:40:30 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 2D59716E7;
	Thu, 15 Oct 2026 17:40:23 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 15 Oct 2026 17:40:28 +0800
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
Subject: [PATCH 3/3] vfs: convert sb->s_inodes iteration to super_iter_inodes()
Date: Thu, 15 Oct 2026 17:38:54 +0800
Message-ID: <20261015093854.2082600-4-huangsj@hygon.cn>
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
 block/bdev.c           |  68 +++++++-------------
 fs/drop_caches.c       |  36 +++--------
 fs/gfs2/ops_fstype.c   |  68 ++++++--------------
 fs/quota/dquot.c       |  66 +++++++------------
 security/landlock/fs.c | 142 ++++++++++++++---------------------------
 5 files changed, 123 insertions(+), 257 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 18b4423b4e61..b263b566056f 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1340,56 +1340,36 @@ void bdev_mark_dead(struct block_device *bdev, bool surprise)
  */
 EXPORT_SYMBOL_GPL(bdev_mark_dead);
 
-void sync_bdevs(bool wait)
+static int sync_bdev_fn(struct inode *inode, void *data)
 {
-	struct inode *inode, *old_inode = NULL;
+	struct block_device *bdev;
+	bool wait = *(bool *)data;
 
-	spin_lock(&blockdev_superblock->s_inode_list_lock);
-	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list) {
-		struct address_space *mapping = inode->i_mapping;
-		struct block_device *bdev;
+	if (inode->i_mapping->nrpages == 0)
+		return INO_ITER_RET_DONE;
 
-		spin_lock(&inode->i_lock);
-		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW) ||
-		    mapping->nrpages == 0) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
-		spin_unlock(&blockdev_superblock->s_inode_list_lock);
+	bdev = I_BDEV(inode);
+	mutex_lock(&bdev->bd_disk->open_mutex);
+	if (!atomic_read(&bdev->bd_openers)) {
+		; /* skip */
+	} else if (wait) {
 		/*
-		 * We hold a reference to 'inode' so it couldn't have been
-		 * removed from s_inodes list while we dropped the
-		 * s_inode_list_lock  We cannot iput the inode now as we can
-		 * be holding the last reference and we cannot iput it under
-		 * s_inode_list_lock. So we keep the reference and iput it
-		 * later.
+		 * We keep the error status of individual mapping so
+		 * that applications can catch the writeback error using
+		 * fsync(2). See filemap_fdatawait_keep_errors() for
+		 * details.
 		 */
-		iput(old_inode);
-		old_inode = inode;
-		bdev = I_BDEV(inode);
-
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
-
-		spin_lock(&blockdev_superblock->s_inode_list_lock);
+		filemap_fdatawait_keep_errors(inode->i_mapping);
+	} else {
+		filemap_fdatawrite(inode->i_mapping);
 	}
-	spin_unlock(&blockdev_superblock->s_inode_list_lock);
-	iput(old_inode);
+	mutex_unlock(&bdev->bd_disk->open_mutex);
+	return INO_ITER_RET_DONE;
+}
+
+void sync_bdevs(bool wait)
+{
+	super_iter_inodes(blockdev_superblock, sync_bdev_fn, &wait, 0);
 }
 
 /*
diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 28c5fb9c7357..3a476b1e17f7 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -17,39 +17,19 @@
 /* A global variable is a bit ugly, but it keeps the code simple */
 static int sysctl_drop_caches;
 
-static void drop_pagecache_sb(struct super_block *sb, void *unused)
+static int invalidate_inode_fn(struct inode *inode, void *data)
 {
-	struct inode *inode, *toput_inode = NULL;
+	if (!mapping_empty(inode->i_mapping))
+		invalidate_mapping_pages(inode->i_mapping, 0, -1);
+	return INO_ITER_RET_DONE;
+}
 
+static void drop_pagecache_sb(struct super_block *sb, void *unused)
+{
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
+	super_iter_inodes(sb, invalidate_inode_fn, NULL, 0);
 }
 
 static int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 718e0da7dfce..17e6294bfdb6 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1719,53 +1719,10 @@ static int gfs2_meta_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
-/**
- * gfs2_evict_inodes - evict inodes cooperatively
- * @sb: the superblock
- *
- * When evicting an inode with a zero link count, we are trying to upgrade the
- * inode's iopen glock from SH to EX mode in order to determine if we can
- * delete the inode.  The other nodes are supposed to evict the inode from
- * their caches if they can, and to poke the inode's inode glock if they cannot
- * do so.  Either behavior allows gfs2_upgrade_iopen_glock() to proceed
- * quickly, but if the other nodes are not cooperating, the lock upgrading
- * attempt will time out.  Since inodes are evicted sequentially, this can add
- * up quickly.
- *
- * Function evict_inodes() tries to keep the s_inode_list_lock list locked over
- * a long time, which prevents other inodes from being evicted concurrently.
- * This precludes the cooperative behavior we are looking for.  This special
- * version of evict_inodes() avoids that.
- *
- * Modeled after drop_pagecache_sb().
- */
-static void gfs2_evict_inodes(struct super_block *sb)
+/* Nothing to do because we just want to bounce the inode through iput() */
+static int gfs2_evict_inode_fn(struct inode *inode, void *data)
 {
-	struct inode *inode, *toput_inode = NULL;
-	struct gfs2_sbd *sdp = sb->s_fs_info;
-
-	set_bit(SDF_EVICTING, &sdp->sd_flags);
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
+	return INO_ITER_RET_DONE;
 }
 
 static void gfs2_kill_sb(struct super_block *sb)
@@ -1785,7 +1742,24 @@ static void gfs2_kill_sb(struct super_block *sb)
 	shrink_dcache_sb(sb);
 
 	set_bit(SDF_KILL, &sdp->sd_flags);
-	gfs2_evict_inodes(sb);
+
+	/*
+	 * When evicting an inode with a zero link count, we are trying to
+	 * upgrade the inode's iopen glock from SH to EX mode in order to
+	 * determine if we can delete the inode. The other nodes are supposed
+	 * to evict the inode from their caches if they can, and to poke the
+	 * inode's inode glock if they cannot do so. Either behavior allows
+	 * gfs2_upgrade_iopen_glock() to proceed quickly, but if the other nodes
+	 * are not cooperating, the lock upgrading attempt will time out. Since
+	 * inodes are evicted sequentially, this can add up quickly.
+	 *
+	 * evict_inodes() tries to keep the s_inode_list_lock list locked over a
+	 * long time, which prevents other inodes from being evicted
+	 * concurrently. This precludes the cooperative behavior we are looking
+	 * for.
+	 */
+	set_bit(SDF_EVICTING, &sdp->sd_flags);
+	super_iter_inodes(sb, gfs2_evict_inode_fn, NULL, 0);
 
 	/*
 	 * Flush and then drain the delete workqueue here (via
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index f9d7ee4dffcd..10fce6ee9804 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1048,56 +1048,36 @@ static int dqinit_needed(struct inode *inode, int type)
 	return 0;
 }
 
-/* This routine is guarded by s_umount semaphore */
-static int add_dquot_ref(struct super_block *sb, int type)
+static int add_dquot_ref_fn(struct inode *inode, void *data)
 {
-	struct inode *inode, *old_inode = NULL;
-#ifdef CONFIG_QUOTA_DEBUG
-	int reserved = 0;
-#endif
-	int err = 0;
+	struct dquot_ref_data *ref = data;
+	int ret;
 
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
+	if (!atomic_read(&inode->i_writecount) ||
+	    !dqinit_needed(inode, ref->type))
+		return INO_ITER_RET_DONE;
 
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
+	if (ret < 0)
+		return ret;
+	return INO_ITER_RET_DONE;
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
+	int err;
+
+	err = super_iter_inodes(sb, add_dquot_ref_fn, &ref, 0);
 #ifdef CONFIG_QUOTA_DEBUG
-	if (reserved) {
+	if (ref.reserved) {
 		quota_error(sb, "Writes happened before quota was turned on "
 			"thus quota information is probably inconsistent. "
 			"Please run quotacheck(8)");
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index cab43892ec2f..5d88bfd616c0 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1375,110 +1375,62 @@ static void hook_inode_free_security_rcu(void *inode_security)
 
 /* Super-block hooks */
 
-/*
- * Release the inodes used in a security policy.
- *
- * Cf. fsnotify_unmount_inodes() and evict_inodes()
- */
-static void hook_sb_delete(struct super_block *const sb)
+static int release_inode_fn(struct inode *inode, void *data)
 {
-	struct inode *inode, *prev_inode = NULL;
-
-	if (!landlock_initialized)
-		return;
+	struct landlock_object *object;
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		struct landlock_object *object;
+	rcu_read_lock();
+	object = rcu_dereference(landlock_inode(inode)->object);
+	if (!object) {
+		rcu_read_unlock();
+		return INO_ITER_RET_DONE;
+	}
 
-		/* Only handles referenced inodes. */
-		if (!icount_read_once(inode))
-			continue;
+	/*
+	 * If there is no concurrent release_inode() ongoing, then we
+	 * are in charge of calling iput() on this inode, otherwise we
+	 * will just wait for it to finish.
+	 */
+	spin_lock(&object->lock);
+	if (object->underobj != inode) {
+		spin_unlock(&object->lock);
+		rcu_read_unlock();
+		return INO_ITER_RET_DONE;
+	}
 
-		/*
-		 * Protects against concurrent modification of inode (e.g.
-		 * from get_inode_object()).
-		 */
-		spin_lock(&inode->i_lock);
-		/*
-		 * Checks I_FREEING and I_WILL_FREE  to protect against a race
-		 * condition when release_inode() just called iput(), which
-		 * could lead to a NULL dereference of inode->security or a
-		 * second call to iput() for the same Landlock object.  Also
-		 * checks I_NEW because such inode cannot be tied to an object.
-		 */
-		if (inode_state_read(inode) &
-		    (I_FREEING | I_WILL_FREE | I_NEW)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
+	object->underobj = NULL;
+	spin_unlock(&object->lock);
+	rcu_read_unlock();
 
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
+	/*
+	 * Because object->underobj was not NULL, release_inode() and
+	 * get_inode_object() guarantee that it is safe to reset
+	 * landlock_inode(inode)->object while it is not NULL.  It is therefore
+	 * not necessary to lock inode->i_lock.
+	 */
+	rcu_assign_pointer(landlock_inode(inode)->object, NULL);
 
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
+	/*
+	 * At this point, we own the ihold() reference that was originally set
+	 * up by get_inode_object() as well as the reference the inode iterator
+	 * obtained before calling us.  Therefore the following call to
+	 * iput_not_last() will not sleep nor drop the inode because there is
+	 * now at least two references to it.
+	 */
+	iput_not_last(inode);
+	return INO_ITER_RET_DONE;
+}
 
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
+/*
+ * Release the inodes used in a security policy.
+ */
+static void hook_sb_delete(struct super_block *const sb)
+{
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
+	super_iter_inodes(sb, release_inode_fn, NULL, INO_ITER_F_REFERENCED);
 
-	/* Puts the inode reference from the last loop walk, if any. */
-	if (prev_inode)
-		iput(prev_inode);
 	/* Waits for pending iput() in release_inode(). */
 	wait_var_event(&landlock_superblock(sb)->inode_refs,
 		       !atomic_long_read(&landlock_superblock(sb)->inode_refs));
-- 
2.34.1


