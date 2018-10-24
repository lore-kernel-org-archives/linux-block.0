Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: ensure hctx to be ran on mapped cpu when issue directly
Date: Wed, 24 Oct 2018 23:20:07 +0800
Message-Id: <1540394407-20769-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

When issue request directly and the task is migrated out of the
original cpu where it allocates request, hctx could be ran on
the cpu where it is not mapped. To fix this, insert the request
if BLK_MQ_F_BLOCKING is set, check whether the current is mapped
to the hctx and invoke __blk_mq_issue_directly under preemption
disabled.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e3c39ea..0cdc306 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1717,6 +1717,12 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 {
 	struct request_queue *q = rq->q;
 	bool run_queue = true;
+	blk_status_t ret;
+
+	if (hctx->flags & BLK_MQ_F_BLOCKING) {
+		bypass_insert = false;
+		goto insert;
+	}
 
 	/*
 	 * RCU or SRCU read lock is needed before checking quiesced flag.
@@ -1734,6 +1740,11 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	if (q->elevator && !bypass_insert)
 		goto insert;
 
+	if (!cpumask_test_cpu(get_cpu(), hctx->cpumask)) {
+		bypass_insert = false;
+		goto insert;
+	}
+
 	if (!blk_mq_get_dispatch_budget(hctx))
 		goto insert;
 
@@ -1742,8 +1753,12 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		goto insert;
 	}
 
-	return __blk_mq_issue_directly(hctx, rq, cookie);
+	ret = __blk_mq_issue_directly(hctx, rq, cookie);
+	put_cpu();
+	return ret;
+
 insert:
+	put_cpu();
 	if (bypass_insert)
 		return BLK_STS_RESOURCE;
 
-- 
2.7.4
