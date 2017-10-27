Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751719AbdJ0DIo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Oct 2017 23:08:44 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        David Jeffery <djeffery@redhat.com>
Subject: [PATCH] block: avoid to fail elevator switch
Date: Fri, 27 Oct 2017 11:08:30 +0800
Message-Id: <20171027030830.25822-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

elevator switch can be done just between register_disk() and
blk_register_queue(), then we can't change elevator during this period
because FLAG_REGISTERED isn't set at that time.

One typical use case is that elevator is changed via udev by the following
rule, and the KOBJ_ADD uevent is just emited at the end of register_disk()
and before running blk_register_queue().

ACTION=="add|change", SUBSYSTEM=="block" , KERNEL=="sda",  RUN+="/bin/sh -c 'echo none > /sys/block/sda/queue/scheduler'"

This patch fixes the elevator switch failure issue.

Fixes: e9a823fb34a8b0(block: fix warning when I/O elevator is changed as request_queue is being removed)
Cc: David Jeffery <djeffery@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-sysfs.c |  7 ++++++-
 block/elevator.c  | 13 +++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b8362c0df51d..480959c5b036 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -927,12 +927,17 @@ int blk_register_queue(struct gendisk *disk)
 void blk_unregister_queue(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
+	bool elv_registered;
 
 	if (WARN_ON(!q))
 		return;
 
 	mutex_lock(&q->sysfs_lock);
 	queue_flag_clear_unlocked(QUEUE_FLAG_REGISTERED, q);
+	if (q->request_fn || (q->mq_ops && q->elevator))
+		elv_registered = q->elevator->registered;
+	else
+		elv_registered = false;
 	mutex_unlock(&q->sysfs_lock);
 
 	wbt_exit(q);
@@ -941,7 +946,7 @@ void blk_unregister_queue(struct gendisk *disk)
 	if (q->mq_ops)
 		blk_mq_unregister_dev(disk_to_dev(disk), q);
 
-	if (q->request_fn || (q->mq_ops && q->elevator))
+	if (elv_registered)
 		elv_unregister_queue(q);
 
 	kobject_uevent(&q->kobj, KOBJ_REMOVE);
diff --git a/block/elevator.c b/block/elevator.c
index 7ae50eb2732b..0e2a5140111f 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -852,6 +852,15 @@ int elv_register_queue(struct request_queue *q)
 	struct elevator_queue *e = q->elevator;
 	int error;
 
+	/*
+	 * When queue isn't registerd to gendisk, the elevator queue
+	 * will be added after it is registered to gendisk; When queue
+	 * is being unregistered, not necessary to add elevator queue
+	 * any more.
+	 */
+	if (!test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags))
+		return 0;
+
 	error = kobject_add(&e->kobj, &q->kobj, "%s", "iosched");
 	if (!error) {
 		struct elv_fs_entry *attr = e->type->elevator_attrs;
@@ -1055,10 +1064,6 @@ static int __elevator_change(struct request_queue *q, const char *name)
 	char elevator_name[ELV_NAME_MAX];
 	struct elevator_type *e;
 
-	/* Make sure queue is not in the middle of being removed */
-	if (!test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags))
-		return -ENOENT;
-
 	/*
 	 * Special case for mq, turn off scheduling
 	 */
-- 
2.9.5
