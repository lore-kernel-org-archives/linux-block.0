Received: from sg-1-17.ptr.blmpb.com (sg-1-17.ptr.blmpb.com [118.26.132.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E5C2405ED
	for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 03:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763263272; cv=none; b=s+w1UeP9B4Fzwb5ICVqw3wxy+mnhz2/gij6lApel70qjkju2bu6YeLFF1fUQqbZup2cngb12Oft5gSXsD9lVwIEfXkUw3sfvQSMQo0ywrX1JEulw6GIyYCOnKZxastIHWufhGNjGuPzODZCgNWxzn9lwqpsQBL/eOWaYxrg/MaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763263272; c=relaxed/simple;
	bh=n29VEJdxJZ+HOGjjAlvi79x6wxADeK7kEvKIGf6MlV0=;
	h=To:Message-Id:From:Subject:Date:Mime-Version:Cc:Content-Type; b=SAQ0e6zojIVvchkryx/iqDKb/MHwIAJc1KeHNGZN627vCkdhkqMKR2JAnKjra8J0kjt2DpTkeGAzW1+zYLQPkD5Czq8vcGy4DAd6XEsR50SJCjjlvICrl5o4yn4UzOq9YEpnLeW/8d3J7L10cgt7R0IHnoWI4OXXbK54ZWtIMjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=Egg1rqrl; arc=none smtp.client-ip=118.26.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="Egg1rqrl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763263264;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=LtEdxwYKGT4UTrow/pOfOtK0nLo0grMZ6U3YGcx7Oos=;
 b=Egg1rqrlQjHRy1bZMxouwkh11LUv2IwfTEDApmbktyX4A/19f7J6lIm4Bn1teSaOLF2mb3
 bX5AcUPqfR51C6XljIcXPrmvy6ksytM9nOXxDw+WMmc2w84djZLkOdTCYxoBIcl9O2sT9V
 De1AtRzZpQgcDAkfRBqrJm+wPWEyeqNkh9Cg/W4ujgKuuUTBkq12QMDiZhz/mLlMU4+VAE
 cRUUHkaLjFmyOzwHOxVjIsJBKYSWnQc9Tz6dqQco3NgZxGBtcAdzhf8XeM3n7rRL7G3n7T
 9flKeixZOVwKDJFsM2sjLJvAiqHfqta6IPqIv7dMHHzUUeOvUl4kTmFVo0wIeQ==
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
Message-Id: <20251116032044.118664-7-yukuai@fnnas.com>
Content-Transfer-Encoding: 7bit
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: [PATCH RESEND v4 6/7] block, bfq: convert to use request_queue->async_depth
Date: Sun, 16 Nov 2025 11:20:40 +0800
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Received: from localhost.localdomain ([39.182.0.135]) by smtp.feishu.cn with ESMTPS; Sun, 16 Nov 2025 11:21:02 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26919431f+f01b8c+vger.kernel.org+yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
Cc: <yukuai@fnnas.com>, <nilay@linux.ibm.com>, <bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8

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
