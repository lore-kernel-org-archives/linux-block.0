Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFC6C11F68
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 15:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E7DE61427
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 15:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhGBPdn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Jul 2021 11:33:43 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:62867 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbhGBPdn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Jul 2021 11:33:43 -0400
Received: from fsav120.sakura.ne.jp (fsav120.sakura.ne.jp [27.133.134.247])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 162FUfXB068613;
        Sat, 3 Jul 2021 00:30:41 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav120.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp);
 Sat, 03 Jul 2021 00:30:41 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 162FUbEU068597
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 3 Jul 2021 00:30:41 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Petr Vorel <pvorel@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] loop: reintroduce global lock for safe loop_validate_file() traversal
Date:   Sat,  3 Jul 2021 00:30:36 +0900
Message-Id: <20210702153036.8089-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 6cc8e7430801fa23 ("loop: scale loop device by introducing per
device lock") re-opened a race window for NULL pointer dereference at
loop_validate_file() where commit 310ca162d779efee ("block/loop: Use
global lock for ioctl() operation.") closed.

Although we need to guarantee that other loop devices will not change
during traversal, we can't take remote "struct loop_device"->lo_mutex
inside loop_validate_file() in order to avoid AB-BA deadlock. Therefore,
introduce a global lock dedicated for loop_validate_file() which is
conditionally taken before local "struct loop_device"->lo_mutex is taken.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 6cc8e7430801fa23 ("loop: scale loop device by introducing per device lock")
---
 drivers/block/loop.c | 138 ++++++++++++++++++++++++++++---------------
 1 file changed, 89 insertions(+), 49 deletions(-)

This is a submission as a patch based on comments from Christoph Hellwig
at https://lkml.kernel.org/r/20210623144130.GA738@lst.de . I don't know
this patch can close all race windows.

For example, loop_change_fd() says

  This can only work if the loop device is used read-only, and if the
  new backing store is the same size and type as the old backing store.

and has

        /* size of the new backing store needs to be the same */
        if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
                goto out_err;

check. Then, do we also need to apply this global lock for
lo_simple_ioctl(LOOP_SET_CAPACITY) path because it changes the size
by loop_set_size(lo, get_loop_size(lo, lo->lo_backing_file)) ?
How serious if this check is racy?

Any other locations to apply this global lock?

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9f5a93688164..040f28b4bd5d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -88,6 +88,35 @@
 
 static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
+static DEFINE_MUTEX(loop_validate_mutex);
+
+static inline void loop_global_lock(struct loop_device *lo)
+{
+	mutex_lock(&loop_validate_mutex);
+	mutex_lock(&lo->lo_mutex);
+}
+
+static int loop_global_lock_killable(struct loop_device *lo, bool global)
+{
+	int err;
+
+	if (global) {
+		err = mutex_lock_killable(&loop_validate_mutex);
+		if (err)
+			return err;
+	}
+	err = mutex_lock_killable(&lo->lo_mutex);
+	if (err && global)
+		mutex_unlock(&loop_validate_mutex);
+	return err;
+}
+
+static void loop_global_unlock(struct loop_device *lo, bool global)
+{
+	mutex_unlock(&lo->lo_mutex);
+	if (global)
+		mutex_unlock(&loop_validate_mutex);
+}
 
 static int max_part;
 static int part_shift;
@@ -672,13 +701,13 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
 	while (is_loop_device(f)) {
 		struct loop_device *l;
 
+		lockdep_assert_held(&loop_validate_mutex);
 		if (f->f_mapping->host->i_rdev == bdev->bd_dev)
 			return -EBADF;
 
 		l = I_BDEV(f->f_mapping->host)->bd_disk->private_data;
-		if (l->lo_state != Lo_bound) {
+		if (l->lo_state != Lo_bound)
 			return -EINVAL;
-		}
 		f = l->lo_backing_file;
 	}
 	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
@@ -697,13 +726,20 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
 static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 			  unsigned int arg)
 {
-	struct file	*file = NULL, *old_file;
+	struct file *file = fget(arg);
+	struct file *old_file;
 	int		error;
 	bool		partscan;
+	bool is_loop;
 
-	error = mutex_lock_killable(&lo->lo_mutex);
-	if (error)
+	if (!file)
+		return -EBADF;
+	is_loop = is_loop_device(file);
+	error = loop_global_lock_killable(lo, is_loop);
+	if (error) {
+		fput(file);
 		return error;
+	}
 	error = -ENXIO;
 	if (lo->lo_state != Lo_bound)
 		goto out_err;
@@ -713,11 +749,6 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	if (!(lo->lo_flags & LO_FLAGS_READ_ONLY))
 		goto out_err;
 
-	error = -EBADF;
-	file = fget(arg);
-	if (!file)
-		goto out_err;
-
 	error = loop_validate_file(file, bdev);
 	if (error)
 		goto out_err;
@@ -740,7 +771,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
-	mutex_unlock(&lo->lo_mutex);
+	loop_global_unlock(lo, is_loop);
 	/*
 	 * We must drop file reference outside of lo_mutex as dropping
 	 * the file ref can take open_mutex which creates circular locking
@@ -752,9 +783,8 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	return 0;
 
 out_err:
-	mutex_unlock(&lo->lo_mutex);
-	if (file)
-		fput(file);
+	loop_global_unlock(lo, is_loop);
+	fput(file);
 	return error;
 }
 
@@ -1143,6 +1173,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	loff_t		size;
 	bool		partscan;
 	unsigned short  bsize;
+	bool is_loop;
 
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
@@ -1162,7 +1193,8 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 			goto out_putf;
 	}
 
-	error = mutex_lock_killable(&lo->lo_mutex);
+	is_loop = is_loop_device(file);
+	error = loop_global_lock_killable(lo, is_loop);
 	if (error)
 		goto out_bdev;
 
@@ -1253,7 +1285,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	 * put /dev/loopXX inode. Later in __loop_clr_fd() we bdput(bdev).
 	 */
 	bdgrab(bdev);
-	mutex_unlock(&lo->lo_mutex);
+	loop_global_unlock(lo, is_loop);
 	if (partscan)
 		loop_reread_partitions(lo);
 	if (!(mode & FMODE_EXCL))
@@ -1261,7 +1293,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	return 0;
 
 out_unlock:
-	mutex_unlock(&lo->lo_mutex);
+	loop_global_unlock(lo, is_loop);
 out_bdev:
 	if (!(mode & FMODE_EXCL))
 		bd_abort_claiming(bdev, loop_configure);
@@ -1400,15 +1432,12 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 
 static int loop_clr_fd(struct loop_device *lo)
 {
-	int err;
+	int err = loop_global_lock_killable(lo, true);
 
-	err = mutex_lock_killable(&lo->lo_mutex);
 	if (err)
 		return err;
-	if (lo->lo_state != Lo_bound) {
-		mutex_unlock(&lo->lo_mutex);
-		return -ENXIO;
-	}
+	if (lo->lo_state != Lo_bound)
+		err = -ENXIO;
 	/*
 	 * If we've explicitly asked to tear down the loop device,
 	 * and it has an elevated reference count, set it for auto-teardown when
@@ -1419,15 +1448,18 @@ static int loop_clr_fd(struct loop_device *lo)
 	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup -d
 	 * command to fail with EBUSY.
 	 */
-	if (atomic_read(&lo->lo_refcnt) > 1) {
+	else if (atomic_read(&lo->lo_refcnt) > 1)
 		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
-		mutex_unlock(&lo->lo_mutex);
-		return 0;
-	}
-	lo->lo_state = Lo_rundown;
-	mutex_unlock(&lo->lo_mutex);
-
-	return __loop_clr_fd(lo, false);
+	else
+		lo->lo_state = Lo_rundown;
+	loop_global_unlock(lo, true);
+	/*
+	 * Since nobody updates lo->lo_state if lo->lo_state == Lo_rundown,
+	 * this check is safe.
+	 */
+	if (lo->lo_state == Lo_rundown)
+		err = __loop_clr_fd(lo, false);
+	return err;
 }
 
 static int
@@ -1988,31 +2020,39 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 {
 	struct loop_device *lo = disk->private_data;
 
-	mutex_lock(&lo->lo_mutex);
-	if (atomic_dec_return(&lo->lo_refcnt))
-		goto out_unlock;
-
+	loop_global_lock(lo);
+	if (atomic_dec_return(&lo->lo_refcnt)) {
+		loop_global_unlock(lo, true);
+		return;
+	}
+	/*
+	 * In autoclear mode, stop the loop thread and remove configuration
+	 * after last close.
+	 */
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
-		if (lo->lo_state != Lo_bound)
-			goto out_unlock;
-		lo->lo_state = Lo_rundown;
-		mutex_unlock(&lo->lo_mutex);
+		if (lo->lo_state == Lo_bound)
+			lo->lo_state = Lo_rundown;
+		loop_global_unlock(lo, true);
 		/*
-		 * In autoclear mode, stop the loop thread
-		 * and remove configuration after last close.
+		 * Since nobody updates lo->lo_state
+		 * if lo->lo_state == Lo_rundown, this check is safe.
 		 */
-		__loop_clr_fd(lo, true);
+		if (lo->lo_state == Lo_rundown)
+			__loop_clr_fd(lo, true);
 		return;
-	} else if (lo->lo_state == Lo_bound) {
-		/*
-		 * Otherwise keep thread (if running) and config,
-		 * but flush possible ongoing bios in thread.
-		 */
+	}
+	/*
+	 * Otherwise keep thread (if running) and config, but flush possible
+	 * ongoing bios in thread.
+	 *
+	 * We can release loop_validate_mutex before flushing, for still held
+	 * lo->lo_mutex prevents lo->lo_state from changing.
+	 */
+	mutex_unlock(&loop_validate_mutex);
+	if (lo->lo_state == Lo_bound) {
 		blk_mq_freeze_queue(lo->lo_queue);
 		blk_mq_unfreeze_queue(lo->lo_queue);
 	}
-
-out_unlock:
 	mutex_unlock(&lo->lo_mutex);
 }
 
-- 
2.18.4

