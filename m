Received: from mta1.migadu.com (out-232.mta1.migadu.com [95.215.58.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B8554781
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787901629; cv=none; b=GCU3Fn1NQcf4OsVl+M6zHjdZgL0Nmsb1RhW+tudMbbYzk+1Ci2HIiqtOyRZ//8NL6FoFE1RkklRUAKMCeGWuxctAlrrnxSHWntmBwpJ+xAhnQWQsG9r1a76yEAMCu+Kad8ygJBslbR770wr4jcWdupEsVkOKvK8WbE8koRr4Jlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787901629; c=relaxed/simple;
	bh=lyJSjacjcFvHRNzPVGXfZPUd0xoPdr41+3jUabfwPgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BIWs346492f1NiB84FuVNwhV5dkstEFsrfWqpFgXPKUc62JzcotdaMWUz3u8GLwguPhREiTq3AJI9ekU8v0HLeCX0UW7x6+q2Mp4C+oeiw1sm4LBsxVrrgtYkc2EwmqXf6noqpfw0hAiFLRXZ7lyIE0Z5tObHq9pAzDCBaMogoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BwGACSes; arc=none smtp.client-ip=95.215.58.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BwGACSes"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lyJSjacjcFvHRNzPVGXfZPUd0xoPdr41+3jUabfwPgg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787901626; v=1; x=1788506426;
 b=BwGACSes3hG+mis1StWLcxbNKOvdlMpjiIPwSGqMWfU3p0OgjAs0J6Hmy3OjAlMoj2ePd3ly
 0HymuBB+LgmucpytCl3AI/gzvLkKSyguPFJVr2+EJL8o1DMQj6m17sXMWPC8x9eLdoVwVjXJHyi
 yRlQnV7+FP+tyOc0Wt9jqdVg=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 60ab96d263ab17e5;
	Fri, 28 Aug 2026 07:20:16 +0000
X-Mizu-Trace-ID: 60ab96d263ab17e5
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: axboe@kernel.dk,
	hch@lst.de
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH] loop: defer the queue limits clear to a workqueue
Date: Fri, 28 Aug 2026 15:20:04 +0800
Message-ID: <20260828072004.273519-1-cui.tao@linux.dev>
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
execution of the work item are not lost, and cancel the work item
before the device is freed.  If the device is reconfigured to a
backing file that does support the operation in that window, the
stale clear takes effect and discard is disabled until the next
reconfiguration.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 drivers/block/loop.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6f12976035b0..5a1e8b6794ed 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -67,6 +67,8 @@ struct loop_device {
 	struct list_head        rootcg_cmd_list;
 	struct list_head        idle_worker_list;
 	struct rb_root          worker_tree;
+	struct work_struct      clear_limits_work;
+	int			clear_limits_mode;
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
+	int mode = lo->clear_limits_mode;
 
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
+	lo->clear_limits_mode |= mode;
+	schedule_work(&lo->clear_limits_work);
 }
 
 static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
@@ -1781,6 +1785,7 @@ static void lo_free_disk(struct gendisk *disk)
 		destroy_workqueue(lo->workqueue);
 	loop_free_idle_workers(lo, true);
 	timer_shutdown_sync(&lo->timer);
+	cancel_work_sync(&lo->clear_limits_work);
 	mutex_destroy(&lo->lo_mutex);
 	kfree(lo);
 }
@@ -2100,6 +2105,7 @@ static int loop_add(int i)
 	spin_lock_init(&lo->lo_lock);
 	spin_lock_init(&lo->lo_work_lock);
 	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
+	INIT_WORK(&lo->clear_limits_work, loop_clear_limits_workfn);
 	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
 	disk->major		= LOOP_MAJOR;
 	disk->first_minor	= i << part_shift;
-- 
2.43.0

