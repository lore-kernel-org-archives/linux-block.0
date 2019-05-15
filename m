Return-Path: <SRS0=Ir13=TP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F8AC04AB4
	for <linux-block@archiver.kernel.org>; Wed, 15 May 2019 03:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74E92084A
	for <linux-block@archiver.kernel.org>; Wed, 15 May 2019 03:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfEODD2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 May 2019 23:03:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbfEODD2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 May 2019 23:03:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8EB70307D92F;
        Wed, 15 May 2019 03:03:27 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60E8460F82;
        Wed, 15 May 2019 03:03:23 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/3] block: move blk_exit_queue into __blk_release_queue
Date:   Wed, 15 May 2019 11:03:08 +0800
Message-Id: <20190515030310.20393-2-ming.lei@redhat.com>
In-Reply-To: <20190515030310.20393-1-ming.lei@redhat.com>
References: <20190515030310.20393-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 15 May 2019 03:03:27 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 498f6650aec8 ("block: Fix a race between the cgroup code and
request queue initialization") moves what blk_exit_queue does into
blk_cleanup_queue() for fixing issue caused by changing back
queue lock.

However, after legacy request IO path is killed, driver queue lock
won't be used at all, and there isn't story for changing back
queue lock. Then the issue addressed by Commit 498f6650aec8 doesn't
exist any more.

So move move blk_exit_queue into __blk_release_queue.

This patch basically reverts the following two commits:

	498f6650aec8 block: Fix a race between the cgroup code and request queue initialization
	24ecc3585348 block: Ensure that a request queue is dissociated from the cgroup controller

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c  | 37 -------------------------------------
 block/blk-sysfs.c | 47 ++++++++++++++++++++++++++++++++---------------
 block/blk.h       |  1 -
 3 files changed, 32 insertions(+), 53 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 419d600e6637..2af1e54870e6 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -282,35 +282,6 @@ void blk_set_queue_dying(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_set_queue_dying);
 
-/* Unconfigure the I/O scheduler and dissociate from the cgroup controller. */
-void blk_exit_queue(struct request_queue *q)
-{
-	/*
-	 * Since the I/O scheduler exit code may access cgroup information,
-	 * perform I/O scheduler exit before disassociating from the block
-	 * cgroup controller.
-	 */
-	if (q->elevator) {
-		ioc_clear_queue(q);
-		elevator_exit(q, q->elevator);
-		q->elevator = NULL;
-	}
-
-	/*
-	 * Remove all references to @q from the block cgroup controller before
-	 * restoring @q->queue_lock to avoid that restoring this pointer causes
-	 * e.g. blkcg_print_blkgs() to crash.
-	 */
-	blkcg_exit_queue(q);
-
-	/*
-	 * Since the cgroup code may dereference the @q->backing_dev_info
-	 * pointer, only decrease its reference count after having removed the
-	 * association with the block cgroup controller.
-	 */
-	bdi_put(q->backing_dev_info);
-}
-
 /**
  * blk_cleanup_queue - shutdown a request queue
  * @q: request queue to shutdown
@@ -346,14 +317,6 @@ void blk_cleanup_queue(struct request_queue *q)
 	del_timer_sync(&q->backing_dev_info->laptop_mode_wb_timer);
 	blk_sync_queue(q);
 
-	/*
-	 * I/O scheduler exit is only safe after the sysfs scheduler attribute
-	 * has been removed.
-	 */
-	WARN_ON_ONCE(q->kobj.state_in_sysfs);
-
-	blk_exit_queue(q);
-
 	if (queue_is_mq(q))
 		blk_mq_exit_queue(q);
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index a16a02c52a85..75b5281cc577 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -840,6 +840,36 @@ static void blk_free_queue_rcu(struct rcu_head *rcu_head)
 	kmem_cache_free(blk_requestq_cachep, q);
 }
 
+/* Unconfigure the I/O scheduler and dissociate from the cgroup controller. */
+static void blk_exit_queue(struct request_queue *q)
+{
+	/*
+	 * Since the I/O scheduler exit code may access cgroup information,
+	 * perform I/O scheduler exit before disassociating from the block
+	 * cgroup controller.
+	 */
+	if (q->elevator) {
+		ioc_clear_queue(q);
+		elevator_exit(q, q->elevator);
+		q->elevator = NULL;
+	}
+
+	/*
+	 * Remove all references to @q from the block cgroup controller before
+	 * restoring @q->queue_lock to avoid that restoring this pointer causes
+	 * e.g. blkcg_print_blkgs() to crash.
+	 */
+	blkcg_exit_queue(q);
+
+	/*
+	 * Since the cgroup code may dereference the @q->backing_dev_info
+	 * pointer, only decrease its reference count after having removed the
+	 * association with the block cgroup controller.
+	 */
+	bdi_put(q->backing_dev_info);
+}
+
+
 /**
  * __blk_release_queue - release a request queue
  * @work: pointer to the release_work member of the request queue to be released
@@ -860,23 +890,10 @@ static void __blk_release_queue(struct work_struct *work)
 		blk_stat_remove_callback(q, q->poll_cb);
 	blk_stat_free_callback(q->poll_cb);
 
-	if (!blk_queue_dead(q)) {
-		/*
-		 * Last reference was dropped without having called
-		 * blk_cleanup_queue().
-		 */
-		WARN_ONCE(blk_queue_init_done(q),
-			  "request queue %p has been registered but blk_cleanup_queue() has not been called for that queue\n",
-			  q);
-		blk_exit_queue(q);
-	}
-
-	WARN(blk_queue_root_blkg(q),
-	     "request queue %p is being released but it has not yet been removed from the blkcg controller\n",
-	     q);
-
 	blk_free_queue_stats(q->stats);
 
+	blk_exit_queue(q);
+
 	blk_queue_free_zone_bitmaps(q);
 
 	if (queue_is_mq(q))
diff --git a/block/blk.h b/block/blk.h
index e27fd1512e4b..91b3581b7c7a 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -50,7 +50,6 @@ struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
 		int node, int cmd_size, gfp_t flags);
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
-void blk_exit_queue(struct request_queue *q);
 void blk_rq_bio_prep(struct request_queue *q, struct request *rq,
 			struct bio *bio);
 void blk_freeze_queue(struct request_queue *q);
-- 
2.20.1

