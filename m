Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACBD22D780;
	Mon,  8 Sep 2025 06:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313658; cv=none; b=nxsUzMdcFAPqAN9KflNW0W/fX9LuXUVlOaBAv7gSg9U9DeNevi3OYNG4sb7+VzS5VHFa3TDUcHiZD3yhHYmAwsdAhM97YaJWz598cFhrWsbUV59RvtfPF7Oh37nWakFZcvokqoV54DN9YHcbR56aMT85cf5T6obzsDh3ozeITMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313658; c=relaxed/simple;
	bh=PxnBnPx3HGipvqdSFWwfxP+7xhUgeL405jjdZJKXqS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZATL7WP0vcxwjZIq9SfCM68HPHI+TsKx1LVKf0Ty0sCBTxcoQFS8tsQs/c0R9J4LK/mMDYY3EqlPqSdZlaEnK6H39SL/nnTi9I5oULyUY2IPG/SgYoMkLqbusM5i8rtikga92/4WjieBcRAr0oSgjq5ma+6hpqalAJrmVZ30JdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cKxks0NxLzKHMxf;
	Mon,  8 Sep 2025 14:24:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2792E1A0FC1;
	Mon,  8 Sep 2025 14:24:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3QY6xdr5oCGEjBw--.62066S7;
	Mon, 08 Sep 2025 14:24:52 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: nilay@linux.ibm.com,
	ming.lei@redhat.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH for-6.18/block 03/10] blk-mq: check invalid nr_requests in queue_requests_store()
Date: Mon,  8 Sep 2025 14:15:26 +0800
Message-Id: <20250908061533.3062917-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
References: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3QY6xdr5oCGEjBw--.62066S7
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4ruw1rXr45Kr17urWfXwb_yoWrWFWkpF
	W3Ka12k34Fqr10vFWIyay7Jw1Skws5Kr1xGFsaqa4Yvr1jkr4xXF1Fqry8XrW0yrWkCF47
	Ar4DtrW5JF1kGrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUHWlkUUUUU=
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
---
 block/blk-mq-tag.c | 16 +---------------
 block/blk-mq.c     |  8 ++------
 block/blk-mq.h     |  2 +-
 block/blk-sysfs.c  | 13 +++++++++++++
 4 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 5cffa5668d0c..725210f27471 100644
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
index 0fac0236a5dc..d7540b8e7471 100644
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
@@ -4938,10 +4935,9 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
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

