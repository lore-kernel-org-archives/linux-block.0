Received: from mta1.migadu.com (out-53.mta1.migadu.com [95.215.58.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22108489892
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588143; cv=none; b=BRBLRtPhbLQ9OhyYA6KWlqsRfde+T3joY2ozkktYQxJmrEA7FoLyW2Pvbprx2/eFnpcu5C5h93Jxlwhqa1JQHJf8SwyYPWK1EIOrhUXqGSTDYrh01eIvR4dHNo7c0ickQtISByU960OQyhUOG8zZUjj3q3u4e3g0RscsPBLkJdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588143; c=relaxed/simple;
	bh=43dZCg58dMILR3vgkjmwNdQV11XqU4A288rUAQkby84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q4XnSgUpdyEfb6n3YMS8pr/glLWCbxAXW7rf+md7R6fPiwH5jCw3ZA8LdxzswADqJS9vzD6Lk1VT31IuTw9pMaXU60UI9M4VCHUg9FfJmsz566zfR3Vko6GKjy/HB4vejr25lmw12NpfiWmT8XLHlHMdRkMY0TPRLDCGUtZMuM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vaSmv1Jp; arc=none smtp.client-ip=95.215.58.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vaSmv1Jp"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=43dZCg58dMILR3vgkjmwNdQV11XqU4A288rUAQkby84=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790588139; v=1; x=1791192939;
 b=vaSmv1JpklyYH/aPygnibnmOJrNB+HLC/v4vykkhUAnkOgB2Tc/SSQd7RjdE0SeZgbaOVrYH
 lu8nUm3LuCOjGAHxt0K8k33e76CMfYA0LVskD/I86UjxVliLI+182vsymbaEzmnMfPGS1Td5tJZ
 WmbXCO3pHOq2yFjwfuntTgVk=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 934e24e1a4cbc90c;
	Mon, 28 Sep 2026 09:35:26 +0000
X-Mizu-Trace-ID: 934e24e1a4cbc90c
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: Bart Van Assche <bvanassche@acm.org>,
	axboe@kernel.dk,
	hch@lst.de,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: cuitao@kylinos.cn,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev
Subject: [PATCH v6] loop: defer the queue limits clear to a workqueue
Date: Mon, 28 Sep 2026 17:35:12 +0800
Message-ID: <20260928093512.3153646-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

loop_clear_limits() calls queue_limits_commit_update() directly from
the loop workqueue that processes the request.  That does a
non-atomic struct assignment to q->limits without freezing the queue,
which races with lockless readers of q->limits on other CPUs - bio
splitting reads max_hw_sectors, the discard path reads
max_hw_discard_sectors - and can let them observe torn values.  The
trigger is a discard or write-zeroes request on a loop device whose
backing file does not support the corresponding fallocate operation.

The code already has an XXX comment saying this should move to a
workqueue.  Do that: schedule a work item on the system workqueue, where
it is safe to freeze the queue around the limits update.  The pending
modes live under a new mutex, lo->clear_limits_lock.
loop_change_fd() and __loop_clr_fd() cancel the work item before
changing or dropping the backing file, and loop_assign_backing_file()
resets the modes, so a stale clear cannot hit the new backing file.
The work item is also cancelled before the device is freed.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>

---
Changes since v5:

- Drop the rebind generation counters and instead cancel the work
  item from loop_change_fd() after the queue freeze and from
  __loop_clr_fd(), as suggested by Bart.  This leaves no work item
  behind when the backing file changes, and the mutex now only
  protects clear_limits_mode.

Changes since v4:

- Rebase onto the current block tree as a single commit.

- Hold clear_limits_lock over the limits commit in the work item.
  The queue freeze is counted, not mutually exclusive, so
  loop_change_fd() could rebind between the generation check and
  the commit, and a stale clear could disable discard and write
  zeroes on the new backing file.

Changes since v3:

- Replace the three atomic variables (clear_limits_mode, rebind_gen,
  clear_limits_gen) with plain variables protected by a new
  clear_limits_lock mutex, as suggested by Bart.  The mutex is taken
  after the queue freeze in the work item, which keeps the same
  freeze -> mutex ordering as loop_change_fd(), the only rebinding
  path that freezes the queue.

Changes since v2:

- Skip the clear when the device was rebound since the work item
  was scheduled: the modes used to be captured before the freeze,
  so a LOOP_CHANGE_FD completing in between could apply the old
  modes to the new backing file.  The rebind generation is now
  checked with the queue frozen, which excludes loop_change_fd()
  because it assigns the new backing file under the same freeze,
  so a rebind cannot slip in between the check and the commit.

- Also bump the rebind generation from __loop_clr_fd(): unbinding
  does not go through loop_assign_backing_file(), so a work item
  scheduled before the last close could otherwise commit a stale
  clear to the queue limits of the unbound device.

Changes since v1:

- Reset clear_limits_mode when assigning a new backing file, so
  stale modes do not clear limits of the new file.

- Cancel the work item from loop_remove() before del_gendisk():
  the queue can already be in RCU-delayed freeing when
  lo_free_disk() cancels it.

Tested on x86-64 (qemu, vfat-backed loop device): a 30s discard and
reconfigure loop exercises the clear path 287 times, no torn sysfs
reads, no difference against the unpatched kernel.

Link: https://lore.kernel.org/r/20260828072004.273519-1-cui.tao@linux.dev/
---
 drivers/block/loop.c | 72 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 758c20678bf6c..92f3ae7324751 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -67,6 +67,9 @@ struct loop_device {
 	struct list_head        rootcg_cmd_list;
 	struct list_head        idle_worker_list;
 	struct rb_root          worker_tree;
+	struct work_struct      clear_limits_work;
+	struct mutex		clear_limits_lock;
+	unsigned int		clear_limits_mode;
 	struct timer_list       timer;
 	bool			sysfs_inited;
 
@@ -222,9 +225,25 @@ static void loop_set_size(struct loop_device *lo, loff_t size)
 		kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 }
 
-static void loop_clear_limits(struct loop_device *lo, int mode)
+static void loop_clear_limits_workfn(struct work_struct *work)
 {
+	struct loop_device *lo =
+		container_of(work, struct loop_device, clear_limits_work);
 	struct queue_limits lim = queue_limits_start_update(lo->lo_queue);
+	unsigned int memflags;
+	int mode = 0;
+
+	/*
+	 * A rebind cannot race with this work item: loop_change_fd()
+	 * and __loop_clr_fd() cancel it, loop_configure() only runs on
+	 * an unbound device, on which no work item can be pending, and
+	 * loop_assign_backing_file() resets the accumulated modes.
+	 */
+	memflags = blk_mq_freeze_queue(lo->lo_queue);
+	mutex_lock(&lo->clear_limits_lock);
+	mode = lo->clear_limits_mode;
+	lo->clear_limits_mode = 0;
+	mutex_unlock(&lo->clear_limits_lock);
 
 	if (mode & FALLOC_FL_ZERO_RANGE)
 		lim.max_write_zeroes_sectors = 0;
@@ -233,15 +252,16 @@ static void loop_clear_limits(struct loop_device *lo, int mode)
 		lim.max_hw_discard_sectors = 0;
 		lim.discard_granularity = 0;
 	}
-
-	/*
-	 * XXX: this updates the queue limits without freezing the queue, which
-	 * is against the locking protocol and dangerous.  But we can't just
-	 * freeze the queue as we're inside the ->queue_rq method here.  So this
-	 * should move out into a workqueue unless we get the file operations to
-	 * advertise if they support specific fallocate operations.
-	 */
 	queue_limits_commit_update(lo->lo_queue, &lim);
+	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
+}
+
+static void loop_clear_limits(struct loop_device *lo, int mode)
+{
+	mutex_lock(&lo->clear_limits_lock);
+	lo->clear_limits_mode |= mode;
+	mutex_unlock(&lo->clear_limits_lock);
+	schedule_work(&lo->clear_limits_work);
 }
 
 static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
@@ -518,6 +538,14 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
 static void loop_assign_backing_file(struct loop_device *lo, struct file *file)
 {
 	lo->lo_backing_file = file;
+	/*
+	 * Discard any modes recorded against the old backing file.  The
+	 * paths that can race with a pending work item cancel it before
+	 * they get here.
+	 */
+	mutex_lock(&lo->clear_limits_lock);
+	lo->clear_limits_mode = 0;
+	mutex_unlock(&lo->clear_limits_lock);
 	lo->old_gfp_mask = mapping_gfp_mask(file->f_mapping);
 	mapping_set_gfp_mask(file->f_mapping,
 			lo->old_gfp_mask & ~(__GFP_IO | __GFP_FS));
@@ -602,6 +630,12 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	/* and ... switch */
 	disk_force_media_change(lo->lo_disk);
 	memflags = blk_mq_freeze_queue(lo->lo_queue);
+	/*
+	 * The freeze drained the in-flight requests, so any clear they
+	 * scheduled is pending or running now; cancelling here leaves
+	 * no clear behind for the new backing file.
+	 */
+	cancel_work_sync(&lo->clear_limits_work);
 	mapping_set_gfp_mask(old_file->f_mapping, lo->old_gfp_mask);
 	loop_assign_backing_file(lo, file);
 	loop_update_dio(lo);
@@ -1148,6 +1182,16 @@ static void __loop_clr_fd(struct loop_device *lo)
 	lo->lo_backing_file = NULL;
 	spin_unlock_irq(&lo->lo_lock);
 
+	/*
+	 * Invalidate any clear that was scheduled against the old backing
+	 * file.  Unbinding cannot race with in-flight I/O, so cancelling
+	 * here leaves no work item behind.
+	 */
+	cancel_work_sync(&lo->clear_limits_work);
+	mutex_lock(&lo->clear_limits_lock);
+	lo->clear_limits_mode = 0;
+	mutex_unlock(&lo->clear_limits_lock);
+
 	lo->lo_device = NULL;
 	lo->lo_offset = 0;
 	lo->lo_sizelimit = 0;
@@ -1783,7 +1827,9 @@ static void lo_free_disk(struct gendisk *disk)
 		destroy_workqueue(lo->workqueue);
 	loop_free_idle_workers(lo, true);
 	timer_shutdown_sync(&lo->timer);
+	cancel_work_sync(&lo->clear_limits_work);
 	mutex_destroy(&lo->lo_mutex);
+	mutex_destroy(&lo->clear_limits_lock);
 	kfree(lo);
 }
 
@@ -2102,6 +2148,8 @@ static int loop_add(int i)
 	spin_lock_init(&lo->lo_lock);
 	spin_lock_init(&lo->lo_work_lock);
 	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
+	INIT_WORK(&lo->clear_limits_work, loop_clear_limits_workfn);
+	mutex_init(&lo->clear_limits_lock);
 	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
 	disk->major		= LOOP_MAJOR;
 	disk->first_minor	= i << part_shift;
@@ -2140,6 +2188,12 @@ static int loop_add(int i)
 
 static void loop_remove(struct loop_device *lo)
 {
+	/*
+	 * Cancel early: the queue may already be in RCU-delayed freeing
+	 * by the time lo_free_disk() cancels the work item.
+	 */
+	cancel_work_sync(&lo->clear_limits_work);
+
 	/* Make this loop device unreachable from pathname. */
 	del_gendisk(lo->lo_disk);
 	blk_mq_free_tag_set(&lo->tag_set);
-- 
2.43.0

