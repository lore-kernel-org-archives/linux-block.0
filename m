Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4622D0C7A;
	Thu,  9 Oct 2025 07:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996402; cv=none; b=Y3Hv+01QU19Hq03uIIK6jMbpkB/ipcEZQyuUbrrUK7aY/STRCMn9QBwkZqSnXETUuCm0YB1PQWWWrfmW55XjHcHB1bjtx8heIUw4V0X1YM/i4NIcaHT1ML1vW44BAVajva7b2/z89fjyYrOkZXsnOlwR/SRhDdX8HcBr/8Y0PJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996402; c=relaxed/simple;
	bh=rJCmr2vRxpQvqOBs2AdVE9J+V9zwFHJ2Ch8Tsy991vM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MZHK7pE0mJkQK7MNjVavg5KYIq2JeObriC19QncYQQ4owNp+Ab06ghcB54RIIdj/CR6iYDov8pVdX5bl55KDH2oDHHc/SAGcQ527XCxSy2MNXnUHwWilEuCDZum4EFOa9Chmrez7R4+HcEusvZ8vHiY2mGu528LHBuQIPuSaZZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cj2Cv6H72zYQv5h;
	Thu,  9 Oct 2025 15:52:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3663F1A0F45;
	Thu,  9 Oct 2025 15:53:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.159.234])
	by APP4 (Coremail) with SMTP id gCh0CgA3+mHqaedo7Fo7CQ--.38248S8;
	Thu, 09 Oct 2025 15:53:16 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	bvanassche@acm.org,
	ming.lei@redhat.com,
	nilay@linux.ibm.com,
	jmoyer@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [patch v2 4/7] kyber: covert to use request_queue->async_depth
Date: Thu,  9 Oct 2025 15:46:31 +0800
Message-Id: <20251009074634.527661-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251009074634.527661-1-yukuai1@huaweicloud.com>
References: <20251009074634.527661-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3+mHqaedo7Fo7CQ--.38248S8
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1UtF4xCr4DAw1kAFy3twb_yoW5tr18pF
	Z5ZanIyF1Utr429rykJ3y7Zw1fWr9Fgr13JFs5t34fKryDt3Z7X3WrtFy0qFWIvryrAwsr
	urZ8ta9rJFn7tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Instead of the internal async_depth, remove kqd->async_depth and related
helpers.

Noted elevator attribute async_depth is now removed, queue attribute
with the same name is used instead.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/kyber-iosched.c | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index cf243a457175..469dad8a981c 100644
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
@@ -401,10 +397,7 @@ static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
 
 static void kyber_depth_updated(struct request_queue *q)
 {
-	struct kyber_queue_data *kqd = q->elevator->elevator_data;
-
-	kqd->async_depth = q->nr_requests * KYBER_ASYNC_PERCENT / 100U;
-	blk_mq_set_min_shallow_depth(q, kqd->async_depth);
+	blk_mq_set_min_shallow_depth(q, q->async_depth);
 }
 
 static int kyber_init_sched(struct request_queue *q, struct elevator_queue *eq)
@@ -421,6 +414,7 @@ static int kyber_init_sched(struct request_queue *q, struct elevator_queue *eq)
 
 	eq->elevator_data = kqd;
 	q->elevator = eq;
+	q->async_depth = q->nr_requests * KYBER_DEFAULT_ASYNC_PERCENT / 100;
 	kyber_depth_updated(q);
 
 	return 0;
@@ -540,15 +534,8 @@ static void rq_clear_domain_token(struct kyber_queue_data *kqd,
 
 static void kyber_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 {
-	/*
-	 * We use the scheduler tags as per-hardware queue queueing tokens.
-	 * Async requests can be limited at this stage.
-	 */
-	if (!blk_mq_sched_sync_request(opf)) {
-		struct kyber_queue_data *kqd = data->q->elevator->elevator_data;
-
-		data->shallow_depth = kqd->async_depth;
-	}
+	if (!blk_mq_sched_sync_request(opf))
+		data->shallow_depth = data->q->async_depth;
 }
 
 static bool kyber_bio_merge(struct request_queue *q, struct bio *bio,
@@ -944,15 +931,6 @@ KYBER_DEBUGFS_DOMAIN_ATTRS(KYBER_DISCARD, discard)
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
@@ -978,7 +956,6 @@ static const struct blk_mq_debugfs_attr kyber_queue_debugfs_attrs[] = {
 	KYBER_QUEUE_DOMAIN_ATTRS(write),
 	KYBER_QUEUE_DOMAIN_ATTRS(discard),
 	KYBER_QUEUE_DOMAIN_ATTRS(other),
-	{"async_depth", 0400, kyber_async_depth_show},
 	{},
 };
 #undef KYBER_QUEUE_DOMAIN_ATTRS
-- 
2.39.2

