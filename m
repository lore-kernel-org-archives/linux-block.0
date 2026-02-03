Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0413F395D88
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770106810; cv=none; b=hXNlXQvaWE22QX7OIGxOKcgua3rpYkd8fWJwmtasNe6y6MgHlOFp/5xd/B+t4r90uvv/YxYWvnObk7Al/OfF9+NIbGkoh8ydswCf2zw0tMfssOd6amTLkBCNDlhVYAEnT5SWlbC25g50+rs8ydvXGXxYvZh/E3co2R8j3mgrQuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770106810; c=relaxed/simple;
	bh=3JBJs+gpMWeDaf/WKToJ96C+KWhFkiq1lJAmqVjjGuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSi0FycXAuqG0QgWJ8zbS3cc/DA6jeddetysHnFXm+arbJMXfnxAVS0zWE2a3PSviinlr1cA3BQx1W03HVmO7gU8qJzyExErKzX/wau9GbirIPg/ZUGknqCQh7wf4IoxuA/muFSY4U6qema1gNTtOjZw3ly/zRhefaQEwYJaGKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641DAC19421;
	Tue,  3 Feb 2026 08:20:06 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com,
	bvanassche@acm.org,
	hare@suse.de
Subject: [PATCH v7 5/8] kyber: covert to use request_queue->async_depth
Date: Tue,  3 Feb 2026 16:19:46 +0800
Message-ID: <20260203081952.732210-6-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260203081952.732210-1-yukuai@fnnas.com>
References: <20260203081952.732210-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of the internal async_depth, remove kqd->async_depth and related
helpers.

Noted elevator attribute async_depth is now removed, queue attribute
with the same name is used instead.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/kyber-iosched.c | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 2b3f5b8959af..b84163d1f851 100644
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
@@ -414,6 +407,7 @@ static int kyber_init_sched(struct request_queue *q, struct elevator_queue *eq)
 	blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
 
 	q->elevator = eq;
+	q->async_depth = q->nr_requests * KYBER_DEFAULT_ASYNC_PERCENT / 100;
 	kyber_depth_updated(q);
 
 	return 0;
@@ -552,15 +546,8 @@ static void rq_clear_domain_token(struct kyber_queue_data *kqd,
 
 static void kyber_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 {
-	/*
-	 * We use the scheduler tags as per-hardware queue queueing tokens.
-	 * Async requests can be limited at this stage.
-	 */
-	if (!blk_mq_is_sync_read(opf)) {
-		struct kyber_queue_data *kqd = data->q->elevator->elevator_data;
-
-		data->shallow_depth = kqd->async_depth;
-	}
+	if (!blk_mq_is_sync_read(opf))
+		data->shallow_depth = data->q->async_depth;
 }
 
 static bool kyber_bio_merge(struct request_queue *q, struct bio *bio,
@@ -956,15 +943,6 @@ KYBER_DEBUGFS_DOMAIN_ATTRS(KYBER_DISCARD, discard)
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
@@ -990,7 +968,6 @@ static const struct blk_mq_debugfs_attr kyber_queue_debugfs_attrs[] = {
 	KYBER_QUEUE_DOMAIN_ATTRS(write),
 	KYBER_QUEUE_DOMAIN_ATTRS(discard),
 	KYBER_QUEUE_DOMAIN_ATTRS(other),
-	{"async_depth", 0400, kyber_async_depth_show},
 	{},
 };
 #undef KYBER_QUEUE_DOMAIN_ATTRS
-- 
2.51.0

