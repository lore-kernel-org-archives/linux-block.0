Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BD6C433EF
	for <linux-block@archiver.kernel.org>; Wed, 24 Nov 2021 21:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhKXWCR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Nov 2021 17:02:17 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:49514 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243780AbhKXWCP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Nov 2021 17:02:15 -0500
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1AOLwrF6037341;
        Thu, 25 Nov 2021 06:58:54 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Thu, 25 Nov 2021 06:58:53 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1AOLwrCI037338
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 25 Nov 2021 06:58:53 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <84a861dc-6d50-81c0-8e8b-461ef59f4c01@i-love.sakura.ne.jp>
Date:   Thu, 25 Nov 2021 06:58:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH] loop: replace loop_validate_mutex with loop_validate_spinlock
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 3ce6e1f662a91097 ("loop: reintroduce global lock for safe
loop_validate_file() traversal") had to use a mutex in order to avoid
AB-BA deadlock. But commit c895b784c699224d ("loop: don't hold lo_mutex
during __loop_clr_fd()") suggested me that we can also avoid AB-BA
deadlock without a mutex if we use dedicated state for individual
operations.

Thus, introduce Lo_binding state in order to allow loop_change_fd() and
loop_configure() to do their operations without holding lo_mutex, and
update loop_validate_file() to use a global spinlock.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/block/loop.c | 153 +++++++++++++++++--------------------------
 drivers/block/loop.h |   1 +
 2 files changed, 60 insertions(+), 94 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ba76319b5544..3dfb39d38235 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -88,46 +88,46 @@
 
 static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
-static DEFINE_MUTEX(loop_validate_mutex);
+static DEFINE_SPINLOCK(loop_validate_spinlock);
 
-/**
- * loop_global_lock_killable() - take locks for safe loop_validate_file() test
- *
- * @lo: struct loop_device
- * @global: true if @lo is about to bind another "struct loop_device", false otherwise
- *
- * Returns 0 on success, -EINTR otherwise.
- *
- * Since loop_validate_file() traverses on other "struct loop_device" if
- * is_loop_device() is true, we need a global lock for serializing concurrent
- * loop_configure()/loop_change_fd()/__loop_clr_fd() calls.
- */
-static int loop_global_lock_killable(struct loop_device *lo, bool global)
+static bool loop_try_update_state_locked(struct loop_device *lo, const int old, const int new)
 {
-	int err;
+	bool ret = false;
 
-	if (global) {
-		err = mutex_lock_killable(&loop_validate_mutex);
-		if (err)
-			return err;
+	lockdep_assert_held(&lo->lo_mutex);
+	spin_lock(&loop_validate_spinlock);
+	if (lo->lo_state == old) {
+		lo->lo_state = new;
+		ret = true;
 	}
-	err = mutex_lock_killable(&lo->lo_mutex);
-	if (err && global)
-		mutex_unlock(&loop_validate_mutex);
-	return err;
+	spin_unlock(&loop_validate_spinlock);
+	return ret;
 }
 
-/**
- * loop_global_unlock() - release locks taken by loop_global_lock_killable()
- *
- * @lo: struct loop_device
- * @global: true if @lo was about to bind another "struct loop_device", false otherwise
- */
-static void loop_global_unlock(struct loop_device *lo, bool global)
+static bool loop_try_update_state(struct loop_device *lo, const int old, const int new)
 {
+	bool ret;
+
+	if (mutex_lock_killable(&lo->lo_mutex))
+		return false;
+	ret = loop_try_update_state_locked(lo, old, new);
+	mutex_unlock(&lo->lo_mutex);
+	return ret;
+}
+
+static void loop_update_state_locked(struct loop_device *lo, const int state)
+{
+	lockdep_assert_held(&lo->lo_mutex);
+	spin_lock(&loop_validate_spinlock);
+	lo->lo_state = state;
+	spin_unlock(&loop_validate_spinlock);
+}
+
+static void loop_update_state(struct loop_device *lo, const int state)
+{
+	mutex_lock(&lo->lo_mutex);
+	loop_update_state_locked(lo, state);
 	mutex_unlock(&lo->lo_mutex);
-	if (global)
-		mutex_unlock(&loop_validate_mutex);
 }
 
 static int max_part;
@@ -532,25 +532,28 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
 {
 	struct inode	*inode = file->f_mapping->host;
 	struct file	*f = file;
+	int		err = 0;
 
 	/* Avoid recursion */
+	spin_lock(&loop_validate_spinlock);
 	while (is_loop_device(f)) {
 		struct loop_device *l;
 
-		lockdep_assert_held(&loop_validate_mutex);
-		if (f->f_mapping->host->i_rdev == bdev->bd_dev)
-			return -EBADF;
-
+		if (f->f_mapping->host->i_rdev == bdev->bd_dev) {
+			err = -EBADF;
+			break;
+		}
 		l = I_BDEV(f->f_mapping->host)->bd_disk->private_data;
-		if (l->lo_state != Lo_bound)
-			return -EINVAL;
-		/* Order wrt setting lo->lo_backing_file in loop_configure(). */
-		rmb();
+		if (l->lo_state != Lo_bound) {
+			err = -EINVAL;
+			break;
+		}
 		f = l->lo_backing_file;
 	}
-	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
-		return -EINVAL;
-	return 0;
+	if (!err && !S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
+		err = -EINVAL;
+	spin_unlock(&loop_validate_spinlock);
+	return err;
 }
 
 /*
@@ -568,17 +571,12 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	struct file *old_file;
 	int error;
 	bool partscan;
-	bool is_loop;
 
 	if (!file)
 		return -EBADF;
-	is_loop = is_loop_device(file);
-	error = loop_global_lock_killable(lo, is_loop);
-	if (error)
-		goto out_putf;
 	error = -ENXIO;
-	if (lo->lo_state != Lo_bound)
-		goto out_err;
+	if (!loop_try_update_state(lo, Lo_bound, Lo_binding))
+		goto out_putf;
 
 	/* the loop device has to be read-only */
 	error = -EINVAL;
@@ -608,16 +606,8 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
-	loop_global_unlock(lo, is_loop);
+	loop_update_state(lo, Lo_bound);
 
-	/*
-	 * Flush loop_validate_file() before fput(), for l->lo_backing_file
-	 * might be pointing at old_file which might be the last reference.
-	 */
-	if (!is_loop) {
-		mutex_lock(&loop_validate_mutex);
-		mutex_unlock(&loop_validate_mutex);
-	}
 	/*
 	 * We must drop file reference outside of lo_mutex as dropping
 	 * the file ref can take open_mutex which creates circular locking
@@ -629,7 +619,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	return 0;
 
 out_err:
-	loop_global_unlock(lo, is_loop);
+	loop_update_state(lo, Lo_bound);
 out_putf:
 	fput(file);
 	return error;
@@ -953,11 +943,9 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	loff_t size;
 	bool partscan;
 	unsigned short bsize;
-	bool is_loop;
 
 	if (!file)
 		return -EBADF;
-	is_loop = is_loop_device(file);
 
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
@@ -972,13 +960,9 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 			goto out_putf;
 	}
 
-	error = loop_global_lock_killable(lo, is_loop);
-	if (error)
-		goto out_bdev;
-
 	error = -EBUSY;
-	if (lo->lo_state != Lo_unbound)
-		goto out_unlock;
+	if (!loop_try_update_state(lo, Lo_unbound, Lo_binding))
+		goto out_bdev;
 
 	error = loop_validate_file(file, bdev);
 	if (error)
@@ -1053,17 +1037,13 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	size = get_loop_size(lo, file);
 	loop_set_size(lo, size);
 
-	/* Order wrt reading lo_state in loop_validate_file(). */
-	wmb();
-
-	lo->lo_state = Lo_bound;
 	if (part_shift)
 		lo->lo_flags |= LO_FLAGS_PARTSCAN;
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
 	if (partscan)
 		lo->lo_disk->flags &= ~GENHD_FL_NO_PART;
 
-	loop_global_unlock(lo, is_loop);
+	loop_update_state(lo, Lo_bound);
 	if (partscan)
 		loop_reread_partitions(lo);
 	if (!(mode & FMODE_EXCL))
@@ -1071,7 +1051,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	return 0;
 
 out_unlock:
-	loop_global_unlock(lo, is_loop);
+	loop_update_state(lo, Lo_unbound);
 out_bdev:
 	if (!(mode & FMODE_EXCL))
 		bd_abort_claiming(bdev, loop_configure);
@@ -1088,18 +1068,6 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	gfp_t gfp = lo->old_gfp_mask;
 	struct loop_worker *pos, *worker;
 
-	/*
-	 * Flush loop_configure() and loop_change_fd(). It is acceptable for
-	 * loop_validate_file() to succeed, for actual clear operation has not
-	 * started yet.
-	 */
-	mutex_lock(&loop_validate_mutex);
-	mutex_unlock(&loop_validate_mutex);
-	/*
-	 * loop_validate_file() now fails because l->lo_state != Lo_bound
-	 * became visible.
-	 */
-
 	/*
 	 * Since this function is called upon "ioctl(LOOP_CLR_FD)" xor "close()
 	 * after ioctl(LOOP_CLR_FD)", it is a sign of something going wrong if
@@ -1181,9 +1149,7 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	lo->lo_flags = 0;
 	if (!part_shift)
 		lo->lo_disk->flags |= GENHD_FL_NO_PART;
-	mutex_lock(&lo->lo_mutex);
-	lo->lo_state = Lo_unbound;
-	mutex_unlock(&lo->lo_mutex);
+	loop_update_state(lo, Lo_unbound);
 
 	/*
 	 * Need not hold lo_mutex to fput backing file. Calling fput holding
@@ -1219,7 +1185,7 @@ static int loop_clr_fd(struct loop_device *lo)
 		mutex_unlock(&lo->lo_mutex);
 		return 0;
 	}
-	lo->lo_state = Lo_rundown;
+	loop_update_state_locked(lo, Lo_rundown);
 	mutex_unlock(&lo->lo_mutex);
 
 	__loop_clr_fd(lo, false);
@@ -1739,9 +1705,8 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		goto out_unlock;
 
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
-		if (lo->lo_state != Lo_bound)
+		if (!loop_try_update_state_locked(lo, Lo_bound, Lo_rundown))
 			goto out_unlock;
-		lo->lo_state = Lo_rundown;
 		mutex_unlock(&lo->lo_mutex);
 		/*
 		 * In autoclear mode, stop the loop thread
@@ -1953,7 +1918,6 @@ static int loop_add(int i)
 	lo = kzalloc(sizeof(*lo), GFP_KERNEL);
 	if (!lo)
 		goto out;
-	lo->lo_state = Lo_unbound;
 
 	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
@@ -2024,6 +1988,7 @@ static int loop_add(int i)
 		disk->flags |= GENHD_FL_NO_PART;
 	atomic_set(&lo->lo_refcnt, 0);
 	mutex_init(&lo->lo_mutex);
+	loop_update_state(lo, Lo_unbound);
 	lo->lo_number		= i;
 	spin_lock_init(&lo->lo_lock);
 	spin_lock_init(&lo->lo_work_lock);
@@ -2119,7 +2084,7 @@ static int loop_control_remove(int idx)
 		goto mark_visible;
 	}
 	/* Mark this loop device no longer open()-able. */
-	lo->lo_state = Lo_deleting;
+	loop_update_state_locked(lo, Lo_deleting);
 	mutex_unlock(&lo->lo_mutex);
 
 	loop_remove(lo);
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 082d4b6bfc6a..56b9392737b2 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -19,6 +19,7 @@
 /* Possible states of device */
 enum {
 	Lo_unbound,
+	Lo_binding,
 	Lo_bound,
 	Lo_rundown,
 	Lo_deleting,
-- 
2.18.4

