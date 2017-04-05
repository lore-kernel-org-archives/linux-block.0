Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36431 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756060AbdDETC4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2017 15:02:56 -0400
Received: by mail-pg0-f42.google.com with SMTP id g2so12790232pge.3
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2017 12:02:56 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v3 7/8] blk-mq: make driver tag failure path easier to follow
Date: Wed,  5 Apr 2017 12:01:35 -0700
Message-Id: <41f30269ef99fc7825e6a4ddc41bf0b642e5de98.1491418411.git.osandov@fb.com>
In-Reply-To: <cover.1491418411.git.osandov@fb.com>
References: <cover.1491418411.git.osandov@fb.com>
In-Reply-To: <cover.1491418411.git.osandov@fb.com>
References: <cover.1491418411.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Minor cleanup that makes it easier to figure out what's going on in the
driver tag allocation failure path of blk_mq_dispatch_rq_list().

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 39e9af3498ac..de57e7727c52 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1003,17 +1003,16 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
 			 * The initial allocation attempt failed, so we need to
 			 * rerun the hardware queue when a tag is freed.
 			 */
-			if (blk_mq_dispatch_wait_add(hctx)) {
-				/*
-				 * It's possible that a tag was freed in the
-				 * window between the allocation failure and
-				 * adding the hardware queue to the wait queue.
-				 */
-				if (!blk_mq_get_driver_tag(rq, &hctx, false))
-					break;
-			} else {
+			if (!blk_mq_dispatch_wait_add(hctx))
+				break;
+
+			/*
+			 * It's possible that a tag was freed in the window
+			 * between the allocation failure and adding the
+			 * hardware queue to the wait queue.
+			 */
+			if (!blk_mq_get_driver_tag(rq, &hctx, false))
 				break;
-			}
 		}
 
 		list_del_init(&rq->queuelist);
-- 
2.12.2
