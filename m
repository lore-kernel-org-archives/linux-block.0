Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C28205E2F;
	Fri, 30 May 2025 08:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748592550; cv=none; b=iP7PG11O+oTDv8ngYAbsb3s2Rzo8WblvbGuvAtc9OlQ9fPglIqEpBplEtaRvXtw3reBDhl2imVcovM/sCiTeyoGL6Z3EF9cuepB92T8/dq0gEgkcd/+RkumrDCTvV1/yFKBd1gauo/qQkIHKh22kU81wjwpfCgU4Iv6bmTCyu+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748592550; c=relaxed/simple;
	bh=QCd4T4J0SpzU2OCx/fj7+3sZvzN/6q1CRTgmuVdWTCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O/9mUUbPY6wXiY/yiZORMzQjAZmW2rbArNTMV86fonNqeHtxKONQQ3vaHy2SPj62rOnDdv6XGQ95npOGKWccM9PErmR9Uvh5g1LJxZhZl1tnbb30V2E8SCmuYxfPKINCKL6CCJovrVSIDZqhGEAppW58vMRdmQxrsK2v22VwYHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4b7wql2SsvzYQvFM;
	Fri, 30 May 2025 16:09:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 6F5FE1A07BD;
	Fri, 30 May 2025 16:09:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP3 (Coremail) with SMTP id _Ch0CgAne8WfZzloSi3_Ng--.6274S8;
	Fri, 30 May 2025 16:09:06 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH RFC 4/4] blk-mq-sched: support request batch dispatching for sq elevator
Date: Fri, 30 May 2025 16:03:55 +0800
Message-Id: <20250530080355.1138759-5-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgAne8WfZzloSi3_Ng--.6274S8
X-Coremail-Antispam: 1UD129KBjvJXoWxJF47AFyUGF4kury3ZrWxCrg_yoW5Zw15pF
	4rXa1FkryqqFnFqFyfAw47J3W5G3yI9r9rWrW3Kr4fJFs2qrsxtF1rJa4UJF4xJrs5CFsr
	ur4DWa4DuF1IvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAV
	WUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUvYLPUUUUU
	=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Before this patch, each context will hold a global lock to dispatch one
request at a time, which introduce intense lock contention:

lock
ops.dispatch_request
unlock

Hence support dispatch a batch of requests while holding the lock to
reduce lock contention.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-sched.c | 53 ++++++++++++++++++++++++++++++++++++++++----
 block/blk-mq.h       | 21 ++++++++++++++++++
 2 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 990d0f19594a..d255c3e6c2a8 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -101,6 +101,47 @@ static bool elevator_can_dispatch(struct sched_dispatch_ctx *ctx)
 	return true;
 }
 
+static void elevator_dispatch_requests(struct sched_dispatch_ctx *ctx)
+{
+	struct request *rq;
+	int budget_token[BUDGET_TOKEN_BATCH];
+	int count;
+	int i;
+
+	while (true) {
+		if (!elevator_can_dispatch(ctx))
+			return;
+
+		count = blk_mq_get_dispatch_budgets(ctx->q, budget_token);
+		if (count <= 0)
+			return;
+
+		elevator_lock(ctx->e);
+		for (i = 0; i < count; ++i) {
+			rq = ctx->e->type->ops.dispatch_request(ctx->hctx);
+			if (!rq) {
+				ctx->run_queue = true;
+				goto err_free_budgets;
+			}
+
+			blk_mq_set_rq_budget_token(rq, budget_token[i]);
+			list_add_tail(&rq->queuelist, &ctx->rq_list);
+			ctx->count++;
+			if (rq->mq_hctx != ctx->hctx)
+				ctx->multi_hctxs = true;
+
+			if (!blk_mq_get_driver_tag(rq))
+				goto err_free_budgets;
+		}
+		elevator_unlock(ctx->e);
+	}
+
+err_free_budgets:
+	elevator_unlock(ctx->e);
+	for (; i < count; ++i)
+		blk_mq_put_dispatch_budget(ctx->q, budget_token[i]);
+}
+
 static bool elevator_dispatch_one_request(struct sched_dispatch_ctx *ctx)
 {
 	struct request *rq;
@@ -202,10 +243,14 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 	else
 		max_dispatch = hctx->queue->nr_requests;
 
-	do {
-		if (!elevator_dispatch_one_request(&ctx))
-			break;
-	} while (ctx.count < max_dispatch);
+	if (blk_queue_sq_sched(ctx.q))
+		elevator_dispatch_requests(&ctx);
+	else {
+		do {
+			if (!elevator_dispatch_one_request(&ctx))
+				break;
+		} while (ctx.count < max_dispatch);
+	}
 
 	return elevator_finish_dispatch(&ctx);
 }
diff --git a/block/blk-mq.h b/block/blk-mq.h
index affb2e14b56e..450c16a07841 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -37,6 +37,7 @@ enum {
 };
 
 #define BLK_MQ_CPU_WORK_BATCH	(8)
+#define BUDGET_TOKEN_BATCH	(8)
 
 typedef unsigned int __bitwise blk_insert_t;
 #define BLK_MQ_INSERT_AT_HEAD		((__force blk_insert_t)0x01)
@@ -262,6 +263,26 @@ static inline int blk_mq_get_dispatch_budget(struct request_queue *q)
 	return 0;
 }
 
+static inline int blk_mq_get_dispatch_budgets(struct request_queue *q,
+					      int *budget_token)
+{
+	int count = 0;
+
+	while (count < BUDGET_TOKEN_BATCH) {
+		int token = 0;
+
+		if (q->mq_ops->get_budget)
+			token = q->mq_ops->get_budget(q);
+
+		if (token < 0)
+			return count;
+
+		budget_token[count++] = token;
+	}
+
+	return count;
+}
+
 static inline void blk_mq_set_rq_budget_token(struct request *rq, int token)
 {
 	if (token < 0)
-- 
2.39.2

