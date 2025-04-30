Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41246AD3
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 04:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745987816; cv=none; b=bkdf+CdEz7qB/Z7W94lr+Ppbju1VWLR7jlXNXRi8JLaoArrP6b55icEp94mFJwQxX32h+wwquVvVU+oefIE/NVdv3+KgP5PTdYoh7whtuwcvTdAVtiZ+DGCfT5fpXGzLspB9blurttPiIS8KzMA3j0Ve7y6YsXrhX5GTkZPAtLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745987816; c=relaxed/simple;
	bh=lLp/zvCSF3z8mKV/vGt/lEgTcp5rtC5qH5G4Y45nj8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbqNwK8NvuYPuq09tQQj2kBxQ+ka6lk6mobi36Rd6d/zGGqxTb06qdQzYMy+7FkBzMVRMuLBbBC9tZNjEBG4+lYRltmMvEPlesxqDRiOJkQbiOdmoDiJRGvzrPZ3AS/a9k2U+EGaUEwsIuxSHkQzCbTQeOG5LfxBklsitK4/8JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5qXwyGM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5qXwyGM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745987814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uW1xJyGNL9QmmsmxIVPgMBVHL+60OC6//Qctal1wdq0=;
	b=G5qXwyGMFce1+dv8Yb3qW37zuqbRrUBGtml2aMBjyc2ulpX5kvXXIKQxrGGPAYwgq8yCxi
	CevIaRnFv7ZvnnF2x48MJfGiMZLW5iygatfP0fMVIHt+oKAHN1g7cSUXOAziKpJpqOr8nw
	Q8bO+KHMXBMjBtQqH+/AuLqD6sf/Y0w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-fRBPCwg4Pk2HK-ExXBCaIg-1; Wed,
 30 Apr 2025 00:36:49 -0400
X-MC-Unique: fRBPCwg4Pk2HK-ExXBCaIg-1
X-Mimecast-MFC-AGG-ID: fRBPCwg4Pk2HK-ExXBCaIg_1745987808
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 919771956095;
	Wed, 30 Apr 2025 04:36:48 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 91CB730001A2;
	Wed, 30 Apr 2025 04:36:47 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 19/24] block: add new helper for disabling elevator switch when deleting disk
Date: Wed, 30 Apr 2025 12:35:21 +0800
Message-ID: <20250430043529.1950194-20-ming.lei@redhat.com>
In-Reply-To: <20250430043529.1950194-1-ming.lei@redhat.com>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add new helper disable_elv_switch() and new flag QUEUE_FLAG_NO_ELV_SWITCH
for disabling elevator switch before deleting disk:

- originally flag QUEUE_FLAG_REGISTERED is added for preventing elevator
switch during removing disk, but this flag has been used widely for
other purposes, so add one new flag for disabling elevator switch only

- for avoiding deadlock risk, we have to move elevator queue
register/unregister out of elevator lock and queue freeze, which will be
done in next patch. However, this way adds small race window between elevator
switch and deleting ->queue_kobj, in which elevator queue register/unregister
could be run concurrently. The added helper will be used for avoiding the race
in the following patch.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c |  1 +
 block/elevator.c       |  5 ++++-
 block/genhd.c          | 12 ++++++++++++
 include/linux/blkdev.h |  3 +++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 2837a8ce8054..29b3540dd180 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -94,6 +94,7 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(HCTX_ACTIVE),
 	QUEUE_FLAG_NAME(SQ_SCHED),
 	QUEUE_FLAG_NAME(DISABLE_WBT_DEF),
+	QUEUE_FLAG_NAME(NO_ELV_SWITCH),
 };
 #undef QUEUE_FLAG_NAME
 
diff --git a/block/elevator.c b/block/elevator.c
index fd0bcf22aaee..98a754f58de5 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -680,6 +680,9 @@ void elevator_set_default(struct request_queue *q)
 	};
 	int err = 0;
 
+	/* now we allow to switch elevator */
+	blk_queue_flag_clear(QUEUE_FLAG_NO_ELV_SWITCH, q);
+
 	if (q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
 		return;
 
@@ -730,7 +733,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	struct blk_mq_tag_set *set = q->tag_set;
 
 	/* Make sure queue is not in the middle of being removed */
-	if (!blk_queue_registered(q))
+	if (!blk_queue_registered(q) || blk_queue_no_elv_switch(q))
 		return -ENOENT;
 
 	/*
diff --git a/block/genhd.c b/block/genhd.c
index 0c34cc1a4eae..0e64e7400fb4 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -749,6 +749,15 @@ static void __del_gendisk(struct gendisk *disk)
 		blk_unfreeze_release_lock(q);
 }
 
+static void disable_elv_switch(struct request_queue *q)
+{
+	WARN_ON_ONCE(!queue_is_mq(q));
+
+	mutex_lock(&q->elevator_lock);
+	blk_queue_flag_set(QUEUE_FLAG_NO_ELV_SWITCH, q);
+	mutex_unlock(&q->elevator_lock);
+}
+
 /**
  * del_gendisk - remove the gendisk
  * @disk: the struct gendisk to remove
@@ -777,6 +786,9 @@ void del_gendisk(struct gendisk *disk)
 		__del_gendisk(disk);
 	} else {
 		set = disk->queue->tag_set;
+
+		disable_elv_switch(disk->queue);
+
 		memflags = memalloc_noio_save();
 		down_read(&set->update_nr_hwq_lock);
 		__del_gendisk(disk);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9c373cf0eb47..b15c53fabe9f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -645,6 +645,7 @@ enum {
 	QUEUE_FLAG_HCTX_ACTIVE,		/* at least one blk-mq hctx is active */
 	QUEUE_FLAG_SQ_SCHED,		/* single queue style io dispatch */
 	QUEUE_FLAG_DISABLE_WBT_DEF,	/* for sched to disable/enable wbt */
+	QUEUE_FLAG_NO_ELV_SWITCH,	/* can't switch elevator any more */
 	QUEUE_FLAG_MAX
 };
 
@@ -682,6 +683,8 @@ void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
 	((q)->limits.features & BLK_FEAT_SKIP_TAGSET_QUIESCE)
 #define blk_queue_disable_wbt(q)	\
 	test_bit(QUEUE_FLAG_DISABLE_WBT_DEF, &(q)->queue_flags)
+#define blk_queue_no_elv_switch(q)	\
+	test_bit(QUEUE_FLAG_NO_ELV_SWITCH, &(q)->queue_flags)
 
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
-- 
2.47.0

