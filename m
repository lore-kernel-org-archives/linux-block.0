Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.didichuxing.com ([111.202.154.82]:29476 "EHLO
        BJEXCAS002.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752184AbeASXed (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jan 2018 18:34:33 -0500
Date: Sat, 20 Jan 2018 07:34:25 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH v2] blk-throttle: use queue_is_rq_based
Message-ID: <20180119233421.GA3961@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

use queue_is_rq_based instead of open code.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/blk-throttle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index e136f5e..c475f0f 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2489,7 +2489,7 @@ void blk_throtl_register_queue(struct request_queue *q)
 	td->throtl_slice = DFL_THROTL_SLICE_HD;
 #endif
 
-	td->track_bio_latency = !q->mq_ops && !q->request_fn;
+	td->track_bio_latency = !queue_is_rq_based(q);
 	if (!td->track_bio_latency)
 		blk_stat_enable_accounting(q);
 }
-- 
2.9.4
