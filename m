Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A5218C03F;
	Tue, 29 Jul 2025 02:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756763; cv=none; b=kf0eBZG56L8OiNd/UkYWEEuAQNWEt6W2UA/L+KNor2QVlCqeVpFnYJajkKBZlMy08WamTjqbG4hu2GIuldY8UD+AVKIJRhgltXSjBn8upr3JnT2v9EMbJJBlxp4JiiFPlxGHtwIC586IbgnA+zlVuoCMJvcScj3LrpcIlTLXnhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756763; c=relaxed/simple;
	bh=vMpn0KpO3HW1qG8qAjCLX4pH1r8OTMr7DXuDbJ98nnA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HTTl3zc0eKt0oplHvGOvVwJMZkDPbqyplNWOTW6mw8/HGfOV88V9BsYQgEmLZkVGe15nTqK/fYeRzRlWzhjL9M7JwDDt94Z6tgPMYsN3gP6bcjs9yIf0rLitJ/2olguRMg8DlbXrEqP/KUUP9kBz2Bfa2lMOksOFtlwJYHDpJFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4brfgV3McSzKHMq8;
	Tue, 29 Jul 2025 10:39:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4E6D51A10F2;
	Tue, 29 Jul 2025 10:39:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBn4hJRNIhoi8FZBw--.16996S4;
	Tue, 29 Jul 2025 10:39:15 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	dlemoal@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v3] blk-ioc: don't hold queue_lock for ioc_lookup_icq()
Date: Tue, 29 Jul 2025 10:32:29 +0800
Message-Id: <20250729023229.2944898-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBn4hJRNIhoi8FZBw--.16996S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZF15Jry8JrWkKrW3Xw1kXwb_yoWrJw4xpF
	WaganIyr40gr17urykJ3W7ZF9ag3ZYkr47t39aqw4FkrWvyrnF9F10yFySqFWSvrZ7ArsF
	vF4DKrWkAr1UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Currently issue io can grab queue_lock three times from bfq_bio_merge(),
bfq_limit_depth() and bfq_prepare_request(), the queue_lock is not
necessary if icq is already created because both queue and ioc can't be
freed before io issuing is done, hence remove the unnecessary queue_lock
and use rcu to protect radix tree lookup.

Noted this is also a prep patch to support request batch dispatching[1].

[1] https://lore.kernel.org/all/20250722072431.610354-1-yukuai1@huaweicloud.com/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
changes from v2:
 - update comments;
 - add review tag from Jan and Damien;
changes from v1:
 - modify ioc_lookup_icq() directly to get rid of queue_lock;

 block/bfq-iosched.c | 18 ++----------------
 block/blk-ioc.c     | 16 ++++++----------
 2 files changed, 8 insertions(+), 26 deletions(-)

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
index ce82770c72ab..9fda3906e5f5 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -308,24 +308,23 @@ int __copy_io(unsigned long clone_flags, struct task_struct *tsk)
 
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
-	 * both of which are protected with RCU.  All removals are done
-	 * holding both q and ioc locks, and we're holding q lock - if we
-	 * find a icq which points to us, it's guaranteed to be valid.
+	 * both of which are protected with RCU, io issue path ensures that
+	 * both request_queue and current task are valid, the found icq
+	 * is guaranteed to be valid until the io is done.
 	 */
 	rcu_read_lock();
 	icq = rcu_dereference(ioc->icq_hint);
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
2.39.2

