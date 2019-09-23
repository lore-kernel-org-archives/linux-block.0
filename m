Return-Path: <SRS0=JlK2=XS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47993C32755
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 15:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B76720673
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 15:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfIWPMh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Sep 2019 11:12:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731676AbfIWPM3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Sep 2019 11:12:29 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F337A30860C8;
        Mon, 23 Sep 2019 15:12:28 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 040F119D70;
        Mon, 23 Sep 2019 15:12:21 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] block: don't release queue's sysfs lock during switching elevator
Date:   Mon, 23 Sep 2019 23:12:09 +0800
Message-Id: <20190923151209.7466-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 23 Sep 2019 15:12:29 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

cecf5d87ff20 ("block: split .sysfs_lock into two locks") starts to
release & acquire sysfs_lock before registering/un-registering elevator
queue during switching elevator for avoiding potential deadlock from
showing & storing 'queue/iosched' attributes and removing elevator's
kobject.

Turns out there isn't such deadlock because 'q->sysfs_lock' isn't
required in .show & .store of queue/iosched's attributes, and just
elevator's sysfs lock is acquired in elv_iosched_store() and
elv_iosched_show(). So it is safe to hold queue's sysfs lock when
registering/un-registering elevator queue.

The biggest issue is that commit cecf5d87ff20 assumes that concurrent
write on 'queue/scheduler' can't happen. However, this assumption isn't
true, because kernfs_fop_write() only guarantees that concurrent write
aren't called on the same open file, but the write could be from
different open on the file. So we can't release & re-acquire queue's
sysfs lock during switching elevator, otherwise use-after-free on
elevator could be triggered.

Fixes the issue by not releasing queue's sysfs lock during switching
elevator.

Fixes: cecf5d87ff20 ("block: split .sysfs_lock into two locks")
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-sysfs.c | 13 ++++---------
 block/elevator.c  | 31 +------------------------------
 2 files changed, 5 insertions(+), 39 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b82736c781c5..962fc0c44381 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -989,13 +989,11 @@ int blk_register_queue(struct gendisk *disk)
 		blk_mq_debugfs_register(q);
 	}
 
-	/*
-	 * The flag of QUEUE_FLAG_REGISTERED isn't set yet, so elevator
-	 * switch won't happen at all.
-	 */
+	mutex_lock(&q->sysfs_lock);
 	if (q->elevator) {
 		ret = elv_register_queue(q, false);
 		if (ret) {
+			mutex_unlock(&q->sysfs_lock);
 			mutex_unlock(&q->sysfs_dir_lock);
 			kobject_del(&q->kobj);
 			blk_trace_remove_sysfs(dev);
@@ -1005,7 +1003,6 @@ int blk_register_queue(struct gendisk *disk)
 		has_elevator = true;
 	}
 
-	mutex_lock(&q->sysfs_lock);
 	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
 	wbt_enable_default(q);
 	blk_throtl_register_queue(q);
@@ -1062,12 +1059,10 @@ void blk_unregister_queue(struct gendisk *disk)
 	kobject_del(&q->kobj);
 	blk_trace_remove_sysfs(disk_to_dev(disk));
 
-	/*
-	 * q->kobj has been removed, so it is safe to check if elevator
-	 * exists without holding q->sysfs_lock.
-	 */
+	mutex_lock(&q->sysfs_lock);
 	if (q->elevator)
 		elv_unregister_queue(q);
+	mutex_unlock(&q->sysfs_lock);
 	mutex_unlock(&q->sysfs_dir_lock);
 
 	kobject_put(&disk_to_dev(disk)->kobj);
diff --git a/block/elevator.c b/block/elevator.c
index bba10e83478a..5437059c9261 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -503,9 +503,7 @@ int elv_register_queue(struct request_queue *q, bool uevent)
 		if (uevent)
 			kobject_uevent(&e->kobj, KOBJ_ADD);
 
-		mutex_lock(&q->sysfs_lock);
 		e->registered = 1;
-		mutex_unlock(&q->sysfs_lock);
 	}
 	return error;
 }
@@ -523,11 +521,9 @@ void elv_unregister_queue(struct request_queue *q)
 		kobject_uevent(&e->kobj, KOBJ_REMOVE);
 		kobject_del(&e->kobj);
 
-		mutex_lock(&q->sysfs_lock);
 		e->registered = 0;
 		/* Re-enable throttling in case elevator disabled it */
 		wbt_enable_default(q);
-		mutex_unlock(&q->sysfs_lock);
 	}
 }
 
@@ -590,32 +586,11 @@ int elevator_switch_mq(struct request_queue *q,
 	lockdep_assert_held(&q->sysfs_lock);
 
 	if (q->elevator) {
-		if (q->elevator->registered) {
-			mutex_unlock(&q->sysfs_lock);
-
-			/*
-			 * Concurrent elevator switch can't happen becasue
-			 * sysfs write is always exclusively on same file.
-			 *
-			 * Also the elevator queue won't be freed after
-			 * sysfs_lock is released becasue kobject_del() in
-			 * blk_unregister_queue() waits for completion of
-			 * .store & .show on its attributes.
-			 */
+		if (q->elevator->registered)
 			elv_unregister_queue(q);
 
-			mutex_lock(&q->sysfs_lock);
-		}
 		ioc_clear_queue(q);
 		elevator_exit(q, q->elevator);
-
-		/*
-		 * sysfs_lock may be dropped, so re-check if queue is
-		 * unregistered. If yes, don't switch to new elevator
-		 * any more
-		 */
-		if (!blk_queue_registered(q))
-			return 0;
 	}
 
 	ret = blk_mq_init_sched(q, new_e);
@@ -623,11 +598,7 @@ int elevator_switch_mq(struct request_queue *q,
 		goto out;
 
 	if (new_e) {
-		mutex_unlock(&q->sysfs_lock);
-
 		ret = elv_register_queue(q, true);
-
-		mutex_lock(&q->sysfs_lock);
 		if (ret) {
 			elevator_exit(q, q->elevator);
 			goto out;
-- 
2.20.1

