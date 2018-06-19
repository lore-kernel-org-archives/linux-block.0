Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESENT] blk-mq: use blk_rq_timeout to limit the max timeout
Date: Tue, 19 Jun 2018 15:03:16 +0800
Message-Id: <1529391796-1819-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

blk_rq_timeout is needed to limit the max timeout value, otherwise,
a idle hctx cannot be deactivated timely in shared-tag case.

Fixes: 12f5b931 (blk-mq: Remove generation seqeunce)
Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 70c65bb..ccebe7b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -868,7 +868,7 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
 
 	if (next != 0) {
-		mod_timer(&q->timeout, next);
+		mod_timer(&q->timeout, blk_rq_timeout(round_jiffies_up(next)));
 	} else {
 		/*
 		 * Request timeouts are handled as a forward rolling timer. If
-- 
2.7.4
