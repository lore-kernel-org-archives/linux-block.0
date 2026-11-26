Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795701409;
	b=dlES5aZoas8yBuhP0oRkeePOPeLKfTSEiGboNBVjPPrDhWVKtGO/X6L4IbKMPD+evyqx
	 QPgofYNThQ9sTLEfE2oeDNv+Ng2GGVOiJdOGjbmiMNwrK/C9Af4Go2pZIAUfR/83yYJHY
	 RyEG6jbwbSYCq5Vjej2uMhWKBb/3AKgTv+bZk8J+o7urHHOrQyoggywWEXCYqYqzyWG+t
	 07dkVlfgsgwMtOe+NvmIcaBe6v9PoiEkeHsa7OMl/3HqCcjsz85uwpYqR3DJJz137+GIl
	 CEl3PtoDp9l2rsCeEwjWJS5R1qXuxcKoT/QYhJllOGzOz5SPDfymX8k0/RLke9PAU+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795701409;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mSDD91TLN/72z/uC3zOy9x3ksTTieaPKZ1YAAqKxj3A=;
	b=xtcep/VYvvi9NGoGQmbTMCODURKlW1okNp9RIlAQvPMyr16eH0myOfWpsQGRZesbgLod
	 FJxLAfKd78tay/+DPDE7ocCl/odOD+FwpQ/5cfGzGQcjdDcfp0gIn+xUm9+V+L2yUaZFr
	 yW8VMa/+VvRA6qn/SByTK903i4l6Ab1hpEkLEBp5OD/lGuKLxSKZNW3qRpmvC6983iVS1
	 P4DjZyZZUrjS4OFsFT47WgK7l09n541jA5bNww9AAcXvzgvwPygJv+7rwAHyBpeFpQFaE
	 vwOUwWtGE12ynpQzE/mb5HcxIC7DeezTUURZA/hSd9JCrDr0N4BwYM9kdQgH9swdmpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hzwJG95u;
	arc=none smtp.remote-ip=95.215.58.120
Received: from mta1.migadu.com (out-120.mta1.migadu.com [95.215.58.120])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FD7606A31E
	for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 13:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59FD7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hzwJG95u
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8b1bEgOOtpzWQWKfCAwVXwtE4knX7o/iGvJiTWAJh08=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795701406; v=1; x=1796306206;
 b=hzwJG95u+TvW2mnvQTkCA5pPxeF24Wk2imZp4uSPwHvyNvN/2oWRvNsCTAUuOw2Xnlwb7MGW
 XRX9oX5P2G9EnlQ8c/nbBXCs9rWnDHyQuPog0rKjL0Rb/mIcekpbynPd5sDn55volq2Xcg+Mwqo
 766su7pNySwIJGPeL2lqSuOc=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id de7d47af3f371c98;
	Thu, 26 Nov 2026 13:56:46 +0000
X-Mizu-Trace-ID: de7d47af3f371c98
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: Bart Van Assche <bvanassche@acm.org>,
	axboe@kernel.dk,
	hch@lst.de,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: cuitao@kylinos.cn,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v9] loop: defer the queue limits clear to a workqueue
Date: Thu, 26 Nov 2026 21:56:28 +0800
Message-ID: <20261126135628.495497-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126054223.176824-1-cui.tao@linux.dev>
References: <20261126054223.176824-1-cui.tao@linux.dev>
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

From: Tao Cui <cuitao@kylinos.cn>

loop_clear_limits() calls queue_limits_commit_update() directly from
the loop workqueue that processes the request.  That does a
non-atomic struct assignment to q->limits without freezing the queue,
which races with lockless readers of q->limits on other CPUs, such
as bio splitting reading max_hw_sectors and the discard path reading
max_hw_discard_sectors, letting them observe torn values.  The
trigger is a discard or write-zeroes request on a loop device whose
backing file does not support the corresponding fallocate operation.

The code already has an XXX comment saying this should move to a
workqueue.  Do that: schedule a work item on the system workqueue,
where it is safe to freeze the queue around the limits update.  The
work item takes the queue limits lock before freezing, matching the
order used by loop_set_dio() and loop_set_block_size().  The
unsupported modes live under a new mutex, lo->clear_limits_lock,
guarded by a backing-file check that drops records from a racing
unbind or rebind.  The work item is scheduled while holding that
lock, so an unbind resets the verdicts under the lock before calling
cancel_work_sync() and cannot miss a schedule from a request that is
still in flight.  Requests that arrive while the clear is in flight
fail quietly, so the console report stays at the first failure.
loop_remove() also cancels the work item before the queue becomes
unreachable.

Fixes: 5f75e081ab5c ("loop: Disable fallocate() zero and discard if not supported")
Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
Changes since v8:
- take limits_lock via queue_limits_start_update() before freezing in
  the work item, following the convention that all block driver code
  takes limits_lock before freezing (06a2ff603f1f, loop_set_dio(),
  loop_set_block_size(), queue_limits_commit_update_frozen()); the
  v8 order was a regression introduced by the v8 early-return rework
  (sashiko review)
