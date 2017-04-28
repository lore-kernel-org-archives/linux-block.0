Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164803AbdD1HdA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 03:33:00 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>
Subject: [PATCH ] block: don't call blk_mq_quiesce_queue() during switching mq sched
Date: Fri, 28 Apr 2017 15:32:50 +0800
Message-Id: <20170428073250.9579-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We have freezed queue already, not necessary to call
blk_mq_quiesce_queue() any more, so remove it.

Cc: Bart Van Assche <bart.vanassche@sandisk.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 3 ---
 1 file changed, 3 deletions(-)

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
