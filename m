Return-Path: <hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <jth@kernel.org>,
	linux-block@vger.kernel.org,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH] genhd: Do not hold event lock when scheduling workqueue elements
Date: Wed, 18 Jan 2017 10:48:16 +0100
Message-Id: <1484732896-22941-1-git-send-email-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

When scheduling workqueue elements the callback function might be called
directly, so holding the event lock is potentially dangerous as it might
lead to a deadlock:

[  989.542827] INFO: task systemd-udevd:459 blocked for more than 480 seconds.
[  989.609721]       Not tainted 4.10.0-rc4+ #546
[  989.648545] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this 
message.
[  989.716429] systemd-udevd   D13368   459      1 0x00000004
[  989.716435] Call Trace:
[  989.716444]  __schedule+0x2f2/0xb10
[  989.716447]  schedule+0x3d/0x90
[  989.716449]  schedule_timeout+0x2fc/0x600
[  989.716451]  ? wait_for_completion+0xac/0x110
[  989.716456]  ? mark_held_locks+0x66/0x90
[  989.716458]  ? _raw_spin_unlock_irq+0x2c/0x40
[  989.716460]  ? trace_hardirqs_on_caller+0x111/0x1e0
[  989.716461]  wait_for_completion+0xb4/0x110
[  989.716464]  ? wake_up_q+0x80/0x80
[  989.716469]  flush_work+0x1ea/0x2a0
[  989.716470]  ? flush_work+0x24e/0x2a0
[  989.716472]  ? destroy_worker+0xd0/0xd0
[  989.716474]  __cancel_work_timer+0x11a/0x1e0
[  989.716476]  ? trace_hardirqs_on_caller+0x111/0x1e0
[  989.716477]  cancel_delayed_work_sync+0x13/0x20
[  989.716482]  disk_block_events+0x82/0x90
[  989.716487]  __blkdev_get+0x58/0x450
[  989.716488]  blkdev_get+0x1ce/0x340
[  989.716490]  ? _raw_spin_unlock+0x27/0x40
[  989.716492]  blkdev_open+0x5b/0x70
[  989.716501]  do_dentry_open+0x213/0x310
[  989.716505]  ? blkdev_get_by_dev+0x50/0x50
[  989.716507]  vfs_open+0x4f/0x80
[  989.716518]  ? may_open+0x9b/0x100
[  989.716521]  path_openat+0x48a/0xdc0
[  989.716527]  ? _crng_backtrack_protect+0x30/0x80
[  989.716530]  do_filp_open+0x7e/0xd0
[  989.716533]  ? _raw_spin_unlock+0x27/0x40
[  989.716537]  ? __alloc_fd+0xf7/0x210
[  989.716539]  do_sys_open+0x115/0x1f0
[  989.716542]  SyS_open+0x1e/0x20
[  989.716546]  entry_SYSCALL_64_fastpath+0x23/0xc6

Signed-off-by: Hannes Reinecke <hare@suse.com>

diff --git a/block/genhd.c b/block/genhd.c
index fcd6d4f..ae46caa 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1426,8 +1426,7 @@ struct disk_events {
 	struct gendisk		*disk;		/* the associated disk */
 	spinlock_t		lock;
 
-	struct mutex		block_mutex;	/* protects blocking */
-	int			block;		/* event blocking depth */
+	atomic_t		block;		/* event blocking depth */
 	unsigned int		pending;	/* events already sent out */
 	unsigned int		clearing;	/* events being cleared */
 
@@ -1488,26 +1487,13 @@ static unsigned long disk_events_poll_jiffies(struct gendisk *disk)
 void disk_block_events(struct gendisk *disk)
 {
 	struct disk_events *ev = disk->ev;
-	unsigned long flags;
-	bool cancel;
 
 	if (!ev)
 		return;
 
-	/*
-	 * Outer mutex ensures that the first blocker completes canceling
-	 * the event work before further blockers are allowed to finish.
-	 */
-	mutex_lock(&ev->block_mutex);
-
-	spin_lock_irqsave(&ev->lock, flags);
-	cancel = !ev->block++;
-	spin_unlock_irqrestore(&ev->lock, flags);
-
-	if (cancel)
+	if (atomic_inc_return(&ev->block) == 1)
 		cancel_delayed_work_sync(&disk->ev->dwork);
 
-	mutex_unlock(&ev->block_mutex);
 }
 
 static void __disk_unblock_events(struct gendisk *disk, bool check_now)
@@ -1516,23 +1502,18 @@ static void __disk_unblock_events(struct gendisk *disk, bool check_now)
 	unsigned long intv;
 	unsigned long flags;
 
-	spin_lock_irqsave(&ev->lock, flags);
-
-	if (WARN_ON_ONCE(ev->block <= 0))
-		goto out_unlock;
-
-	if (--ev->block)
-		goto out_unlock;
+	if (atomic_dec_return(&ev->block) > 0)
+		return;
 
+	spin_lock_irqsave(&ev->lock, flags);
 	intv = disk_events_poll_jiffies(disk);
+	spin_unlock_irqrestore(&ev->lock, flags);
 	if (check_now)
 		queue_delayed_work(system_freezable_power_efficient_wq,
 				&ev->dwork, 0);
 	else if (intv)
 		queue_delayed_work(system_freezable_power_efficient_wq,
 				&ev->dwork, intv);
-out_unlock:
-	spin_unlock_irqrestore(&ev->lock, flags);
 }
 
 /**
@@ -1572,10 +1553,10 @@ void disk_flush_events(struct gendisk *disk, unsigned int mask)
 
 	spin_lock_irq(&ev->lock);
 	ev->clearing |= mask;
-	if (!ev->block)
+	spin_unlock_irq(&ev->lock);
+	if (!atomic_read(&ev->block))
 		mod_delayed_work(system_freezable_power_efficient_wq,
 				&ev->dwork, 0);
-	spin_unlock_irq(&ev->lock);
 }
 
 /**
@@ -1666,12 +1647,11 @@ static void disk_check_events(struct disk_events *ev,
 	*clearing_ptr &= ~clearing;
 
 	intv = disk_events_poll_jiffies(disk);
-	if (!ev->block && intv)
+	spin_unlock_irq(&ev->lock);
+	if (!atomic_read(&ev->block) && intv)
 		queue_delayed_work(system_freezable_power_efficient_wq,
 				&ev->dwork, intv);
 
-	spin_unlock_irq(&ev->lock);
-
 	/*
 	 * Tell userland about new events.  Only the events listed in
 	 * @disk->events are reported.  Unlisted events are processed the
@@ -1824,8 +1804,7 @@ static void disk_alloc_events(struct gendisk *disk)
 	INIT_LIST_HEAD(&ev->node);
 	ev->disk = disk;
 	spin_lock_init(&ev->lock);
-	mutex_init(&ev->block_mutex);
-	ev->block = 1;
+	atomic_set(&ev->block, 1);
 	ev->poll_msecs = -1;
 	INIT_DELAYED_WORK(&ev->dwork, disk_events_workfn);
 
@@ -1870,6 +1849,6 @@ static void disk_del_events(struct gendisk *disk)
 static void disk_release_events(struct gendisk *disk)
 {
 	/* the block count should be 1 from disk_del_events() */
-	WARN_ON_ONCE(disk->ev && disk->ev->block != 1);
+	WARN_ON_ONCE(disk->ev && atomic_read(&disk->ev->block) != 1);
 	kfree(disk->ev);
 }
