Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 4/6] blk-mq: ensure hctx to be ran on mapped cpu when issue directly
Date: Mon, 12 Nov 2018 17:23:27 +0800
Message-Id: <1542014609-1769-5-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1542014609-1769-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1542014609-1769-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

When issue request directly and the task is migrated out of the
original cpu where it allocates request, hctx could be ran on
the cpu where it is not mapped.
To fix this,
 - insert the request forcibly if BLK_MQ_F_BLOCKING is set.
 - check whether the current is mapped to the hctx, if not, insert
   forcibly.
 - invoke __blk_mq_issue_directly under preemption disabled.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f54c092..7915f44 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1808,6 +1808,17 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	enum mq_issue_decision dec;
 	int srcu_idx;
 
+	if (hctx->flags & BLK_MQ_F_BLOCKING) {
+		force = true;
+		goto out;
+	}
+
+	if (!cpumask_test_cpu(get_cpu(), hctx->cpumask)) {
+		put_cpu();
+		force = true;
+		goto out;
+	}
+
 	hctx_lock(hctx, &srcu_idx);
 	/*
 	 * hctx_lock is needed before checking quiesced flag.
@@ -1840,7 +1851,8 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 out_unlock:
 	hctx_unlock(hctx, srcu_idx);
-
+	put_cpu();
+out:
 	dec = blk_mq_make_dicision(ret, bypass, force);
 	switch(dec) {
 	case MQ_ISSUE_INSERT_QUEUE:
-- 
2.7.4
