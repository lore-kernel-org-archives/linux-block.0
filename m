Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AB05B1FB
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732715533; cv=none; b=UkuyUDeQluiwf2GEpfpOx7/6xsEhLaiafSHcn5a5OHsT8DCsdo83lQeZUXfmWKzBlWrQuadxqqswttgueq15kv+ddFQDNzTGJW9dmdC8gituvSyB4wv+xtd6c/2epUWZ8XJTMW3gLLxVatfn4EOpFPJMVOetQsQuREoXcEuEgcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732715533; c=relaxed/simple;
	bh=2gDZpy7pWCMsgEItcIkPARbKqddwJ0iWoG09xM+5mSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeucS72oVwX+W0wHGvMUTfeiR69qZwEB2OImabsFyyWlfVpJKTMg++2cHRX4cOOILvRv1Squ3AxQOi4kUtxFYI8Ri+JM1SMSX9kz64Plk+MP+DO+25k5Clknx/ldddmj4YHROakwtZI8f0LMtcY9w5PGerxjWUakdGyCyji+0d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q6lqwS1Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6lqwS1Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732715531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hz4uUJmw/03lEHj/i3sHrjAmVPH/g/kaUqFUUkPzl5U=;
	b=Q6lqwS1ZjdD28yiyxyQaEmoARExi3UwdMcaBiLj2TZHjBMZO0cokV24SFpviMMLr34a0tk
	T+2IaNuLCJlToC2umdqHN+P8RzIVqFC67ENA7EJT4wtInXffb1rXCPQxDDGKOSu9n12DXv
	1e3opzQjI0FWYZJ3Ok+A0aNQuU/5VgY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-erFtJjA-Mamge56JJz5Q9A-1; Wed,
 27 Nov 2024 08:52:09 -0500
X-MC-Unique: erFtJjA-Mamge56JJz5Q9A-1
X-Mimecast-MFC-AGG-ID: erFtJjA-Mamge56JJz5Q9A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D904C19560B4;
	Wed, 27 Nov 2024 13:52:08 +0000 (UTC)
Received: from localhost (unknown [10.72.116.17])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AF9511955F40;
	Wed, 27 Nov 2024 13:52:06 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/4] block: track queue dying state automatically for modeling queue freeze lockdep
Date: Wed, 27 Nov 2024 21:51:30 +0800
Message-ID: <20241127135133.3952153-5-ming.lei@redhat.com>
In-Reply-To: <20241127135133.3952153-1-ming.lei@redhat.com>
References: <20241127135133.3952153-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Now we only verify the outmost freeze & unfreeze in current context in case
that !q->mq_freeze_depth, so it is reliable to save queue lying state when
we want to lock the freeze queue since the state is one per-task variable
now.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         |  5 +++--
 block/blk.h            | 12 ++++++------
 block/genhd.c          |  7 +++----
 include/linux/blkdev.h |  6 +++++-
 4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 32b398d0c598..1f9c943175ef 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -133,6 +133,7 @@ static bool blk_freeze_set_owner(struct request_queue *q,
 		q->mq_freeze_disk_dead = !q->disk ||
 			test_bit(GD_DEAD, &q->disk->state) ||
 			!blk_queue_registered(q);
+		q->mq_freeze_queue_dying = blk_queue_dying(q);
 		return true;
 	}
 
@@ -189,7 +190,7 @@ bool __blk_freeze_queue_start(struct request_queue *q,
 void blk_freeze_queue_start(struct request_queue *q)
 {
 	if (__blk_freeze_queue_start(q, current))
-		blk_freeze_acquire_lock(q, false);
+		blk_freeze_acquire_lock(q);
 }
 EXPORT_SYMBOL_GPL(blk_freeze_queue_start);
 
@@ -237,7 +238,7 @@ bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 void blk_mq_unfreeze_queue(struct request_queue *q)
 {
 	if (__blk_mq_unfreeze_queue(q, false))
-		blk_unfreeze_release_lock(q, false);
+		blk_unfreeze_release_lock(q);
 }
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
 
diff --git a/block/blk.h b/block/blk.h
index 8708168d50e4..cbf6a676ffe9 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -721,26 +721,26 @@ void blk_integrity_prepare(struct request *rq);
 void blk_integrity_complete(struct request *rq, unsigned int nr_bytes);
 
 #ifdef CONFIG_LOCKDEP
-static inline void blk_freeze_acquire_lock(struct request_queue *q, bool queue_dying)
+static inline void blk_freeze_acquire_lock(struct request_queue *q)
 {
 	if (!q->mq_freeze_disk_dead)
 		rwsem_acquire(&q->io_lockdep_map, 0, 1, _RET_IP_);
-	if (!queue_dying)
+	if (!q->mq_freeze_queue_dying)
 		rwsem_acquire(&q->q_lockdep_map, 0, 1, _RET_IP_);
 }
 
-static inline void blk_unfreeze_release_lock(struct request_queue *q, bool queue_dying)
+static inline void blk_unfreeze_release_lock(struct request_queue *q)
 {
-	if (!queue_dying)
+	if (!q->mq_freeze_queue_dying)
 		rwsem_release(&q->q_lockdep_map, _RET_IP_);
 	if (!q->mq_freeze_disk_dead)
 		rwsem_release(&q->io_lockdep_map, _RET_IP_);
 }
 #else
-static inline void blk_freeze_acquire_lock(struct request_queue *q, bool queue_dying)
+static inline void blk_freeze_acquire_lock(struct request_queue *q)
 {
 }
-static inline void blk_unfreeze_release_lock(struct request_queue *q, bool queue_dying)
+static inline void blk_unfreeze_release_lock(struct request_queue *q)
 {
 }
 #endif
diff --git a/block/genhd.c b/block/genhd.c
index fa4183cfb436..be65aa158bad 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -661,7 +661,7 @@ void del_gendisk(struct gendisk *disk)
 	struct request_queue *q = disk->queue;
 	struct block_device *part;
 	unsigned long idx;
-	bool start_drain, queue_dying;
+	bool start_drain;
 
 	might_sleep();
 
@@ -690,9 +690,8 @@ void del_gendisk(struct gendisk *disk)
 	 */
 	mutex_lock(&disk->open_mutex);
 	start_drain = __blk_mark_disk_dead(disk);
-	queue_dying = blk_queue_dying(q);
 	if (start_drain)
-		blk_freeze_acquire_lock(q, queue_dying);
+		blk_freeze_acquire_lock(q);
 	xa_for_each_start(&disk->part_tbl, idx, part, 1)
 		drop_partition(part);
 	mutex_unlock(&disk->open_mutex);
@@ -751,7 +750,7 @@ void del_gendisk(struct gendisk *disk)
 	}
 
 	if (start_drain)
-		blk_unfreeze_release_lock(q, queue_dying);
+		blk_unfreeze_release_lock(q);
 }
 EXPORT_SYMBOL(del_gendisk);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5f7fe8070a53..a698731c1432 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -579,8 +579,12 @@ struct request_queue {
 #ifdef CONFIG_LOCKDEP
 	struct task_struct	*mq_freeze_owner;
 	int			mq_freeze_owner_depth;
-	/* Records disk state in current context, used in unfreeze queue */
+	/*
+	 * Records disk & queue state in current context, used in unfreeze
+	 * queue
+	 */
 	bool			mq_freeze_disk_dead;
+	bool			mq_freeze_queue_dying;
 #endif
 	wait_queue_head_t	mq_freeze_wq;
 	/*
-- 
2.47.0

