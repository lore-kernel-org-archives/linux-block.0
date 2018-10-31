Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/30] blk-mq: remove legacy check in queue blk_freeze_queue()
Date: Wed, 31 Oct 2018 11:58:58 -0600
Message-Id: <20181031175922.8849-7-axboe@kernel.dk>
In-Reply-To: <20181031175922.8849-1-axboe@kernel.dk>
References: <20181031175922.8849-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c82dc44d4d8..a58d2d953876 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -177,8 +177,6 @@ void blk_freeze_queue(struct request_queue *q)
 	 * exported to drivers as the only user for unfreeze is blk_mq.
 	 */
 	blk_freeze_queue_start(q);
-	if (!q->mq_ops)
-		blk_drain_queue(q);
 	blk_mq_freeze_queue_wait(q);
 }
 
-- 
2.17.1
