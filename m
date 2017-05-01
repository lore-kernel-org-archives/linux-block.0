Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750757AbdEAX2U (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 May 2017 19:28:20 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>
Subject: [PATCH] block: don't call blk_mq_quiesce_queue() after queue is freezed
Date: Tue,  2 May 2017 07:28:02 +0800
Message-Id: <20170501232802.27219-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

After queue is freezed, no request in this queue can be in use
at all, so there can't be any .queue_rq() is running on this queue.
It isn't necessary to call blk_mq_quiesce_queue() any more, so
remove it in both elevator_switch_mq() and blk_mq_update_nr_requests().

Cc: Bart Van Assche <bart.vanassche@sandisk.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c   | 2 --
 block/elevator.c | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index bf90684a007a..8f72f16b498a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2617,7 +2617,6 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 		return -EINVAL;
 
 	blk_mq_freeze_queue(q);
-	blk_mq_quiesce_queue(q);
 
 	ret = 0;
 	queue_for_each_hw_ctx(q, hctx, i) {
@@ -2643,7 +2642,6 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 		q->nr_requests = nr;
 
 	blk_mq_unfreeze_queue(q);
-	blk_mq_start_stopped_hw_queues(q, true);
 
 	return ret;
 }
diff --git a/block/elevator.c b/block/elevator.c
index bf11e70f008b..c7a4ee682033 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -950,7 +950,6 @@ static int elevator_switch_mq(struct request_queue *q,
 	int ret;
 
 	blk_mq_freeze_queue(q);
-	blk_mq_quiesce_queue(q);
 
 	if (q->elevator) {
 		if (q->elevator->registered)
@@ -978,9 +977,7 @@ static int elevator_switch_mq(struct request_queue *q,
 
 out:
 	blk_mq_unfreeze_queue(q);
-	blk_mq_start_stopped_hw_queues(q, true);
 	return ret;
-
 }
 
 /*
-- 
2.9.3
