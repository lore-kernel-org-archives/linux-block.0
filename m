Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1428A2798EF;
	Thu, 14 Aug 2025 03:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755143003; cv=none; b=YRHgKpVIsay1dbPUIcjGCoN8JrGAQBEpPRTbA2amu50yofwk4MCPO/odPVpMf1cDUJTYf8c71hHD33jO64El+zhgO1Uiacxs0hISFkvH/0hmMTFPIXWBv3bDRrEl2YBQZIPiHPMgR0fZLiZq9iRJCpbnB6mpZfP3fdx4ASC15J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755143003; c=relaxed/simple;
	bh=x8b5vVzsArBONueQXu3yg1g74YDP24Pvc4pmd7gaF0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gj4mnAYJ56CbONuFKvxrN/bMjmUDAzPKe5fFFIAq7NN1Lqp0AdM2oaTYZJno7HtWImOSS6UgyaWPBPaX8yozDMXDVh2LlsAO/94zX2TUSth92KLwVef6XXIh3Xhu1zAPfWiTP9k/ysho1HA+qEfVGPTLSfLbIv0jCslY9SVSIEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c2WKv3rp7zYQv8x;
	Thu, 14 Aug 2025 11:43:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2AEBA1A01A3;
	Thu, 14 Aug 2025 11:43:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCnIxRKW51ogs93Dg--.15627S16;
	Thu, 14 Aug 2025 11:43:13 +0800 (CST)
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
Subject: [PATCH 12/16] kyber: covert to use request_queue->async_depth
Date: Thu, 14 Aug 2025 11:35:18 +0800
Message-Id: <20250814033522.770575-13-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCnIxRKW51ogs93Dg--.15627S16
X-Coremail-Antispam: 1UD129KBjvJXoWxXF17Xw43XFyDGr48XF1fWFg_yoW5KF1rpF
	ZYvanIyF1UtF4j9rykA3yxZw1fXr4agr13AFsYyw4xKryDt3Z3XF18tFy0qFWIvrWrArsF
	9rWqvasrXrn7tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUQFxUUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Instead of the internal async_depth, remove kqd->async_depth and related
helpers, also remove limit_depth() method that is useless now.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/kyber-iosched.c | 36 +++---------------------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index b3df807044c3..2b38ee46140f 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -47,9 +47,8 @@ enum {
 	 * asynchronous requests, we reserve 25% of requests for synchronous
 	 * operations.
 	 */
-	KYBER_ASYNC_PERCENT = 75,
+	KYBER_DEFAULT_ASYNC_PERCENT = 75,
 };
-
 /*
  * Maximum device-wide depth for each scheduling domain.
  *
@@ -157,9 +156,6 @@ struct kyber_queue_data {
 	 */
 	struct sbitmap_queue domain_tokens[KYBER_NUM_DOMAINS];
 
-	/* Number of allowed async requests. */
-	unsigned int async_depth;
-
 	struct kyber_cpu_latency __percpu *cpu_latency;
 
 	/* Timer for stats aggregation and adjusting domain tokens. */
@@ -413,6 +409,7 @@ static int kyber_init_sched(struct request_queue *q, struct elevator_queue *eq)
 
 	eq->elevator_data = kqd;
 	q->elevator = eq;
+	q->async_depth = q->nr_requests * KYBER_DEFAULT_ASYNC_PERCENT / 100;
 
 	return 0;
 }
@@ -442,10 +439,7 @@ static void kyber_ctx_queue_init(struct kyber_ctx_queue *kcq)
 
 static void kyber_depth_updated(struct request_queue *q)
 {
-	struct kyber_queue_data *kqd = q->elevator->elevator_data;
-
-	kqd->async_depth = q->nr_requests * KYBER_ASYNC_PERCENT / 100U;
-	blk_mq_set_min_shallow_depth(q, kqd->async_depth);
+	blk_mq_set_min_shallow_depth(q, q->async_depth);
 }
 
 static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
@@ -537,19 +531,6 @@ static void rq_clear_domain_token(struct kyber_queue_data *kqd,
 	}
 }
 
-static void kyber_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
-{
-	/*
-	 * We use the scheduler tags as per-hardware queue queueing tokens.
-	 * Async requests can be limited at this stage.
-	 */
-	if (!blk_mq_sched_sync_request(opf)) {
-		struct kyber_queue_data *kqd = data->q->elevator->elevator_data;
-
-		data->shallow_depth = kqd->async_depth;
-	}
-}
-
 static bool kyber_bio_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs)
 {
@@ -943,15 +924,6 @@ KYBER_DEBUGFS_DOMAIN_ATTRS(KYBER_DISCARD, discard)
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
@@ -977,7 +949,6 @@ static const struct blk_mq_debugfs_attr kyber_queue_debugfs_attrs[] = {
 	KYBER_QUEUE_DOMAIN_ATTRS(write),
 	KYBER_QUEUE_DOMAIN_ATTRS(discard),
 	KYBER_QUEUE_DOMAIN_ATTRS(other),
-	{"async_depth", 0400, kyber_async_depth_show},
 	{},
 };
 #undef KYBER_QUEUE_DOMAIN_ATTRS
@@ -1003,7 +974,6 @@ static struct elevator_type kyber_sched = {
 		.exit_sched = kyber_exit_sched,
 		.init_hctx = kyber_init_hctx,
 		.exit_hctx = kyber_exit_hctx,
-		.limit_depth = kyber_limit_depth,
 		.bio_merge = kyber_bio_merge,
 		.prepare_request = kyber_prepare_request,
 		.insert_requests = kyber_insert_requests,
-- 
2.39.2

