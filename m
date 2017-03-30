Return-Path: <linux-block-owner@vger.kernel.org>
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:58681 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932196AbdC3FUu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2017 01:20:50 -0400
From: Minchan Kim <minchan@kernel.org>
To: Jens Axboe <axboe@fb.com>
Cc: kernel-team@lge.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Omar Sandoval <osandov@fb.com>
Subject: [PATCH] block: do not put mq context in blk_mq_alloc_request_hctx
Date: Thu, 30 Mar 2017 14:20:45 +0900
Message-Id: <1490851245-32245-1-git-send-email-minchan@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In blk_mq_alloc_request_hctx, blk_mq_sched_get_request doesn't
get sw context so we don't need to put the context with
blk_mq_put_ctx. Unless, we will see preempt counter underflow.

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Jens Axboe <axboe@fb.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---

Maybe, it would be fixed by someone but I have noticed preempt counter
undeflow problem a few weeks ago and still see the problem with
linux-next.

 block/blk-mq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a4546f060e80..a6f3998dc4ee 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -321,7 +321,6 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
 
 	rq = blk_mq_sched_get_request(q, NULL, rw, &alloc_data);
 
-	blk_mq_put_ctx(alloc_data.ctx);
 	blk_queue_exit(q);
 
 	if (!rq)
-- 
2.7.4
