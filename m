Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F198DC48BDF
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 07:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6228613E7
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 07:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhFXHqV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jun 2021 03:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhFXHqV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 03:46:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAB0C061574
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 00:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mVrg0SJm2Yjjopyw7GQLPNj9TJevljTeCIc847q9fjY=; b=V3LunmBgrSWmVjUJHR5r+El1DL
        oK2ZdBWCHqztTKyf8iWXa4ve5SvcuHeHdtWi2ZJHnJOjthSP1TCbOQ8LRnu8TG/lzAxXpcSEg3/0Q
        HLREDQ+vb7FL03Vf/cLkSTdt+N5/WtzDqrywHqrTxDZpjbAEwbLuijoMcZAfGoK0qv6BAX9TrL1u4
        h7C423tZWElNUvv896ZBr1PlCva8KEc3ojBjBy2DXDUm1+E2O+i9GohSM4S1LqtlBoM9AJLM4TWjF
        0A4jn+A2yO8is1D8qZ10fyhu1hAKRbzoZPDKUIds0h9Eeiwlu2KymNj+vmuDa3O1ETAcBszkNfkrn
        Dse6li3g==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwK1L-00GJul-0n; Thu, 24 Jun 2021 07:43:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: move the disk events code to a separate file
Date:   Thu, 24 Jun 2021 09:38:42 +0200
Message-Id: <20210624073843.251178-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210624073843.251178-1-hch@lst.de>
References: <20210624073843.251178-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the code for handling disk events from genhd.c into a new file
as it isn't very related to the rest of the file while at the same
time requiring lots of forward declarations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/Makefile      |   3 +-
 block/blk.h         |   5 +
 block/disk-events.c | 484 +++++++++++++++++++++++++++++++++++++++++++
 block/genhd.c       | 492 --------------------------------------------
 4 files changed, 491 insertions(+), 493 deletions(-)
 create mode 100644 block/disk-events.c

diff --git a/block/Makefile b/block/Makefile
index b9db5d4edfc8..bfbe4e13ca1e 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -8,7 +8,8 @@ obj-$(CONFIG_BLOCK) := bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-exec.o blk-merge.o blk-timeout.o \
 			blk-lib.o blk-mq.o blk-mq-tag.o blk-stat.o \
 			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
-			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o
+			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o \
+			disk-events.o
 
 obj-$(CONFIG_BOUNCE)		+= bounce.o
 obj-$(CONFIG_BLK_SCSI_REQUEST)	+= scsi_ioctl.o
diff --git a/block/blk.h b/block/blk.h
index d3fa47af3607..f8d726429906 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -360,4 +360,9 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 
 struct request_queue *blk_alloc_queue(int node_id);
 
+void disk_alloc_events(struct gendisk *disk);
+void disk_add_events(struct gendisk *disk);
+void disk_del_events(struct gendisk *disk);
+void disk_release_events(struct gendisk *disk);
+
 #endif /* BLK_INTERNAL_H */
