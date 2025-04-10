Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E593270EDD
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291877; cv=none; b=EwLnyw2FSOpEFbU/b/taCZ+QqTUymQ+++OOCIBQMdE75yHqj6mvOe26F8WxhPwv31+KL+5vdM+fksySC7BwGTxtnIBdvP/fbT5CvyVzcvM91EX+hbheepkFCbCsJI5QCBjqPJKB28kOkoDioCffwF6JZk7ngL4/LdbqcfPm9WUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291877; c=relaxed/simple;
	bh=vB94mJlJVNxRktJmKMzj1ehDRWHsgE+mw5WQGHr9uA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSm4H5t2zjnWnuZlYazexWZ4RQPl4tmfXcUDCSAJC16bAOeTImzXnlFqzTADR1M5TnYYk5+R2m7WI+/GLlCLN8LnU1OhD2Wj5zXdDSvHNaEzUqN4ckmSThSRM61QrdWXBC9o8pDC/fftkuVTbXR4nW5mYrxP4VjJ021+HchMG/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X4MiWT5V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4MiWT5V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744291874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E6agpd/d3D4wyti/Vo36daRc/khYWwqjQIgEm97GzwE=;
	b=X4MiWT5ViPYV1lGXTuVK1DiryvGlNdR4WMlfn+BvOSj4LWGG9/oJgmqU7LGdOeVBRJwpH7
	WqcHzdqin6z3qLCjgRDYb2wwmXhHA82rINZsNj0JwVoxaY6rM5R4NOIu1jfDjQj+nuLBCV
	JSNdCRWSY2py0SRmJp9JH/VYv8zTqqg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-WjOQ-DTqOBuhgbuBkSfreQ-1; Thu,
 10 Apr 2025 09:31:10 -0400
X-MC-Unique: WjOQ-DTqOBuhgbuBkSfreQ-1
X-Mimecast-MFC-AGG-ID: WjOQ-DTqOBuhgbuBkSfreQ_1744291869
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 405DD1954B32;
	Thu, 10 Apr 2025 13:31:09 +0000 (UTC)
Received: from localhost (unknown [10.72.120.20])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F8901808882;
	Thu, 10 Apr 2025 13:31:07 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 04/15] block: prevent elevator switch during updating nr_hw_queues
Date: Thu, 10 Apr 2025 21:30:16 +0800
Message-ID: <20250410133029.2487054-5-ming.lei@redhat.com>
In-Reply-To: <20250410133029.2487054-1-ming.lei@redhat.com>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

updating nr_hw_queues is usually used for error handling code, when it
doesn't make sense to allow blk-mq elevator switching, since nr_hw_queues
may change, and elevator tags depends on nr_hw_queues.

Prevent elevator switch during updating nr_hw_queues by setting flag of
BLK_MQ_F_UPDATE_HW_QUEUES, and use srcu to fail elevator switch during
the period. Here elevator switch code is srcu reader of nr_hw_queues,
and blk_mq_update_nr_hw_queues() is the writer.

This way avoids lot of trouble.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/linux-block/mz4t4tlwiqjijw3zvqnjb7ovvvaegkqganegmmlc567tt5xj67@xal5ro544cnc/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c |  1 +
 block/blk-mq.c         | 19 ++++++++++++++++++-
 block/elevator.c       | 12 +++++++++++-
 include/linux/blk-mq.h | 10 +++++++++-
 4 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index c308699ded58..27f984311bb7 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -180,6 +180,7 @@ static const char *const hctx_flag_name[] = {
 	HCTX_FLAG_NAME(BLOCKING),
 	HCTX_FLAG_NAME(TAG_RR),
 	HCTX_FLAG_NAME(NO_SCHED_BY_DEFAULT),
+	HCTX_FLAG_NAME(UPDATE_HW_QUEUES),
 };
 #undef HCTX_FLAG_NAME
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d7a103dc258b..4b0707fb7ae3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4785,12 +4785,16 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 			goto out_free_srcu;
 	}
 
