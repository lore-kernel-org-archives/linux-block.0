Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B565A25785E;
	Sun, 16 Nov 2025 03:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763265164; cv=none; b=MQjZBFVw+/7PFmKflacJYbn9rm6yjML47+Bo74iyH0qiwpW1ooWkzvpGHGQE0AVY65AcHq5UxvBqfTY5+9rwdNFjEnc1AA8cEPZ9ya1BEF1dVuxmhV0cpqHXpsCgxetpevqHuQ56vHXRdAVhmHj0kfiJ2TawKT/yVM6vfTSSIJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763265164; c=relaxed/simple;
	bh=n29VEJdxJZ+HOGjjAlvi79x6wxADeK7kEvKIGf6MlV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2YLXf89gjoVmlnZKC8cn8jyIEgNhEgwTq2iGFGAIFFmHoDkFqG/HNpztwp9gWwpLZHGgwwPE+JyAchgVvf+rMwnjbKEVH/bVs4iftb0c+pFc9Me5ff1LjLE8S6kGY1KPhWjQiFdH0TTPyzOAOlDj7nNYl0quQ86zdgSTd0+ivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B619AC2BCAF;
	Sun, 16 Nov 2025 03:52:42 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yukuai@fnnas.com,
	nilay@linux.ibm.com,
	bvanassche@acm.org
Subject: [PATCH RESEND v5 6/7] block, bfq: convert to use request_queue->async_depth
Date: Sun, 16 Nov 2025 11:52:26 +0800
Message-ID: <20251116035228.119987-7-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251116035228.119987-1-yukuai@fnnas.com>
References: <20251116035228.119987-1-yukuai@fnnas.com>
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
index 63452e791f98..9e0eee9aba5c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7112,39 +7112,29 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
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
 
@@ -7365,6 +7355,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_queue *eq)
 	blk_queue_flag_set(QUEUE_FLAG_DISABLE_WBT_DEF, q);
 	wbt_disable_default(q->disk);
 	blk_stat_enable_accounting(q);
+	q->async_depth = (q->nr_requests * 3) >> 2;
 
 	return 0;
 
-- 
2.51.0

