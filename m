Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7ED10E0;
	Fri, 15 Aug 2025 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755244393; cv=none; b=hJtnrSYj9PjSX1WteElfDIwr9zsHLTfhkf8Nq1OnVbWffP1PJsJ43X6YJVaeDVpaPYKFGadG0yoJ0T+kW8rj9yGV4KKe8baospsq5qWVglPLedELN3kHDrbtwOMNeHRC6mR84loWx02NQvSYoRzQtgv89gVUFxVWlLf7tmMN90g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755244393; c=relaxed/simple;
	bh=E/nbNwfWlTTVzsAK1l2kL2cE73vo/5eDQGqNnWJ1A7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZXdZkhRQ35l5xGt6SzCBPkbbBsXDD+BdrYRh6KTTNnhMqPOJBWR+AyXHujSeuQ6+/yrKw9CVSeMGh6lxPkuBfMaKpUbmSb+vyeGjlNtRYQ8rkRCXvutTGEV7Eyhr7klxcsXG5wDpfW/BelBBYGXu9cFaB3ype95JZX9u1mtoJXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c3Dqn0l9DzYQv7h;
	Fri, 15 Aug 2025 15:53:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A9A191A0359;
	Fri, 15 Aug 2025 15:53:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDnrxBh555oQLj9Dg--.33563S4;
	Fri, 15 Aug 2025 15:53:07 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: nilay@linux.ibm.com,
	ming.lei@redhat.com,
	axboe@kernel.dk,
	bvanassche@acm.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH] blk-mq: fix elevator depth_updated method
Date: Fri, 15 Aug 2025 15:45:17 +0800
Message-Id: <20250815074517.367896-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnrxBh555oQLj9Dg--.33563S4
X-Coremail-Antispam: 1UD129KBjvJXoW3AF4xWFyfGF4fZFyUKr17KFg_yoWfJr4UpF
	W5tanrKryrtF4UuFWjy39xXw43K39agry2yFs3t34rKrZFgFs3XF1rGFyxXFWIqrZ5CFsr
	Zr4kta4DXr1Iq3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Current depth_updated has some problems:

1) depth_updated() will be called for each hctx, while all elevators
will update async_depth for the disk level, this is not related to hctx;
2) In blk_mq_update_nr_requests(), if previous hctx update succeed and
this hctx update failed, q->nr_requests will not be updated, while
async_depth is already updated with new nr_reqeuests in previous
depth_updated();
3) All elevators are using q->nr_requests to calculate async_depth now,
however, q->nr_requests is still the old value when depth_updated() is
called from blk_mq_update_nr_requests();

Fix those problems by:

- pass in request_queue instead of hctx;
- move depth_updated() after q->nr_requests is updated in
  blk_mq_update_nr_requests();
- add depth_updated() call in blk_mq_init_sched();
- remove init_hctx() method for mq-deadline and bfq that is useless now;

Fixes: 77f1e0a52d26 ("bfq: update internal depth state when queue depth changes")
Fixes: 39823b47bbd4 ("block/mq-deadline: Fix the tag reservation code")
Fixes: 42e6c6ce03fd ("lib/sbitmap: convert shallow_depth from one word to the whole sbitmap")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c   | 21 ++++-----------------
 block/blk-mq-sched.c  |  3 +++
 block/blk-mq-sched.h  | 11 +++++++++++
 block/blk-mq.c        | 23 ++++++++++++-----------
 block/elevator.h      |  2 +-
 block/kyber-iosched.c | 10 ++++------
 block/mq-deadline.c   | 15 ++-------------
 7 files changed, 37 insertions(+), 48 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 50e51047e1fe..c0c398998aa1 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7109,9 +7109,10 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
  * See the comments on bfq_limit_depth for the purpose of
  * the depths set in the function. Return minimum shallow depth we'll use.
  */
-static void bfq_update_depths(struct bfq_data *bfqd, struct sbitmap_queue *bt)
+static void bfq_depth_updated(struct request_queue *q)
 {
-	unsigned int nr_requests = bfqd->queue->nr_requests;
+	struct bfq_data *bfqd = q->elevator->elevator_data;
+	unsigned int nr_requests = q->nr_requests;
 
 	/*
 	 * In-word depths if no bfq_queue is being weight-raised:
@@ -7143,21 +7144,8 @@ static void bfq_update_depths(struct bfq_data *bfqd, struct sbitmap_queue *bt)
 	bfqd->async_depths[1][0] = max((nr_requests * 3) >> 4, 1U);
 	/* no more than ~37% of tags for sync writes (~20% extra tags) */
 	bfqd->async_depths[1][1] = max((nr_requests * 6) >> 4, 1U);
-}
-
-static void bfq_depth_updated(struct blk_mq_hw_ctx *hctx)
-{
-	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
-	struct blk_mq_tags *tags = hctx->sched_tags;
 
-	bfq_update_depths(bfqd, &tags->bitmap_tags);
-	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, 1);
-}
-
-static int bfq_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int index)
-{
-	bfq_depth_updated(hctx);
-	return 0;
+	blk_mq_set_min_shallow_depth(q, 1);
 }
 
 static void bfq_exit_queue(struct elevator_queue *e)
