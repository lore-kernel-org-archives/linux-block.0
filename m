Return-Path: <baijiaju1990@gmail.com>
Return-Path: <baijiaju1990@gmail.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] block: blk-mq-sched: Replace GFP_ATOMIC with GFP_KERNEL in blk_mq_sched_assign_ioc
Date: Thu, 25 Jan 2018 10:46:26 +0800
Message-Id: <1516848386-5720-1-git-send-email-baijiaju1990@gmail.com>
List-ID: <linux-block@vger.kernel.org>

The function ioc_create_icq here is not called in atomic context.
Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 block/blk-mq-sched.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index c117bd8..d461e31 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -42,7 +42,7 @@ void blk_mq_sched_assign_ioc(struct request *rq, struct bio *bio)
 	spin_unlock_irq(q->queue_lock);
 
 	if (!icq) {
-		icq = ioc_create_icq(ioc, q, GFP_ATOMIC);
+		icq = ioc_create_icq(ioc, q, GFP_KERNEL);
 		if (!icq)
 			return;
 	}
-- 
1.7.9.5