- gate lo_fallocate() on the per-mode hardware limits
  (max_hw_discard_sectors / max_write_zeroes_sectors) instead of the
  shared bdev_max_discard_sectors(), which is also driven by the sysfs
  discard cap: with only the punch-hole verdict committed, a
  write-zeroes request could latch a false ZERO_RANGE verdict and
  clear the write-zeroes limits on a backing file that supports them
  (sashiko review)
- reset clear_limits_seen in loop_set_block_size(): its limits
  recompute re-enables cleared modes, and with verdicts previously
  kept for the life of the backing file, repeat failures would never
  reschedule the clear (sashiko review)
- drop verdicts recorded against a NULL backing file silently and
  annotate the lockless lo_backing_file accesses with READ_ONCE and
  WRITE_ONCE (sashiko review)
- verified with a PROVE_LOCKING-enabled kernel running loop/011, the
  concurrency sweep, interleaved LOOP_SET_BLOCK_SIZE and write-zeroes
  traffic, and sixty mkfs/unbind stress rounds: no lockdep reports and
  no hangs, both with this reorder and, as a negative control, with
  the v8 order

 drivers/block/loop.c | 142 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 128 insertions(+), 14 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 194f51d9dab6..460c3a319988 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -67,6 +67,9 @@ struct loop_device {
 	struct list_head        rootcg_cmd_list;
 	struct list_head        idle_worker_list;
 	struct rb_root          worker_tree;
+	struct work_struct      clear_limits_work;
+	struct mutex		clear_limits_lock;
+	unsigned int		clear_limits_seen;
 	struct timer_list       timer;
 	bool			sysfs_inited;
 
@@ -222,9 +225,35 @@ static void loop_set_size(struct loop_device *lo, loff_t size)
 		kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 }
 
-static void loop_clear_limits(struct loop_device *lo, int mode)
+static void loop_clear_limits_workfn(struct work_struct *work)
 {
-	struct queue_limits lim = queue_limits_start_update(lo->lo_queue);
+	struct loop_device *lo =
+		container_of(work, struct loop_device, clear_limits_work);
+	struct queue_limits lim;
+	unsigned int memflags;
+	int mode;
+
+	/*
+	 * Take limits_lock before freezing, like loop_set_dio() and
+	 * loop_set_block_size().
+	 */
+	lim = queue_limits_start_update(lo->lo_queue);
+
+	/*
+	 * The freeze drains in-flight requests, so everything scheduled
+	 * before it is visible in the snapshot below.
+	 */
+	memflags = blk_mq_freeze_queue(lo->lo_queue);
+	mutex_lock(&lo->clear_limits_lock);
+	mode = lo->clear_limits_seen;
+	mutex_unlock(&lo->clear_limits_lock);
+
+	/* A racing unbind may have reset the verdicts; nothing to commit. */
+	if (!mode) {
+		queue_limits_commit_update(lo->lo_queue, &lim);
+		blk_mq_unfreeze_queue(lo->lo_queue, memflags);
+		return;
+	}
 
 	if (mode & FALLOC_FL_ZERO_RANGE)
 		lim.max_write_zeroes_sectors = 0;
@@ -234,14 +263,69 @@ static void loop_clear_limits(struct loop_device *lo, int mode)
 		lim.discard_granularity = 0;
 	}
 
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
+/*
+ * Record that the backing file does not support @mode.  Returns true
+ * for a first verdict or a dropped stale record, false for a repeat.
+ */
+static bool loop_clear_limits(struct loop_device *lo, struct file *file,
+			      int mode)
+{
+	bool first;
+
+	mutex_lock(&lo->clear_limits_lock);
+	if (READ_ONCE(lo->lo_backing_file) != file) {
+		/* Stale record from a racing unbind or rebind; drop it. */
+		mutex_unlock(&lo->clear_limits_lock);
+		return true;
+	}
+	first = (mode & ~lo->clear_limits_seen) != 0;
+	lo->clear_limits_seen |= mode;
+	/* Scheduled under the lock so cancel_work_sync() cannot miss it. */
+	if (first)
+		schedule_work(&lo->clear_limits_work);
+	mutex_unlock(&lo->clear_limits_lock);
+
+	return first;
+}
+
+/*
+ * Record the verdict and return -EOPNOTSUPP; repeats stay quiet so only
+ * the first failure per mode reports.
+ */
+static int lo_unsupported(struct loop_device *lo, struct request *rq,
+			  struct file *file, int mode)
+{
+	/* A NULL file means the backing file is already gone. */
+	if (!file)
+		return -EOPNOTSUPP;
+
+	if (!loop_clear_limits(lo, file, mode))
+		rq->rq_flags |= RQF_QUIET;
+
+	return -EOPNOTSUPP;
+}
+
+/*
+ * Return true when @mode is already recorded as unsupported, so the
+ * fallocate probe can be skipped.
+ */
+static bool loop_mode_unsupported(struct loop_device *lo, struct file *file,
+				  int mode)
+{
+	bool known;
+
+	mode &= FALLOC_FL_ZERO_RANGE | FALLOC_FL_PUNCH_HOLE;
+
+	mutex_lock(&lo->clear_limits_lock);
+	known = file && READ_ONCE(lo->lo_backing_file) == file &&
+		(mode & lo->clear_limits_seen);
+	mutex_unlock(&lo->clear_limits_lock);
+
+	return known;
 }
 
 static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