@@ -7628,7 +7616,6 @@ static struct elevator_type iosched_bfq_mq = {
 		.request_merged		= bfq_request_merged,
 		.has_work		= bfq_has_work,
 		.depth_updated		= bfq_depth_updated,
-		.init_hctx		= bfq_init_hctx,
 		.init_sched		= bfq_init_queue,
 		.exit_sched		= bfq_exit_queue,
 	},
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index e2ce4a28e6c9..bf7dd97422ec 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -585,6 +585,9 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
 			}
 		}
 	}
+
+	if (e->ops.depth_updated)
+		e->ops.depth_updated(q);
 	return 0;
 
 out:
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index b554e1d55950..fe83187f41db 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -92,4 +92,15 @@ static inline bool blk_mq_sched_needs_restart(struct blk_mq_hw_ctx *hctx)
 	return test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
 }
 
+static inline void blk_mq_set_min_shallow_depth(struct request_queue *q,
+						unsigned int depth)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned long i;
+
+	queue_for_each_hw_ctx(q, hctx, i)
+		sbitmap_queue_min_shallow_depth(&hctx->sched_tags->bitmap_tags,
+						depth);
+}
+
 #endif
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b67d6c02eceb..9c68749124c6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4951,20 +4951,21 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 						      false);
 		}
 		if (ret)
-			break;
-		if (q->elevator && q->elevator->type->ops.depth_updated)
-			q->elevator->type->ops.depth_updated(hctx);
+			goto out;
 	}
-	if (!ret) {
-		q->nr_requests = nr;
-		if (blk_mq_is_shared_tags(set->flags)) {
-			if (q->elevator)
-				blk_mq_tag_update_sched_shared_tags(q);
-			else
-				blk_mq_tag_resize_shared_tags(set, nr);
-		}
+
+	q->nr_requests = nr;
+	if (q->elevator && q->elevator->type->ops.depth_updated)
+		q->elevator->type->ops.depth_updated(q);
+
+	if (blk_mq_is_shared_tags(set->flags)) {
+		if (q->elevator)
+			blk_mq_tag_update_sched_shared_tags(q);
+		else
+			blk_mq_tag_resize_shared_tags(set, nr);
 	}
 
+out:
 	blk_mq_unquiesce_queue(q);
 
 	return ret;
diff --git a/block/elevator.h b/block/elevator.h
index adc5c157e17e..c4d20155065e 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -37,7 +37,7 @@ struct elevator_mq_ops {
 	void (*exit_sched)(struct elevator_queue *);
 	int (*init_hctx)(struct blk_mq_hw_ctx *, unsigned int);
 	void (*exit_hctx)(struct blk_mq_hw_ctx *, unsigned int);
-	void (*depth_updated)(struct blk_mq_hw_ctx *);
+	void (*depth_updated)(struct request_queue *);
 
 	bool (*allow_merge)(struct request_queue *, struct request *, struct bio *);
 	bool (*bio_merge)(struct request_queue *, struct bio *, unsigned int);
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 70cbc7b2deb4..49ae52aa20d9 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -440,13 +440,12 @@ static void kyber_ctx_queue_init(struct kyber_ctx_queue *kcq)
 		INIT_LIST_HEAD(&kcq->rq_list[i]);
 }
 
-static void kyber_depth_updated(struct blk_mq_hw_ctx *hctx)
+static void kyber_depth_updated(struct request_queue *q)
 {
-	struct kyber_queue_data *kqd = hctx->queue->elevator->elevator_data;
-	struct blk_mq_tags *tags = hctx->sched_tags;
+	struct kyber_queue_data *kqd = q->elevator->elevator_data;
 
-	kqd->async_depth = hctx->queue->nr_requests * KYBER_ASYNC_PERCENT / 100U;
-	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, kqd->async_depth);
+	kqd->async_depth = q->nr_requests * KYBER_ASYNC_PERCENT / 100U;
+	blk_mq_set_min_shallow_depth(q, kqd->async_depth);
 }
 
 static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
@@ -493,7 +492,6 @@ static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 	khd->batching = 0;
 
 	hctx->sched_data = khd;
-	kyber_depth_updated(hctx);
 
 	return 0;
 
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index b9b7cdf1d3c9..578bc79c5654 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -507,22 +507,12 @@ static void dd_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 }
 
 /* Called by blk_mq_update_nr_requests(). */
-static void dd_depth_updated(struct blk_mq_hw_ctx *hctx)
+static void dd_depth_updated(struct request_queue *q)
 {
-	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
-	struct blk_mq_tags *tags = hctx->sched_tags;
 
 	dd->async_depth = q->nr_requests;
-
-	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, 1);
-}
-
-/* Called by blk_mq_init_hctx() and blk_mq_init_sched(). */
-static int dd_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
-{
-	dd_depth_updated(hctx);
-	return 0;
+	blk_mq_set_min_shallow_depth(q, 1);
 }
 
 static void dd_exit_sched(struct elevator_queue *e)
@@ -1048,7 +1038,6 @@ static struct elevator_type mq_deadline = {
 		.has_work		= dd_has_work,
 		.init_sched		= dd_init_sched,
 		.exit_sched		= dd_exit_sched,
-		.init_hctx		= dd_init_hctx,
 	},
 
 #ifdef CONFIG_BLK_DEBUG_FS
-- 
2.39.2