diff --git a/block/disk-events.c b/block/disk-events.c
new file mode 100644
index 000000000000..1bc5dcb75e4e
--- /dev/null
+++ b/block/disk-events.c
@@ -0,0 +1,484 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Disk events - monitor disk events like media change and eject request.
+ */
+#include <linux/export.h>
+#include <linux/moduleparam.h>
+#include <linux/genhd.h>
+#include "blk.h"
+
+struct disk_events {
+	struct list_head	node;		/* all disk_event's */
+	struct gendisk		*disk;		/* the associated disk */
+	spinlock_t		lock;
+
+	struct mutex		block_mutex;	/* protects blocking */
+	int			block;		/* event blocking depth */
+	unsigned int		pending;	/* events already sent out */
+	unsigned int		clearing;	/* events being cleared */
+
+	long			poll_msecs;	/* interval, -1 for default */
+	struct delayed_work	dwork;
+};
+
+static const char *disk_events_strs[] = {
+	[ilog2(DISK_EVENT_MEDIA_CHANGE)]	= "media_change",
+	[ilog2(DISK_EVENT_EJECT_REQUEST)]	= "eject_request",
+};
+
+static char *disk_uevents[] = {
+	[ilog2(DISK_EVENT_MEDIA_CHANGE)]	= "DISK_MEDIA_CHANGE=1",
+	[ilog2(DISK_EVENT_EJECT_REQUEST)]	= "DISK_EJECT_REQUEST=1",
+};
+
+/* list of all disk_events */
+static DEFINE_MUTEX(disk_events_mutex);
+static LIST_HEAD(disk_events);
+
+/* disable in-kernel polling by default */
+static unsigned long disk_events_dfl_poll_msecs;
+
+static unsigned long disk_events_poll_jiffies(struct gendisk *disk)
+{
+	struct disk_events *ev = disk->ev;
+	long intv_msecs = 0;
+
+	/*
+	 * If device-specific poll interval is set, always use it.  If
+	 * the default is being used, poll if the POLL flag is set.
+	 */
+	if (ev->poll_msecs >= 0)
+		intv_msecs = ev->poll_msecs;
+	else if (disk->event_flags & DISK_EVENT_FLAG_POLL)
+		intv_msecs = disk_events_dfl_poll_msecs;
+
+	return msecs_to_jiffies(intv_msecs);
+}
+
+/**
+ * disk_block_events - block and flush disk event checking
+ * @disk: disk to block events for
+ *
+ * On return from this function, it is guaranteed that event checking
+ * isn't in progress and won't happen until unblocked by
+ * disk_unblock_events().  Events blocking is counted and the actual
+ * unblocking happens after the matching number of unblocks are done.
+ *
+ * Note that this intentionally does not block event checking from
+ * disk_clear_events().
+ *
+ * CONTEXT:
+ * Might sleep.
+ */
+void disk_block_events(struct gendisk *disk)
+{
+	struct disk_events *ev = disk->ev;
+	unsigned long flags;
+	bool cancel;
+
+	if (!ev)
+		return;
+
+	/*
+	 * Outer mutex ensures that the first blocker completes canceling
+	 * the event work before further blockers are allowed to finish.
+	 */
+	mutex_lock(&ev->block_mutex);
+
+	spin_lock_irqsave(&ev->lock, flags);
+	cancel = !ev->block++;
+	spin_unlock_irqrestore(&ev->lock, flags);
+
+	if (cancel)
+		cancel_delayed_work_sync(&disk->ev->dwork);
+
+	mutex_unlock(&ev->block_mutex);
+}
+
+static void __disk_unblock_events(struct gendisk *disk, bool check_now)
+{
+	struct disk_events *ev = disk->ev;
+	unsigned long intv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ev->lock, flags);
+
+	if (WARN_ON_ONCE(ev->block <= 0))
+		goto out_unlock;
+
+	if (--ev->block)
+		goto out_unlock;
+
+	intv = disk_events_poll_jiffies(disk);
+	if (check_now)
+		queue_delayed_work(system_freezable_power_efficient_wq,
+				&ev->dwork, 0);
+	else if (intv)
+		queue_delayed_work(system_freezable_power_efficient_wq,
+				&ev->dwork, intv);
+out_unlock:
+	spin_unlock_irqrestore(&ev->lock, flags);
+}
+
+/**
+ * disk_unblock_events - unblock disk event checking
+ * @disk: disk to unblock events for
+ *
+ * Undo disk_block_events().  When the block count reaches zero, it
+ * starts events polling if configured.
+ *
+ * CONTEXT:
+ * Don't care.  Safe to call from irq context.
+ */
+void disk_unblock_events(struct gendisk *disk)
+{
+	if (disk->ev)
+		__disk_unblock_events(disk, false);
+}
+
+/**
+ * disk_flush_events - schedule immediate event checking and flushing
+ * @disk: disk to check and flush events for
+ * @mask: events to flush
+ *
+ * Schedule immediate event checking on @disk if not blocked.  Events in
+ * @mask are scheduled to be cleared from the driver.  Note that this
+ * doesn't clear the events from @disk->ev.
+ *
+ * CONTEXT:
+ * If @mask is non-zero must be called with disk->open_mutex held.
+ */
+void disk_flush_events(struct gendisk *disk, unsigned int mask)
+{
+	struct disk_events *ev = disk->ev;
+
+	if (!ev)
+		return;
+
+	spin_lock_irq(&ev->lock);
+	ev->clearing |= mask;
+	if (!ev->block)
+		mod_delayed_work(system_freezable_power_efficient_wq,
+				&ev->dwork, 0);
+	spin_unlock_irq(&ev->lock);
+}
+
+static void disk_check_events(struct disk_events *ev,
+			      unsigned int *clearing_ptr)
+{
+	struct gendisk *disk = ev->disk;
+	char *envp[ARRAY_SIZE(disk_uevents) + 1] = { };
+	unsigned int clearing = *clearing_ptr;
+	unsigned int events;
+	unsigned long intv;
+	int nr_events = 0, i;
+
+	/* check events */
+	events = disk->fops->check_events(disk, clearing);
+
+	/* accumulate pending events and schedule next poll if necessary */
+	spin_lock_irq(&ev->lock);
+
+	events &= ~ev->pending;
+	ev->pending |= events;
+	*clearing_ptr &= ~clearing;
+
+	intv = disk_events_poll_jiffies(disk);
+	if (!ev->block && intv)
+		queue_delayed_work(system_freezable_power_efficient_wq,
+				&ev->dwork, intv);
+
+	spin_unlock_irq(&ev->lock);
+
+	/*
+	 * Tell userland about new events.  Only the events listed in
+	 * @disk->events are reported, and only if DISK_EVENT_FLAG_UEVENT
+	 * is set. Otherwise, events are processed internally but never
+	 * get reported to userland.
+	 */
+	for (i = 0; i < ARRAY_SIZE(disk_uevents); i++)
+		if ((events & disk->events & (1 << i)) &&
+		    (disk->event_flags & DISK_EVENT_FLAG_UEVENT))
+			envp[nr_events++] = disk_uevents[i];
+
+	if (nr_events)
+		kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
+}
+
+/**
+ * disk_clear_events - synchronously check, clear and return pending events
+ * @disk: disk to fetch and clear events from
+ * @mask: mask of events to be fetched and cleared
+ *
+ * Disk events are synchronously checked and pending events in @mask
+ * are cleared and returned.  This ignores the block count.
+ *
+ * CONTEXT:
+ * Might sleep.
+ */
+static unsigned int disk_clear_events(struct gendisk *disk, unsigned int mask)
+{
+	struct disk_events *ev = disk->ev;
+	unsigned int pending;
+	unsigned int clearing = mask;
+
+	if (!ev)
+		return 0;
+
+	disk_block_events(disk);
+
+	/*
+	 * store the union of mask and ev->clearing on the stack so that the
+	 * race with disk_flush_events does not cause ambiguity (ev->clearing
+	 * can still be modified even if events are blocked).
+	 */
+	spin_lock_irq(&ev->lock);
+	clearing |= ev->clearing;
+	ev->clearing = 0;
+	spin_unlock_irq(&ev->lock);
+
+	disk_check_events(ev, &clearing);
+	/*
+	 * if ev->clearing is not 0, the disk_flush_events got called in the
+	 * middle of this function, so we want to run the workfn without delay.
+	 */
+	__disk_unblock_events(disk, ev->clearing ? true : false);
+
+	/* then, fetch and clear pending events */
+	spin_lock_irq(&ev->lock);
+	pending = ev->pending & mask;
+	ev->pending &= ~mask;
+	spin_unlock_irq(&ev->lock);
+	WARN_ON_ONCE(clearing & mask);
+
+	return pending;
+}
+
+/**
+ * bdev_check_media_change - check if a removable media has been changed
+ * @bdev: block device to check
+ *
+ * Check whether a removable media has been changed, and attempt to free all
+ * dentries and inodes and invalidates all block device page cache entries in
+ * that case.
+ *
+ * Returns %true if the block device changed, or %false if not.
+ */
+bool bdev_check_media_change(struct block_device *bdev)
+{
+	unsigned int events;
+
+	events = disk_clear_events(bdev->bd_disk, DISK_EVENT_MEDIA_CHANGE |
+				   DISK_EVENT_EJECT_REQUEST);
+	if (!(events & DISK_EVENT_MEDIA_CHANGE))
+		return false;
+
+	if (__invalidate_device(bdev, true))
+		pr_warn("VFS: busy inodes on changed media %s\n",
+			bdev->bd_disk->disk_name);
+	set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
+	return true;
+}
+EXPORT_SYMBOL(bdev_check_media_change);
+
+/*
+ * Separate this part out so that a different pointer for clearing_ptr can be
+ * passed in for disk_clear_events.
+ */
+static void disk_events_workfn(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct disk_events *ev = container_of(dwork, struct disk_events, dwork);
+
+	disk_check_events(ev, &ev->clearing);
+}
+
+/*
+ * A disk events enabled device has the following sysfs nodes under
+ * its /sys/block/X/ directory.
+ *
+ * events		: list of all supported events
+ * events_async		: list of events which can be detected w/o polling
+ *			  (always empty, only for backwards compatibility)
+ * events_poll_msecs	: polling interval, 0: disable, -1: system default
+ */
+static ssize_t __disk_events_show(unsigned int events, char *buf)
+{
+	const char *delim = "";
+	ssize_t pos = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(disk_events_strs); i++)
+		if (events & (1 << i)) {
+			pos += sprintf(buf + pos, "%s%s",
+				       delim, disk_events_strs[i]);
+			delim = " ";
+		}
+	if (pos)
+		pos += sprintf(buf + pos, "\n");
+	return pos;
+}
+
+static ssize_t disk_events_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+
+	if (!(disk->event_flags & DISK_EVENT_FLAG_UEVENT))
+		return 0;
+	return __disk_events_show(disk->events, buf);
+}
+
+static ssize_t disk_events_async_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	return 0;
+}
+
+static ssize_t disk_events_poll_msecs_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+
+	if (!disk->ev)
+		return sprintf(buf, "-1\n");
+	return sprintf(buf, "%ld\n", disk->ev->poll_msecs);
+}
+
+static ssize_t disk_events_poll_msecs_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t count)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	long intv;
+
+	if (!count || !sscanf(buf, "%ld", &intv))
+		return -EINVAL;
+
+	if (intv < 0 && intv != -1)
+		return -EINVAL;
+
+	if (!disk->ev)
+		return -ENODEV;
+
+	disk_block_events(disk);
+	disk->ev->poll_msecs = intv;
+	__disk_unblock_events(disk, true);
+	return count;
+}
+
+static const DEVICE_ATTR(events, 0444, disk_events_show, NULL);
+static const DEVICE_ATTR(events_async, 0444, disk_events_async_show, NULL);
+static const DEVICE_ATTR(events_poll_msecs, 0644,
+			 disk_events_poll_msecs_show,
+			 disk_events_poll_msecs_store);
+
+static const struct attribute *disk_events_attrs[] = {
+	&dev_attr_events.attr,
+	&dev_attr_events_async.attr,
+	&dev_attr_events_poll_msecs.attr,
+	NULL,
+};
+
+/*
+ * The default polling interval can be specified by the kernel
+ * parameter block.events_dfl_poll_msecs which defaults to 0
+ * (disable).  This can also be modified runtime by writing to
+ * /sys/module/block/parameters/events_dfl_poll_msecs.
+ */
+static int disk_events_set_dfl_poll_msecs(const char *val,
+					  const struct kernel_param *kp)
+{
+	struct disk_events *ev;
+	int ret;
+
+	ret = param_set_ulong(val, kp);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&disk_events_mutex);
+	list_for_each_entry(ev, &disk_events, node)
+		disk_flush_events(ev->disk, 0);
+	mutex_unlock(&disk_events_mutex);
+	return 0;
+}
+
+static const struct kernel_param_ops disk_events_dfl_poll_msecs_param_ops = {
+	.set	= disk_events_set_dfl_poll_msecs,
+	.get	= param_get_ulong,
+};
+
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX	"block."
+
+module_param_cb(events_dfl_poll_msecs, &disk_events_dfl_poll_msecs_param_ops,
+		&disk_events_dfl_poll_msecs, 0644);
+
+/*
+ * disk_{alloc|add|del|release}_events - initialize and destroy disk_events.
+ */
+void disk_alloc_events(struct gendisk *disk)
+{
+	struct disk_events *ev;
+
+	if (!disk->fops->check_events || !disk->events)
+		return;
+
+	ev = kzalloc(sizeof(*ev), GFP_KERNEL);
+	if (!ev) {
+		pr_warn("%s: failed to initialize events\n", disk->disk_name);
+		return;
+	}
+
+	INIT_LIST_HEAD(&ev->node);
+	ev->disk = disk;
+	spin_lock_init(&ev->lock);
+	mutex_init(&ev->block_mutex);
+	ev->block = 1;
+	ev->poll_msecs = -1;
+	INIT_DELAYED_WORK(&ev->dwork, disk_events_workfn);
+
+	disk->ev = ev;
+}
+
+void disk_add_events(struct gendisk *disk)
+{
+	/* FIXME: error handling */
+	if (sysfs_create_files(&disk_to_dev(disk)->kobj, disk_events_attrs) < 0)
+		pr_warn("%s: failed to create sysfs files for events\n",
+			disk->disk_name);
+
+	if (!disk->ev)
+		return;
+
+	mutex_lock(&disk_events_mutex);
+	list_add_tail(&disk->ev->node, &disk_events);
+	mutex_unlock(&disk_events_mutex);
+
+	/*
+	 * Block count is initialized to 1 and the following initial
+	 * unblock kicks it into action.
+	 */
+	__disk_unblock_events(disk, true);
+}
+
+void disk_del_events(struct gendisk *disk)
+{
+	if (disk->ev) {
+		disk_block_events(disk);
+
+		mutex_lock(&disk_events_mutex);
+		list_del_init(&disk->ev->node);
+		mutex_unlock(&disk_events_mutex);
+	}
+
+	sysfs_remove_files(&disk_to_dev(disk)->kobj, disk_events_attrs);
+}
+
+void disk_release_events(struct gendisk *disk)
+{
+	/* the block count should be 1 from disk_del_events() */
+	WARN_ON_ONCE(disk->ev && disk->ev->block != 1);
+	kfree(disk->ev);
+}
diff --git a/block/genhd.c b/block/genhd.c
index 5f5628216295..4f879deede9a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -33,13 +33,6 @@ static struct kobject *block_depr;
 #define NR_EXT_DEVT		(1 << MINORBITS)
 static DEFINE_IDA(ext_devt_ida);
 
