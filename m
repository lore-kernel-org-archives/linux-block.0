Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A5531197B;
	Wed, 10 Sep 2025 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492063; cv=none; b=BFzzVEejID7QlS32Ofg73M8HV+KzPj0gAehcz1rwTB2XuQHwl4ozjcVW6c8kRGwyo0KD/xVBEWMEtKwJ2o1A18iMa8OoJYnoAxIbtP3NxGzHbH6jUFZ+TTF00a4+R1ty7sS0ZRs1wT4Q2JbrnIK5GqzE89g2BEUm+q4wrO2Xwp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492063; c=relaxed/simple;
	bh=GsKOZF3qFE6ICsxBenXAEA8x+suEAgpMUrpmSFUs9xs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IjZeyN1kpu9NUQtQwCJOHLY/OsrQKOxwLvzKgsz3U8PVx/+DLw1iNlEjM26MVtMtSwoB6LS7NOXE0ilZF4qo5KBoG4RMzQIxnxlqCoeISO0k4E0kopdSG7QfGSZnDH6yWAtpZgywVnhNN7EQ7IDGMVWEzhHEwbXYEgaFqkMpfd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cMD450LRgzKHNLf;
	Wed, 10 Sep 2025 16:14:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 42FF91A1317;
	Wed, 10 Sep 2025 16:14:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDnMY5QM8Fo1ggRCA--.52270S10;
	Wed, 10 Sep 2025 16:14:13 +0800 (CST)
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
Subject: [PATCH v2 for-6.18/block 06/10] blk-mq: split bitmap grow and resize case in blk_mq_update_nr_requests()
Date: Wed, 10 Sep 2025 16:04:41 +0800
Message-Id: <20250910080445.239096-7-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDnMY5QM8Fo1ggRCA--.52270S10
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWkXF18Ww1rZr17tFykGrg_yoW8ZFy3pF
	W3Wa1ak3sYqrn8ZFZI934UX3Z0gFs7Jr1xJr4xtryrWr1Uur4Sgr4Ig34aqFyxtrZ5CFWS
	kFs8trWDCr1UXrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

No functional changes are intended, make code cleaner and prepare to fix
the grow case in following patches.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 80c20700bce8..299aac458185 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4936,25 +4936,40 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 	blk_mq_quiesce_queue(q);
 
 	if (blk_mq_is_shared_tags(set->flags)) {
+		/*
+		 * Shared tags, for sched tags, we allocate max initially hence
+		 * tags can't grow, see blk_mq_alloc_sched_tags().
+		 */
 		if (q->elevator)
 			blk_mq_tag_update_sched_shared_tags(q);
 		else
 			blk_mq_tag_resize_shared_tags(set, nr);
-	} else {
+	} else if (!q->elevator) {
+		/*
+		 * Non-shared hardware tags, nr is already checked from
+		 * queue_requests_store() and tags can't grow.
+		 */
 		queue_for_each_hw_ctx(q, hctx, i) {
 			if (!hctx->tags)
 				continue;
-			/*
-			 * If we're using an MQ scheduler, just update the
-			 * scheduler queue depth. This is similar to what the
-			 * old code would do.
-			 */
-			if (hctx->sched_tags)
-				ret = blk_mq_tag_update_depth(hctx,
-							&hctx->sched_tags, nr);
-			else
-				ret = blk_mq_tag_update_depth(hctx,
-							&hctx->tags, nr);
+			sbitmap_queue_resize(&hctx->tags->bitmap_tags,
+				nr - hctx->tags->nr_reserved_tags);
+		}
+	} else if (nr <= q->elevator->et->nr_requests) {
+		/* Non-shared sched tags, and tags don't grow. */
+		queue_for_each_hw_ctx(q, hctx, i) {
+			if (!hctx->sched_tags)
+				continue;
+			sbitmap_queue_resize(&hctx->sched_tags->bitmap_tags,
+				nr - hctx->sched_tags->nr_reserved_tags);
+		}
+	} else {
+		/* Non-shared sched tags, and tags grow */
+		queue_for_each_hw_ctx(q, hctx, i) {
+			if (!hctx->sched_tags)
+				continue;
+			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
+						      nr);
 			if (ret)
 				goto out;
 		}
-- 
2.39.2

