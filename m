Received: from mta0.migadu.com (out-233.mta0.migadu.com [91.218.175.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6489F33937F
	for <linux-block@vger.kernel.org>; Wed,  2 Sep 2026 06:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330876; cv=none; b=Xp0W0gm2JgbEwDFi/O9dlatiK6/Cvu+vC6ZraadnOILGnJV0/ljXa5iYYWKchqwoD4aRHtpfnNRwY9cXphn9VBEPVjTvRGhx5U2jSEQ16tTuC2KhLT7rxRjMhtuHWPsqPPoNfMaRI/RiiFisJQhEQR59JffAVIUXv4Q+BAjOM6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330876; c=relaxed/simple;
	bh=y0/Akl8uG8eaa9O02WZ8JyUXr0VKAh4Ji2V1kDVCKxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MZjE+SIfWtgp0i5Q6VWkItWGCskSSHmSp0PjNNGA2kzN4nEhX3OcXnh4LMOk2E/2XiryaeXt0sRj+f5YCCaQUoZe/tR8mEoAM9aRnorJ5neijVKewRZYV8G3TyDoNrE6spoHDEgul5blBYobx8mwNb8PFqKaXf2M8F8Vm3Yd4CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sOVdYpnW; arc=none smtp.client-ip=91.218.175.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sOVdYpnW"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=y0/Akl8uG8eaa9O02WZ8JyUXr0VKAh4Ji2V1kDVCKxs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788330872; v=1; x=1788935672;
 b=sOVdYpnWQXw6k2l5WvKf2LweCAVvuxZuG4yza70EcMuWQr12sY4ZcIBVVtecXeJCaNKR4mig
 zni3Tft2tXnOF7Bop3bs6OtiWWUqZbcP8lIzzrvqS9DvlZXnZ3NuBCCO5gSBN7nDPm3kqDY6Fge
 HsCon+WyR5sLtcGy45GSrWOY=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d4ebb0c9fefb1d85;
	Wed, 02 Sep 2026 06:34:32 +0000
X-Mizu-Trace-ID: d4ebb0c9fefb1d85
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: Bart Van Assche <bvanassche@acm.org>,
	axboe@kernel.dk,
	hch@lst.de,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: cui.tao@linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2] loop: defer the queue limits clear to a workqueue
Date: Wed,  2 Sep 2026 14:34:20 +0800
Message-ID: <20260902063420.882203-1-cui.tao@linux.dev>
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
workqueue.  Do that: schedule a work item on the system workqueue,
where it is safe to freeze the queue and update the limits using
queue_limits_commit_update_frozen().  Accumulate pending modes in
lo->clear_limits_mode so that failures between scheduling and
execution of the work item are not lost, reset the accumulated
modes when a new backing file is assigned, and cancel the work
item before the device is freed.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>

---
Changes since v1:

- Make clear_limits_mode atomic_t: loop workers can hit the |=
  concurrently.

- Reset clear_limits_mode when assigning a new backing file, so
  stale modes do not clear limits of the new file.

- Cancel the work item from loop_remove() before del_gendisk():
  the queue can already be in RCU-delayed freeing when
  lo_free_disk() cancels it.

Tested on x86-64 (qemu, vfat-backed loop device): 30s discard and
reconfigure loop exercises the clear 577 times, no torn sysfs reads,
no difference against the unpatched kernel.

Link: https://lore.kernel.org/r/20260828072004.273519-1-cui.tao@linux.dev/
---
 drivers/block/loop.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6f12976035b0..368ea857895c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -67,6 +67,8 @@ struct loop_device {
 	struct list_head        rootcg_cmd_list;
 	struct list_head        idle_worker_list;
 	struct rb_root          worker_tree;
+	struct work_struct      clear_limits_work;
+	atomic_t		clear_limits_mode;
 	struct timer_list       timer;
 	bool			sysfs_inited;
 
@@ -222,9 +224,12 @@ static void loop_set_size(struct loop_device *lo, loff_t size)
 		kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 }
 
-static void loop_clear_limits(struct loop_device *lo, int mode)
+static void loop_clear_limits_workfn(struct work_struct *work)
 {
+	struct loop_device *lo =
+		container_of(work, struct loop_device, clear_limits_work);
 	struct queue_limits lim = queue_limits_start_update(lo->lo_queue);
+	int mode = atomic_xchg(&lo->clear_limits_mode, 0);
 
 	if (mode & FALLOC_FL_ZERO_RANGE)
 		lim.max_write_zeroes_sectors = 0;
@@ -234,14 +239,13 @@ static void loop_clear_limits(struct loop_device *lo, int mode)
 		lim.discard_granularity = 0;
 	}
 
-	/*
-	 * XXX: this updates the queue limits without freezing the queue, which
-	 * is against the locking protocol and dangerous.  But we can't just
-	 * freeze the queue as we're inside the ->queue_rq method here.  So this
-	 * should move out into a workqueue unless we get the file operations to
-	 * advertise if they support specific fallocate operations.
-	 */
-	queue_limits_commit_update(lo->lo_queue, &lim);
+	queue_limits_commit_update_frozen(lo->lo_queue, &lim);
+}
+
+static void loop_clear_limits(struct loop_device *lo, int mode)
+{
+	atomic_or(mode, &lo->clear_limits_mode);
+	schedule_work(&lo->clear_limits_work);
 }
 
 static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
@@ -516,6 +520,7 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
 static void loop_assign_backing_file(struct loop_device *lo, struct file *file)
 {
 	lo->lo_backing_file = file;
+	atomic_set(&lo->clear_limits_mode, 0);
 	lo->old_gfp_mask = mapping_gfp_mask(file->f_mapping);
 	mapping_set_gfp_mask(file->f_mapping,
 			lo->old_gfp_mask & ~(__GFP_IO | __GFP_FS));
@@ -1781,6 +1786,7 @@ static void lo_free_disk(struct gendisk *disk)
 		destroy_workqueue(lo->workqueue);
 	loop_free_idle_workers(lo, true);
 	timer_shutdown_sync(&lo->timer);
+	cancel_work_sync(&lo->clear_limits_work);
 	mutex_destroy(&lo->lo_mutex);
 	kfree(lo);
 }
@@ -2100,6 +2106,7 @@ static int loop_add(int i)
 	spin_lock_init(&lo->lo_lock);
 	spin_lock_init(&lo->lo_work_lock);
 	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
+	INIT_WORK(&lo->clear_limits_work, loop_clear_limits_workfn);
 	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
 	disk->major		= LOOP_MAJOR;
 	disk->first_minor	= i << part_shift;
@@ -2138,6 +2145,10 @@ static int loop_add(int i)
 
 static void loop_remove(struct loop_device *lo)
 {
+	/* Cancel early: the queue may be in RCU-delayed freeing
+	 * by the time lo_free_disk() runs. */
+	cancel_work_sync(&lo->clear_limits_work);
+
 	/* Make this loop device unreachable from pathname. */
 	del_gendisk(lo->lo_disk);
 	blk_mq_free_tag_set(&lo->tag_set);
-- 
2.43.0

