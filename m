Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DF41DF75D
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508203; cv=none; b=EcvnbTOgxOx+P7SOreJmEkSr7MzPOEs2Vkf2/HqCDAoSubM9cYOMWKAqxSdSpbNFMMGTXW4pS408qIVeRCRS/Rk935QLT+WcDNbwcf1lk9FzFpVwNJ7YUVj7ATrjIqNS0KBGDxGgPqz79bFhY3QvVtXwagNrJvmOpw7SDFlxp2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508203; c=relaxed/simple;
	bh=CdQ2VssGJBG6l2mHIOI8JtRiHjuL3OPGUlfwLpsa28U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSjNi+cRYzeqxnCJtElHt8lfPWW5A30zTDt4fn9Iz8vfjrsY+KfDjwMnaLQcBWIl+fL3RkV+pRreaC2aL8ecAN0pV4qBCOotnV8rYuVj/VmKCyv8VuMCcTjtocwYO/JAvl8xvxBMcCdEMKkc1pEPyBY88xsXkmIBeVHFbsUNdfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BQrwM4VC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQrwM4VC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745508200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=37CnyDU3q9aG+5f5YH+duQgJEgHs+rA6GNO8gKYkyU0=;
	b=BQrwM4VCjhyJ6d/iodMs+/c5U6zyxjKkc3GaoWlKyYWTAkotBzlGMssn5KGCeHtGHW9JDg
	mkW53EWfYaQYFsxVjFbP17c645POXp5hzJBmY4pGcxdwOLrzp2qokWwjP3r2yRXIwweqih
	oTtsJtx5VwOJ3Dvna2a1eze+ZdvXHqo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-gEx688iDNqi2EbwEzhJ1rg-1; Thu,
 24 Apr 2025 11:23:15 -0400
X-MC-Unique: gEx688iDNqi2EbwEzhJ1rg-1
X-Mimecast-MFC-AGG-ID: gEx688iDNqi2EbwEzhJ1rg_1745508194
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D64E19560BB;
	Thu, 24 Apr 2025 15:23:14 +0000 (UTC)
Received: from localhost (unknown [10.72.116.90])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E3B719560A3;
	Thu, 24 Apr 2025 15:23:12 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 20/20] block: move wbt_enable_default() out of queue freezing from sched ->exit()
Date: Thu, 24 Apr 2025 23:21:43 +0800
Message-ID: <20250424152148.1066220-21-ming.lei@redhat.com>
In-Reply-To: <20250424152148.1066220-1-ming.lei@redhat.com>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

scheduler's ->exit() is called with queue frozen and elevator lock is held, and
wbt_enable_default() can't be called with queue frozen, otherwise the
following lockdep warning is triggered:

	#6 (&q->rq_qos_mutex){+.+.}-{4:4}:
	#5 (&eq->sysfs_lock){+.+.}-{4:4}:
	#4 (&q->elevator_lock){+.+.}-{4:4}:
	#3 (&q->q_usage_counter(io)#3){++++}-{0:0}:
	#2 (fs_reclaim){+.+.}-{0:0}:
	#1 (&sb->s_type->i_mutex_key#3){+.+.}-{4:4}:
	#0 (&q->debugfs_mutex){+.+.}-{4:4}:

Fix the issue by moving wbt_enable_default() out of bfq's exit(), and
call it from elevator_change_done().

Meantime add disk->rqos_state_mutex for covering wbt state change, which
matches the purpose more than ->elevator_lock.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bfq-iosched.c    |  2 +-
 block/blk-sysfs.c      |  6 ++----
 block/blk-wbt.c        | 10 ++++++++--
 block/elevator.c       |  5 +++++
 block/elevator.h       |  1 +
 block/genhd.c          |  1 +
 include/linux/blkdev.h |  2 ++
 7 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index cc6f59836dcd..0cb1e9873aab 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7211,7 +7211,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
 
 	blk_stat_disable_accounting(bfqd->queue);
 	blk_queue_flag_clear(QUEUE_FLAG_DISABLE_WBT_DEF, bfqd->queue);
-	wbt_enable_default(bfqd->queue->disk);
+	set_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT, &e->flags);
 
 	kfree(bfqd);
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 9aa05666f32a..fafe9e9e97cc 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -593,7 +593,7 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 		return -EINVAL;
 
 	memflags = blk_mq_freeze_queue(q);
