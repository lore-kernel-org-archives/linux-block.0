Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0D7246BB9;
	Fri, 15 Aug 2025 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245412; cv=none; b=lBLJGzOK8VpgkSwJEz80QdOiZjA32H9ZuwFNgny6HRWrYFDU98SM0nGqdHO1V9ugJmYCXi8+P4BYwRkjXEFOVyGYvfkFi2B8YIAMKuisyjfyXwqrwtu31BDJ34IzIEsNla1jVV8NPtn/vx6CrPTkFxfayylpTbGPOmHIO8W+skI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245412; c=relaxed/simple;
	bh=qJyYXd4U74eACysqGJuJcbG8PT+aB8k8HUbQhaWO0YI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JPuS1rPAuY+eR1uMbXJPeu9kyDtVoK2Oxrbi0ud2SlWwIMcNR9iO5xty1zv0qy9o4VHI/csF24F4DlTwfqFE93e/de5BQWgWKYavoPg836oDq4JGhqrZrJiOeykp7Hwk/gb2R16jduwvPW5pJ8EaxpxcRJw09PG7sTyXwK4IGlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c3FCP3gfRzKHMjH;
	Fri, 15 Aug 2025 16:10:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C9A481A0E51;
	Fri, 15 Aug 2025 16:10:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHjxBc655o+xX_Dg--.53834S9;
	Fri, 15 Aug 2025 16:10:08 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	hare@suse.de,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH 05/10] blk-mq: cleanup shared tags case in blk_mq_update_nr_requests()
Date: Fri, 15 Aug 2025 16:02:11 +0800
Message-Id: <20250815080216.410665-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250815080216.410665-1-yukuai1@huaweicloud.com>
References: <20250815080216.410665-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHjxBc655o+xX_Dg--.53834S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1rWrWUuF1xZr17Cr1UAwb_yoW5JFWrpF
	Waka13K34Fqr1avFWav39xXw4Ygrs3Wr1SkrsxtryFqr12kF4xGF4rWr1rXFW8trZ5AFsI
	9F4DJFWUXr18W37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VUbPC7UUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

For shared tags case, all hctx->shared_tags/tags are the same, it
doesn't make sense to call blk_mq_tag_update_depth() multiple times
for the same tags.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c |  7 -------
 block/blk-mq.c     | 42 ++++++++++++++++++++++--------------------
 2 files changed, 22 insertions(+), 27 deletions(-)

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
index 048d6b2cffe6..1e85fcd474c2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4926,33 +4926,35 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 
 	blk_mq_quiesce_queue(q);
 
-	queue_for_each_hw_ctx(q, hctx, i) {
-		if (!hctx->tags)
-			continue;
-		/*
-		 * If we're using an MQ scheduler, just update the scheduler
-		 * queue depth. This is similar to what the old code would do.
-		 */
-		if (hctx->sched_tags)
-			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
-						      nr);
-		else
-			ret = blk_mq_tag_update_depth(hctx, &hctx->tags, nr);
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
+						&hctx->sched_tags, nr);
+			else
+				ret = blk_mq_tag_update_depth(hctx,
+						&hctx->tags, nr);
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

