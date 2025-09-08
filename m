Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FF821A436;
	Mon,  8 Sep 2025 06:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757312699; cv=none; b=AUGJJ+Bku0j05ruScHaz+3d6QzUSvlzT9Sp0pD17PmerwSW4AfmFr8Q4EkCzZGaYOwdavKk+yoHp4p4bhrfIrSdCOAiZMkE+TfSgLhro+FmYixpteQUaAbVEq6EszC/LdAUS9+PLaiEX02XJ8/Tlwo7+Y8DaH1p0GE21Gq+KFGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757312699; c=relaxed/simple;
	bh=Z2lF5VRF1gU52WsJJgXT9skRDuSW6oh7G1IpHKaVa4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NTSZ3w3CmI1cpq6Q8QJzaoHhYplmZ44g1Qu66QJyUgbgZwx2TQrqEiek846hC/lIBANa4dC2NTtE7FyfKoqBDJj/ERgnQ049bKCx4oA2dE8TsWCbWabX589li2u6gBr7X0A6vcmRfTlxIK8Fcgt/GLValPM5X58czmtp7qkfGVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cKxkv3vMlzYQvLN;
	Mon,  8 Sep 2025 14:24:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0AE0C1A0AD9;
	Mon,  8 Sep 2025 14:24:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3QY6xdr5oCGEjBw--.62066S9;
	Mon, 08 Sep 2025 14:24:53 +0800 (CST)
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
Subject: [PATCH for-6.18/block 05/10] blk-mq: cleanup shared tags case in blk_mq_update_nr_requests()
Date: Mon,  8 Sep 2025 14:15:28 +0800
Message-Id: <20250908061533.3062917-6-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3QY6xdr5oCGEjBw--.62066S9
X-Coremail-Antispam: 1UD129KBjvJXoWxAr18ZFWDZryUAFWUtFWDurg_yoW5Jw1rpF
	Waka13K3sYqr12vFWav39xXw4Ygrsagr1SkrsxtryFqr12kF4xGr4rWrn5XFW8trZ5AFsI
	vF4DJFWUXr18W37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VUbPC7UUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

For shared tags case, all hctx->shared_tags/tags are the same, it doesn't
make sense to call into blk_mq_tag_update_depth() multiple times for the
same tags.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c |  7 -------
 block/blk-mq.c     | 43 ++++++++++++++++++++++---------------------
 2 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 725210f27471..aed84c5d5c2b 100644
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
index d7540b8e7471..1ff6370f7314 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4926,34 +4926,35 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 
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

