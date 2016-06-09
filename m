Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33930 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932336AbcFIBW3 (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Wed, 8 Jun 2016 21:22:29 -0400
Received: by mail-pf0-f179.google.com with SMTP id 62so7859784pfd.1
        for <linux-block@vger.kernel.org>; Wed, 08 Jun 2016 18:22:29 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] blk-mq: actually hook up defer list when running requests
Date: Wed,  8 Jun 2016 18:22:20 -0700
Message-Id: <9680c9b9108376337b3c4ee1f5c282eaac8440fd.1465435173.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

If ->queue_rq() returns BLK_MQ_RQ_QUEUE_OK, we use continue and skip
over the rest of the loop body. However, dptr is assigned later in the
loop body, and the BLK_MQ_RQ_QUEUE_OK case is exactly the case that we'd
want it for.

NVMe isn't actually using BLK_MQ_F_DEFER_ISSUE yet, nor is any other
in-tree driver, but if the code's going to be there, it might as well
work.

Fixes: 74c450521dd8 ("blk-mq: add a 'list' parameter to ->queue_rq()")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Let me know if I'm crazy and just misunderstood how this is supposed to
work :) Like I mentioned in the commit description, this doesn't
actually matter since there aren't any drivers using it, but last I saw,
Jens still wanted to get it through eventually
(http://thread.gmane.org/gmane.linux.kernel/1934318).

 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 29cbc1b5fbdb..6eb9a8068f11 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -784,7 +784,7 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 		switch (ret) {
 		case BLK_MQ_RQ_QUEUE_OK:
 			queued++;
-			continue;
+			break;
 		case BLK_MQ_RQ_QUEUE_BUSY:
 			list_add(&rq->queuelist, &rq_list);
 			__blk_mq_requeue_request(rq);
-- 
2.8.3

