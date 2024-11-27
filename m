Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08491FCF6B
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732715527; cv=none; b=RvR1DgafjUlkBUMq+Md1cuL2xa9S17NI5b7vspRJuMz2JItM9sZArIM+1iyo8G+ZKLVdCO4wLCCWBgyJLzvzud5sy5NHWxsIU0i5E9GM1VBQnAu0NhvRPEA7qM+UMRmzeIvqOPPFScTmUzwQ7SuqOTmT4q3FWBrGRO2DR1i+GQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732715527; c=relaxed/simple;
	bh=YKn8Pg+DVWjot8nxBrQdCUiyg8WTb7SmNOZsmI++gEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iuh7sjCCqDUoEPZl9jB5vDqfZsdKfLjx4nkWNnw+eMtMDXLiHeqTPRXV4CTNjpv9hgSuF7TPSufXLpysRzxgFasn32d+m0X7ANV254sJr3fBNU9zQDwr5KmGJRT6+I+bIzjGWlz5CDuBs027faKEDfY5yMC2wiUbVsbgwFsG4zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vek82FN9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vek82FN9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732715521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2myeemWryBWwLlqDnr+04RCfp4N8hMA7PkwIJaeJLdw=;
	b=Vek82FN94KDLfYelqUWdXLv/Nj/VW5QNiMc1zPuNLqm16Gq3ivOt1BDmglIr4H2Pl9C/JS
	OH8/Bx1bMyD7kw7yozE6KimjZ9qD/RoFLW6H8LjZKbBKbdY4dB6DnrnAt9nCMGaGx/nSUp
	SvzQA4wwj0CFtgQtdn2eGKAtLP/PBxo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-VOLDmMmXOsykkEM4kqgxdQ-1; Wed,
 27 Nov 2024 08:51:58 -0500
X-MC-Unique: VOLDmMmXOsykkEM4kqgxdQ-1
X-Mimecast-MFC-AGG-ID: VOLDmMmXOsykkEM4kqgxdQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29C8919560A6;
	Wed, 27 Nov 2024 13:51:57 +0000 (UTC)
Received: from localhost (unknown [10.72.116.17])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD953196BC17;
	Wed, 27 Nov 2024 13:51:54 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/4] block: track disk DEAD state automatically for modeling queue freeze lockdep
Date: Wed, 27 Nov 2024 21:51:28 +0800
Message-ID: <20241127135133.3952153-3-ming.lei@redhat.com>
In-Reply-To: <20241127135133.3952153-1-ming.lei@redhat.com>
References: <20241127135133.3952153-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Now we only verify the outmost freeze & unfreeze in current context in case
that !q->mq_freeze_depth, so it is reliable to save disk DEAD state when
we want to lock the freeze queue since the state is one per-task variable
now.

Doing this way can kill lots of false positive when freeze queue is
called before adding disk[1].

