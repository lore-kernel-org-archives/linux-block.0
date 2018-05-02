Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43684 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeEBRer (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 May 2018 13:34:47 -0400
Received: by mail-pf0-f193.google.com with SMTP id j11so12367213pff.10
        for <linux-block@vger.kernel.org>; Wed, 02 May 2018 10:34:47 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com
Subject: [PATCH 6/7] block: move blk_stat_add() to __blk_mq_end_request()
Date: Wed,  2 May 2018 10:34:25 -0700
Message-Id: <cd489c632d7294cdc41603008777c472ae183c55.1525282392.git.osandov@fb.com>
In-Reply-To: <cover.1525282392.git.osandov@fb.com>
References: <cover.1525282392.git.osandov@fb.com>
In-Reply-To: <cover.1525282392.git.osandov@fb.com>
References: <cover.1525282392.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

We want this next to blk_account_io_done() for the next change so that
we can call ktime_get() only once for both.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9fa8069af032..65141edda189 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -490,6 +490,11 @@ EXPORT_SYMBOL_GPL(blk_mq_free_request);
 
 inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 {
+	if (rq->rq_flags & RQF_STATS) {
+		blk_mq_poll_stats_start(rq->q);
+		blk_stat_add(rq);
+	}
+
 	blk_account_io_done(rq);
 
 	if (rq->end_io) {
@@ -529,10 +534,6 @@ static void __blk_mq_complete_request(struct request *rq)
 
 	if (rq->internal_tag != -1)
 		blk_mq_sched_completed_request(rq);
-	if (rq->rq_flags & RQF_STATS) {
-		blk_mq_poll_stats_start(rq->q);
-		blk_stat_add(rq);
-	}
 
 	if (!test_bit(QUEUE_FLAG_SAME_COMP, &rq->q->queue_flags)) {
 		rq->q->softirq_done_fn(rq);
-- 
2.17.0
