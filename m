Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F144130BB97;
	Wed, 10 Sep 2025 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492056; cv=none; b=Mf6Gtce/Dx9zBQxgrmSAAItQJ+14f2nhXHdktoarMdQBGKpIsipOI9pvRavgNj1leoexmfNObj4Yq1TfqZnRMcxkqVLHifKoJp9gwFt39u1HjkNXVL8GxVQ6sOJyubOOaEd3/3aNtRNMvzevpaVaqyvjAE2AQnUJLbKS06z+8Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492056; c=relaxed/simple;
	bh=8f6yQr2ilRVYLH8ad9QGBDmDAvao7c4GnRf/r0/N1P8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=toVvhYr+aYVPLbTQ2MCB1zPD+jKCpDI0U6G7T2QWg45CglVD1tK0hplCAzeVUl1gr1o/QudIveRFOIf14tWd3FlssWc7+LGrEs0YH5ff6sQfDfXKNmiCc9My9esuZNg1mcKeWWsXxlZ0QTJT02Sx+AdRdyoDreS+5Y3mb7fPZB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cMD462N6vzYQvjR;
	Wed, 10 Sep 2025 16:14:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D19B01A19EE;
	Wed, 10 Sep 2025 16:14:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDnMY5QM8Fo1ggRCA--.52270S9;
	Wed, 10 Sep 2025 16:14:12 +0800 (CST)
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
Subject: [PATCH v2 for-6.18/block 05/10] blk-mq: cleanup shared tags case in blk_mq_update_nr_requests()
Date: Wed, 10 Sep 2025 16:04:40 +0800
Message-Id: <20250910080445.239096-6-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDnMY5QM8Fo1ggRCA--.52270S9
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWDWr4xWw1rtFWDur45Wrg_yoW5Gry3pF
	Waka13K3sYqr12vFWavw13Jw4Ygws2gr1SkFsxtr1Fqr1jkF4xGr4rWrn5XFW8trZ5AFsI
	vF4DJFWUXr18W37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZTmfUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

For shared tags case, all hctx->sched_tags/tags are the same, it doesn't
make sense to call into blk_mq_tag_update_depth() multiple times for the
same tags.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-tag.c |  7 -------
 block/blk-mq.c     | 43 ++++++++++++++++++++++---------------------
 2 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 56f9bc839000..936b68273cad 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -622,13 +622,6 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
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
index 9b97f2f3f2c9..80c20700bce8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4935,34 +4935,35 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 
 	blk_mq_quiesce_queue(q);
 
-	queue_for_each_hw_ctx(q, hctx, i) {
-		if (!hctx->tags)
-			continue;
-		/*
-		 * If we're using an MQ scheduler, just update the scheduler
-		 * queue depth. This is similar to what the old code would do.
-		 */
-		if (hctx->sched_tags) {
-			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
-						      nr);
-		} else {
-			ret = blk_mq_tag_update_depth(hctx, &hctx->tags, nr);
-		}
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
+			if (!hctx->tags)
+				continue;
+			/*
+			 * If we're using an MQ scheduler, just update the
+			 * scheduler queue depth. This is similar to what the
+			 * old code would do.
+			 */
+			if (hctx->sched_tags)
+				ret = blk_mq_tag_update_depth(hctx,
+							&hctx->sched_tags, nr);
+			else
+				ret = blk_mq_tag_update_depth(hctx,
+							&hctx->tags, nr);
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
 
-- 
2.39.2

