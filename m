Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DDF273D6D;
	Thu, 14 Aug 2025 03:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755143000; cv=none; b=pvSLsGauY6OAo2nDhhGFXgGcosmcmIruxchlkchOeu/3ZubXsgBj+R9ZSDPag3gnfvYYIsKVkV8tDmCCLtaoJXV1YeJQNsunT6G6BF23tbG+VmN0oEyQHpBdkXqFA2050O8DEJGs7p/6vHliysgyPKeqVkobnQGW3JupRjrLD2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755143000; c=relaxed/simple;
	bh=mRbI3tmkA/TYRsZDHdbsy7279ICniBUzF0QF8ydpZ9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F9G58ORc7r4s3E9mqzXpxMkrz8CUPLVjlR231R6w3eFmulD9hgXZq6GESzx1dkWuQ0JhbIBP4sl7UukJycqyOa653DORoXCTU4KHCFsI/erm8NaonXMAH7teIVf0FOOUDsQVnpjJ/mz+Zk1a8nT3ftb17qhA8kJd4vCBP/JtDQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c2WKr4QhWzYQv7q;
	Thu, 14 Aug 2025 11:43:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3AA271A0BD8;
	Thu, 14 Aug 2025 11:43:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCnIxRKW51ogs93Dg--.15627S10;
	Thu, 14 Aug 2025 11:43:11 +0800 (CST)
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
Subject: [PATCH 06/16] blk-mq: cleanup shared tags case in blk_mq_update_nr_requests()
Date: Thu, 14 Aug 2025 11:35:12 +0800
Message-Id: <20250814033522.770575-7-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCnIxRKW51ogs93Dg--.15627S10
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1rWrWUuF1xCr17tF45Awb_yoW5JrW8pr
	W3Ka13K34Fqr1SvFWavw43Xw4Ygws3Wr1IkFsxJryFqr12kF4xGr4rWrn5XFW8trZ5AFsI
	9F4DJFWUXr1kW37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

For shared tags case, all hctx->shared_tags/tags are the same, it
doesn't make sense to call blk_mq_tag_update_depth() multiple times
for the same tags.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c |  7 -------
 block/blk-mq.c     | 40 +++++++++++++++++++++-------------------
 2 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 7613a9889eb1..84a452e708e4 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -596,13 +596,6 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 		struct blk_mq_tag_set *set = hctx->queue->tag_set;
 		struct blk_mq_tags *new;
 
-		/*
-		 * Only the sbitmap needs resizing since we allocated the max
-		 * initially.
-		 */
-		if (blk_mq_is_shared_tags(set->flags))
-			return 0;
-
 		new = blk_mq_alloc_map_and_rqs(set, hctx->queue_num, tdepth);
 		if (!new)
 			return -ENOMEM;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 14446d3927dd..c29f98ec283d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4926,32 +4926,34 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 
 	blk_mq_quiesce_queue(q);
 
-	queue_for_each_hw_ctx(q, hctx, i) {
-		/*
-		 * If we're using an MQ scheduler, just update the scheduler
-		 * queue depth. This is similar to what the old code would do.
-		 */
-		if (hctx->sched_tags)
-			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
-						      nr);
-		else
-			ret = blk_mq_tag_update_depth(hctx, &hctx->tags, nr);
-
-		if (ret)
-			goto out;
-	}
-
-	q->nr_requests = nr;
-	if (q->elevator && q->elevator->type->ops.depth_updated)
-		q->elevator->type->ops.depth_updated(q);
-
 	if (blk_mq_is_shared_tags(set->flags)) {
 		if (q->elevator)
 			blk_mq_tag_update_sched_shared_tags(q);
 		else
 			blk_mq_tag_resize_shared_tags(set, nr);
+	} else {
+		queue_for_each_hw_ctx(q, hctx, i) {
+			/*
+			 * If we're using an MQ scheduler, just update the
+			 * scheduler queue depth. This is similar to what the
+			 * old code would do.
+			 */
+			if (hctx->sched_tags)
+				ret = blk_mq_tag_update_depth(hctx,
+						&hctx->sched_tags, nr);
+			else
+				ret = blk_mq_tag_update_depth(hctx,
+						&hctx->tags, nr);
+
+			if (ret)
+				goto out;
+		}
 	}
 
+	q->nr_requests = nr;
+	if (q->elevator && q->elevator->type->ops.depth_updated)
+		q->elevator->type->ops.depth_updated(q);
+
 out:
 	blk_mq_unquiesce_queue(q);
 	return ret;
-- 
2.39.2

