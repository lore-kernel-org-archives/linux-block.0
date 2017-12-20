Return-Path: <naby88@gmail.com>
Return-Path: <naby88@gmail.com>
From: Khan M Rashedun-Naby <naby88@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khan M Rashedun-Naby <naby88@gmail.com>
Subject: [PATCH] Block: blk-flush: removed an unnecessary else statement
Date: Wed, 20 Dec 2017 22:23:55 +0600
Message-Id: <1513787035-18973-1-git-send-email-naby88@gmail.com>
List-ID: <linux-block@vger.kernel.org>

As both of the if and else statement block is returning something then 
there is no need of the else statement. Thus this else statement 
has been removed.

Signed-off-by: Khan M Rashedun-Naby <naby88@gmail.com>
---
 block/blk-flush.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index f171706..b629014 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -137,13 +137,14 @@ static bool blk_flush_queue_rq(struct request *rq, bool add_front)
 	if (rq->q->mq_ops) {
 		blk_mq_add_to_requeue_list(rq, add_front, true);
 		return false;
-	} else {
-		if (add_front)
-			list_add(&rq->queuelist, &rq->q->queue_head);
-		else
-			list_add_tail(&rq->queuelist, &rq->q->queue_head);
-		return true;
 	}
+
+	if (add_front)
+		list_add(&rq->queuelist, &rq->q->queue_head);
+	else
+		list_add_tail(&rq->queuelist, &rq->q->queue_head);
+
+	return true;
 }
 
 /**
-- 
2.7.4
