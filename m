Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795671763;
	b=ufQ4RzmUISddFEPi+9g7anakvJpj63+24qMZNKJpG5QAbj4HOP8UbvT5Ei+QNZiZMwQc
	 Ogc2CSAi/n6OIyW/ZnBqr+GkD/ePlucg+H5p26AAxcvm/r+4GhMKlIEGp5x8IVvaHgwRI
	 4kKT7dHwFLletdcztDl2mwoXMCa6PW3Neb04ni92tWfV9tdHGniGGqOERZE3k/TPzj2vW
	 l5Nk0c/JtqCi1Bi6MhTzURapDnIs3ZYHJOD5C7EvHbTM8u+gaV8rO/9o3PmAmBOYnHRME
	 jWHXIpTCY4/iGbfIlWnjosS67ZPV9dqWAQGiOMidIwFcLx2qdbjOSt5lZmDu1xx7sMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795671763;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=KDqQNEtQd+6jLTv721CtUFemKZb8effCJHvw+bLNXTQ=;
	b=qPSomNyTwFrn/ZMAHn32HvaaEnm0a98LtnCUvSHXqQA8nuxQ/G7w4/h1KZmdF5niAwq3
	 c1PyHYLvMbi0/2sX7vFOa/WURgcc66514j9EwP7fljrehSVq9cLGg/i+4zChc8TftI0E7
	 wp3JCFTb12KUqGKDGeSh8oLlxgFFnzWeYoRRaPgHkfkUkGz3ucEaFyqPDcs3UyIl8kPI0
	 s+6mC1g4wR3Cajv1S8w8I0+Qg6sebdjER+ubwAfCv2mocKRnJRACITU9O4X96Li1+mcAY
	 bj2lcLNEG9y6p+zD07+QqDjdgBEZWT/Nn3Zk6xwvjBcIJw8d79V1fxLYbuXT7iyweeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eNU4T4YD;
	arc=none smtp.remote-ip=95.215.58.159
Received: from mta1.migadu.com (out-159.mta1.migadu.com [95.215.58.159])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B7E606A31C
	for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 05:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0B7E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eNU4T4YD
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=T/D/ipZeoT1JY+2pYK8EBjpZvR47x2HelHbDUPah5nQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795671760; v=1; x=1796276560;
 b=eNU4T4YDa+uzIViBA/92ub72RdYtnCpJ/UinaRX696eF6S260xWb6PBsaAvDpABjwMtblIp9
 ZN70vbUMB6Tq0jZhexwL0DJ8Dk4UXqulR86uXX8wBnMXJ2UFLOEs5N6FsAd22W9g8Wq5tV8gtmM
 rSdXHJUcHeTT5eoVAPyN2TyU=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d6142d2087cb271f;
	Thu, 26 Nov 2026 05:42:40 +0000
X-Mizu-Trace-ID: d6142d2087cb271f
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
Subject: [PATCH v8] loop: defer the queue limits clear to a workqueue
Date: Thu, 26 Nov 2026 13:42:23 +0800
Message-ID: <20261126054223.176824-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
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
Changes since v7:
- quiet repeated failures at the point of failure instead of at
  queue_rq() time: verdicts are recorded per mode for the lifetime of
  the backing file and loop_clear_limits() reports whether a verdict
  is new, so repeats mark only their own request quiet.  Under
  concurrent dispatch this keeps exactly the first failure per mode on
  the console (sashiko review; eight-thread write-zeroes on a
  tmpfs-backed loop device: v7 logged two errors where loop/011
  expects one, this logs one)
- schedule the clear work while holding clear_limits_lock and reset
  the verdicts before cancel_work_sync() in __loop_clr_fd(): a verdict
  that passed the backing-file check now queues the work before the
  lock is released, so the cancel cannot miss a schedule from a
  request still in flight, which previously could touch a loop_device
  already freed (Bart)
- skip the fallocate probe when the mode is already known to be
  unsupported, instead of repeating it while the limits commit is in
  flight (Bart)
- return early from the work item when no verdict is left to commit,
  instead of freezing the queue and committing unchanged limits (Bart)
