Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46082 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeIZSss (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Sep 2018 14:48:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id z3-v6so15010377wrr.13
        for <linux-block@vger.kernel.org>; Wed, 26 Sep 2018 05:35:59 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>
Subject: [PATCH] blk-mq: I/O and timer unplugs are inverted in blktrace
Date: Wed, 26 Sep 2018 14:35:50 +0200
Message-Id: <20180926123550.16311-1-idryomov@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

trace_block_unplug() takes true for explicit unplugs and false for
implicit unplugs.  schedule() unplugs are implicit and should be
reported as timer unplugs.  While correct in the legacy code, this has
been inverted in blk-mq since 4.11.

Cc: stable@vger.kernel.org
Fixes: bd166ef183c2 ("blk-mq-sched: add framework for MQ capable IO schedulers")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 block/blk-mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 85a1c1a59c72..e3c39ea8e17b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1628,7 +1628,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 		BUG_ON(!rq->q);
 		if (rq->mq_ctx != this_ctx) {
 			if (this_ctx) {
-				trace_block_unplug(this_q, depth, from_schedule);
+				trace_block_unplug(this_q, depth, !from_schedule);
 				blk_mq_sched_insert_requests(this_q, this_ctx,
 								&ctx_list,
 								from_schedule);
@@ -1648,7 +1648,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	 * on 'ctx_list'. Do those.
 	 */
 	if (this_ctx) {
-		trace_block_unplug(this_q, depth, from_schedule);
+		trace_block_unplug(this_q, depth, !from_schedule);
 		blk_mq_sched_insert_requests(this_q, this_ctx, &ctx_list,
 						from_schedule);
 	}
-- 
2.14.4
