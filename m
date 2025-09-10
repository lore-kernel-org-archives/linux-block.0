Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FA53115A3;
	Wed, 10 Sep 2025 08:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492062; cv=none; b=etuXQhHQRjHQg8C3Hvd2r4Mhg8KvO4MaVJN0+BvgPvIzMZoD9sYvhxsbTe44D4WE9y80n7HvD6FHxfYY/3PRW44v8ntir1JsQEiLLCCS4PcLnAxuzMwbgAclluYmrMnuYmp1ZEw/GKQq+C1uej/ocPAGbY8aaoXcYTUvmYblV9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492062; c=relaxed/simple;
	bh=SvfqHcfgVZT8JpRjERmPrhVusoKfNDeu1R0KsVJBGLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YOGUxXrnQLiYBlB9frOFEBpRH//E2dEaOZ320wqL2M+RmajcKMgCRyrNr2j/9JDsWK4TxQpGMtoTyBjjfNge6jyumGF2j7QieLq6Z9UE/cAc1PkBhsCTG5+Wz6ytb+5e0gNXeMR4c7MG7jlid9z7f0T3teiBYxZJChYezqJ9Q9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cMD435q20zKHNJx;
	Wed, 10 Sep 2025 16:14:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0C28C1A1307;
	Wed, 10 Sep 2025 16:14:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDnMY5QM8Fo1ggRCA--.52270S7;
	Wed, 10 Sep 2025 16:14:11 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v2 for-6.18/block 03/10] blk-mq: check invalid nr_requests in queue_requests_store()
Date: Wed, 10 Sep 2025 16:04:38 +0800
Message-Id: <20250910080445.239096-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250910080445.239096-1-yukuai1@huaweicloud.com>
References: <20250910080445.239096-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnMY5QM8Fo1ggRCA--.52270S7
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4ruw1rXr45Kr17urWfXwb_yoWrAF1DpF
	W5KanFk340qr10vFWIyay7Jw13Kws5Kr1xJFsaqa4Yvr12kr4xXF1FqrWrXr40yrWkCF47
	Ar4DtrW5JF1kGrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14
	v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU14xRDUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

queue_requests_store() is the only caller of
blk_mq_update_nr_requests(), and blk_mq_update_nr_requests() is the
only caller of blk_mq_tag_update_depth(), however, they all have
checkings for nr_requests input by user.

Make code cleaner by moving all the checkings to the top function:

1) nr_requests > reserved tags;
2) if there is elevator, 4 <= nr_requests <= 2048;
3) if elevator is none, 4 <= nr_requests <= tag_set->queue_depth;

Meanwhile, case 2 is the only case tags can grow and -ENOMEM might be
returned.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-tag.c | 16 +---------------
 block/blk-mq.c     |  8 ++------
 block/blk-mq.h     |  2 +-
 block/blk-sysfs.c  | 13 +++++++++++++
 4 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 086c67849e06..56f9bc839000 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -610,14 +610,10 @@ void blk_mq_free_tags(struct blk_mq_tag_set *set, struct blk_mq_tags *tags)
 }
 
 int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
-			    struct blk_mq_tags **tagsptr, unsigned int tdepth,
-			    bool can_grow)
+			    struct blk_mq_tags **tagsptr, unsigned int tdepth)
 {
 	struct blk_mq_tags *tags = *tagsptr;
 
-	if (tdepth <= tags->nr_reserved_tags)
-		return -EINVAL;
-
 	/*
 	 * If we are allowed to grow beyond the original size, allocate
 	 * a new set of tags before freeing the old one.
@@ -626,16 +622,6 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 		struct blk_mq_tag_set *set = hctx->queue->tag_set;
 		struct blk_mq_tags *new;
 
-		if (!can_grow)
-			return -EINVAL;
-
-		/*
-		 * We need some sort of upper limit, set it high enough that
-		 * no valid use cases should require more.
-		 */
-		if (tdepth > MAX_SCHED_RQ)
-			return -EINVAL;
-
 		/*
 		 * Only the sbitmap needs resizing since we allocated the max
 		 * initially.
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 55ccc9f4435d..9b97f2f3f2c9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4933,9 +4933,6 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 	int ret = 0;
 	unsigned long i;
 
-	if (q->nr_requests == nr)
-		return 0;
-
 	blk_mq_quiesce_queue(q);
 
 	queue_for_each_hw_ctx(q, hctx, i) {
@@ -4947,10 +4944,9 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 		 */
 		if (hctx->sched_tags) {
 			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
-						      nr, true);
+						      nr);
 		} else {
-			ret = blk_mq_tag_update_depth(hctx, &hctx->tags, nr,
-						      false);
+			ret = blk_mq_tag_update_depth(hctx, &hctx->tags, nr);
 		}
 		if (ret)
 			goto out;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index b96a753809ab..5d42c7d3a952 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -171,7 +171,7 @@ void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
 		unsigned int tag);
 void blk_mq_put_tags(struct blk_mq_tags *tags, int *tag_array, int nr_tags);
 int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
-		struct blk_mq_tags **tags, unsigned int depth, bool can_grow);
+		struct blk_mq_tags **tags, unsigned int depth);
 void blk_mq_tag_resize_shared_tags(struct blk_mq_tag_set *set,
 		unsigned int size);
 void blk_mq_tag_update_sched_shared_tags(struct request_queue *q);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 1ffa65feca4f..f99519f7a820 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -75,12 +75,25 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
 
 	memflags = blk_mq_freeze_queue(q);
 	mutex_lock(&q->elevator_lock);
+
+	if (nr == q->nr_requests)
+		goto unlock;
+
 	if (nr < BLKDEV_MIN_RQ)
 		nr = BLKDEV_MIN_RQ;
 
+	if (nr <= q->tag_set->reserved_tags ||
+	    (q->elevator && nr > MAX_SCHED_RQ) ||
+	    (!q->elevator && nr > q->tag_set->queue_depth)) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
 	err = blk_mq_update_nr_requests(disk->queue, nr);
 	if (err)
 		ret = err;
+
+unlock:
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
 	return ret;
-- 
2.39.2

