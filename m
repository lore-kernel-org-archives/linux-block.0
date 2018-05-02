Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45293 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751822AbeEBVdK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 May 2018 17:33:10 -0400
Received: by mail-pg0-f66.google.com with SMTP id i29-v6so11544945pgn.12
        for <linux-block@vger.kernel.org>; Wed, 02 May 2018 14:33:10 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 6/7] block: move blk_stat_add() to __blk_mq_end_request()
Date: Wed,  2 May 2018 14:32:44 -0700
Message-Id: <728efba0143eef9d37212d1b1def9ccc9b93c3af.1525296089.git.osandov@fb.com>
In-Reply-To: <cover.1525296089.git.osandov@fb.com>
References: <cover.1525296089.git.osandov@fb.com>
In-Reply-To: <cover.1525296089.git.osandov@fb.com>
References: <cover.1525296089.git.osandov@fb.com>
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
