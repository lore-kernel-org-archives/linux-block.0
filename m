Received: from sg-1-12.ptr.blmpb.com (sg-1-12.ptr.blmpb.com [118.26.132.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5151723817D
	for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 03:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763263269; cv=none; b=GPeK5tqFjsLU6bpS96X6kezYwcIvB9YqX/G3NRL9fVJb/Sr9omU/mMjz79wpkfbSMpLHClxobigxoH2ixxehXKuMA0WVikV8AqTKnEHlNSCUZZK3r7MZp7jj0P+CfIVzxFUPS6ALnkNn/kT/6Sq8mHtRUiZFjsHEHooyKc0viM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763263269; c=relaxed/simple;
	bh=cbq3/nGBqyWtn+FqQv8Elx9mceqf5mSOyIsszSbvcBI=;
	h=Date:Mime-Version:Subject:To:Content-Type:Cc:From:Message-Id; b=Kz8F05P0i7K+hzfmVqXd/MR5EtuRWdGldAr2QdWrzHmqajKHUat8kUh+cM9/3b8YotOdR/cRSM4k8xXmgZ70qeEkm7DK+YB/5T7l9AUvE4pC5Fud2z7S2I+xVODzEYHw/o1V4Ja89H/eKH+A7vQXKpPecPDARRS8+ceVW3s+oMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=ghFjIrhV; arc=none smtp.client-ip=118.26.132.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="ghFjIrhV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763263262;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=73t4+wm38j9e4ozEFCXBZ8YQ7XMpRf46AJe3alSZuWA=;
 b=ghFjIrhVfDEj/hNsSU1XSRrGbjI1vcV6XFm6CGXMuxNuH87wKgzpCJ+7V29esGGszH/FG7
 xGX5nquWAanNa29/DajeKxueIRZsnH3TDbfBWDf4rXezJbO/sDDKEI77aHKuFt/N3GjHiM
 Ugw8p1rnfKdZrHCicciwx+0G34iIJ5d4EuKclcX0eo0WDXko/83MRCMfk4HAbjobTOleWM
 iUu4B9Jp86lp+NmLGkVp9KRTRVcwIIX80E9fTGB1BvbQylzFeZHHgp3BTGkGOtpk4aZQ2Z
 IjOTDKEtK6XnEpOVzWP4gvqNRglKXo9g5tCJ1p21h397f8sQyrGks+DGQMxbHA==
Date: Sun, 16 Nov 2025 11:20:38 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH RESEND v4 4/7] kyber: covert to use request_queue->async_depth
Content-Transfer-Encoding: 7bit
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=UTF-8
X-Original-From: Yu Kuai <yukuai@fnnas.com>
X-Lms-Return-Path: <lba+26919431c+b7f90f+vger.kernel.org+yukuai@fnnas.com>
Cc: <yukuai@fnnas.com>, <nilay@linux.ibm.com>, <bvanassche@acm.org>
From: "Yu Kuai" <yukuai@fnnas.com>
Message-Id: <20251116032044.118664-5-yukuai@fnnas.com>
Received: from localhost.localdomain ([39.182.0.135]) by smtp.feishu.cn with ESMTPS; Sun, 16 Nov 2025 11:20:59 +0800

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
