Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193231E1C1A;
	Fri, 30 May 2025 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748592550; cv=none; b=ij+lldFfg+8Fd7ua3+1aofELK0WMWT1qVvF4npWoGtC1m3VLD9FX+DPT8sHCANCzlrEgR1DTFa8p1hcEVqQRA+nOZRc47d/PV7vQfWPHFxYMO1tjkmSfDOzlIqm3eFfk6MS5MzI5is86j/KiuK9HACngJbPSE0X/3+rgYhjNq8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748592550; c=relaxed/simple;
	bh=EyPn0v8wmitLWs9aCg2B546g5NqdZvn6zhrSgVC0Fkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AO1zMkd0mwtk0lT2ezwAfgGB7X4b/kchCWzAbl5DTQyr18RlyWSsC9cdDAxb31VMHvZYBmKxZmG6mhTzbH45WeJ15PBC1aCTUmdK0MH5Sgbjvzu9/WMY3jaE0EsMUoAlzFE5gC3y5jlat3Z+55DOLiTcLXosmz9Kkg64aN1hxOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4b7wql4nfrzKHMvG;
	Fri, 30 May 2025 16:09:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 153461A09DF;
	Fri, 30 May 2025 16:09:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP3 (Coremail) with SMTP id _Ch0CgAne8WfZzloSi3_Ng--.6274S7;
	Fri, 30 May 2025 16:09:05 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH RFC 3/4] blk-mq-sched: refactor __blk_mq_do_dispatch_sched()
Date: Fri, 30 May 2025 16:03:54 +0800
Message-Id: <20250530080355.1138759-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250530080355.1138759-1-yukuai1@huaweicloud.com>
References: <20250530080355.1138759-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAne8WfZzloSi3_Ng--.6274S7
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr45uw17CF1xtrW5try8uFg_yoWxZr13pF
	4fGa13J395XF4jqFyI9w43Jw1Sy3yxWasrWryrKr4fJws8Zrs5Jrn5JFyUAFs7JrZ5uFW2
	9r4DWr95AFs2qFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU9J5rUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Introduce struct sched_dispatch_ctx(), and split it into
elevator_dispatch_one_request() and elevator_finish_dispatch(). Make
code cleaner and prepare to support request batch dispatching.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-sched.c | 181 ++++++++++++++++++++++++++-----------------
 1 file changed, 109 insertions(+), 72 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index c1390d3e6381..990d0f19594a 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -74,85 +74,88 @@ static bool blk_mq_dispatch_hctx_list(struct list_head *rq_list)
 
 #define BLK_MQ_BUDGET_DELAY	3		/* ms units */
 
