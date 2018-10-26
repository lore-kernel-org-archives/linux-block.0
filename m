Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/3] blk-mq: ensure hctx to be ran on mapped cpu when issue directly
Date: Sat, 27 Oct 2018 00:01:11 +0800
Message-Id: <1540569671-6589-4-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1540569671-6589-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1540569671-6589-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

When issue request directly and the task is migrated out of the
original cpu where it allocates request, hctx could be ran on
the cpu where it is not mapped. To fix this, insert the request
if BLK_MQ_F_BLOCKING is set, check whether the current is mapped
to the hctx and invoke __blk_mq_issue_directly under preemption
disabled.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 71b829c..4f1dedb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1745,6 +1745,14 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	if (q->elevator)
 		goto out;
 
+	if (hctx->flags & BLK_MQ_F_BLOCKING)
+		goto out;
+
+	if (!cpumask_test_cpu(get_cpu(), hctx->cpumask)) {
+		put_cpu();
+		goto out;
+	}
+
 	hctx_lock(hctx, &srcu_idx);
 	/*
 	 * hctx_lock is needed before checking quiesced flag.
@@ -1779,6 +1787,7 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 out_unlock:
 	hctx_unlock(hctx, srcu_idx);
+	put_cpu();
 out:
 	if (insert)
 		blk_mq_sched_insert_request(rq, false, true, false);
-- 
2.7.4
