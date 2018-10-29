Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 28/29] blk-merge: kill dead queue lock held check
Date: Mon, 29 Oct 2018 10:34:43 -0600
Message-Id: <20181029163444.9940-29-axboe@kernel.dk>
In-Reply-To: <20181029163444.9940-1-axboe@kernel.dk>
References: <20181029163444.9940-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

This is dead code, any queue reaching this part has mq_ops
attached.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-merge.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3561dcce2260..0128284bded4 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -704,9 +704,6 @@ static void blk_account_io_merge(struct request *req)
 static struct request *attempt_merge(struct request_queue *q,
 				     struct request *req, struct request *next)
 {
-	if (!q->mq_ops)
-		lockdep_assert_held(q->queue_lock);
-
 	if (!rq_mergeable(req) || !rq_mergeable(next))
 		return NULL;
 
-- 
2.17.1
