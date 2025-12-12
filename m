Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFE7289811
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765550115; cv=none; b=nyvl9AE6Ips5/nHV6ZaAeoUzatxOwO8sXJOMsexGaMVoeUOhtQJPOpEDFqFFInMnBWGXhk9XpQyl4Gv94+HBhXbZgBicfk9a3Hd+3aKVcjzQF6yPoGX624XfCfLW6ECryWgLozEs8UdWuGzG7iTImZB5BuIcoqpxmCTSBOIMhPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765550115; c=relaxed/simple;
	bh=IFxkq9EJvi3x7MBTgFJOD73j45X314+zVnikBY3rPsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fekv+VeD+Ul6dGvtzrywKZQq3R1eczw4H19Z4GpX1Dz9nSHuWokXDtROmgpL/c7dr7trdiaGx/dOXSHS3Cx2xgw+d/n5jyXk7QzbdhbzBafPzlk+rr7JrxPj/qPMT7GdfCuTuPOsdWwQEk9zDYtTlEhQRuDK/TBMDdqYDYCCdpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LVhRv8qI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVhRv8qI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765550112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yiRdZ7NzjY6LhC6NMlbBCLJmABhpOl86DzaV7OksYFw=;
	b=LVhRv8qIhiRquM5Og6nOdBqSzjO5qsw2lM8H38H7MAA6SAKHViHREqbZFyzK1VvhMhHKu9
	OT2QQjg6YwPxnPD3QbFhV0yIsXxhZTobvU+LMN54j2byCY9fj7SlvywLVYMq3afuFISyx3
	CUrn01yk9d2RBeQrL0ftJtjpJajI6AQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-Hb04Af92N66B-fQlg8q73Q-1; Fri,
 12 Dec 2025 09:35:09 -0500
X-MC-Unique: Hb04Af92N66B-fQlg8q73Q-1
X-Mimecast-MFC-AGG-ID: Hb04Af92N66B-fQlg8q73Q_1765550108
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C2D0180057E;
	Fri, 12 Dec 2025 14:35:08 +0000 (UTC)
Received: from localhost (unknown [10.72.116.20])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 35ABA180045B;
	Fri, 12 Dec 2025 14:35:06 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Yu Kuai <yukuai@fnnas.com>,
	Guangwu Zhang <guazhang@redhat.com>
Subject: [PATCH V2] block: fix race between wbt_enable_default and IO submission
Date: Fri, 12 Dec 2025 22:35:00 +0800
Message-ID: <20251212143500.485521-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When wbt_enable_default() is moved out of queue freezing in elevator_change(),
it can cause the wbt inflight counter to become negative (-1), leading to hung
tasks in the writeback path. Tasks get stuck in wbt_wait() because the counter
is in an inconsistent state.

The issue occurs because wbt_enable_default() could race with IO submission,
allowing the counter to be decremented before proper initialization. This manifests
as:

  rq_wait[0]:
    inflight:             -1
    has_waiters:        True

rwb_enabled() checks the state, which can be updated exactly between wbt_wait()
(rq_qos_throttle()) and wbt_track()(rq_qos_track()), then the inflight counter
will become negative.

And results in hung task warnings like:
  task:kworker/u24:39 state:D stack:0 pid:14767
  Call Trace:
    rq_qos_wait+0xb4/0x150
    wbt_wait+0xa9/0x100
    __rq_qos_throttle+0x24/0x40
    blk_mq_submit_bio+0x672/0x7b0
    ...

Fix this by:

1. Splitting wbt_enable_default() into:
   - __wbt_enable_default(): Returns true if wbt_init() should be called
   - wbt_enable_default(): Wrapper for existing callers (no init)
   - wbt_init_enable_default(): New function that checks and inits WBT

2. Using wbt_init_enable_default() in blk_register_queue() to ensure
   proper initialization during queue registration

3. Move wbt_init() out of wbt_enable_default() which is only for enabling
   disabled wbt from bfq and iocost, and wbt_init() isn't needed. Then the
   original lock warning can be avoided.

4. Removing the ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT flag and its handling
   code since it's no longer needed

This ensures WBT is properly initialized before any IO can be submitted,
preventing the counter from going negative.

