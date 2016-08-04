Return-Path: <BATV+b244dc37f40e53d0e5a9+4729+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: ming.lei@canonical.com,
	mchristi@redhat.com,
	david@fromorbit.com,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] loop: don't try to use AIO for discards
Date: Thu,  4 Aug 2016 16:10:00 +0200
Message-Id: <1470319801-20594-2-git-send-email-hch@lst.de>
In-Reply-To: <1470319801-20594-1-git-send-email-hch@lst.de>
References: <1470319801-20594-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Fix a fat-fingered conversion to the req_op accessors, and also
use a switch statement to make it more obvious what is being checked.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Dave Chinner <david@fromorbit.com>
Fixes: c2df40 ("drivers: use req op accessor");
---
 drivers/block/loop.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 075377e..91c2c88 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1659,11 +1659,15 @@ static int loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (lo->lo_state != Lo_bound)
 		return -EIO;
 
-	if (lo->use_dio && (req_op(cmd->rq) != REQ_OP_FLUSH ||
-	    req_op(cmd->rq) == REQ_OP_DISCARD))
-		cmd->use_aio = true;
-	else
+	switch (req_op(cmd->rq)) {
+	case REQ_OP_FLUSH:
+	case REQ_OP_DISCARD:
 		cmd->use_aio = false;
+		break;
+	default:
+		cmd->use_aio = lo->use_dio;
+		break;
+	}
 
 	queue_kthread_work(&lo->worker, &cmd->work);
 
-- 
2.1.4
