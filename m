Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7DD1EE7B6;
	Sat, 21 Dec 2024 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734774070; cv=none; b=J8KlYYwSuEKhXvHn9Ii/rpjImXKJO4d/pzdPTHUY5FW1E3Rb+X6qJaUGg/37nJlAuk6HcWA65vd+Q+fcwn4EYL5u9uP/UQeHatZFiDaY4debGNiIUERYD6hGBNuj+HJR2nAHHI8PQ+Ufr2rlddoaLyIgNIpuK6OZ77uGrJ7zf+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734774070; c=relaxed/simple;
	bh=65zi5A/F+7fS+4iUI0T2GyGtTMz0l5fvVn4uxS6TX9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KHJvEmzdY2wjYNWhu5QpfIfrSjcLAR2rebrPqU6c73qhr4ECxYUQoYPvqrTb7ZlPecOZl0PFb+JyZWRse7t/u3FnJhxtA5XdkfDyxuAnJq6n/NhT61CyGYhWjzfcSCbRkgRUo0jip2Ln1guYwX6IvG3eiTeRzKU3v6XoKZrIPdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YFfRH1kxWz4f3lCf;
	Sat, 21 Dec 2024 17:40:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DAB9E1A0568;
	Sat, 21 Dec 2024 17:41:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHIoYqjWZnocfeFA--.21383S11;
	Sat, 21 Dec 2024 17:41:03 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	akpm@linux-foundation.org,
	ming.lei@redhat.com,
	yang.yang@vivo.com,
	yukuai3@huawei.com,
	bvanassche@acm.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC v3 7/7] block/kyber-iosched: switch to use queue async_depth
Date: Sat, 21 Dec 2024 17:37:10 +0800
Message-Id: <20241221093710.926309-8-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241221093710.926309-1-yukuai1@huaweicloud.com>
References: <20241221093710.926309-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHIoYqjWZnocfeFA--.21383S11
X-Coremail-Antispam: 1UD129KBjvJXoWxCry7Ar1rtFWrCFyDCF4UArb_yoW5Ar1fpF
	Z5ZanIyFy8tF4Uury8J397Zw1SqrsIgr43Jan3t34rtryqqanrXF4FyFy0vFWIvrWrArsr
	urWDAFZrJrnFqF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

To make code cleaner.

Noted that for kyber, async_depth is still always 75% nr_requests, and
user can't set new value for now.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/kyber-iosched.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index ccfefa6a3669..0909851f22c6 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -157,9 +157,6 @@ struct kyber_queue_data {
 	 */
 	struct sbitmap_queue domain_tokens[KYBER_NUM_DOMAINS];
 
-	/* Number of allowed async requests. */
-	unsigned int async_depth;
-
 	struct kyber_cpu_latency __percpu *cpu_latency;
 
 	/* Timer for stats aggregation and adjusting domain tokens. */
@@ -449,11 +446,11 @@ static void kyber_ctx_queue_init(struct kyber_ctx_queue *kcq)
 
 static void kyber_depth_updated(struct blk_mq_hw_ctx *hctx)
 {
-	struct kyber_queue_data *kqd = hctx->queue->elevator->elevator_data;
+	struct request_queue *q = hctx->queue;
 	struct blk_mq_tags *tags = hctx->sched_tags;
 
-	kqd->async_depth = hctx->queue->nr_requests * KYBER_ASYNC_PERCENT / 100U;
-	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, kqd->async_depth);
+	q->async_depth = hctx->queue->nr_requests * KYBER_ASYNC_PERCENT / 100U;
+	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, q->async_depth);
 }
 
 static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
@@ -552,11 +549,8 @@ static void kyber_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 	 * We use the scheduler tags as per-hardware queue queueing tokens.
 	 * Async requests can be limited at this stage.
 	 */
-	if (!op_is_sync(opf)) {
-		struct kyber_queue_data *kqd = data->q->elevator->elevator_data;
-
-		data->shallow_depth = kqd->async_depth;
-	}
+	if (!op_is_sync(opf))
+		data->shallow_depth = data->q->async_depth;
 }
 
 static bool kyber_bio_merge(struct request_queue *q, struct bio *bio,
@@ -952,15 +946,6 @@ KYBER_DEBUGFS_DOMAIN_ATTRS(KYBER_DISCARD, discard)
 KYBER_DEBUGFS_DOMAIN_ATTRS(KYBER_OTHER, other)
 #undef KYBER_DEBUGFS_DOMAIN_ATTRS
 
-static int kyber_async_depth_show(void *data, struct seq_file *m)
-{
-	struct request_queue *q = data;
-	struct kyber_queue_data *kqd = q->elevator->elevator_data;
-
-	seq_printf(m, "%u\n", kqd->async_depth);
-	return 0;
-}
-
 static int kyber_cur_domain_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_hw_ctx *hctx = data;
@@ -986,7 +971,6 @@ static const struct blk_mq_debugfs_attr kyber_queue_debugfs_attrs[] = {
 	KYBER_QUEUE_DOMAIN_ATTRS(write),
 	KYBER_QUEUE_DOMAIN_ATTRS(discard),
 	KYBER_QUEUE_DOMAIN_ATTRS(other),
-	{"async_depth", 0400, kyber_async_depth_show},
 	{},
 };
 #undef KYBER_QUEUE_DOMAIN_ATTRS
-- 
2.39.2

