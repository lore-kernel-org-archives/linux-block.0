Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.didichuxing.com ([111.202.154.82]:17294 "EHLO
        BJEXCAS004.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752680AbdKWNj1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Nov 2017 08:39:27 -0500
Date: Thu, 23 Nov 2017 21:39:24 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH 2/5] blk-wbt: cleanup comments to one line
Message-ID: <c6f5c88ce4abbab07e5939f4e357b61f00b796ab.1511444141.git.zhangweiping@didichuxing.com>
References: <cover.1511444141.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cover.1511444141.git.zhangweiping@didichuxing.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/blk-wbt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index edb09e93..0fb65f0 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -729,9 +729,7 @@ int wbt_init(struct request_queue *q)
 	rwb->enable_state = WBT_STATE_ON_DEFAULT;
 	wbt_update_limits(rwb);
 
-	/*
-	 * Assign rwb and add the stats callback.
-	 */
+	/* Assign rwb and add the stats callback. */
 	q->rq_wb = rwb;
 	blk_stat_add_callback(q, rwb->cb);
 
-- 
2.9.4