- drop the verdict reset in loop_assign_backing_file(): since the
  LOOP_CHANGE_FD removal (d4fabede1da0) its only caller is
  loop_configure(), which requires an unbound device, so it was dead;
  one reset site remains, so no helper was added (Bart)

Changes since v6:
- fix the __loop_clr_fd() comment: asynchronous I/O can be in flight
  across an unbind, and loop_remove()'s cancel is the backstop for
  work scheduled after __loop_clr_fd()'s
- drop the cancel_work_sync() from lo_free_disk(): no reachable path
  needs it
- reword the loop_remove() comment accordingly

 drivers/block/loop.c | 123 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 111 insertions(+), 12 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 194f51d9dab6..8c2ef0c327d4 100644
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
 
@@ -222,9 +225,31 @@ static void loop_set_size(struct loop_device *lo, loff_t size)
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
+	 * Snapshot the recorded modes without clearing them; verdicts stay
+	 * for the life of the backing file.  The freeze drains in-flight
+	 * requests, so everything scheduled before it is visible here.
+	 */
+	memflags = blk_mq_freeze_queue(lo->lo_queue);
+	mutex_lock(&lo->clear_limits_lock);
+	mode = lo->clear_limits_seen;
+	mutex_unlock(&lo->clear_limits_lock);
+
+	/* A racing unbind may have reset the verdicts; nothing to commit. */
+	if (!mode) {
+		blk_mq_unfreeze_queue(lo->lo_queue, memflags);
+		return;
+	}
+
+	lim = queue_limits_start_update(lo->lo_queue);
 
 	if (mode & FALLOC_FL_ZERO_RANGE)
 		lim.max_write_zeroes_sectors = 0;
@@ -234,14 +259,65 @@ static void loop_clear_limits(struct loop_device *lo, int mode)
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
+	if (lo->lo_backing_file != file) {
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
+	known = lo->lo_backing_file == file &&
+		(mode & lo->clear_limits_seen);
+	mutex_unlock(&lo->clear_limits_lock);
+
+	return known;
 }
 
 static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
@@ -256,8 +332,16 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 
 	mode |= FALLOC_FL_KEEP_SIZE;
 
-	if (!bdev_max_discard_sectors(lo->lo_device))
-		return -EOPNOTSUPP;
+	if (!bdev_max_discard_sectors(lo->lo_device)) {
+		/*
+		 * Limits already committed; record the op's bit to keep
+		 * the per-mode quiet accounting.
+		 */
+		return lo_unsupported(lo, rq, file, mode);
+	}
+
+	if (loop_mode_unsupported(lo, file, mode))
+		return lo_unsupported(lo, rq, file, mode);
 
 	scoped_guard(file_write, file)
 		ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
@@ -269,7 +353,7 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 	 * supported and clear them here if that turns out not to be true.
 	 */
 	if (unlikely(ret == -EOPNOTSUPP))
-		loop_clear_limits(lo, mode);
+		return lo_unsupported(lo, rq, file, mode);
 
 	return ret;
 }
@@ -1035,6 +1119,15 @@ static void __loop_clr_fd(struct loop_device *lo)
 	lo->lo_backing_file = NULL;
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
@@ -1700,6 +1793,7 @@ static void lo_free_disk(struct gendisk *disk)
 	loop_free_idle_workers(lo, true);
 	timer_shutdown_sync(&lo->timer);
 	mutex_destroy(&lo->lo_mutex);
+	mutex_destroy(&lo->clear_limits_lock);
 	kfree(lo);
 }
 
@@ -2018,6 +2112,8 @@ static int loop_add(int i)
 	spin_lock_init(&lo->lo_lock);
 	spin_lock_init(&lo->lo_work_lock);
 	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
+	INIT_WORK(&lo->clear_limits_work, loop_clear_limits_workfn);
+	mutex_init(&lo->clear_limits_lock);
 	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
 	disk->major		= LOOP_MAJOR;
 	disk->first_minor	= i << part_shift;
@@ -2056,6 +2152,9 @@ static int loop_add(int i)
 
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

