Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	broonie@kernel.org,
	linus.walleij@linaro.org,
	bfq-iosched@googlegroups.com,
	oleksandr@natalenko.name,
	filippo.muzzini@outlook.it,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 1/3] block, bfq: remove wrong lock in bfq_requests_merged
Date: Thu, 31 May 2018 15:23:11 +0200
Message-Id: <20180531132313.2986-2-paolo.valente@linaro.org>
In-Reply-To: <20180531132313.2986-1-paolo.valente@linaro.org>
References: <20180531132313.2986-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

From: Filippo Muzzini <filippo.muzzini@outlook.it>

In bfq_requests_merged(), there is a deadlock because the lock on
bfqq->bfqd->lock is held by the calling function, but the code of
this function tries to grab the lock again.

This deadlock is currently hidden by another bug (fixed by next commit
for this source file), which causes the body of bfq_requests_merged()
to be never executed.

This commit removes the deadlock by removing the lock/unlock pair.

Signed-off-by: Filippo Muzzini <filippo.muzzini@outlook.it>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 771ae9730ac6..1f0951d36424 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1898,7 +1898,6 @@ static void bfq_requests_merged(struct request_queue *q, struct request *rq,
 
 	if (!RB_EMPTY_NODE(&rq->rb_node))
 		goto end;
-	spin_lock_irq(&bfqq->bfqd->lock);
 
 	/*
 	 * If next and rq belong to the same bfq_queue and next is older
@@ -1923,7 +1922,6 @@ static void bfq_requests_merged(struct request_queue *q, struct request *rq,
 	bfq_remove_request(q, next);
 	bfqg_stats_update_io_remove(bfqq_group(bfqq), next->cmd_flags);
 
-	spin_unlock_irq(&bfqq->bfqd->lock);
 end:
 	bfqg_stats_update_io_merged(bfqq_group(bfqq), next->cmd_flags);
 }
-- 
2.16.1
