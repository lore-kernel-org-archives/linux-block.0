Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB581A262A;
	Mon,  8 Sep 2025 06:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313657; cv=none; b=itH4L6kjrr+LrJgA+ydfYU26r9kUA395bbzNYM6L1O+0rNszaHfNYyvlm/hEmnyy1ugkdVcon/1IljtjUlZOX1/yeCa5tOsz/Exfzy4MUBDWCgik0fLq0V6M3Kn9abP3iixXq6UUfdfERDtQKvx2/PuM2/JFxRde0QjWLN9ua8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313657; c=relaxed/simple;
	bh=por5FVkETrw0t+twqGZClVMpdCkS3aLmnlAefWWwm/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jEa4BG8pFo41VfgthJEzpqaLvGuN5dg5hBHnH4Z/JRsvgK4KqMaqqP2/dVMvYTTVOpNKFJ51NJr7bus765SMslSlzWPDiiOrFvHgvPgQUztjQALzQII1ifqswGHOQfLx4Zf/E8NHqsY519UKm4o/IKtm1oPZQnQMYx/c49mUOVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cKxkt5gdgzKHMxf;
	Mon,  8 Sep 2025 14:24:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DEC181A1B4C;
	Mon,  8 Sep 2025 14:24:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3QY6xdr5oCGEjBw--.62066S11;
	Mon, 08 Sep 2025 14:24:54 +0800 (CST)
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
Subject: [PATCH for-6.18/block 07/10] blk-mq-sched: add new parameter nr_requests in blk_mq_alloc_sched_tags()
Date: Mon,  8 Sep 2025 14:15:30 +0800
Message-Id: <20250908061533.3062917-8-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3QY6xdr5oCGEjBw--.62066S11
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1kXF1rWryftFWrZryDGFg_yoWrGr4fpF
	45XanFk34Yqr1kXay2yw4xXr13tws29FyxGr4ft34Fyr1q9rs3XF10gr47XrW0yrZ3AFsF
	yr1Dtay5WrsFg3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

This helper only support to allocate the default number of requests,
add a new parameter to support specific number of requests.

Prepare to fix potential deadlock in the case nr_requests grow.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
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
index 2b3ade60c90b..731f4578d9a8 100644
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

