Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65672D0632;
	Fri, 15 Aug 2025 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245414; cv=none; b=Sm8w0P1WDdS9/ZR3fiVSy4mj+FgRCS1loXIb14/i29HL4infd2+4ZgUlcTY5aycXJ72RdZozei7uD0cFQyrbTwdueBQvdbD2l6rW0SNwot1mWNdJdtweEsextA9lnXu5XT265GUh/HoeGlUd9Jfg9w8nQOUjKRoNcgoXzDRrHXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245414; c=relaxed/simple;
	bh=qzvTwBje3GDMsYRDWYIDuCfP2wb2OrBVObEVkbxcZoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K4JHSHX/lu3TVCaK+pIQ5+MWDp6fZMYCUdQljJrlDk8avNaVGfX23nJt4hKGFa6cBChXQjDfCnEYvCpp67JuKLc8YdVq79AkZGfBJIiYoP/q7KwnulTVo8G0o09XCi6MDgrKStTqHr23BkYjBfh2OX2tCkjQkZVfa1HI6SYRRDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c3FCR2mNNzKHMXj;
	Fri, 15 Aug 2025 16:10:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B22831A1B19;
	Fri, 15 Aug 2025 16:10:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHjxBc655o+xX_Dg--.53834S13;
	Fri, 15 Aug 2025 16:10:10 +0800 (CST)
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
Subject: [PATCH 09/10] blk-mq: remove blk_mq_tag_update_depth()
Date: Fri, 15 Aug 2025 16:02:15 +0800
Message-Id: <20250815080216.410665-10-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDHjxBc655o+xX_Dg--.53834S13
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4xtF15Zr1xWF4rKF1DGFg_yoW8uFWfpF
	W3tanrK3yYqr1q9F4Dta9rAr1rKw4vgr18Ka9aq34Fqr1jkr4IqFn5Xr1kA3y0yrWkCF43
	ArWqqryrJr1kJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUQFxUUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

This helper is not used now.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c | 31 -------------------------------
 block/blk-mq.h     |  2 --
 2 files changed, 33 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 84a452e708e4..cbb93a653cef 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -583,37 +583,6 @@ void blk_mq_free_tags(struct blk_mq_tags *tags)
 	kfree(tags);
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
index 98740f9c204e..aaa006fe5076 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -183,8 +183,6 @@ unsigned long blk_mq_get_tags(struct blk_mq_alloc_data *data, int nr_tags,
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

