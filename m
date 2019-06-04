Return-Path: <SRS0=GlWt=UD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C25C282CE
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 13:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF41247FE
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 13:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfFDNIN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:08:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbfFDNIN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Jun 2019 09:08:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE7DE30C26D4;
        Tue,  4 Jun 2019 13:08:12 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C800A5B684;
        Tue,  4 Jun 2019 13:08:09 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        kernel test robot <rong.a.chen@intel.com>
Subject: [PATCH] block: free sched's request pool in blk_cleanup_queue
Date:   Tue,  4 Jun 2019 21:08:02 +0800
Message-Id: <20190604130802.17076-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 04 Jun 2019 13:08:13 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In theory, IO scheduler belongs to request queue, and the request pool
of sched tags belongs to the request queue too.

However, the current tags allocation interfaces are re-used for both
driver tags and sched tags, and driver tags is definitely host wide,
and doesn't belong to any request queue, same with its request pool.
So we need tagset instance for freeing request of sched tags.

Meantime, blk_mq_free_tag_set() often follows blk_cleanup_queue() in case
of non-BLK_MQ_F_TAG_SHARED, this way requires that request pool of sched
tags to be freed before calling blk_mq_free_tag_set().

Commit 47cdee29ef9d94e ("block: move blk_exit_queue into __blk_release_queue")
moves blk_exit_queue into __blk_release_queue for simplying the fast
path in generic_make_request(), then causes oops during freeing requests
of sched tags in __blk_release_queue().

Fix the above issue by move freeing request pool of sched tags into
blk_cleanup_queue(), this way is safe becasue queue has been frozen and no any
in-queue requests at that time. Freeing sched tags has to be kept in queue's
release handler becasue there might be un-completed dispatch activity
which might refer to sched tags.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>
Fixes: 47cdee29ef9d94e485eb08f962c74943023a5271 ("block: move blk_exit_queue into __blk_release_queue")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c     | 13 +++++++++++++
 block/blk-mq-sched.c | 30 +++++++++++++++++++++++++++---
 block/blk-mq-sched.h |  1 +
 block/blk-sysfs.c    |  2 +-
 block/blk.h          | 10 +++++++++-
 block/elevator.c     |  2 +-
 6 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ee1b35fe8572..8340f69670d8 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -320,6 +320,19 @@ void blk_cleanup_queue(struct request_queue *q)
 	if (queue_is_mq(q))
 		blk_mq_exit_queue(q);
 
+	/*
+	 * In theory, request pool of sched_tags belongs to request queue.
+	 * However, the current implementation requires tag_set for freeing
+	 * requests, so free the pool now.
+	 *
+	 * Queue has become frozen, there can't be any in-queue requests, so
+	 * it is safe to free requests now.
+	 */
+	mutex_lock(&q->sysfs_lock);
+	if (q->elevator)
+		blk_mq_sched_free_requests(q);
+	mutex_unlock(&q->sysfs_lock);
+
 	percpu_ref_exit(&q->q_usage_counter);
 
 	/* @q is and will stay empty, shutdown and put */
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 74c6bb871f7e..500cb04901cc 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -475,14 +475,18 @@ static int blk_mq_sched_alloc_tags(struct request_queue *q,
 	return ret;
 }
 
+/* called in queue's release handler, tagset has gone away */
 static void blk_mq_sched_tags_teardown(struct request_queue *q)
 {
-	struct blk_mq_tag_set *set = q->tag_set;
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	queue_for_each_hw_ctx(q, hctx, i)
-		blk_mq_sched_free_tags(set, hctx, i);
+	queue_for_each_hw_ctx(q, hctx, i) {
+		if (hctx->sched_tags) {
+			blk_mq_free_rq_map(hctx->sched_tags);
+			hctx->sched_tags = NULL;
+		}
+	}
 }
 
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
@@ -523,6 +527,7 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 			ret = e->ops.init_hctx(hctx, i);
 			if (ret) {
 				eq = q->elevator;
+				blk_mq_sched_free_requests(q);
 				blk_mq_exit_sched(q, eq);
 				kobject_put(&eq->kobj);
 				return ret;
@@ -534,11 +539,30 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	return 0;
 
 err:
+	blk_mq_sched_free_requests(q);
 	blk_mq_sched_tags_teardown(q);
 	q->elevator = NULL;
 	return ret;
 }
 
+/*
+ * called in either blk_queue_cleanup or elevator_switch, tagset
+ * is required for freeing requests
+ */
+void blk_mq_sched_free_requests(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	int i;
+
+	lockdep_assert_held(&q->sysfs_lock);
+	WARN_ON(!q->elevator);
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		if (hctx->sched_tags)
+			blk_mq_free_rqs(q->tag_set, hctx->sched_tags, i);
+	}
+}
+
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
 {
 	struct blk_mq_hw_ctx *hctx;
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index c7bdb52367ac..3cf92cbbd8ac 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -28,6 +28,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
 
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
+void blk_mq_sched_free_requests(struct request_queue *q);
 
 static inline bool
 blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 75b5281cc577..977c659dcd18 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -850,7 +850,7 @@ static void blk_exit_queue(struct request_queue *q)
 	 */
 	if (q->elevator) {
 		ioc_clear_queue(q);
-		elevator_exit(q, q->elevator);
+		__elevator_exit(q, q->elevator);
 		q->elevator = NULL;
 	}
 
diff --git a/block/blk.h b/block/blk.h
index 91b3581b7c7a..7814aa207153 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -6,6 +6,7 @@
 #include <linux/blk-mq.h>
 #include <xen/xen.h>
 #include "blk-mq.h"
+#include "blk-mq-sched.h"
 
 /* Max future timer expiry for timeouts */
 #define BLK_MAX_TIMEOUT		(5 * HZ)
@@ -176,10 +177,17 @@ void blk_insert_flush(struct request *rq);
 int elevator_init_mq(struct request_queue *q);
 int elevator_switch_mq(struct request_queue *q,
 			      struct elevator_type *new_e);
-void elevator_exit(struct request_queue *, struct elevator_queue *);
+void __elevator_exit(struct request_queue *, struct elevator_queue *);
 int elv_register_queue(struct request_queue *q);
 void elv_unregister_queue(struct request_queue *q);
 
+static inline void elevator_exit(struct request_queue *q,
+		struct elevator_queue *e)
+{
+	blk_mq_sched_free_requests(q);
+	__elevator_exit(q, e);
+}
+
 struct hd_struct *__disk_get_part(struct gendisk *disk, int partno);
 
 #ifdef CONFIG_FAIL_IO_TIMEOUT
diff --git a/block/elevator.c b/block/elevator.c
index ec55d5fc0b3e..2f17d66d0e61 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -178,7 +178,7 @@ static void elevator_release(struct kobject *kobj)
 	kfree(e);
 }
 
-void elevator_exit(struct request_queue *q, struct elevator_queue *e)
+void __elevator_exit(struct request_queue *q, struct elevator_queue *e)
 {
 	mutex_lock(&e->sysfs_lock);
 	if (e->type->ops.exit_sched)
-- 
2.20.1

