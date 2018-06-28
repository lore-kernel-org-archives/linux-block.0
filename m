Return-Path: <axboe@kernel.dk>
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id w7-v6sm3891337ita.34.2018.06.28.08.46.51
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 08:46:52 -0700 (PDT)
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] blk-mq: don't queue more if we get a busy return
Message-ID: <2167f1fb-68b0-c302-88d9-964be5fe3bb3@kernel.dk>
Date: Thu, 28 Jun 2018 09:46:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Some devices have different queue limits depending on the type of IO. A
classic case is SATA NCQ, where some commands can queue, but others
cannot. If we have NCQ commands inflight and encounter a non-queueable
command, the driver returns busy. Currently we attempt to dispatch more
from the scheduler, if we were able to queue some commands. But for the
case where we ended up stopping due to BUSY, we should not attempt to
retrieve more from the scheduler. If we do, we can get into a situation
where we attempt to queue a non-queueable command, get BUSY, then
successfully retrieve more commands from that scheduler and queue those.
This can repeat forever, starving the non-queuable command indefinitely.

Fix this by NOT attempting to pull more commands from the scheduler, if
we get a BUSY return. This should also be more optimal in terms of
letting requests stay in the scheduler for as long as possible, if we
get a BUSY due to the regular out-of-tags condition.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b6888ff556cf..d394cdd8d8c6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1075,6 +1075,9 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
 
 #define BLK_MQ_RESOURCE_DELAY	3		/* ms units */
 
+/*
+ * Returns true if we did some work AND can potentially do more.
+ */
 bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 			     bool got_budget)
 {
@@ -1205,8 +1208,17 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 			blk_mq_run_hw_queue(hctx, true);
 		else if (needs_restart && (ret == BLK_STS_RESOURCE))
 			blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
+
+		return false;
 	}
 
+	/*
+	 * If the host/device is unable to accept more work, inform the
+	 * caller of that.
+	 */
+	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
+		return false;
+
 	return (queued + errors) != 0;
 }
 
-- 
Jens Axboe
 
