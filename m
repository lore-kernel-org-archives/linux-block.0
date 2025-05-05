Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583F9259CA1
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454810; cv=none; b=emS4maJuRJ3lvHS1kUa2DUAuwEpV9PckwQ1ZyFeTRombXzmlF35g02nTVo6QXWFBY1ozdTAfZuRimtUqO198rW2ZzRoKxQETPzAMrdJtAFJ4+DpNILvDlbmgxtBbHZtnPKG2nKO9j/tSubeuriqqknYzZRj2GhYGQlWYNTcm+3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454810; c=relaxed/simple;
	bh=DvPMx56+USSDUEHOkzVVL5YW/tx3sdOnVuPc06+797w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUyhEN43HPaUbXM7OV/iLm+A2VqdMZpW7V0NSOraot/msFP7rBpMTMini4G73Xf4S1JASJ6qywEJtX3p3a7iDd7rIw58XmilRN9y2UQwvo1qRFCG6iIV6r2NA5t4JTObmcMT0Kg6Xk76fKv9p0puLD+o74iPgbL6TPiOBbEqxRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rss/5ap6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rss/5ap6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746454807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zwXNYTk4ETiI5zzDqTKuxV6bG1h/hUQXvP4KjkWd++U=;
	b=Rss/5ap6lsPaZA9mUyCfDwfzZE8uAl8aR0eluEnsnhz3w5bD3mdiKAAKt0mx8DDkwMQz98
	nvrk+9k4Sw1K53AXlk2C1WntjAMs3IaynyMOk2TjZsyD6FoRluHj17aucqmxOzy0xril1U
	Trg9SWMIOmtLSTQflLxiX8zS3tcgcNg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-PvGW16nuPauDg_0hfzDubw-1; Mon,
 05 May 2025 10:20:04 -0400
X-MC-Unique: PvGW16nuPauDg_0hfzDubw-1
X-Mimecast-MFC-AGG-ID: PvGW16nuPauDg_0hfzDubw_1746454802
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17DDF1800986;
	Mon,  5 May 2025 14:20:02 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E5CDE180045B;
	Mon,  5 May 2025 14:20:00 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 25/25] block: move wbt_enable_default() out of queue freezing from sched ->exit()
Date: Mon,  5 May 2025 22:18:03 +0800
Message-ID: <20250505141805.2751237-26-ming.lei@redhat.com>
In-Reply-To: <20250505141805.2751237-1-ming.lei@redhat.com>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

Reviewed-by: Hannes Reinecke <hare@suse.de>
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
index 8578b969e173..f8d72bd20610 100644
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
index a8cb5607b6e3..9c7c657380db 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1470,6 +1470,7 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
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

