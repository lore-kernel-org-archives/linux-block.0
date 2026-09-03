Received: from mta1.migadu.com (out-133.mta1.migadu.com [95.215.58.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C464E2ECD1D
	for <linux-block@vger.kernel.org>; Thu,  3 Sep 2026 01:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788399501; cv=none; b=VoZh+pK0yjPw4KHB59Z4hVtkRRt9WHSBQoSW9c7rnd8CrpgDZejsy8w5WJlKw3bvV2m41E1jHjOM2x58dJR2/PgtvgUlOwDwy1KmQj26hR7jl9DziYdBPpT+O+OW67dwupnm7w7y2Mf1Mi5hpEHF7qtEQ0iRkXuOV3xVEl8lVS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788399501; c=relaxed/simple;
	bh=1pj158FLJPReukgGffRDhnS0CLcUC3lDVfOPz6oelMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XEqF/Qw4I7UmXU0TkwMRB5WiyzatFVECU7u+dV/afrWvHeXwc4O3cCN5AKJPFY/trPyig5fyjhFM0GZbXFND93IDg7N9Tj5vHpT1gSP6M2mnsT4/61IjQ9IrE7gJYYvAD+P78M8AR92Ew35zpaHA1tJLBcIL1hEr7KdqE0/oDzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xzdwd3O9; arc=none smtp.client-ip=95.215.58.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xzdwd3O9"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1pj158FLJPReukgGffRDhnS0CLcUC3lDVfOPz6oelMw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788399497; v=1; x=1789004297;
 b=Xzdwd3O9s5WVwg4uZWa/Uh47Jubt1TwGLq4VXSu9tLHSaJ9ehnV6K/cxCQl0TTbZteAxcjmd
 QfmYbsjICXtEjV/0nSxZNNVgewwgF0J1/a5uhJzsYX/1aUUfoZMf7emrRdN9NYJ+iO8caNNhz0A
 Yz9lSA+aLFekf/l1CxbOSO6k=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 798159db53fb6a2d;
	Thu, 03 Sep 2026 01:38:07 +0000
X-Mizu-Trace-ID: 798159db53fb6a2d
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
Subject: [PATCH v3] loop: defer the queue limits clear to a workqueue
Date: Thu,  3 Sep 2026 09:38:00 +0800
Message-ID: <20260903013800.1036691-1-cui.tao@linux.dev>
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
it is safe to freeze the queue around the limits update.  Accumulate
pending modes in lo->clear_limits_mode so that failures between
scheduling and execution of the work item are not lost.  A rebinding of
the device drops the accumulated modes and invalidates an already
scheduled work item, so a stale clear cannot hit the new backing file.
The work item is cancelled before the device is freed.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>

---
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

- Make clear_limits_mode atomic_t: loop workers can hit the |=
  concurrently.

- Reset clear_limits_mode when assigning a new backing file, so
  stale modes do not clear limits of the new file.

- Cancel the work item from loop_remove() before del_gendisk():
  the queue can already be in RCU-delayed freeing when
  lo_free_disk() cancels it.

Tested on x86-64 (qemu, vfat-backed loop device): 30s discard and
reconfigure loop exercises the clear path 577 times, no torn sysfs reads,
no difference against the unpatched kernel.

Link: https://lore.kernel.org/r/20260828072004.273519-1-cui.tao@linux.dev/
---
 drivers/block/loop.c | 64 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 14 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6f12976035b0..9f6e518e60d2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -67,6 +67,10 @@ struct loop_device {
 	struct list_head        rootcg_cmd_list;
 	struct list_head        idle_worker_list;
 	struct rb_root          worker_tree;
+	struct work_struct      clear_limits_work;
+	atomic_t		clear_limits_mode;
+	atomic_t		rebind_gen;
+	atomic_t		clear_limits_gen;
 	struct timer_list       timer;
 	bool			sysfs_inited;
 
@@ -222,26 +226,44 @@ static void loop_set_size(struct loop_device *lo, loff_t size)
 		kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 }
 
-static void loop_clear_limits(struct loop_device *lo, int mode)
+static void loop_clear_limits_workfn(struct work_struct *work)
 {
+	struct loop_device *lo =
+		container_of(work, struct loop_device, clear_limits_work);
 	struct queue_limits lim = queue_limits_start_update(lo->lo_queue);
-
-	if (mode & FALLOC_FL_ZERO_RANGE)
-		lim.max_write_zeroes_sectors = 0;
-
-	if (mode & FALLOC_FL_PUNCH_HOLE) {
-		lim.max_hw_discard_sectors = 0;
-		lim.discard_granularity = 0;
-	}
+	unsigned int memflags;
+	int mode = 0;
 
 	/*
-	 * XXX: this updates the queue limits without freezing the queue, which
-	 * is against the locking protocol and dangerous.  But we can't just
-	 * freeze the queue as we're inside the ->queue_rq method here.  So this
-	 * should move out into a workqueue unless we get the file operations to
-	 * advertise if they support specific fallocate operations.
+	 * Commit the unmodified limits if the device was rebound since
+	 * the work item was scheduled.  The freeze excludes a rebind
+	 * through loop_change_fd(), which assigns the new backing file
+	 * under the freeze; the other rebinding paths, loop_configure()
+	 * and __loop_clr_fd(), do not freeze the queue, but they bump
+	 * rebind_gen and reset clear_limits_mode themselves, so the
+	 * generation check and the atomic_xchg() below cover them.
 	 */
+	memflags = blk_mq_freeze_queue(lo->lo_queue);
+	if (atomic_read(&lo->clear_limits_gen) == atomic_read(&lo->rebind_gen)) {
+		mode = atomic_xchg(&lo->clear_limits_mode, 0);
+
+		if (mode & FALLOC_FL_ZERO_RANGE)
+			lim.max_write_zeroes_sectors = 0;
+
+		if (mode & FALLOC_FL_PUNCH_HOLE) {
+			lim.max_hw_discard_sectors = 0;
+			lim.discard_granularity = 0;
+		}
+	}
 	queue_limits_commit_update(lo->lo_queue, &lim);
+	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
+}
+
+static void loop_clear_limits(struct loop_device *lo, int mode)
+{
+	atomic_set(&lo->clear_limits_gen, atomic_read(&lo->rebind_gen));
+	atomic_or(mode, &lo->clear_limits_mode);
+	schedule_work(&lo->clear_limits_work);
 }
 
 static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
@@ -516,6 +538,8 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
 static void loop_assign_backing_file(struct loop_device *lo, struct file *file)
 {
 	lo->lo_backing_file = file;
+	atomic_inc(&lo->rebind_gen);
+	atomic_set(&lo->clear_limits_mode, 0);
 	lo->old_gfp_mask = mapping_gfp_mask(file->f_mapping);
 	mapping_set_gfp_mask(file->f_mapping,
 			lo->old_gfp_mask & ~(__GFP_IO | __GFP_FS));
@@ -1144,6 +1168,12 @@ static void __loop_clr_fd(struct loop_device *lo)
 	spin_lock_irq(&lo->lo_lock);
 	filp = lo->lo_backing_file;
 	lo->lo_backing_file = NULL;
+	/*
+	 * Invalidate any pending clear that was scheduled against the old
+	 * backing file, like loop_assign_backing_file() does on rebind.
+	 */
+	atomic_inc(&lo->rebind_gen);
+	atomic_set(&lo->clear_limits_mode, 0);
 	spin_unlock_irq(&lo->lo_lock);
 
 	lo->lo_device = NULL;
@@ -1781,6 +1811,7 @@ static void lo_free_disk(struct gendisk *disk)
 		destroy_workqueue(lo->workqueue);
 	loop_free_idle_workers(lo, true);
 	timer_shutdown_sync(&lo->timer);
+	cancel_work_sync(&lo->clear_limits_work);
 	mutex_destroy(&lo->lo_mutex);
 	kfree(lo);
 }
@@ -2100,6 +2131,7 @@ static int loop_add(int i)
 	spin_lock_init(&lo->lo_lock);
 	spin_lock_init(&lo->lo_work_lock);
 	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
+	INIT_WORK(&lo->clear_limits_work, loop_clear_limits_workfn);
 	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
 	disk->major		= LOOP_MAJOR;
 	disk->first_minor	= i << part_shift;
@@ -2138,6 +2170,10 @@ static int loop_add(int i)
 
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

