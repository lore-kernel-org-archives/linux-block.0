Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377EC14A62B;
	Thu, 14 Aug 2025 03:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755142994; cv=none; b=ZriNKPNfUc9AjTVKPlTtLgcPZLS0mQVZ+8YFcBObQ5+3xo4+soo7o9chIS2WV1Lb7KP66zS5RwNoNI1GXHhJnBYzUpoUJGsi6rrgckY1K2UdeHB2685V7crOhkRyRb/qWxKET6Oss0vfGs/S7D/JOWCmcsYMWlnU1C+or+GDumc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755142994; c=relaxed/simple;
	bh=saM+n0D5pmnodx9T6iE8cyyLYX/dVjqVxc4FoBTKkVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u23aR4T9ZPD1WCMGSouRp6Gfq8fWAVYAuY/HUTC7s9Ke9ViyW1ymIxg62+Cd4f5jB/Rlw+uHSqIUSpQUewYKjnqml+kIvaNZixP6uY9moUID3+hAS8Ir/bsG/bhnL76A2SfribvXWbgAilLff+fybUdpWKgTLcnchpDnGASQpNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c2WKp6pdXzKHMhB;
	Thu, 14 Aug 2025 11:43:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3D31F1A07BD;
	Thu, 14 Aug 2025 11:43:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCnIxRKW51ogs93Dg--.15627S8;
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
Subject: [PATCH 04/16] blk-mq: check invalid nr_requests in queue_requests_store()
Date: Thu, 14 Aug 2025 11:35:10 +0800
Message-Id: <20250814033522.770575-5-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCnIxRKW51ogs93Dg--.15627S8
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4ruw1rXr45Kr17urWfXwb_yoWrCFyxpF
	W5Ka12k340qr10vFWIyay7Xw1Fkws3Kr1xGFsaqa4avr1jkr4xXF1FqryrZrW0yrWkCF47
	Zr4DtrW5JF1kGrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

queue_requests_store() is the only caller of
blk_mq_update_nr_requests(), and blk_mq_update_nr_requests() is the
only caller of blk_mq_tag_update_depth(), however, they all have
checkings for nr_requests input by user.

Make code cleaner by moving all the checkings to the top function:

1) nr_requests > reserved tags;
2) if there is elevator, 4 <= nr_requests <= 2048;
3) if elevator is none, 4 <= nr_requests < tag_set->queue_depth;

Meanwhile, case 2 is the only case tags can grow and -ENOMEM might be
returned.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c | 16 +---------------
 block/blk-mq.c     | 14 +++++---------
 block/blk-mq.h     |  2 +-
 block/blk-sysfs.c  | 13 +++++++++++++
 4 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index d880c50629d6..7613a9889eb1 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -584,14 +584,10 @@ void blk_mq_free_tags(struct blk_mq_tags *tags)
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
@@ -600,16 +596,6 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
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
index 3a219b7b3688..e86cab125a2d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4924,9 +4924,6 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 	int ret = 0;
 	unsigned long i;
 
-	if (q->nr_requests == nr)
-		return 0;
-
 	blk_mq_quiesce_queue(q);
 
 	queue_for_each_hw_ctx(q, hctx, i) {
@@ -4934,13 +4931,12 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 		 * If we're using an MQ scheduler, just update the scheduler
 		 * queue depth. This is similar to what the old code would do.
 		 */
-		if (hctx->sched_tags) {
+		if (hctx->sched_tags)
 			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
-						      nr, true);
-		} else {
-			ret = blk_mq_tag_update_depth(hctx, &hctx->tags, nr,
-						      false);
-		}
+						      nr);
+		else
+			ret = blk_mq_tag_update_depth(hctx, &hctx->tags, nr);
+
 		if (ret)
 			break;
 		if (q->elevator && q->elevator->type->ops.depth_updated)
diff --git a/block/blk-mq.h b/block/blk-mq.h
index affb2e14b56e..2b3ade60c90b 100644
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
index 1086f7b9da28..f3d08edcc34f 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -75,12 +75,25 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
 
 	memflags = blk_mq_freeze_queue(q);
 	mutex_lock(&q->elevator_lock);
+
+	if (q->nr_requests == nr)
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