Cc: Nilay Shroff <nilay@linux.ibm.com>
Cc: Yu Kuai <yukuai@fnnas.com>
Cc: Guangwu Zhang <guazhang@redhat.com>
Fixes: 78c271344b6f ("block: move wbt_enable_default() out of queue freezing from sched ->exit()")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- explain the race in commit log(Nilay, YuKuai)


 block/bfq-iosched.c |  2 +-
 block/blk-sysfs.c   |  2 +-
 block/blk-wbt.c     | 20 ++++++++++++++++----
 block/blk-wbt.h     |  5 +++++
 block/elevator.c    |  4 ----
 block/elevator.h    |  1 -
 6 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 4a8d3d96bfe4..6e54b1d3d8bc 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7181,7 +7181,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
 
 	blk_stat_disable_accounting(bfqd->queue);
 	blk_queue_flag_clear(QUEUE_FLAG_DISABLE_WBT_DEF, bfqd->queue);
-	set_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT, &e->flags);
+	wbt_enable_default(bfqd->queue->disk);
 
 	kfree(bfqd);
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 8684c57498cc..e0a70d26972b 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -932,7 +932,7 @@ int blk_register_queue(struct gendisk *disk)
 		elevator_set_default(q);
 
 	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
-	wbt_enable_default(disk);
+	wbt_init_enable_default(disk);
 
 	/* Now everything is ready and send out KOBJ_ADD uevent */
 	kobject_uevent(&disk->queue_kobj, KOBJ_ADD);
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index eb8037bae0bd..0974875f77bd 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -699,7 +699,7 @@ static void wbt_requeue(struct rq_qos *rqos, struct request *rq)
 /*
  * Enable wbt if defaults are configured that way
  */
-void wbt_enable_default(struct gendisk *disk)
+static bool __wbt_enable_default(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 	struct rq_qos *rqos;
@@ -716,19 +716,31 @@ void wbt_enable_default(struct gendisk *disk)
 		if (enable && RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
 			RQWB(rqos)->enable_state = WBT_STATE_ON_DEFAULT;
 		mutex_unlock(&disk->rqos_state_mutex);
-		return;
+		return false;
 	}
 	mutex_unlock(&disk->rqos_state_mutex);
 
 	/* Queue not registered? Maybe shutting down... */
 	if (!blk_queue_registered(q))
-		return;
+		return false;
 
 	if (queue_is_mq(q) && enable)
-		wbt_init(disk);
+		return true;
+	return false;
+}
+
+void wbt_enable_default(struct gendisk *disk)
+{
+	__wbt_enable_default(disk);
 }
 EXPORT_SYMBOL_GPL(wbt_enable_default);
 
+void wbt_init_enable_default(struct gendisk *disk)
+{
+	if (__wbt_enable_default(disk))
+		WARN_ON_ONCE(wbt_init(disk));
+}
+
 u64 wbt_default_latency_nsec(struct request_queue *q)
 {
 	/*
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index e5fc653b9b76..925f22475738 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -5,6 +5,7 @@
 #ifdef CONFIG_BLK_WBT
 
 int wbt_init(struct gendisk *disk);
+void wbt_init_enable_default(struct gendisk *disk);
 void wbt_disable_default(struct gendisk *disk);
 void wbt_enable_default(struct gendisk *disk);
 
@@ -16,6 +17,10 @@ u64 wbt_default_latency_nsec(struct request_queue *);
 
 #else
 
+static inline void wbt_init_enable_default(struct gendisk *disk)
+{
+}
+
 static inline void wbt_disable_default(struct gendisk *disk)
 {
 }
diff --git a/block/elevator.c b/block/elevator.c
index 5b37ef44f52d..a2f8b2251dc6 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -633,14 +633,10 @@ static int elevator_change_done(struct request_queue *q,
 			.et = ctx->old->et,
 			.data = ctx->old->elevator_data
 		};
-		bool enable_wbt = test_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT,
-				&ctx->old->flags);
 
 		elv_unregister_queue(q, ctx->old);
 		blk_mq_free_sched_res(&res, ctx->old->type, q->tag_set);
 		kobject_put(&ctx->old->kobj);
-		if (enable_wbt)
-			wbt_enable_default(q->disk);
 	}
 	if (ctx->new) {
 		ret = elv_register_queue(q, ctx->new, !ctx->no_uevent);
diff --git a/block/elevator.h b/block/elevator.h
index a9d092c5a9e8..3eb32516be0b 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -156,7 +156,6 @@ struct elevator_queue
 
 #define ELEVATOR_FLAG_REGISTERED	0
 #define ELEVATOR_FLAG_DYING		1
-#define ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT	2
 
 /*
  * block elevator interface
-- 
2.47.1

