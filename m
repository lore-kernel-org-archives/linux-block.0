Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABE71D5CD1;
	Mon,  8 Sep 2025 06:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313659; cv=none; b=PvProxub8Twxjvr+4Rn7G1OgR/F7PDAGk5KwF6b7sl8i6hg2QWAMdS2H15KYFNz7CmVg1Qp/Zzd4CKedPEU6xIdkvcnARaqYJRob0vKqnTLU+kpPsC/is1Ac/umUfiAhkrwkTVzI6gy8KerqkVnF942UrMLbTDs5YF2EILkiuEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313659; c=relaxed/simple;
	bh=DBDmrXI0Lw4LgHUZO1aFS/h89AGch/2dM76jHulMRWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L4BFgU1BUDsB0InPROqzQm65JNxAzMRUqHDcjgH7ZOtSUw1qD44wj2+rnh3h8ntW/MpGnLZewHYSCnyJwqz+l2+bqWBU1t49R60gb8yjEuzRwWhl2nybS9/rhVsHgCWgvPIJFdoB3UkxfRFnslt+DEGKbQDgQIrc3vWE/jXfCLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cKxkx51FPzKHN3F;
	Mon,  8 Sep 2025 14:24:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C423D1A1005;
	Mon,  8 Sep 2025 14:24:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3QY6xdr5oCGEjBw--.62066S13;
	Mon, 08 Sep 2025 14:24:57 +0800 (CST)
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
Subject: [PATCH for-6.18/block 09/10] blk-mq: remove blk_mq_tag_update_depth()
Date: Mon,  8 Sep 2025 14:15:32 +0800
Message-Id: <20250908061533.3062917-10-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3QY6xdr5oCGEjBw--.62066S13
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4xtF15Zr1xWr1rtryxKrg_yoW8trW5pF
	W3Ja1DK3yYqr1q9FWDtay7Aw1Fgw4vgr18Ka9aq34Fqr1jkr4xXF1kXr1kA3y0yrWkCr43
	ArWqgryrJF1DJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

This helper is not used now.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c | 32 --------------------------------
 block/blk-mq.h     |  2 --
 2 files changed, 34 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index aed84c5d5c2b..cbb93a653cef 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -583,38 +583,6 @@ void blk_mq_free_tags(struct blk_mq_tags *tags)
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
index 6c9d03625ba1..af09eb617d11 100644
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

