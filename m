Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0CB6AD3
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 04:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745987837; cv=none; b=qe4q/NVf+DcjFmpSWavXMM2QQjSgGm6zOgraDu5ZUmHAEakEnDrkViRxILj7Td/lXQJx4gkcpK5j/0RZNA34gbMsyUmj3H8Szwaz/gO6eD6hzGt4javyMVnVk7eXRt6O1B+4EJfSkVKIA0RtZWD1NL/aK33cOYkw9TBsOYkKsn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745987837; c=relaxed/simple;
	bh=bZmET45OGOCMwc+Q4v+WeWO877s4t8N6G9wMi+uN5/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3tu1ohhChERb9A3IsYnwJhEuPq/B2bdMCleKkrVAczMDeYOgwjdP+T+Lj+KUCFfPWiUmsINwI3CbX41Wft9DROeHwtuYAiqp2Jc4h4s4qodbMyUeHRHoB3nr4nnEC1QhxvTd0bbLCNnH4JQFk7tvOYRoqZQh7HfUWjpyOkkc5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T/qMs7tu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/qMs7tu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745987832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjixIQR8SwWl5Yd+txBqJPl2CTbBY7tIhe/IxpvdnyY=;
	b=T/qMs7tubRPK/hR8PiD+36VMQN5NOqNykuB38AelXRA3PwHBJW0BTd1Um9zKgQY0evsy6T
	7V3O4Lg/yrYJv5cCKmM7rfZHYMzFr0jA+4Aa+o/5xzPwURhK9kL2UvtEoH9RsbUQQr/wm5
	dxlkWmjjowQ2Nxip8cjosT/M8GxellA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-U9QjP4LVOh-KaAi6Qgmblg-1; Wed,
 30 Apr 2025 00:37:07 -0400
X-MC-Unique: U9QjP4LVOh-KaAi6Qgmblg-1
X-Mimecast-MFC-AGG-ID: U9QjP4LVOh-KaAi6Qgmblg_1745987826
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A58531956086;
	Wed, 30 Apr 2025 04:37:06 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 87481180045C;
	Wed, 30 Apr 2025 04:37:05 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 24/24] block: move wbt_enable_default() out of queue freezing from sched ->exit()
Date: Wed, 30 Apr 2025 12:35:26 +0800
Message-ID: <20250430043529.1950194-25-ming.lei@redhat.com>
In-Reply-To: <20250430043529.1950194-1-ming.lei@redhat.com>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bfq-iosched.c    |  2 +-
 block/blk-sysfs.c      | 10 ++++------
 block/blk-wbt.c        |  6 ++++++
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
index 741e607dfab6..01e0ead13278 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -560,7 +560,7 @@ static ssize_t queue_wb_lat_show(struct gendisk *disk, char *page)
 	ssize_t ret;
 	struct request_queue *q = disk->queue;
 
-	mutex_lock(&q->elevator_lock);
+	mutex_lock(&disk->rqos_state_mutex);
 	if (!wbt_rq_qos(q)) {
 		ret = -EINVAL;
 		goto out;
@@ -573,7 +573,7 @@ static ssize_t queue_wb_lat_show(struct gendisk *disk, char *page)
 
 	ret = sysfs_emit(page, "%llu\n", div_u64(wbt_get_min_lat(q), 1000));
 out:
-	mutex_unlock(&q->elevator_lock);
+	mutex_unlock(&disk->rqos_state_mutex);
 	return ret;
 }
 
@@ -593,7 +593,6 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 		return -EINVAL;
 
 	memflags = blk_mq_freeze_queue(q);
-	mutex_lock(&q->elevator_lock);
 
 	rqos = wbt_rq_qos(q);
 	if (!rqos) {
@@ -618,11 +617,12 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 	 */
 	blk_mq_quiesce_queue(q);
 
+	mutex_lock(&disk->rqos_state_mutex);
 	wbt_set_min_lat(q, val);
+	mutex_unlock(&disk->rqos_state_mutex);
 
 	blk_mq_unquiesce_queue(q);
 out:
-	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
 
 	return ret;
@@ -871,9 +871,7 @@ int blk_register_queue(struct gendisk *disk)
 
 	if (queue_is_mq(q))
 		elevator_set_default(q);
-	mutex_lock(&q->elevator_lock);
 	wbt_enable_default(disk);
-	mutex_unlock(&q->elevator_lock);
 
 	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
 
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 29cd2e33666f..74ae7131ada9 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -704,6 +704,8 @@ void wbt_enable_default(struct gendisk *disk)
 	struct rq_qos *rqos;
 	bool enable = IS_ENABLED(CONFIG_BLK_WBT_MQ);
 
+	mutex_lock(&disk->rqos_state_mutex);
+
 	if (blk_queue_disable_wbt(q))
 		enable = false;
 
@@ -712,8 +714,10 @@ void wbt_enable_default(struct gendisk *disk)
 	if (rqos) {
 		if (enable && RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
 			RQWB(rqos)->enable_state = WBT_STATE_ON_DEFAULT;
+		mutex_unlock(&disk->rqos_state_mutex);
 		return;
 	}
+	mutex_unlock(&disk->rqos_state_mutex);
 
 	/* Queue not registered? Maybe shutting down... */
 	if (!blk_queue_registered(q))
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
index 492a593160ae..936d73cda6ed 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -637,8 +637,13 @@ static int elevator_change_done(struct request_queue *q,
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
 		ret = elv_register_queue(q, ctx->new, !ctx->no_uevent);
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
index 59d9febd8c14..21b4ea191d24 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1460,6 +1460,7 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 #ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
 	INIT_LIST_HEAD(&disk->slave_bdevs);
 #endif
+	mutex_init(&disk->rqos_state_mutex);
 	return disk;
 
 out_erase_part0:
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b15c53fabe9f..c19ae1877061 100644
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

