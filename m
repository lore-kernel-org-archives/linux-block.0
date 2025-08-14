Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A6B1C1AAA;
	Thu, 14 Aug 2025 03:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755142995; cv=none; b=bL+MwjVWMDEcooAUYMm4ES8X/GhrF5KxNU+79K4+wUGktCvwWil/LUqwj14R3+9P8ovVAPynazBFbR47isR5DrnWT6+tJJl2C+YdlVuIUG17ukWpWF/TcC0mA5KuZ8b45vgcecOEPfh429CbBZY2vcXSAIM9YkovKPwSUj6aTwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755142995; c=relaxed/simple;
	bh=9HCgRc+TAQUdTQUM95EmCDP3h6calstWWkZjnBPOJ3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ePd9xRsFgYUOStSe6CP0TlgGnd4xU922AQJY2RKo3d/NITmI9j+VEP3fW2CmMupx/YawsUmfFxxkWrAh7sKiZUhcjc2T/tAbuC8Fz1QPtSBD0nB/lMcAE8sV4codi0NazpG1AFTLAZoFXYKC6jdizb+emxreOJB7Uj64XPM5sl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c2WKq3HB9zKHMg4;
	Thu, 14 Aug 2025 11:43:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B7A581A0BD4;
	Thu, 14 Aug 2025 11:43:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCnIxRKW51ogs93Dg--.15627S9;
	Thu, 14 Aug 2025 11:43:10 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	yukuai3@huawei.com,
	bvanassche@acm.org,
	nilay@linux.ibm.com,
	hare@suse.de,
	ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH 05/16] blk-mq: fix elevator depth_updated method
Date: Thu, 14 Aug 2025 11:35:11 +0800
Message-Id: <20250814033522.770575-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250814033522.770575-1-yukuai1@huaweicloud.com>
References: <20250814033522.770575-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnIxRKW51ogs93Dg--.15627S9
X-Coremail-Antispam: 1UD129KBjvJXoW3AF4xWFyfGF4fZFyUuw17ZFb_yoWfJF47pF
	W5ta17KryrtF4UuFWjy39xXw43K39agry2yFs3t34rKrZrKFs3XF1rGFyxXFWIqrZ5CFsF
	vr4Dta4DXr1Iq3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
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
 block/blk-mq.c        | 24 ++++++++++++------------
 block/elevator.h      |  2 +-
 block/kyber-iosched.c | 10 ++++------
 block/mq-deadline.c   | 15 ++-------------
 7 files changed, 37 insertions(+), 49 deletions(-)

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
index 9a8a0b5e04a9..c6a1e5a25fec 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -588,6 +588,9 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
 			}
 		}
 	}
+
+	if (e->ops.depth_updated)
+		e->ops.depth_updated(q);
 	return 0;
 
 out:
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 0582d4bc3987..8e21a6b1415d 100644
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
index e86cab125a2d..14446d3927dd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4938,22 +4938,22 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 			ret = blk_mq_tag_update_depth(hctx, &hctx->tags, nr);
 
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
-
 	return ret;
 }
 
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

