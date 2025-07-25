Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22138291C36;
	Fri, 25 Jul 2025 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753427547; cv=none; b=h8fKty51fXPAt+JkgwT+FC4uUM4ialXxvRPicgW/3/N6hCNX/K6ufY3s4LkTQAZn5njSyN6gb586xx1LtGAkOrp7+N+DI8wJew22X3o+4KGZd6tw2SDZF6/c9fEkULhAI3HhMfflrWwiAXQkdAe65egAjq/UwHTVE553L2FCA30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753427547; c=relaxed/simple;
	bh=4m21/tOaaQuK9P5OB3BkYbzOAtN//6qSdsCq/Pg9FOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kPTrLYOQgbD/SRlaPj9HLyH3S27GdqgytmsAQuwoW/BI6wzvgGGHR5YvssxTG3ouSxgjZEwdLUtMZm9Apn66oXawotZkJM++3V2fUfH51ZAKnXSNYxMIaOKmJFBUc0hqNh1ad2ZNZxsurBaR1tYNCcPrCchkO1/BEwc4PXuac3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bpJwS4zNNzYQvBW;
	Fri, 25 Jul 2025 15:12:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 63E8A1A0DEA;
	Fri, 25 Jul 2025 15:12:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3QBFRLoNonnivBQ--.56345S7;
	Fri, 25 Jul 2025 15:12:23 +0800 (CST)
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
Subject: [PATCH 3/3] blk-ioc: convert to use ioc_lookup_icq_rcu()
Date: Fri, 25 Jul 2025 15:05:47 +0800
Message-Id: <20250725070547.3953398-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250725070547.3953398-1-yukuai1@huaweicloud.com>
References: <20250725070547.3953398-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3QBFRLoNonnivBQ--.56345S7
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1DAFy5CF1ktr1fCr4rZrb_yoW5Cw45pF
	WagFsIyrW0gr47urykJ3ZrZrn3W3WUCr47tan3tw4Fkr92krnavF10yryIqFyS9rW8AFs0
	qr18KrWDAr18uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUHWlkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Now ioc_lookup_icq() is only called from bfq_prepare_request() from
IO issue path, if it's the first time current issue IO to the disk,
'queue_lock' will be held to creat new icq, otherwise it's safe to
use the new helper. Noted if multiple task share one ioc, and
ioc_create_icq() raced, queue_lock is used to serialize them and only
the first one can succeed inserting icq to ioc.

Also remove ioc_lookup_icq() that is not used now.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-ioc.c | 44 ++++----------------------------------------
 block/blk.h     |  1 -
 2 files changed, 4 insertions(+), 41 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 4945b48dfdb6..27dd65957853 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -307,42 +307,6 @@ int __copy_io(unsigned long clone_flags, struct task_struct *tsk)
 }
 
 #ifdef CONFIG_BLK_ICQ
-/**
- * ioc_lookup_icq - lookup io_cq from ioc
- * @q: the associated request_queue
- *
- * Look up io_cq associated with @ioc - @q pair from @ioc.  Must be called
- * with @q->queue_lock held.
- */
-struct io_cq *ioc_lookup_icq(struct request_queue *q)
-{
-	struct io_context *ioc = current->io_context;
-	struct io_cq *icq;
-
-	lockdep_assert_held(&q->queue_lock);
-
-	/*
-	 * icq's are indexed from @ioc using radix tree and hint pointer,
-	 * both of which are protected with RCU.  All removals are done
-	 * holding both q and ioc locks, and we're holding q lock - if we
-	 * find a icq which points to us, it's guaranteed to be valid.
-	 */
-	rcu_read_lock();
-	icq = rcu_dereference(ioc->icq_hint);
-	if (icq && icq->q == q)
-		goto out;
-
-	icq = radix_tree_lookup(&ioc->icq_tree, q->id);
-	if (icq && icq->q == q)
-		rcu_assign_pointer(ioc->icq_hint, icq);	/* allowed to race */
-	else
-		icq = NULL;
-out:
-	rcu_read_unlock();
-	return icq;
-}
-EXPORT_SYMBOL(ioc_lookup_icq);
-
 /**
  * ioc_lookup_icq_rcu - lookup io_cq from ioc in io path
  * @q: the associated request_queue
@@ -420,7 +384,7 @@ static struct io_cq *ioc_create_icq(struct request_queue *q)
 			et->ops.init_icq(icq);
 	} else {
 		kmem_cache_free(et->icq_cache, icq);
-		icq = ioc_lookup_icq(q);
+		icq = ioc_lookup_icq_rcu(q);
 		if (!icq)
 			printk(KERN_ERR "cfq: icq link failed!\n");
 	}
@@ -454,9 +418,9 @@ struct io_cq *ioc_find_get_icq(struct request_queue *q)
 	} else {
 		get_io_context(ioc);
 
-		spin_lock_irq(&q->queue_lock);
-		icq = ioc_lookup_icq(q);
-		spin_unlock_irq(&q->queue_lock);
+		rcu_read_lock();
+		icq = ioc_lookup_icq_rcu(q);
+		rcu_read_unlock();
 	}
 
 	if (!icq) {
diff --git a/block/blk.h b/block/blk.h
index ef31b3ec1c69..3c078e517d59 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -460,7 +460,6 @@ static inline void req_set_nomerge(struct request_queue *q, struct request *req)
  * Internal io_context interface
  */
 struct io_cq *ioc_find_get_icq(struct request_queue *q);
-struct io_cq *ioc_lookup_icq(struct request_queue *q);
 struct io_cq *ioc_lookup_icq_rcu(struct request_queue *q);
 #ifdef CONFIG_BLK_ICQ
 void ioc_clear_queue(struct request_queue *q);
-- 
2.39.2