-static void disk_check_events(struct disk_events *ev,
-			      unsigned int *clearing_ptr);
-static void disk_alloc_events(struct gendisk *disk);
-static void disk_add_events(struct gendisk *disk);
-static void disk_del_events(struct gendisk *disk);
-static void disk_release_events(struct gendisk *disk);
-
 void set_capacity(struct gendisk *disk, sector_t sectors)
 {
 	struct block_device *bdev = disk->part0;
@@ -1367,488 +1360,3 @@ int bdev_read_only(struct block_device *bdev)
 	return bdev->bd_read_only || get_disk_ro(bdev->bd_disk);
 }
 EXPORT_SYMBOL(bdev_read_only);
-
-/*
- * Disk events - monitor disk events like media change and eject request.
- */
-struct disk_events {
-	struct list_head	node;		/* all disk_event's */
-	struct gendisk		*disk;		/* the associated disk */
-	spinlock_t		lock;
-
-	struct mutex		block_mutex;	/* protects blocking */
-	int			block;		/* event blocking depth */
-	unsigned int		pending;	/* events already sent out */
-	unsigned int		clearing;	/* events being cleared */
-
-	long			poll_msecs;	/* interval, -1 for default */
-	struct delayed_work	dwork;
-};
-
-static const char *disk_events_strs[] = {
-	[ilog2(DISK_EVENT_MEDIA_CHANGE)]	= "media_change",
-	[ilog2(DISK_EVENT_EJECT_REQUEST)]	= "eject_request",
-};
-
-static char *disk_uevents[] = {
-	[ilog2(DISK_EVENT_MEDIA_CHANGE)]	= "DISK_MEDIA_CHANGE=1",
-	[ilog2(DISK_EVENT_EJECT_REQUEST)]	= "DISK_EJECT_REQUEST=1",
-};
-
-/* list of all disk_events */
-static DEFINE_MUTEX(disk_events_mutex);
-static LIST_HEAD(disk_events);
-
-/* disable in-kernel polling by default */
-static unsigned long disk_events_dfl_poll_msecs;
-
-static unsigned long disk_events_poll_jiffies(struct gendisk *disk)
-{
-	struct disk_events *ev = disk->ev;
-	long intv_msecs = 0;
-
-	/*
-	 * If device-specific poll interval is set, always use it.  If
-	 * the default is being used, poll if the POLL flag is set.
-	 */
-	if (ev->poll_msecs >= 0)
-		intv_msecs = ev->poll_msecs;
-	else if (disk->event_flags & DISK_EVENT_FLAG_POLL)
-		intv_msecs = disk_events_dfl_poll_msecs;
-
-	return msecs_to_jiffies(intv_msecs);
-}
-
-/**
- * disk_block_events - block and flush disk event checking
- * @disk: disk to block events for
- *
- * On return from this function, it is guaranteed that event checking
- * isn't in progress and won't happen until unblocked by
- * disk_unblock_events().  Events blocking is counted and the actual
- * unblocking happens after the matching number of unblocks are done.
- *
- * Note that this intentionally does not block event checking from
- * disk_clear_events().
- *
- * CONTEXT:
- * Might sleep.
- */
-void disk_block_events(struct gendisk *disk)
-{
-	struct disk_events *ev = disk->ev;
-	unsigned long flags;
-	bool cancel;
-
-	if (!ev)
-		return;
-
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
-		cancel_delayed_work_sync(&disk->ev->dwork);
-
-	mutex_unlock(&ev->block_mutex);
-}
-
-static void __disk_unblock_events(struct gendisk *disk, bool check_now)
-{
-	struct disk_events *ev = disk->ev;
-	unsigned long intv;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ev->lock, flags);
-
-	if (WARN_ON_ONCE(ev->block <= 0))
-		goto out_unlock;
-
-	if (--ev->block)
-		goto out_unlock;
-
-	intv = disk_events_poll_jiffies(disk);
-	if (check_now)
-		queue_delayed_work(system_freezable_power_efficient_wq,
-				&ev->dwork, 0);
-	else if (intv)
-		queue_delayed_work(system_freezable_power_efficient_wq,
-				&ev->dwork, intv);
-out_unlock:
-	spin_unlock_irqrestore(&ev->lock, flags);
-}
-
-/**
- * disk_unblock_events - unblock disk event checking
- * @disk: disk to unblock events for
- *
- * Undo disk_block_events().  When the block count reaches zero, it
- * starts events polling if configured.
- *
- * CONTEXT:
- * Don't care.  Safe to call from irq context.
- */
-void disk_unblock_events(struct gendisk *disk)
-{
-	if (disk->ev)
-		__disk_unblock_events(disk, false);
-}
-
-/**
- * disk_flush_events - schedule immediate event checking and flushing
- * @disk: disk to check and flush events for
- * @mask: events to flush
- *
- * Schedule immediate event checking on @disk if not blocked.  Events in
- * @mask are scheduled to be cleared from the driver.  Note that this
- * doesn't clear the events from @disk->ev.
- *
- * CONTEXT:
- * If @mask is non-zero must be called with disk->open_mutex held.
- */
-void disk_flush_events(struct gendisk *disk, unsigned int mask)
-{
-	struct disk_events *ev = disk->ev;
-
-	if (!ev)
-		return;
-
-	spin_lock_irq(&ev->lock);
-	ev->clearing |= mask;
-	if (!ev->block)
-		mod_delayed_work(system_freezable_power_efficient_wq,
-				&ev->dwork, 0);
-	spin_unlock_irq(&ev->lock);
-}
-
-/**
- * disk_clear_events - synchronously check, clear and return pending events
- * @disk: disk to fetch and clear events from
- * @mask: mask of events to be fetched and cleared
- *
- * Disk events are synchronously checked and pending events in @mask
- * are cleared and returned.  This ignores the block count.
- *
- * CONTEXT:
- * Might sleep.
- */
-static unsigned int disk_clear_events(struct gendisk *disk, unsigned int mask)
-{
-	struct disk_events *ev = disk->ev;
-	unsigned int pending;
-	unsigned int clearing = mask;
-
-	if (!ev)
-		return 0;
-
-	disk_block_events(disk);
-
-	/*
-	 * store the union of mask and ev->clearing on the stack so that the
-	 * race with disk_flush_events does not cause ambiguity (ev->clearing
-	 * can still be modified even if events are blocked).
-	 */
-	spin_lock_irq(&ev->lock);
-	clearing |= ev->clearing;
-	ev->clearing = 0;
-	spin_unlock_irq(&ev->lock);
-
-	disk_check_events(ev, &clearing);
-	/*
-	 * if ev->clearing is not 0, the disk_flush_events got called in the
-	 * middle of this function, so we want to run the workfn without delay.
-	 */
-	__disk_unblock_events(disk, ev->clearing ? true : false);
-
-	/* then, fetch and clear pending events */
-	spin_lock_irq(&ev->lock);
-	pending = ev->pending & mask;
-	ev->pending &= ~mask;
-	spin_unlock_irq(&ev->lock);
-	WARN_ON_ONCE(clearing & mask);
-
-	return pending;
-}
-
-/**
- * bdev_check_media_change - check if a removable media has been changed
- * @bdev: block device to check
- *
- * Check whether a removable media has been changed, and attempt to free all
- * dentries and inodes and invalidates all block device page cache entries in
- * that case.
- *
- * Returns %true if the block device changed, or %false if not.
- */
-bool bdev_check_media_change(struct block_device *bdev)
-{
-	unsigned int events;
-
-	events = disk_clear_events(bdev->bd_disk, DISK_EVENT_MEDIA_CHANGE |
-				   DISK_EVENT_EJECT_REQUEST);
-	if (!(events & DISK_EVENT_MEDIA_CHANGE))
-		return false;
-
-	if (__invalidate_device(bdev, true))
-		pr_warn("VFS: busy inodes on changed media %s\n",
-			bdev->bd_disk->disk_name);
-	set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
-	return true;
-}
-EXPORT_SYMBOL(bdev_check_media_change);
-
-/*
- * Separate this part out so that a different pointer for clearing_ptr can be
- * passed in for disk_clear_events.
- */
-static void disk_events_workfn(struct work_struct *work)
-{
-	struct delayed_work *dwork = to_delayed_work(work);
-	struct disk_events *ev = container_of(dwork, struct disk_events, dwork);
-
-	disk_check_events(ev, &ev->clearing);
-}
-
-static void disk_check_events(struct disk_events *ev,
-			      unsigned int *clearing_ptr)
-{
-	struct gendisk *disk = ev->disk;
-	char *envp[ARRAY_SIZE(disk_uevents) + 1] = { };
-	unsigned int clearing = *clearing_ptr;
-	unsigned int events;
-	unsigned long intv;
-	int nr_events = 0, i;
-
-	/* check events */
-	events = disk->fops->check_events(disk, clearing);
-
-	/* accumulate pending events and schedule next poll if necessary */
-	spin_lock_irq(&ev->lock);
-
-	events &= ~ev->pending;
-	ev->pending |= events;
-	*clearing_ptr &= ~clearing;
-
-	intv = disk_events_poll_jiffies(disk);
-	if (!ev->block && intv)
-		queue_delayed_work(system_freezable_power_efficient_wq,
-				&ev->dwork, intv);
-
-	spin_unlock_irq(&ev->lock);
-
-	/*
-	 * Tell userland about new events.  Only the events listed in
-	 * @disk->events are reported, and only if DISK_EVENT_FLAG_UEVENT
-	 * is set. Otherwise, events are processed internally but never
-	 * get reported to userland.
-	 */
-	for (i = 0; i < ARRAY_SIZE(disk_uevents); i++)
-		if ((events & disk->events & (1 << i)) &&
-		    (disk->event_flags & DISK_EVENT_FLAG_UEVENT))
-			envp[nr_events++] = disk_uevents[i];
-
-	if (nr_events)
-		kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
-}
-
-/*
- * A disk events enabled device has the following sysfs nodes under
- * its /sys/block/X/ directory.
- *
- * events		: list of all supported events
- * events_async		: list of events which can be detected w/o polling
- *			  (always empty, only for backwards compatibility)
- * events_poll_msecs	: polling interval, 0: disable, -1: system default
- */
-static ssize_t __disk_events_show(unsigned int events, char *buf)
-{
-	const char *delim = "";
-	ssize_t pos = 0;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(disk_events_strs); i++)
-		if (events & (1 << i)) {
-			pos += sprintf(buf + pos, "%s%s",
-				       delim, disk_events_strs[i]);
-			delim = " ";
-		}
-	if (pos)
-		pos += sprintf(buf + pos, "\n");
-	return pos;
-}
-
-static ssize_t disk_events_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct gendisk *disk = dev_to_disk(dev);
-
-	if (!(disk->event_flags & DISK_EVENT_FLAG_UEVENT))
-		return 0;
-
-	return __disk_events_show(disk->events, buf);
-}
-
-static ssize_t disk_events_async_show(struct device *dev,
-				      struct device_attribute *attr, char *buf)
-{
-	return 0;
-}
-
-static ssize_t disk_events_poll_msecs_show(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
-{
-	struct gendisk *disk = dev_to_disk(dev);
-
-	if (!disk->ev)
-		return sprintf(buf, "-1\n");
-
-	return sprintf(buf, "%ld\n", disk->ev->poll_msecs);
-}
-
-static ssize_t disk_events_poll_msecs_store(struct device *dev,
-					    struct device_attribute *attr,
-					    const char *buf, size_t count)
-{
-	struct gendisk *disk = dev_to_disk(dev);
-	long intv;
-
-	if (!count || !sscanf(buf, "%ld", &intv))
-		return -EINVAL;
-
-	if (intv < 0 && intv != -1)
-		return -EINVAL;
-
-	if (!disk->ev)
-		return -ENODEV;
-
-	disk_block_events(disk);
-	disk->ev->poll_msecs = intv;
-	__disk_unblock_events(disk, true);
-
-	return count;
-}
-
-static const DEVICE_ATTR(events, 0444, disk_events_show, NULL);
-static const DEVICE_ATTR(events_async, 0444, disk_events_async_show, NULL);
-static const DEVICE_ATTR(events_poll_msecs, 0644,
-			 disk_events_poll_msecs_show,
-			 disk_events_poll_msecs_store);
-
-static const struct attribute *disk_events_attrs[] = {
-	&dev_attr_events.attr,
-	&dev_attr_events_async.attr,
-	&dev_attr_events_poll_msecs.attr,
-	NULL,
-};
-
-/*
- * The default polling interval can be specified by the kernel
- * parameter block.events_dfl_poll_msecs which defaults to 0
- * (disable).  This can also be modified runtime by writing to
- * /sys/module/block/parameters/events_dfl_poll_msecs.
- */
-static int disk_events_set_dfl_poll_msecs(const char *val,
-					  const struct kernel_param *kp)
-{
-	struct disk_events *ev;
-	int ret;
-
-	ret = param_set_ulong(val, kp);
-	if (ret < 0)
-		return ret;
-
-	mutex_lock(&disk_events_mutex);
-
-	list_for_each_entry(ev, &disk_events, node)
-		disk_flush_events(ev->disk, 0);
-
-	mutex_unlock(&disk_events_mutex);
-
-	return 0;
-}
-
-static const struct kernel_param_ops disk_events_dfl_poll_msecs_param_ops = {
-	.set	= disk_events_set_dfl_poll_msecs,
-	.get	= param_get_ulong,
-};
-
-#undef MODULE_PARAM_PREFIX
-#define MODULE_PARAM_PREFIX	"block."
-
-module_param_cb(events_dfl_poll_msecs, &disk_events_dfl_poll_msecs_param_ops,
-		&disk_events_dfl_poll_msecs, 0644);
-
-/*
- * disk_{alloc|add|del|release}_events - initialize and destroy disk_events.
- */
-static void disk_alloc_events(struct gendisk *disk)
-{
-	struct disk_events *ev;
-
-	if (!disk->fops->check_events || !disk->events)
-		return;
-
-	ev = kzalloc(sizeof(*ev), GFP_KERNEL);
-	if (!ev) {
-		pr_warn("%s: failed to initialize events\n", disk->disk_name);
-		return;
-	}
-
-	INIT_LIST_HEAD(&ev->node);
-	ev->disk = disk;
-	spin_lock_init(&ev->lock);
-	mutex_init(&ev->block_mutex);
-	ev->block = 1;
-	ev->poll_msecs = -1;
-	INIT_DELAYED_WORK(&ev->dwork, disk_events_workfn);
-
-	disk->ev = ev;
-}
-
-static void disk_add_events(struct gendisk *disk)
-{
-	/* FIXME: error handling */
-	if (sysfs_create_files(&disk_to_dev(disk)->kobj, disk_events_attrs) < 0)
-		pr_warn("%s: failed to create sysfs files for events\n",
-			disk->disk_name);
-
-	if (!disk->ev)
-		return;
-
-	mutex_lock(&disk_events_mutex);
-	list_add_tail(&disk->ev->node, &disk_events);
-	mutex_unlock(&disk_events_mutex);
-
-	/*
-	 * Block count is initialized to 1 and the following initial
-	 * unblock kicks it into action.
-	 */
-	__disk_unblock_events(disk, true);
-}
-
-static void disk_del_events(struct gendisk *disk)
-{
-	if (disk->ev) {
-		disk_block_events(disk);
-
-		mutex_lock(&disk_events_mutex);
-		list_del_init(&disk->ev->node);
-		mutex_unlock(&disk_events_mutex);
-	}
-
-	sysfs_remove_files(&disk_to_dev(disk)->kobj, disk_events_attrs);
-}
-
-static void disk_release_events(struct gendisk *disk)
-{
-	/* the block count should be 1 from disk_del_events() */
-	WARN_ON_ONCE(disk->ev && disk->ev->block != 1);
-	kfree(disk->ev);
-}
-- 
2.30.2