-/*
- * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
- * its queue by itself in its completion handler, so we don't need to
- * restart queue if .get_budget() fails to get the budget.
- *
- * Returns -EAGAIN if hctx->dispatch was found non-empty and run_work has to
- * be run again.  This is necessary to avoid starving flushes.
- */
-static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
-{
-	struct request_queue *q = hctx->queue;
-	struct elevator_queue *e = q->elevator;
-	bool multi_hctxs = false, run_queue = false;
-	bool dispatched = false, busy = false;
-	unsigned int max_dispatch;
-	LIST_HEAD(rq_list);
-	int count = 0;
+struct sched_dispatch_ctx {
+	struct blk_mq_hw_ctx *hctx;
+	struct elevator_queue *e;
+	struct request_queue *q;
 
-	if (hctx->dispatch_busy)
-		max_dispatch = 1;
-	else
-		max_dispatch = hctx->queue->nr_requests;
+	struct list_head rq_list;
+	int count;
 
-	do {
-		struct request *rq;
-		int budget_token;
+	bool multi_hctxs;
+	bool run_queue;
+	bool busy;
+};
 
-		if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
-			break;
+static bool elevator_can_dispatch(struct sched_dispatch_ctx *ctx)
+{
+	if (ctx->e->type->ops.has_work &&
+	    !ctx->e->type->ops.has_work(ctx->hctx))
+		return false;
 
-		if (!list_empty_careful(&hctx->dispatch)) {
-			busy = true;
-			break;
-		}
+	if (!list_empty_careful(&ctx->hctx->dispatch)) {
+		ctx->busy = true;
+		return false;
+	}
 
-		budget_token = blk_mq_get_dispatch_budget(q);
-		if (budget_token < 0)
-			break;
+	return true;
+}
 
-		rq = elevator_dispatch_request(hctx);
-		if (!rq) {
-			blk_mq_put_dispatch_budget(q, budget_token);
-			/*
-			 * We're releasing without dispatching. Holding the
-			 * budget could have blocked any "hctx"s with the
-			 * same queue and if we didn't dispatch then there's
-			 * no guarantee anyone will kick the queue.  Kick it
-			 * ourselves.
-			 */
-			run_queue = true;
-			break;
-		}
+static bool elevator_dispatch_one_request(struct sched_dispatch_ctx *ctx)
+{
+	struct request *rq;
+	int budget_token;
 
-		blk_mq_set_rq_budget_token(rq, budget_token);
+	if (!elevator_can_dispatch(ctx))
+		return false;
 
-		/*
-		 * Now this rq owns the budget which has to be released
-		 * if this rq won't be queued to driver via .queue_rq()
-		 * in blk_mq_dispatch_rq_list().
-		 */
-		list_add_tail(&rq->queuelist, &rq_list);
-		count++;
-		if (rq->mq_hctx != hctx)
-			multi_hctxs = true;
+	budget_token = blk_mq_get_dispatch_budget(ctx->q);
+	if (budget_token < 0)
+		return false;
 
+	rq = elevator_dispatch_request(ctx->hctx);
+	if (!rq) {
+		blk_mq_put_dispatch_budget(ctx->q, budget_token);
 		/*
-		 * If we cannot get tag for the request, stop dequeueing
-		 * requests from the IO scheduler. We are unlikely to be able
-		 * to submit them anyway and it creates false impression for
-		 * scheduling heuristics that the device can take more IO.
+		 * We're releasing without dispatching. Holding the
+		 * budget could have blocked any "hctx"s with the
+		 * same queue and if we didn't dispatch then there's
+		 * no guarantee anyone will kick the queue.  Kick it
+		 * ourselves.
 		 */
-		if (!blk_mq_get_driver_tag(rq))
-			break;
-	} while (count < max_dispatch);
+		ctx->run_queue = true;
+		return false;
+	}
 
-	if (!count) {
-		if (run_queue)
-			blk_mq_delay_run_hw_queues(q, BLK_MQ_BUDGET_DELAY);
-	} else if (multi_hctxs) {
+	blk_mq_set_rq_budget_token(rq, budget_token);
+
+	/*
+	 * Now this rq owns the budget which has to be released
+	 * if this rq won't be queued to driver via .queue_rq()
+	 * in blk_mq_dispatch_rq_list().
+	 */
+	list_add_tail(&rq->queuelist, &ctx->rq_list);
+	ctx->count++;
+	if (rq->mq_hctx != ctx->hctx)
+		ctx->multi_hctxs = true;
+
+	/*
+	 * If we cannot get tag for the request, stop dequeueing
+	 * requests from the IO scheduler. We are unlikely to be able
+	 * to submit them anyway and it creates false impression for
+	 * scheduling heuristics that the device can take more IO.
+	 */
+	return blk_mq_get_driver_tag(rq);
+}
+
+static int elevator_finish_dispatch(struct sched_dispatch_ctx *ctx)
+{
+	bool dispatched = false;
+
+	if (!ctx->count) {
+		if (ctx->run_queue)
+			blk_mq_delay_run_hw_queues(ctx->q, BLK_MQ_BUDGET_DELAY);
+	} else if (ctx->multi_hctxs) {
 		/*
 		 * Requests from different hctx may be dequeued from some
 		 * schedulers, such as bfq and deadline.
@@ -160,19 +163,53 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		 * Sort the requests in the list according to their hctx,
 		 * dispatch batching requests from same hctx at a time.
 		 */
-		list_sort(NULL, &rq_list, sched_rq_cmp);
+		list_sort(NULL, &ctx->rq_list, sched_rq_cmp);
 		do {
-			dispatched |= blk_mq_dispatch_hctx_list(&rq_list);
-		} while (!list_empty(&rq_list));
+			dispatched |= blk_mq_dispatch_hctx_list(&ctx->rq_list);
+		} while (!list_empty(&ctx->rq_list));
 	} else {
-		dispatched = blk_mq_dispatch_rq_list(hctx, &rq_list, false);
+		dispatched = blk_mq_dispatch_rq_list(ctx->hctx, &ctx->rq_list,
+						     false);
 	}
 
-	if (busy)
+	if (ctx->busy)
 		return -EAGAIN;
+
 	return !!dispatched;
 }
 
+/*
+ * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
+ * its queue by itself in its completion handler, so we don't need to
+ * restart queue if .get_budget() fails to get the budget.
+ *
+ * Returns -EAGAIN if hctx->dispatch was found non-empty and run_work has to
+ * be run again.  This is necessary to avoid starving flushes.
+ */
+static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
+{
+	unsigned int max_dispatch;
+	struct sched_dispatch_ctx ctx = {
+		.hctx	= hctx,
+		.q	= hctx->queue,
+		.e	= hctx->queue->elevator,
+	};
+
+	INIT_LIST_HEAD(&ctx.rq_list);
+
+	if (hctx->dispatch_busy)
+		max_dispatch = 1;
+	else
+		max_dispatch = hctx->queue->nr_requests;
+
+	do {
+		if (!elevator_dispatch_one_request(&ctx))
+			break;
+	} while (ctx.count < max_dispatch);
+
+	return elevator_finish_dispatch(&ctx);
+}
+
 static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 {
 	unsigned long end = jiffies + HZ;
-- 
2.39.2

