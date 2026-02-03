Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1269C393DE0
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 08:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770106814; cv=none; b=um6ZxTSbGx58wkyP4l4lYHpVgLxc1XyoPkiKBmOVrXlsvoKK/KkD3N4I3ebUpdM/GG2V05g/pa5qiz5I6fDUTXLafenOs8asa8+uNUmAvb1QaLQWcTEjAXM8+83DnrMTSHVRvc8Jginf3Aa9DKBr+Igcjc4OYv0SMefCgF99eLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770106814; c=relaxed/simple;
	bh=NXkK9pRM1XIQjHD30sZjyfvW58CpLEyp5/X6mYwYOqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOy9KF1aXbTP62TDLhAgPTRPGk8hK7PBvSIGk+NX4OqTfga6UvTKW1kGxz34t+sRdhdRA7LDQxYhYpDfN3+X5vRnhlQCZEM1jeD43Z19n+ZsPzlBFOpLPFgJ1+70Smd6v+f33wFFtk7k1rqAUTTwPQAxwVb/AD609ubbGmPrN00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349A6C116D0;
	Tue,  3 Feb 2026 08:20:11 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com,
	bvanassche@acm.org,
	hare@suse.de
Subject: [PATCH v7 7/8] block, bfq: convert to use request_queue->async_depth
Date: Tue,  3 Feb 2026 16:19:48 +0800
Message-ID: <20260203081952.732210-8-yukuai@fnnas.com>
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

The default limits is unchanged, and user can configure async_depth now.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/bfq-iosched.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 89289ec283f6..8f05b7cdf754 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7114,39 +7114,29 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
 static void bfq_depth_updated(struct request_queue *q)
 {
 	struct bfq_data *bfqd = q->elevator->elevator_data;
-	unsigned int nr_requests = q->nr_requests;
+	unsigned int async_depth = q->async_depth;
 
 	/*
-	 * In-word depths if no bfq_queue is being weight-raised:
-	 * leaving 25% of tags only for sync reads.
+	 * By default:
+	 *  - sync reads are not limited
+	 * If bfqq is not being weight-raised:
+	 *  - sync writes are limited to 75%(async depth default value)
+	 *  - async IO are limited to 50%
+	 * If bfqq is being weight-raised:
+	 *  - sync writes are limited to ~37%
+	 *  - async IO are limited to ~18
 	 *
-	 * In next formulas, right-shift the value
-	 * (1U<<bt->sb.shift), instead of computing directly
-	 * (1U<<(bt->sb.shift - something)), to be robust against
-	 * any possible value of bt->sb.shift, without having to
-	 * limit 'something'.
+	 * If request_queue->async_depth is updated by user, all limit are
+	 * updated relatively.
 	 */
-	/* no more than 50% of tags for async I/O */
-	bfqd->async_depths[0][0] = max(nr_requests >> 1, 1U);
-	/*
-	 * no more than 75% of tags for sync writes (25% extra tags
-	 * w.r.t. async I/O, to prevent async I/O from starving sync
-	 * writes)
-	 */
-	bfqd->async_depths[0][1] = max((nr_requests * 3) >> 2, 1U);
+	bfqd->async_depths[0][1] = async_depth;
+	bfqd->async_depths[0][0] = max(async_depth * 2 / 3, 1U);
+	bfqd->async_depths[1][1] = max(async_depth >> 1, 1U);
+	bfqd->async_depths[1][0] = max(async_depth >> 2, 1U);
 
 	/*
-	 * In-word depths in case some bfq_queue is being weight-
-	 * raised: leaving ~63% of tags for sync reads. This is the
-	 * highest percentage for which, in our tests, application
-	 * start-up times didn't suffer from any regression due to tag
-	 * shortage.
+	 * Due to cgroup qos, the allowed request for bfqq might be 1
 	 */
-	/* no more than ~18% of tags for async I/O */
-	bfqd->async_depths[1][0] = max((nr_requests * 3) >> 4, 1U);
-	/* no more than ~37% of tags for sync writes (~20% extra tags) */
-	bfqd->async_depths[1][1] = max((nr_requests * 6) >> 4, 1U);
-
 	blk_mq_set_min_shallow_depth(q, 1);
 }
 
@@ -7367,6 +7357,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_queue *eq)
 	blk_queue_flag_set(QUEUE_FLAG_DISABLE_WBT_DEF, q);
 	wbt_disable_default(q->disk);
 	blk_stat_enable_accounting(q);
+	q->async_depth = (q->nr_requests * 3) >> 2;
 
 	return 0;
 
-- 
2.51.0

