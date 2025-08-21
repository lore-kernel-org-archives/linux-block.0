Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD0225A325;
	Thu, 21 Aug 2025 06:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755756871; cv=none; b=ZI/AFPFNGMv8a9Cg/kHhxEy22bv6EkQTc5Po2owaX/ndip2fBOPlmKadm1VRGqizRoGxiTwda97X/qV2v8PHSXzg7FBU7pN7mYUX7Nyn66xqjkfTinovfd/DU6UMjH8HYLRrwnl/Vio0zgHacLSDAPiQtKh0J85FyveVyVL2fUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755756871; c=relaxed/simple;
	bh=g5Zf49Zj6Toyl/Iq+EkHakNtdzK4ISAiST4qEj/I1GQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rj+9bs95Xb6DvUQRd9eeSNTrpOUidMEfLRyPXOii02C/nxNO71A4CxyETfeZROTiL5pXk1/qfy75mGSXCVQCdd9ixZxbSNAI3CBc8kRraI5dsTpsh/Ebo6IDC0SKW68SKw/fvhLlDV6rlK+WHBGewGMiK6kwwxAdb0X2lYkyeMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c6tM63fFczYQvmX;
	Thu, 21 Aug 2025 14:14:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 141BA1A106E;
	Thu, 21 Aug 2025 14:14:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHERI+uaZoxBuhEQ--.58405S5;
	Thu, 21 Aug 2025 14:14:24 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: yukuai3@huawei.com,
	axboe@kernel.dk,
	bvanassche@acm.org,
	ming.lei@redhat.com,
	nilay@linux.ibm.com,
	hare@suse.de
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v3 1/2] blk-mq: fix elevator depth_updated method
Date: Thu, 21 Aug 2025 14:06:11 +0800
Message-Id: <20250821060612.1729939-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250821060612.1729939-1-yukuai1@huaweicloud.com>
References: <20250821060612.1729939-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHERI+uaZoxBuhEQ--.58405S5
X-Coremail-Antispam: 1UD129KBjvJXoW3AF4xWFyfGF4fCF18tr4Dtwb_yoWfur17pF
	WYqanrKr1rtF47uFyjy39xXw43K39agry2yFs3t34rKrZrKFs3XF1rGFyxXFWIqrZ5CFsr
	Zr4ktayDXr1Iq3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JU4OJ5UUUUU=
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

Those problems are first from error path, then mq-deadline, and recently
for bfq and kyber, fix those problems by:

- pass in request_queue instead of hctx;
- move depth_updated() after q->nr_requests is updated in
  blk_mq_update_nr_requests();
- add depth_updated() call inside init_sched() method to initialize
  async_depth;
- remove init_hctx() method for mq-deadline and bfq that is useless now;

Fixes: 77f1e0a52d26 ("bfq: update internal depth state when queue depth changes")
Fixes: 39823b47bbd4 ("block/mq-deadline: Fix the tag reservation code")
Fixes: 42e6c6ce03fd ("lib/sbitmap: convert shallow_depth from one word to the whole sbitmap")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c   | 22 +++++-----------------
 block/blk-mq-sched.h  | 11 +++++++++++
 block/blk-mq.c        | 23 ++++++++++++-----------
 block/elevator.h      |  2 +-
 block/kyber-iosched.c | 19 +++++++++----------
 block/mq-deadline.c   | 16 +++-------------
 6 files changed, 41 insertions(+), 52 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 50e51047e1fe..4a8d3d96bfe4 100644
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
@@ -7369,6 +7357,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_queue *eq)
 		goto out_free;
 	bfq_init_root_group(bfqd->root_group, bfqd);
 	bfq_init_entity(&bfqd->oom_bfqq.entity, bfqd->root_group);
+	bfq_depth_updated(q);
 
 	/* We dispatch from request queue wide instead of hw queue */
 	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
@@ -7628,7 +7617,6 @@ static struct elevator_type iosched_bfq_mq = {
 		.request_merged		= bfq_request_merged,
 		.has_work		= bfq_has_work,
 		.depth_updated		= bfq_depth_updated,
-		.init_hctx		= bfq_init_hctx,
 		.init_sched		= bfq_init_queue,
 		.exit_sched		= bfq_exit_queue,
 	},
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
index 70cbc7b2deb4..18efd6ef2a2b 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -399,6 +399,14 @@ static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
 	return ERR_PTR(ret);
 }
 
+static void kyber_depth_updated(struct request_queue *q)
+{
+	struct kyber_queue_data *kqd = q->elevator->elevator_data;
+
+	kqd->async_depth = q->nr_requests * KYBER_ASYNC_PERCENT / 100U;
+	blk_mq_set_min_shallow_depth(q, kqd->async_depth);
+}
+
 static int kyber_init_sched(struct request_queue *q, struct elevator_queue *eq)
 {
 	struct kyber_queue_data *kqd;
@@ -413,6 +421,7 @@ static int kyber_init_sched(struct request_queue *q, struct elevator_queue *eq)
 
 	eq->elevator_data = kqd;
 	q->elevator = eq;
+	kyber_depth_updated(q);
 
 	return 0;
 }
@@ -440,15 +449,6 @@ static void kyber_ctx_queue_init(struct kyber_ctx_queue *kcq)
 		INIT_LIST_HEAD(&kcq->rq_list[i]);
 }
 
-static void kyber_depth_updated(struct blk_mq_hw_ctx *hctx)
-{
-	struct kyber_queue_data *kqd = hctx->queue->elevator->elevator_data;
-	struct blk_mq_tags *tags = hctx->sched_tags;
-
-	kqd->async_depth = hctx->queue->nr_requests * KYBER_ASYNC_PERCENT / 100U;
-	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, kqd->async_depth);
-}
-
 static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 {
 	struct kyber_hctx_data *khd;
@@ -493,7 +493,6 @@ static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 	khd->batching = 0;
 
 	hctx->sched_data = khd;
-	kyber_depth_updated(hctx);
 
 	return 0;
 
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index b9b7cdf1d3c9..2e689b2c4021 100644
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
@@ -587,6 +577,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_queue *eq)
 	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
 
 	q->elevator = eq;
+	dd_depth_updated(q);
 	return 0;
 }
 
@@ -1048,7 +1039,6 @@ static struct elevator_type mq_deadline = {
 		.has_work		= dd_has_work,
 		.init_sched		= dd_init_sched,
 		.exit_sched		= dd_exit_sched,
-		.init_hctx		= dd_init_hctx,
 	},
 
 #ifdef CONFIG_BLK_DEBUG_FS
-- 
2.39.2

