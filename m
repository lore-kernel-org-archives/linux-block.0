Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C1B1FECAB;
	Fri, 25 Jul 2025 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466649; cv=none; b=aa4yaB72od9Ji+7eBCV8lS0jLXfxnCE8OxRezwwJzSUjnR2qRRh5d8cH0WgZ1O+h7VH+Lsu2l0hMiNQK68d9659m0guIbAuEixry0BQSWnuFQPnO7vyNjWqHNcb/6NRn6JNf5PvRW3HdfX+J9n/udYT9uA4PSTJ/lI9M+6e7png=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466649; c=relaxed/simple;
	bh=WqTj9yEK0vxbfqPbpn2nCVfDXVC3xGegM2GRpyvUMMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XGbqkTD3U+vtY1bRq7bN6rzY5Fil61uZTbagFGrA6wmeasECQ8GLjI40CYbPnlDfnQaYeGPKepdcifHtu9Jk6q306s1SX2G1xPPAmswsy+F79MBvd5SzRI9ThhqitkgMbtddT5k198Lr+HYByuveOMsW7Mx/OVXeDW90vNnLyFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPQ2YU1p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPQ2YU1p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B4AC4CEF7;
	Fri, 25 Jul 2025 18:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753466648;
	bh=WqTj9yEK0vxbfqPbpn2nCVfDXVC3xGegM2GRpyvUMMo=;
	h=From:To:Cc:Subject:Date:From;
	b=pPQ2YU1pVTQxPkSJ1kP3ed8qLxNpY8PVvOmT5AShhs7d7yOCgwBsy4aFmMMKXuOIZ
	 y9Lk4rEEkl33en9AdRLLO5ci+KFvSWMWrWcT3GPPyMBJfnqpJnGgwLLz6V02BvB6qW
	 cDGql+QDMshC0D3jYGdJfeEJdpq5TudhPQTrHaTbRbfw6bbbY35EukJQcw6gkXeEC2
	 2kcmLssRBYWOlhZBGFbkma70naL1DVICX+IxySBQ/nXH3u50y1iyTEp3Ob4SK6RO+g
	 r1yyUSs3Rs6krjZ8uDugKIOFo7ea6ZtWd7JbPZkHXm0Udn3b3tMPxRtRSep73J5R4d
	 HtxdWm8TJvy2g==
From: Yu Kuai <yukuai@kernel.org>
To: jack@suse.cz,
	dlemoal@kernel.org,
	axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v2] blk-ioc: don't hold queue_lock for ioc_lookup_icq()
Date: Sat, 26 Jul 2025 02:03:34 +0800
Message-ID: <20250725180334.40187-1-yukuai@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

Currently issue io can grab queue_lock three times from bfq_bio_merge(),
bfq_limit_depth() and bfq_prepare_request(), the queue_lock is not
necessary if icq is already created because both queue and ioc can't be
freed before io issuing is done, hence remove the unnecessary queue_lock
and use rcu to protect radix tree lookup.

Noted this is also a prep patch to support request batch dispatching[1].

[1] https://lore.kernel.org/all/20250722072431.610354-1-yukuai1@huaweicloud.com/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
changes from v1:
 - modify ioc_lookup_icq() directly to get rid of queue_lock

 block/bfq-iosched.c | 18 ++----------------
 block/blk-ioc.c     | 10 +++-------
 2 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0cb1e9873aab..f71ec0887733 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -454,17 +454,10 @@ static struct bfq_io_cq *icq_to_bic(struct io_cq *icq)
  */
 static struct bfq_io_cq *bfq_bic_lookup(struct request_queue *q)
 {
-	struct bfq_io_cq *icq;
-	unsigned long flags;
-
 	if (!current->io_context)
 		return NULL;
 
-	spin_lock_irqsave(&q->queue_lock, flags);
-	icq = icq_to_bic(ioc_lookup_icq(q));
-	spin_unlock_irqrestore(&q->queue_lock, flags);
-
-	return icq;
+	return icq_to_bic(ioc_lookup_icq(q));
 }
 
 /*
@@ -2457,15 +2450,8 @@ static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs)
 {
 	struct bfq_data *bfqd = q->elevator->elevator_data;
-	struct request *free = NULL;
-	/*
-	 * bfq_bic_lookup grabs the queue_lock: invoke it now and
-	 * store its return value for later use, to avoid nesting
-	 * queue_lock inside the bfqd->lock. We assume that the bic
-	 * returned by bfq_bic_lookup does not go away before
-	 * bfqd->lock is taken.
-	 */
 	struct bfq_io_cq *bic = bfq_bic_lookup(q);
+	struct request *free = NULL;
 	bool ret;
 
 	spin_lock_irq(&bfqd->lock);
diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index ce82770c72ab..ea9c975aaef7 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -308,19 +308,18 @@ int __copy_io(unsigned long clone_flags, struct task_struct *tsk)
 
 #ifdef CONFIG_BLK_ICQ
 /**
- * ioc_lookup_icq - lookup io_cq from ioc
+ * ioc_lookup_icq - lookup io_cq from ioc in io issue path
  * @q: the associated request_queue
  *
  * Look up io_cq associated with @ioc - @q pair from @ioc.  Must be called
- * with @q->queue_lock held.
+ * from io issue path, either return NULL if current issue io to @q for the
+ * first time, or return a valid icq.
  */
 struct io_cq *ioc_lookup_icq(struct request_queue *q)
 {
 	struct io_context *ioc = current->io_context;
 	struct io_cq *icq;
 
-	lockdep_assert_held(&q->queue_lock);
-
 	/*
 	 * icq's are indexed from @ioc using radix tree and hint pointer,
 	 * both of which are protected with RCU.  All removals are done
@@ -419,10 +418,7 @@ struct io_cq *ioc_find_get_icq(struct request_queue *q)
 		task_unlock(current);
 	} else {
 		get_io_context(ioc);
-
-		spin_lock_irq(&q->queue_lock);
 		icq = ioc_lookup_icq(q);
-		spin_unlock_irq(&q->queue_lock);
 	}
 
 	if (!icq) {
-- 
2.43.0

