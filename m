Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3352750E6;
	Thu, 14 Aug 2025 03:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755143001; cv=none; b=mo4TDCRkRVPwS3jv3V0tP6JoQzio0a6eIsZ8Gs5Y6cX677n3SjD8KD64AQjEFlr1d1j18roxa12ycDLnFoqM9PuqlY+RIYbh9COQvgGX79LsSpXrp1u8SiysLnbkmjFdBYzxdi/EKGhBhKSZuN08uiifnz5fQ/UAnOL054IJn4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755143001; c=relaxed/simple;
	bh=Jvoii4nVwMwLtCBE+IEICnuYYTqxC1rF9PACWcI0ppY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mjokNTeVfqJYDVy4W+V8BL4rNFu0CkSOugmW68HKm7oSRjnSaF3v0frcpVa7p+YP62f3OfL7L11glJIBCxu30fJ1k5gr/IrgS0Zp4IcZx2Z/C5Gq5VEkOIJQe5W6m8vq7lMS0zUZweZCwwaQe0/ZLiI6Z4X+68mcmu3c9oMYgok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c2WKs4GZNzYQv3p;
	Thu, 14 Aug 2025 11:43:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 342551A07BD;
	Thu, 14 Aug 2025 11:43:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCnIxRKW51ogs93Dg--.15627S12;
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
Subject: [PATCH 08/16] blk-mq: fix blk_mq_tags double free while nr_requests grown
Date: Thu, 14 Aug 2025 11:35:14 +0800
Message-Id: <20250814033522.770575-9-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCnIxRKW51ogs93Dg--.15627S12
X-Coremail-Antispam: 1UD129KBjvJXoWxur13Xr1DtF47ZFWfXw48Crg_yoW5Gr4xpF
	W5Wa13K34Fqr1xZFZ2y3y7Xas0gws2qw1xKFs3tryrtr1UKrs7ur48Wr4FqrWIyrWkCFZ2
	krZ8GF9rXryqqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

In the case user trigger tags grow by queue sysfs attribute nr_requests,
hctx->sched_tags will be freed directly and replaced with a new
allocated tags, see blk_mq_tag_update_depth().

The problem is that hctx->sched_tags is from elevator->et->tags, while
et->tags is still the freed tags, hence later elevator exist will try to
free the tags again, causing kernel panic.

Fix this problem by using new halper blk_mq_alloc_sched_tags() to
allocate a new sched_tags. Meanwhile, there is a longterm problem can be
fixed as well:

If blk_mq_tag_update_depth() succeed for previous hctx, then bitmap depth
is updated, however, if following hctx failed, q->nr_requests is not
updated and the previous hctx->sched_tags endup bigger than q->nr_requests.

Fixes: f5a6604f7a44 ("block: fix lockdep warning caused by lock dependency in elv_iosched_store")
Fixes: e3a2b3f931f5 ("blk-mq: allow changing of queue depth through sysfs")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a7d6a20c1524..f1c11f591c27 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4917,6 +4917,23 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 }
 EXPORT_SYMBOL(blk_mq_free_tag_set);
 
+static int blk_mq_sched_grow_tags(struct request_queue *q, unsigned int nr)
+{
+	struct elevator_tags *et =
+		blk_mq_alloc_sched_tags(q->tag_set, q->nr_hw_queues, nr);
+	struct blk_mq_hw_ctx *hctx;
+	unsigned long i;
+
+	if (!et)
+		return -ENOMEM;
+
+	blk_mq_free_sched_tags(q->elevator->et, q->tag_set);
+	queue_for_each_hw_ctx(q, hctx, i)
+		hctx->sched_tags = et->tags[i];
+	q->elevator->et = et;
+	return 0;
+}
+
 int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
@@ -4940,17 +4957,9 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 			sbitmap_queue_resize(&hctx->sched_tags->bitmap_tags,
 				nr - hctx->sched_tags->nr_reserved_tags);
 	} else {
-		queue_for_each_hw_ctx(q, hctx, i) {
-			/*
-			 * If we're using an MQ scheduler, just update the
-			 * scheduler queue depth. This is similar to what the
-			 * old code would do.
-			 */
-			ret = blk_mq_tag_update_depth(hctx,
-					&hctx->sched_tags, nr);
-			if (ret)
-				goto out;
-		}
+		ret = blk_mq_sched_grow_tags(q, nr);
+		if (ret)
+			goto out;
 	}
 
 	q->nr_requests = nr;
-- 
2.39.2

