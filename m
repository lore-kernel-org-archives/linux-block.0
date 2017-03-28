Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34770 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753523AbdC1XNR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2017 19:13:17 -0400
Received: by mail-pg0-f47.google.com with SMTP id 21so85758978pgg.1
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2017 16:13:16 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v2 3/3] block: fix leak of q->rq_wb
Date: Tue, 28 Mar 2017 16:12:17 -0700
Message-Id: <a1688be84c82d71a04e9a0cb0b9c38e02fd921a3.1490742717.git.osandov@fb.com>
In-Reply-To: <91d938665e5386f10f8756ee8c7ef3e6496ea260.1490742717.git.osandov@fb.com>
References: <91d938665e5386f10f8756ee8c7ef3e6496ea260.1490742717.git.osandov@fb.com>
In-Reply-To: <91d938665e5386f10f8756ee8c7ef3e6496ea260.1490742717.git.osandov@fb.com>
References: <91d938665e5386f10f8756ee8c7ef3e6496ea260.1490742717.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

CONFIG_DEBUG_TEST_DRIVER_REMOVE found a possible leak of q->rq_wb when a
request queue is reregistered. This has been a problem since wbt was
introduced, but the WARN_ON(!list_empty(&stats->callbacks)) in the
blk-stat rework exposed it. Fix it by cleaning up wbt when we unregister
the queue.

Fixes: 87760e5eef35 ("block: hook up writeback throttling")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 833fb7f9ce9d..45854266e398 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -795,7 +795,6 @@ static void blk_release_queue(struct kobject *kobj)
 	struct request_queue *q =
 		container_of(kobj, struct request_queue, kobj);
 
-	wbt_exit(q);
 	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
 		blk_stat_remove_callback(q, q->poll_cb);
 	blk_stat_free_callback(q->poll_cb);
@@ -938,6 +937,9 @@ void blk_unregister_queue(struct gendisk *disk)
 
 	queue_flag_clear_unlocked(QUEUE_FLAG_REGISTERED, q);
 
+	wbt_exit(q);
+
+
 	if (q->mq_ops)
 		blk_mq_unregister_dev(disk_to_dev(disk), q);
 
-- 
2.12.1
