Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECD63E4C88
	for <linux-block@vger.kernel.org>; Sun, 20 Sep 2026 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789899122; cv=none; b=raaRXURhtNIkaKUu/DqiF9s99y2grj4GzGqaV7S79iW/CBr1vX4E3QCcg2K19Bb/f0aeFNMDUkAf2Fxny7R6/zBe0N8yEFQEkHwi4qcAafFdgEiZomp2MjSbA6DOyopS7Sz8cYZL2cYNgFjq1EB7PVkgDzhc+fb2Q+th8gXd8fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789899122; c=relaxed/simple;
	bh=EfpQVxqo0jdZMKB0pXCMoH8MHUf1ypqHzGvy/Hxilww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ug6CwNVn12FnOzmkBEqA+seD8s3euvwO07bF15KxcI1EKQcEWwrYRRjetcTd2Yq4MVTkBeNTo5rGI5OI6ognyajENvoUKdPlFdbC3+HehurVwi8IUwaQ200lgAPPFd6ZKtTU4eXwZOaEI6Xgs16W3AyJPLBGA6z5jKfif/Jvcaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jDoq/jmH; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jDoq/jmH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=5X
	k1snBG6y5TeksmcyhCaeA9BrfzosIcn8EdOAf5Mvo=; b=jDoq/jmHp9o8otYOgo
	66g9du3TvsYJVcxGVs9OCAVUdsEY2vQGzJSSjo+7XUe1uNcD5+uRuPA7IW/tbOaC
	Pn2fx3Q/A6QuaDBFAwtNLZfJc5kRDxy4pILU6iGVPRRAiqQjb7AgKLOfw1+7ajcb
	pNd2DViVXXi+YusyUj0Mk4oeM=
Received: from ubuntu.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3dchgsa9qvH+FAQ--.48876S4;
	Sun, 20 Sep 2026 18:11:46 +0800 (CST)
From: huhai <15815827059@163.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	shikemeng@huaweicloud.com,
	Henry Hu <huhai@kylinos.cn>
Subject: [PATCH 2/2] blk-mq: fix dispatch waiter accounting for reserved tags
Date: Sun, 20 Sep 2026 18:11:32 +0800
Message-Id: <8c336b911555c02ebd44154b7bd2d5375919b36d.1789890726.git.huhai@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1789890726.git.huhai@kylinos.cn>
References: <cover.1789890726.git.huhai@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgC3dchgsa9qvH+FAQ--.48876S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw15ur43Kry8AFW8Zw1xGrg_yoW7Gw4xpF
	W5Ja1YkaySqF4jqFW7Cw4DAw1j9ws09r9rGr1fKr45CrnYkrn3Xr48Ca4kAFW0yrZ5CFZx
	XrWkGryfCr15XFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2-eOUUUUU=
X-CM-SenderInfo: rprvmiivyslimvzbiqqrwthudrp/xtbCzQILkGqvsWJwsgAA3A

From: Henry Hu <huhai@kylinos.cn>

blk_mq_mark_tag_wait() can queue dispatch_wait on breserved_tags and
increment its ws_active. But blk_mq_dispatch_wake() always decrements
tags->bitmap_tags.ws_active. The reserved counter stays elevated and
bitmap_tags.ws_active gets decremented without a matching increment.
If bitmap_tags.ws_active reaches zero while waiters are still queued,
sbitmap_queue_wake_up() skips their wakeups and dispatch can stall.

Make dispatch_wait a struct sbq_wait that records the sbitmap_queue it
was accounted against. Add it with __sbitmap_add_wait_queue() while
holding the waitqueue lock, and remove it with sbitmap_del_wait_queue()
on both the wakeup and successful allocation retry paths, so the
matching ws_active counter is decremented and the association is
cleared.