[1] https://lore.kernel.org/linux-block/6741f6b2.050a0220.1cc393.0017.GAE@google.com/

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         |  7 +++++--
 block/blk.h            | 19 +++++++++++++------
 block/elevator.c       |  4 ++--
 block/genhd.c          |  4 ++--
 include/linux/blkdev.h |  2 ++
 5 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6af56b0e8ffd..32b398d0c598 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -130,6 +130,9 @@ static bool blk_freeze_set_owner(struct request_queue *q,
 	if (!q->mq_freeze_depth) {
 		q->mq_freeze_owner = owner;
 		q->mq_freeze_owner_depth = 1;
+		q->mq_freeze_disk_dead = !q->disk ||
+			test_bit(GD_DEAD, &q->disk->state) ||
+			!blk_queue_registered(q);
 		return true;
 	}
 
@@ -186,7 +189,7 @@ bool __blk_freeze_queue_start(struct request_queue *q,
 void blk_freeze_queue_start(struct request_queue *q)
 {
 	if (__blk_freeze_queue_start(q, current))
-		blk_freeze_acquire_lock(q, false, false);
+		blk_freeze_acquire_lock(q, false);
 }
 EXPORT_SYMBOL_GPL(blk_freeze_queue_start);
 
@@ -234,7 +237,7 @@ bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 void blk_mq_unfreeze_queue(struct request_queue *q)
 {
 	if (__blk_mq_unfreeze_queue(q, false))
-		blk_unfreeze_release_lock(q, false, false);
+		blk_unfreeze_release_lock(q, false);
 }
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
 
diff --git a/block/blk.h b/block/blk.h
index 2c26abf505b8..8708168d50e4 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -720,22 +720,29 @@ void blk_integrity_verify(struct bio *bio);
 void blk_integrity_prepare(struct request *rq);
 void blk_integrity_complete(struct request *rq, unsigned int nr_bytes);
 
-static inline void blk_freeze_acquire_lock(struct request_queue *q, bool
-		disk_dead, bool queue_dying)
+#ifdef CONFIG_LOCKDEP
+static inline void blk_freeze_acquire_lock(struct request_queue *q, bool queue_dying)
 {
-	if (!disk_dead)
+	if (!q->mq_freeze_disk_dead)
 		rwsem_acquire(&q->io_lockdep_map, 0, 1, _RET_IP_);
 	if (!queue_dying)
 		rwsem_acquire(&q->q_lockdep_map, 0, 1, _RET_IP_);
 }
 
-static inline void blk_unfreeze_release_lock(struct request_queue *q, bool
-		disk_dead, bool queue_dying)
+static inline void blk_unfreeze_release_lock(struct request_queue *q, bool queue_dying)
 {
 	if (!queue_dying)
 		rwsem_release(&q->q_lockdep_map, _RET_IP_);
-	if (!disk_dead)
+	if (!q->mq_freeze_disk_dead)
 		rwsem_release(&q->io_lockdep_map, _RET_IP_);
 }
+#else
+static inline void blk_freeze_acquire_lock(struct request_queue *q, bool queue_dying)
+{
+}
+static inline void blk_unfreeze_release_lock(struct request_queue *q, bool queue_dying)
+{
+}
+#endif
 
 #endif /* BLK_INTERNAL_H */
diff --git a/block/elevator.c b/block/elevator.c
index 7c3ba80e5ff4..ca0a74369f1c 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -602,14 +602,14 @@ void elevator_init_mq(struct request_queue *q)
 	 * Disk isn't added yet, so verifying queue lock only manually.
 	 */
 	blk_freeze_queue_start_non_owner(q);
-	blk_freeze_acquire_lock(q, true, false);
+	blk_freeze_acquire_lock(q, false);
 	blk_mq_freeze_queue_wait(q);
 
 	blk_mq_cancel_work_sync(q);
 
 	err = blk_mq_init_sched(q, e);
 
-	blk_unfreeze_release_lock(q, true, false);
+	blk_unfreeze_release_lock(q, false);
 	blk_mq_unfreeze_queue_non_owner(q);
 
 	if (err) {
diff --git a/block/genhd.c b/block/genhd.c
index 9130e163e191..fa4183cfb436 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -692,7 +692,7 @@ void del_gendisk(struct gendisk *disk)
 	start_drain = __blk_mark_disk_dead(disk);
 	queue_dying = blk_queue_dying(q);
 	if (start_drain)
-		blk_freeze_acquire_lock(q, true, queue_dying);
+		blk_freeze_acquire_lock(q, queue_dying);
 	xa_for_each_start(&disk->part_tbl, idx, part, 1)
 		drop_partition(part);
 	mutex_unlock(&disk->open_mutex);
@@ -751,7 +751,7 @@ void del_gendisk(struct gendisk *disk)
 	}
 
 	if (start_drain)
-		blk_unfreeze_release_lock(q, true, queue_dying);
+		blk_unfreeze_release_lock(q, queue_dying);
 }
 EXPORT_SYMBOL(del_gendisk);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a1fd0ddce5cf..5f7fe8070a53 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -579,6 +579,8 @@ struct request_queue {
 #ifdef CONFIG_LOCKDEP
 	struct task_struct	*mq_freeze_owner;
 	int			mq_freeze_owner_depth;
+	/* Records disk state in current context, used in unfreeze queue */
+	bool			mq_freeze_disk_dead;
 #endif
 	wait_queue_head_t	mq_freeze_wq;
 	/*
-- 
2.47.0

