Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B6E2566E2;
	Fri, 10 Oct 2025 02:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760063314; cv=none; b=GGf0l4PcarZVfuYOllXQnrFmryDZVA3PRuiIWKsbLxITbKKwuqtS/LfkevQHz8C8keBMrG2pI/CNthbsPXY1EkMfiIfyaXDfRny2Yo80s0BuhMighk8fVYy0I+t6iOp1YmXI7JH+l+PT+SGj9SpAxHkT698orHxkpJ74m4jf4XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760063314; c=relaxed/simple;
	bh=2taC/R/r2EkYl7NPgfLzCfLf3Ik3Fpxzu7ejMKv33e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mcEvxGPJgv3pqZJL2HxklLHvlDDP7rVXeLOmQFGvz6Eq2sggQ0uqSxyMWnDD9VNSNAst00iBb0quJtlTW/Vjo4E6JqzBg061hw+Jkv2UkfI1YGALHxo4o5Ws0m6dcN9BbyDxd/Dx8hDotqi2L7rKu9v/JHVIGkwaNHWFoiwmUeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdtvm8AH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdtvm8AH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5935BC4CEE7;
	Fri, 10 Oct 2025 02:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760063313;
	bh=2taC/R/r2EkYl7NPgfLzCfLf3Ik3Fpxzu7ejMKv33e0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bdtvm8AHqQjJt+sxdo3nNkcTJh6ZCExExsyUvD7U0aiQuDhRqu7tAprtm6tWW8Mcz
	 qbs3KuZ2mZPw3ReI5dsrgzof94GbCW4AdXPuskIeuBPAFKMFy4gniOMXWr1My6kfUd
	 7cyxw0eWi90bMcpRRcQlH5JnlqLwSAF5lN0+/wSdftIA6naNfnkxjkJwsU/D7vbPDw
	 XBqh21tSiewXffsoEcskmEGI2IeaxVJEXPsLH1ZWGVZ2TZikSLqwCjIZ4JtHJeDeHU
	 C9+VBveC84/JRU+326ado1UXr3r5I0yE6APXydjhazVCrEE4J8xS0aG2+1zhp3KYln
	 vY6DnsCwSKh7w==
From: Yu Kuai <yukuai@kernel.org>
To: axboe@kernel.dk,
	bvanassche@acm.org,
	nilay@linux.ibm.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v3 4/7] kyber: covert to use request_queue->async_depth
Date: Fri, 10 Oct 2025 10:28:06 +0800
Message-ID: <20251010022812.2985286-5-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010022812.2985286-1-yukuai@kernel.org>
References: <20251010022812.2985286-1-yukuai@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

Instead of the internal async_depth, remove kqd->async_depth and related
helpers.

Noted elevator attribute async_depth is now removed, queue attribute
with the same name is used instead.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
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
2.51.0

