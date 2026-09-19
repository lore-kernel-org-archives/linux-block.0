Received: from mta1.migadu.com (out-60.mta1.migadu.com [95.215.58.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7672A30D401
	for <linux-block@vger.kernel.org>; Sat, 19 Sep 2026 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789814836; cv=none; b=Jm9klFoBluIKTtLa3++s6rHYfEw2/buwrzPOCYe/7DXB+v0d36KtsyAvVInDhFicFhNuMzk/Ox1fZ+zQtxDgpfgXMA/0rBnwQn6GuTqlQuAZbxnPXBhXfAjCavSLlh+MDFcFK8db01IaM32XMA3cVYnbMXmkkreqBAuUygf2giw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789814836; c=relaxed/simple;
	bh=WP2pU0lcLiLTGhnsY0C/w1WlODK/RB5avIeRttjFroY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZIh+M18sailBZIlQ2KTH3otYCAhI/dLEyv5DHdx6FINEOEbvQqvM9PWKY6q3VZpbZwTPRQrh6keH4Fny+cjzokt60fbvnUW4lx81z3equyOUHHp8d/oPkHhZk5zl1yVgm9A0heZe/dyh+H1GBqm/YaZM0BLw9+3ohsFLwcVk9t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C9TEDVgm; arc=none smtp.client-ip=95.215.58.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C9TEDVgm"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WP2pU0lcLiLTGhnsY0C/w1WlODK/RB5avIeRttjFroY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789814831; v=1; x=1790419631;
 b=C9TEDVgmB4ZV7KJdGjHVNm0LTA1tqETKZk18vNSKNZqV8kKS8hOtFPtPEtqRxzeu3NhBb7aL
 tX8sDgDYwiFGq3yGX0kDIFC9dWrpOqZsTAJ8/XWlW54wtbCfAmgO5guPmjBMc7WOqohJGu9q9xm
 awTFDS+d/RUqnYNRj7ioe59s=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 72562e3c9ca8669f;
	Sat, 19 Sep 2026 10:47:11 +0000
X-Mizu-Trace-ID: 72562e3c9ca8669f
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: Bart Van Assche <bvanassche@acm.org>,
	axboe@kernel.dk,
	hch@lst.de,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: cui.tao@linux.dev,
	cuitao@kylinos.cn,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] loop: defer the queue limits clear to a workqueue
Date: Sat, 19 Sep 2026 18:47:00 +0800
Message-ID: <20260919104700.1578247-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
modes and the rebind generation live under a new mutex,
lo->clear_limits_lock.  The work item takes the mutex with the queue
frozen, so a rebind cannot slip in between the generation check and
the limits commit.  Rebinding the device drops the accumulated modes
and invalidates an already scheduled work item, so a stale clear
cannot hit the new backing file.  The work item is cancelled before
the device is freed.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>

---
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
  Cancelling from loop_assign_backing_file() would instead
  deadlock on the freeze held by loop_change_fd().

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
reconfigure loop exercises the clear path 260 times, no torn sysfs
reads, no difference against the unpatched kernel.

Link: https://lore.kernel.org/r/20260828072004.273519-1-cui.tao@linux.dev/
---
 drivers/block/loop.c | 45 +++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9f6e518e60d28..d6460f359c0a8 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -68,9 +68,10 @@ struct loop_device {
 	struct list_head        idle_worker_list;
 	struct rb_root          worker_tree;
 	struct work_struct      clear_limits_work;
-	atomic_t		clear_limits_mode;
-	atomic_t		rebind_gen;
-	atomic_t		clear_limits_gen;
+	struct mutex		clear_limits_lock;
+	unsigned int		clear_limits_mode;
+	unsigned int		rebind_gen;
+	unsigned int		clear_limits_gen;
 	struct timer_list       timer;
 	bool			sysfs_inited;
 
@@ -241,11 +242,13 @@ static void loop_clear_limits_workfn(struct work_struct *work)
 	 * under the freeze; the other rebinding paths, loop_configure()
 	 * and __loop_clr_fd(), do not freeze the queue, but they bump
 	 * rebind_gen and reset clear_limits_mode themselves, so the
-	 * generation check and the atomic_xchg() below cover them.
+	 * generation check and the reset below cover them.
 	 */
 	memflags = blk_mq_freeze_queue(lo->lo_queue);
-	if (atomic_read(&lo->clear_limits_gen) == atomic_read(&lo->rebind_gen)) {
-		mode = atomic_xchg(&lo->clear_limits_mode, 0);
+	mutex_lock(&lo->clear_limits_lock);
+	if (lo->clear_limits_gen == lo->rebind_gen) {
+		mode = lo->clear_limits_mode;
+		lo->clear_limits_mode = 0;
 
 		if (mode & FALLOC_FL_ZERO_RANGE)
 			lim.max_write_zeroes_sectors = 0;
@@ -255,14 +258,17 @@ static void loop_clear_limits_workfn(struct work_struct *work)
 			lim.discard_granularity = 0;
 		}
 	}
+	mutex_unlock(&lo->clear_limits_lock);
 	queue_limits_commit_update(lo->lo_queue, &lim);
 	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
 }
 
 static void loop_clear_limits(struct loop_device *lo, int mode)
 {
-	atomic_set(&lo->clear_limits_gen, atomic_read(&lo->rebind_gen));
-	atomic_or(mode, &lo->clear_limits_mode);
+	mutex_lock(&lo->clear_limits_lock);
+	lo->clear_limits_gen = lo->rebind_gen;
+	lo->clear_limits_mode |= mode;
+	mutex_unlock(&lo->clear_limits_lock);
 	schedule_work(&lo->clear_limits_work);
 }
 
@@ -538,8 +544,10 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
 static void loop_assign_backing_file(struct loop_device *lo, struct file *file)
 {
 	lo->lo_backing_file = file;
-	atomic_inc(&lo->rebind_gen);
-	atomic_set(&lo->clear_limits_mode, 0);
+	mutex_lock(&lo->clear_limits_lock);
+	lo->rebind_gen++;
+	lo->clear_limits_mode = 0;
+	mutex_unlock(&lo->clear_limits_lock);
 	lo->old_gfp_mask = mapping_gfp_mask(file->f_mapping);
 	mapping_set_gfp_mask(file->f_mapping,
 			lo->old_gfp_mask & ~(__GFP_IO | __GFP_FS));
@@ -1168,13 +1176,16 @@ static void __loop_clr_fd(struct loop_device *lo)
 	spin_lock_irq(&lo->lo_lock);
 	filp = lo->lo_backing_file;
 	lo->lo_backing_file = NULL;
+	spin_unlock_irq(&lo->lo_lock);
+
 	/*
 	 * Invalidate any pending clear that was scheduled against the old
 	 * backing file, like loop_assign_backing_file() does on rebind.
 	 */
-	atomic_inc(&lo->rebind_gen);
-	atomic_set(&lo->clear_limits_mode, 0);
-	spin_unlock_irq(&lo->lo_lock);
+	mutex_lock(&lo->clear_limits_lock);
+	lo->rebind_gen++;
+	lo->clear_limits_mode = 0;
+	mutex_unlock(&lo->clear_limits_lock);
 
 	lo->lo_device = NULL;
 	lo->lo_offset = 0;
@@ -1813,6 +1824,7 @@ static void lo_free_disk(struct gendisk *disk)
 	timer_shutdown_sync(&lo->timer);
 	cancel_work_sync(&lo->clear_limits_work);
 	mutex_destroy(&lo->lo_mutex);
+	mutex_destroy(&lo->clear_limits_lock);
 	kfree(lo);
 }
 
@@ -2132,6 +2144,7 @@ static int loop_add(int i)
 	spin_lock_init(&lo->lo_work_lock);
 	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
 	INIT_WORK(&lo->clear_limits_work, loop_clear_limits_workfn);
+	mutex_init(&lo->clear_limits_lock);
 	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
 	disk->major		= LOOP_MAJOR;
 	disk->first_minor	= i << part_shift;
@@ -2170,8 +2183,10 @@ static int loop_add(int i)
 
 static void loop_remove(struct loop_device *lo)
 {
-	/* Cancel early: the queue may be in RCU-delayed freeing
-	 * by the time lo_free_disk() runs. */
+	/*
+	 * Cancel early: the queue may already be in RCU-delayed freeing
+	 * by the time lo_free_disk() cancels the work item.
+	 */
 	cancel_work_sync(&lo->clear_limits_work);
 
 	/* Make this loop device unreachable from pathname. */
-- 
2.43.0