Fixes: 98b99e9412d0 ("blk-mq: wait on correct sbitmap_queue in blk_mq_mark_tag_wait")
Assisted-by: LLM
Signed-off-by: Henry Hu <huhai@kylinos.cn>
---
 block/blk-mq.c         | 33 +++++++++++++--------------------
 include/linux/blk-mq.h |  2 +-
 2 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a26a11c73ee3..2e07aad3853a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1863,16 +1863,10 @@ static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
 {
 	struct blk_mq_hw_ctx *hctx;
 
-	hctx = container_of(wait, struct blk_mq_hw_ctx, dispatch_wait);
+	hctx = container_of(wait, struct blk_mq_hw_ctx, dispatch_wait.wait);
 
 	spin_lock(&hctx->dispatch_wait_lock);
-	if (!list_empty(&wait->entry)) {
-		struct sbitmap_queue *sbq;
-
-		list_del_init(&wait->entry);
-		sbq = &hctx->tags->bitmap_tags;
-		atomic_dec(&sbq->ws_active);
-	}
+	sbitmap_del_wait_queue(&hctx->dispatch_wait);
 	spin_unlock(&hctx->dispatch_wait_lock);
 
 	blk_mq_run_hw_queue(hctx, true);
@@ -1889,8 +1883,9 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
 				 struct request *rq)
 {
 	struct sbitmap_queue *sbq;
+	struct sbq_wait_state *ws;
 	struct wait_queue_head *wq;
-	wait_queue_entry_t *wait;
+	struct sbq_wait *wait;
 	bool ret;
 
 	if (!(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED) &&
@@ -1909,26 +1904,25 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
 	}
 
 	wait = &hctx->dispatch_wait;
-	if (!list_empty_careful(&wait->entry))
+	if (!list_empty_careful(&wait->wait.entry))
 		return false;
 
 	if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag))
 		sbq = &hctx->tags->breserved_tags;
 	else
 		sbq = &hctx->tags->bitmap_tags;
-	wq = &bt_wait_ptr(sbq, hctx)->wait;
+	ws = bt_wait_ptr(sbq, hctx);
+	wq = &ws->wait;
 
 	spin_lock_irq(&wq->lock);
 	spin_lock(&hctx->dispatch_wait_lock);
-	if (!list_empty(&wait->entry)) {
+	if (!list_empty(&wait->wait.entry)) {
 		spin_unlock(&hctx->dispatch_wait_lock);
 		spin_unlock_irq(&wq->lock);
 		return false;
 	}
 
-	atomic_inc(&sbq->ws_active);
-	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
-	__add_wait_queue(wq, wait);
+	__sbitmap_add_wait_queue(sbq, ws, wait);
 
 	/*
 	 * Add one explicit barrier since blk_mq_get_driver_tag() may
@@ -1962,8 +1956,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
 	 * We got a tag, remove ourselves from the wait queue to ensure
 	 * someone else gets the wakeup.
 	 */
-	list_del_init(&wait->entry);
-	atomic_dec(&sbq->ws_active);
+	sbitmap_del_wait_queue(wait);
 	spin_unlock(&hctx->dispatch_wait_lock);
 	spin_unlock_irq(&wq->lock);
 
@@ -2197,7 +2190,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 		if (prep == PREP_DISPATCH_NO_BUDGET)
 			needs_resource = true;
 		if (!needs_restart ||
-		    (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
+		    (no_tag && list_empty_careful(&hctx->dispatch_wait.wait.entry)))
 			blk_mq_run_hw_queue(hctx, true);
 		else if (needs_resource)
 			blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
@@ -4058,8 +4051,8 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 	hctx->nr_ctx = 0;
 
 	spin_lock_init(&hctx->dispatch_wait_lock);
-	init_waitqueue_func_entry(&hctx->dispatch_wait, blk_mq_dispatch_wake);
-	INIT_LIST_HEAD(&hctx->dispatch_wait.entry);
+	init_waitqueue_func_entry(&hctx->dispatch_wait.wait, blk_mq_dispatch_wake);
+	INIT_LIST_HEAD(&hctx->dispatch_wait.wait.entry);
 
 	blk_mq_hctx_kobj_init(hctx);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index af878597afb8..7912139bca9f 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -407,7 +407,7 @@ struct blk_mq_hw_ctx {
 	 * @dispatch_wait: Waitqueue to put requests when there is no tag
 	 * available at the moment, to wait for another try in the future.
 	 */
-	wait_queue_entry_t	dispatch_wait;
+	struct sbq_wait		dispatch_wait;
 
 	/**
 	 * @wait_index: Index of next available dispatch_wait queue to insert
-- 
2.40.1