-	mutex_lock(&q->elevator_lock);
+	mutex_lock(&disk->rqos_state_mutex);
 
 	rqos = wbt_rq_qos(q);
 	if (!rqos) {
@@ -622,7 +622,7 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 
 	blk_mq_unquiesce_queue(q);
 out:
-	mutex_unlock(&q->elevator_lock);
+	mutex_unlock(&disk->rqos_state_mutex);
 	blk_mq_unfreeze_queue(q, memflags);
 
 	return ret;
@@ -870,9 +870,7 @@ int blk_register_queue(struct gendisk *disk)
 		goto out_unregister_ia_ranges;
 
 	elevator_set_default(q);
-	mutex_lock(&q->elevator_lock);
 	wbt_enable_default(disk);
-	mutex_unlock(&q->elevator_lock);
 
 	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
 
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 29cd2e33666f..c8588bae1c1b 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -704,6 +704,8 @@ void wbt_enable_default(struct gendisk *disk)
 	struct rq_qos *rqos;
 	bool enable = IS_ENABLED(CONFIG_BLK_WBT_MQ);
 
+	mutex_lock(&disk->rqos_state_mutex);
+
 	if (blk_queue_disable_wbt(q))
 		enable = false;
 
@@ -712,15 +714,17 @@ void wbt_enable_default(struct gendisk *disk)
 	if (rqos) {
 		if (enable && RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
 			RQWB(rqos)->enable_state = WBT_STATE_ON_DEFAULT;
-		return;
+		goto unlock;
 	}
 
 	/* Queue not registered? Maybe shutting down... */
 	if (!blk_queue_registered(q))
-		return;
+		goto unlock;
 
 	if (queue_is_mq(q) && enable)
 		wbt_init(disk);
+unlock:
+	mutex_unlock(&disk->rqos_state_mutex);
 }
 EXPORT_SYMBOL_GPL(wbt_enable_default);
 
@@ -773,11 +777,13 @@ void wbt_disable_default(struct gendisk *disk)
 	struct rq_wb *rwb;
 	if (!rqos)
 		return;
+	mutex_lock(&disk->rqos_state_mutex);
 	rwb = RQWB(rqos);
 	if (rwb->enable_state == WBT_STATE_ON_DEFAULT) {
 		blk_stat_deactivate(rwb->cb);
 		rwb->enable_state = WBT_STATE_OFF_DEFAULT;
 	}
+	mutex_unlock(&disk->rqos_state_mutex);
 }
 EXPORT_SYMBOL_GPL(wbt_disable_default);
 
diff --git a/block/elevator.c b/block/elevator.c
index aec8081a6be3..a637426da56d 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -663,8 +663,13 @@ static int elevator_change_done(struct request_queue *q,
 	int ret = 0;
 
 	if (ctx->old) {
+		bool enable_wbt = test_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT,
+				&ctx->old->flags);
+
 		elv_unregister_queue(q, ctx->old);
 		kobject_put(&ctx->old->kobj);
+		if (enable_wbt)
+			wbt_enable_default(q->disk);
 	}
 	if (ctx->new) {
 		ret = elv_register_queue(q, ctx->new, ctx->uevent);
diff --git a/block/elevator.h b/block/elevator.h
index 76a90a1b7ed6..a07ce773a38f 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -122,6 +122,7 @@ struct elevator_queue
 
 #define ELEVATOR_FLAG_REGISTERED	0
 #define ELEVATOR_FLAG_DYING		1
+#define ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT	2
 
 /*
  * block elevator interface
diff --git a/block/genhd.c b/block/genhd.c
index a50063c4c40f..e13be309552a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1452,6 +1452,7 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 #ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
 	INIT_LIST_HEAD(&disk->slave_bdevs);
 #endif
+	mutex_init(&disk->rqos_state_mutex);
 	return disk;
 
 out_erase_part0:
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 228b2e5ad493..281d56b910c2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -218,6 +218,8 @@ struct gendisk {
 	 * devices that do not have multiple independent access ranges.
 	 */
 	struct blk_independent_access_ranges *ia_ranges;
+
+	struct mutex rqos_state_mutex;	/* rqos state change mutex */
 };
 
 /**
-- 
2.47.0

