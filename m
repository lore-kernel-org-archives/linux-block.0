Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936C9310782;
	Wed, 10 Sep 2025 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492060; cv=none; b=T1jaEkBrdxfgjyiKWQiNfmcCotVoIBI2k+I+bK43+KX71dTniMJMCOXeK/T3ZTENwPFgI8q8BIa3/AGtJo79URagnzUB31IOforepOQMGBdq6ySJ7kyH9cytTWiVD4WKIfBcAxV2oD5bNxds+0COh7PFdE+y4gdUUl5/oVF3RI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492060; c=relaxed/simple;
	bh=Y8UX9C+IfTgkO7D+2lbw/xOeX64zQrTkxbIfVJS1Vgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IL5BZmVjnPbvNEXpmkfyzRxEUukAmH5g/zQXYB2Uk12tQprgzEHVtO+Dd1YJONRWee+kRMHePrNVZMCsK0uzROaz7JlQipejRxeP4HN+5KLUliHRsRM5PGEH7F5sc4Us49ZA557pPdou8cTK8PXPbJ/9lVE+i3SDxzDN3JOr8e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cMD49340GzYQvjh;
	Wed, 10 Sep 2025 16:14:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E8C6C1A1B26;
	Wed, 10 Sep 2025 16:14:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDnMY5QM8Fo1ggRCA--.52270S13;
	Wed, 10 Sep 2025 16:14:15 +0800 (CST)
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
Subject: [PATCH v2 for-6.18/block 09/10] blk-mq: remove blk_mq_tag_update_depth()
Date: Wed, 10 Sep 2025 16:04:44 +0800
Message-Id: <20250910080445.239096-10-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDnMY5QM8Fo1ggRCA--.52270S13
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4xtrWkAF4fCrWxJr48tFb_yoW8KF4DpF
	W3ta1DK3y5tr1q9FWDtay7Aw1Fgw4vgr18Ka9aqa4Fqr1jkr4xXF1vqr1kA3y0yrWkCF4f
	ZrWqgryrJF1kJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
	0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IU1aLvJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

This helper is not used now.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-tag.c | 32 --------------------------------
 block/blk-mq.h     |  2 --
 2 files changed, 34 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 936b68273cad..a63d21a4aab4 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -609,38 +609,6 @@ void blk_mq_free_tags(struct blk_mq_tag_set *set, struct blk_mq_tags *tags)
 	call_srcu(&set->tags_srcu, &tags->rcu_head, blk_mq_free_tags_callback);
 }
 
-int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
-			    struct blk_mq_tags **tagsptr, unsigned int tdepth)
-{
-	struct blk_mq_tags *tags = *tagsptr;
-
-	/*
-	 * If we are allowed to grow beyond the original size, allocate
-	 * a new set of tags before freeing the old one.
-	 */
-	if (tdepth > tags->nr_tags) {
-		struct blk_mq_tag_set *set = hctx->queue->tag_set;
-		struct blk_mq_tags *new;
-
-		new = blk_mq_alloc_map_and_rqs(set, hctx->queue_num, tdepth);
-		if (!new)
-			return -ENOMEM;
-
-		blk_mq_free_map_and_rqs(set, *tagsptr, hctx->queue_num);
-		hctx->queue->elevator->et->tags[hctx->queue_num] = new;
-		*tagsptr = new;
-	} else {
-		/*
-		 * Don't need (or can't) update reserved tags here, they
-		 * remain static and should never need resizing.
-		 */
-		sbitmap_queue_resize(&tags->bitmap_tags,
-				tdepth - tags->nr_reserved_tags);
-	}
-
-	return 0;
-}
-
 void blk_mq_tag_resize_shared_tags(struct blk_mq_tag_set *set, unsigned int size)
 {
 	struct blk_mq_tags *tags = set->shared_tags;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 0ef96f510477..af42dc018808 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -184,8 +184,6 @@ unsigned long blk_mq_get_tags(struct blk_mq_alloc_data *data, int nr_tags,
 void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
 		unsigned int tag);
 void blk_mq_put_tags(struct blk_mq_tags *tags, int *tag_array, int nr_tags);
-int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
-		struct blk_mq_tags **tags, unsigned int depth);
 void blk_mq_tag_resize_shared_tags(struct blk_mq_tag_set *set,
 		unsigned int size);
 void blk_mq_tag_update_sched_shared_tags(struct request_queue *q);
-- 
2.39.2