+	ret = init_srcu_struct(&set->update_nr_hwq_srcu);
+	if (ret)
+		goto out_cleanup_srcu;
+
 	ret = -ENOMEM;
 	set->tags = kcalloc_node(set->nr_hw_queues,
 				 sizeof(struct blk_mq_tags *), GFP_KERNEL,
 				 set->numa_node);
 	if (!set->tags)
-		goto out_cleanup_srcu;
+		goto out_cleanup_hwq_srcu;
 
 	for (i = 0; i < set->nr_maps; i++) {
 		set->map[i].mq_map = kcalloc_node(nr_cpu_ids,
@@ -4819,6 +4823,8 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	}
 	kfree(set->tags);
 	set->tags = NULL;
+out_cleanup_hwq_srcu:
+	cleanup_srcu_struct(&set->update_nr_hwq_srcu);
 out_cleanup_srcu:
 	if (set->flags & BLK_MQ_F_BLOCKING)
 		cleanup_srcu_struct(set->srcu);
@@ -5081,7 +5087,18 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
 {
 	mutex_lock(&set->tag_list_lock);
+	/*
+	 * Mark us in updating nr_hw_queues for preventing switching
+	 * elevator
+	 *
+	 * Elevator switch code can _not_ acquire ->tag_list_lock
+	 */
+	set->flags |= BLK_MQ_F_UPDATE_HW_QUEUES;
+	synchronize_srcu(&set->update_nr_hwq_srcu);
+
 	__blk_mq_update_nr_hw_queues(set, nr_hw_queues);
+
+	set->flags &= BLK_MQ_F_UPDATE_HW_QUEUES;
 	mutex_unlock(&set->tag_list_lock);
 }
 EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
diff --git a/block/elevator.c b/block/elevator.c
index cf48613c6e62..7d7b77dd4341 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -718,9 +718,10 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 {
 	char elevator_name[ELV_NAME_MAX];
 	char *name;
-	int ret;
+	int ret, idx;
 	unsigned int memflags;
 	struct request_queue *q = disk->queue;
+	struct blk_mq_tag_set *set = q->tag_set;
 
 	/*
 	 * If the attribute needs to load a module, do it before freezing the
@@ -732,6 +733,13 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 
 	elv_iosched_load_module(name);
 
+	idx = srcu_read_lock(&set->update_nr_hwq_srcu);
+
+	if (set->flags & BLK_MQ_F_UPDATE_HW_QUEUES) {
+		ret = -EBUSY;
+		goto exit;
+	}
+
 	memflags = blk_mq_freeze_queue(q);
 	mutex_lock(&q->elevator_lock);
 	ret = elevator_change(q, name);
@@ -739,6 +747,8 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 		ret = count;
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
+exit:
+	srcu_read_unlock(&set->update_nr_hwq_srcu, idx);
 	return ret;
 }
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8eb9b3310167..473871c760e1 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -527,6 +527,7 @@ struct blk_mq_tag_set {
 	struct mutex		tag_list_lock;
 	struct list_head	tag_list;
 	struct srcu_struct	*srcu;
+	struct srcu_struct	update_nr_hwq_srcu;
 };
 
 /**
@@ -681,7 +682,14 @@ enum {
 	 */
 	BLK_MQ_F_NO_SCHED_BY_DEFAULT	= 1 << 6,
 
-	BLK_MQ_F_MAX = 1 << 7,
+	/*
+	 * True when updating nr_hw_queues is in-progress
+	 *
+	 * tag_set only flag, not usable for hctx
+	 */
+	BLK_MQ_F_UPDATE_HW_QUEUES	= 1 << 7,
+
+	BLK_MQ_F_MAX = 1 << 8,
 };
 
 #define BLK_MQ_MAX_DEPTH	(10240)
-- 
2.47.0

