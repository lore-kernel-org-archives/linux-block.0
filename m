Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825B53101BC;
	Wed, 10 Sep 2025 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492059; cv=none; b=pitNWWNB5yhHoYHfNRa5yQzUV1RTPfgFygylXVO1k6SGIPTn1AK1h1PugJo7meYVQiD9NdgwKFXr1OzsZg04SWoNE2F5FKakDK+Tqn1kTBbnv35dVnrGgtuW2vDi6tJ3iu51ZlBPjpeMuJT5ep4z+6aCJp4PkQ+fYYL2zGOaxQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492059; c=relaxed/simple;
	bh=kLBSDL3ag7C4cQImvjvGguTl1y6B0gZ+c+sJSB3hnug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PicSCorqzNcRFynDlKq0SUoYAHPaB/oCeVAULn3gYytF1y83cd/2pgydWMqfcXDtONjV/KcGAaZ1SGpd6WJBngNV1A5tcg26OZ2R+o2P4vwMyfKd39e/Rrw/FyghRUiLGS2iKQ1DcebI815ivGyERGaHm98mMjFU3FL4kdwYPTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cMD471DtxzYQvjR;
	Wed, 10 Sep 2025 16:14:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A74211A1323;
	Wed, 10 Sep 2025 16:14:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDnMY5QM8Fo1ggRCA--.52270S11;
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
Subject: [PATCH v2 for-6.18/block 07/10] blk-mq-sched: add new parameter nr_requests in blk_mq_alloc_sched_tags()
Date: Wed, 10 Sep 2025 16:04:42 +0800
Message-Id: <20250910080445.239096-8-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDnMY5QM8Fo1ggRCA--.52270S11
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1kXF1rWryftFWrZryDGFg_yoWrGFy8pF
	45XanFk34Yqr1kXay2y3yfZr13Kws29FyxGr4ft34Fyr1q9ws3WF10gr47XrW0yrZ3AFsF
	vr1DtFWUWrsFg3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

This helper only support to allocate the default number of requests,
add a new parameter to support specific number of requests.

Prepare to fix potential deadlock in the case nr_requests grow.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-sched.c | 14 +++++---------
 block/blk-mq-sched.h |  2 +-
 block/blk-mq.h       | 11 +++++++++++
 block/elevator.c     |  3 ++-
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index e2ce4a28e6c9..d06bb137a743 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -454,7 +454,7 @@ void blk_mq_free_sched_tags_batch(struct xarray *et_table,
 }
 
 struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
-		unsigned int nr_hw_queues)
+		unsigned int nr_hw_queues, unsigned int nr_requests)
 {
 	unsigned int nr_tags;
 	int i;
@@ -470,13 +470,8 @@ struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
 			nr_tags * sizeof(struct blk_mq_tags *), gfp);
 	if (!et)
 		return NULL;
-	/*
-	 * Default to double of smaller one between hw queue_depth and
-	 * 128, since we don't split into sync/async like the old code
-	 * did. Additionally, this is a per-hw queue depth.
-	 */
-	et->nr_requests = 2 * min_t(unsigned int, set->queue_depth,
-			BLKDEV_DEFAULT_RQ);
+
+	et->nr_requests = nr_requests;
 	et->nr_hw_queues = nr_hw_queues;
 
 	if (blk_mq_is_shared_tags(set->flags)) {
@@ -521,7 +516,8 @@ int blk_mq_alloc_sched_tags_batch(struct xarray *et_table,
 		 * concurrently.
 		 */
 		if (q->elevator) {
-			et = blk_mq_alloc_sched_tags(set, nr_hw_queues);
+			et = blk_mq_alloc_sched_tags(set, nr_hw_queues,
+					blk_mq_default_nr_requests(set));
 			if (!et)
 				goto out_unwind;
 			if (xa_insert(et_table, q->id, et, gfp))
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index fe83187f41db..8e21a6b1415d 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -24,7 +24,7 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
 void blk_mq_sched_free_rqs(struct request_queue *q);
 
 struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
-		unsigned int nr_hw_queues);
+		unsigned int nr_hw_queues, unsigned int nr_requests);
 int blk_mq_alloc_sched_tags_batch(struct xarray *et_table,
 		struct blk_mq_tag_set *set, unsigned int nr_hw_queues);
 void blk_mq_free_sched_tags(struct elevator_tags *et,
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 5d42c7d3a952..3a1d4c37d1bc 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -109,6 +109,17 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(blk_opf_t opf,
 	return ctx->hctxs[blk_mq_get_hctx_type(opf)];
 }
 
+/*
+ * Default to double of smaller one between hw queue_depth and
+ * 128, since we don't split into sync/async like the old code
+ * did. Additionally, this is a per-hw queue depth.
+ */
+static inline unsigned int blk_mq_default_nr_requests(
+		struct blk_mq_tag_set *set)
+{
+	return 2 * min_t(unsigned int, set->queue_depth, BLKDEV_DEFAULT_RQ);
+}
+
 /*
  * sysfs helpers
  */
diff --git a/block/elevator.c b/block/elevator.c
index fe96c6f4753c..e2ebfbf107b3 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -669,7 +669,8 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 	lockdep_assert_held(&set->update_nr_hwq_lock);
 
 	if (strncmp(ctx->name, "none", 4)) {
-		ctx->et = blk_mq_alloc_sched_tags(set, set->nr_hw_queues);
+		ctx->et = blk_mq_alloc_sched_tags(set, set->nr_hw_queues,
+				blk_mq_default_nr_requests(set));
 		if (!ctx->et)
 			return -ENOMEM;
 	}
-- 
2.39.2