@@ -256,8 +340,19 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 
 	mode |= FALLOC_FL_KEEP_SIZE;
 
-	if (!bdev_max_discard_sectors(lo->lo_device))
-		return -EOPNOTSUPP;
+	/*
+	 * Zeroed hardware limits mean the matching verdict is already
+	 * committed; record the op's bit for the per-mode quiet accounting.
+	 */
+	if ((mode & FALLOC_FL_PUNCH_HOLE) &&
+	    !bdev_limits(lo->lo_device)->max_hw_discard_sectors)
+		return lo_unsupported(lo, rq, file, mode);
+	if ((mode & FALLOC_FL_ZERO_RANGE) &&
+	    !bdev_write_zeroes_sectors(lo->lo_device))
+		return lo_unsupported(lo, rq, file, mode);
+
+	if (loop_mode_unsupported(lo, file, mode))
+		return lo_unsupported(lo, rq, file, mode);
 
 	scoped_guard(file_write, file)
 		ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
@@ -269,7 +364,7 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 	 * supported and clear them here if that turns out not to be true.
 	 */
 	if (unlikely(ret == -EOPNOTSUPP))
-		loop_clear_limits(lo, mode);
+		return lo_unsupported(lo, rq, file, mode);
 
 	return ret;
 }
@@ -513,7 +608,7 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
 
 static void loop_assign_backing_file(struct loop_device *lo, struct file *file)
 {
-	lo->lo_backing_file = file;
+	WRITE_ONCE(lo->lo_backing_file, file);
 	lo->old_gfp_mask = mapping_gfp_mask(file->f_mapping);
 	mapping_set_gfp_mask(file->f_mapping,
 			lo->old_gfp_mask & ~(__GFP_IO | __GFP_FS));
@@ -1032,9 +1127,18 @@ static void __loop_clr_fd(struct loop_device *lo)
 
 	spin_lock_irq(&lo->lo_lock);
 	filp = lo->lo_backing_file;
-	lo->lo_backing_file = NULL;
+	WRITE_ONCE(lo->lo_backing_file, NULL);
 	spin_unlock_irq(&lo->lo_lock);
 
+	/*
+	 * Requests may still be in flight across this unbind; reset the
+	 * verdicts before the cancel so it cannot miss the work item.
+	 */
+	mutex_lock(&lo->clear_limits_lock);
+	lo->clear_limits_seen = 0;
+	mutex_unlock(&lo->clear_limits_lock);
+	cancel_work_sync(&lo->clear_limits_work);
+
 	lo->lo_device = NULL;
 	lo->lo_offset = 0;
 	lo->lo_sizelimit = 0;
@@ -1415,6 +1519,10 @@ static int loop_set_block_size(struct loop_device *lo, blk_mode_t mode,
 	loop_update_limits(lo, &lim, arg);
 
 	memflags = blk_mq_freeze_queue(lo->lo_queue);
+	/* The recompute above may re-enable modes with recorded verdicts. */
+	mutex_lock(&lo->clear_limits_lock);
+	lo->clear_limits_seen = 0;
+	mutex_unlock(&lo->clear_limits_lock);
 	err = queue_limits_commit_update(lo->lo_queue, &lim);
 	loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
@@ -1700,6 +1808,7 @@ static void lo_free_disk(struct gendisk *disk)
 	loop_free_idle_workers(lo, true);
 	timer_shutdown_sync(&lo->timer);
 	mutex_destroy(&lo->lo_mutex);
+	mutex_destroy(&lo->clear_limits_lock);
 	kfree(lo);
 }
 
@@ -2018,6 +2127,8 @@ static int loop_add(int i)
 	spin_lock_init(&lo->lo_lock);
 	spin_lock_init(&lo->lo_work_lock);
 	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
+	INIT_WORK(&lo->clear_limits_work, loop_clear_limits_workfn);
+	mutex_init(&lo->clear_limits_lock);
 	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
 	disk->major		= LOOP_MAJOR;
 	disk->first_minor	= i << part_shift;
@@ -2056,6 +2167,9 @@ static int loop_add(int i)
 
 static void loop_remove(struct loop_device *lo)
 {
+	/* Cancel before the queue becomes unreachable. */
+	cancel_work_sync(&lo->clear_limits_work);
+
 	/* Make this loop device unreachable from pathname. */
 	del_gendisk(lo->lo_disk);
 	blk_mq_free_tag_set(&lo->tag_set);
-- 
2.53.0

