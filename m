Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD137462
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994299; cv=none; b=gxEW76Aeh9DnM6HyRz0BUEtIX36nrFvNXTDpk+pIgTryImYrA7sZUqfZOVpknimWPExPrPhxCu98/jJEzfuE/miSgiRvXlNtYEQ3BxAQFELCOcSDD+HINgfBnt3LMKv4qPrB/jIeJ9/eXmbjyWS92AO3qDh9C6RinIBR9oEzv68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994299; c=relaxed/simple;
	bh=dWiGyVnze8iyTTOSQcPeHmem5mrMIPAMUWmsaLD5BA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBJA9OC5RCa/nDWZ+PSd9mLQO99kyWsjtH4NpeyOR38lPGNfqsa/88SHp3JvjrC+S7ShRLGGhveWr/0YbQlw61mNANOhsryoqJEDjn4Mssw0pdZ6G5ew2EuinZYODfMqAb3W4KCk6c2RKMmliQkFcfPQTIUEf5ZEnF3Rl0rfwOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DAytdnjY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DAytdnjY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744994295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WPMeHn70SahxC5BWbKKirz+/N0HSPtcsBxvwuyrkJWI=;
	b=DAytdnjY80x7fknFWx1n2mZv+UFX8k8NdBFUmryLaFDvXqpHQXn5SFIqvYhKFsmouzEe5Y
	45Z2RqPqzvW1TbrZZMpvh1zQ4YbHfVnMJXpoJDdXh7lNt42NezWiLhjPX5+bwdKWi2DS+B
	xvSlUziVePiiwiO2/HbhOS9e/b50o+I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-CpWK5XexPZW_agwG-PLapw-1; Fri,
 18 Apr 2025 12:38:12 -0400
X-MC-Unique: CpWK5XexPZW_agwG-PLapw-1
X-Mimecast-MFC-AGG-ID: CpWK5XexPZW_agwG-PLapw_1744994291
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2EF6619560A1;
	Fri, 18 Apr 2025 16:38:11 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BCE9019560A3;
	Fri, 18 Apr 2025 16:38:09 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 12/20] block: add `struct elv_change_ctx` for unifying elevator_change
Date: Sat, 19 Apr 2025 00:36:53 +0800
Message-ID: <20250418163708.442085-13-ming.lei@redhat.com>
In-Reply-To: <20250418163708.442085-1-ming.lei@redhat.com>
References: <20250418163708.442085-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add `struct elv_change_ctx` and prepare for unifying elevator_change(),
with this way, any input & output parameter can be provided & observed
in top caller.

This way also helps to move kobject & debugfs things out of
->elevator_lock & freezing queue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c   | 16 ++++++++++------
 block/blk.h      |  4 ++--
 block/elevator.c | 33 +++++++++++++++++++--------------
 block/elevator.h |  7 +++++++
 4 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0f4a5e674874..1a287c2e791c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4984,16 +4984,20 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	}
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		const char *name = "none";
-
-		mutex_lock(&q->elevator_lock);
-		if (q->elevator && !blk_queue_dying(q))
-			name = q->elevator->type->elevator_name;
 		/*
 		 * nr_hw_queues is changed and elevator data depends on
 		 * it, so we have to force to rebuild elevator
 		 */
-		__elevator_change(q, name, true);
+		struct elv_change_ctx ctx = {
+			.name	= "none",
+			.force	= true,
+			.uevent	= true,
+		};
+
+		mutex_lock(&q->elevator_lock);
+		if (q->elevator && !blk_queue_dying(q))
+			ctx.name = q->elevator->type->elevator_name;
+		__elevator_change(q, &ctx);
 		mutex_unlock(&q->elevator_lock);
 	}
 
diff --git a/block/blk.h b/block/blk.h
index 0c3cc1af2525..be01cb9f3910 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -12,6 +12,7 @@
 #include "blk-crypto-internal.h"
 
 struct elevator_type;
+struct elv_change_ctx;
 
 #define	BLK_DEV_MAX_SECTORS	(LLONG_MAX >> 9)
 #define	BLK_MIN_SEGMENT_SIZE	4096
@@ -319,8 +320,7 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 
 bool blk_insert_flush(struct request *rq);
 
-int __elevator_change(struct request_queue *q, const char *elevator_name,
-		      bool force);
+int __elevator_change(struct request_queue *q, struct elv_change_ctx *ctx);
 void elevator_exit(struct request_queue *q);
 int elv_register_queue(struct request_queue *q, bool uevent);
 void elv_unregister_queue(struct request_queue *q);
diff --git a/block/elevator.c b/block/elevator.c
index 6bf3871c7164..836138fc148a 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -53,7 +53,8 @@ static LIST_HEAD(elv_list);
  */
 #define rq_hash_key(rq)		(blk_rq_pos(rq) + blk_rq_sectors(rq))
 
-static int elevator_change(struct request_queue *q, const char *name);
+static int elevator_change(struct request_queue *q,
+			   struct elv_change_ctx *ctx);
 
 /*
  * Query io scheduler to see if the current process issuing bio may be
@@ -623,7 +624,8 @@ void elevator_init_mq(struct request_queue *q)
  * If switching fails, we are most likely running out of memory and not able
  * to restore the old io scheduler, so leaving the io scheduler being none.
  */
-static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
+static int elevator_switch(struct request_queue *q, struct elevator_type *new_e,
+			   struct elv_change_ctx *ctx)
 {
 	int ret;
 
@@ -641,7 +643,7 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 	if (ret)
 		goto out_unfreeze;
 
-	ret = elv_register_queue(q, true);
+	ret = elv_register_queue(q, ctx->uevent);
 	if (ret) {
 		elevator_exit(q);
 		goto out_unfreeze;
@@ -679,9 +681,9 @@ static void elevator_disable(struct request_queue *q)
 /*
  * Switch this queue to the given IO scheduler.
  */
-int __elevator_change(struct request_queue *q, const char *elevator_name,
-		      bool force)
+int __elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 {
+	const char *elevator_name = ctx->name;
 	struct elevator_type *e;
 	int ret;
 
@@ -695,19 +697,20 @@ int __elevator_change(struct request_queue *q, const char *elevator_name,
 		return 0;
 	}
 
-	if (!force && q->elevator &&
+	if (!ctx->force && q->elevator &&
 	    elevator_match(q->elevator->type, elevator_name))
 		return 0;
 
 	e = elevator_find_get(elevator_name);
 	if (!e)
 		return -EINVAL;
-	ret = elevator_switch(q, e);
+	ret = elevator_switch(q, e, ctx);
 	elevator_put(e);
 	return ret;
 }
 
-static int elevator_change(struct request_queue *q, const char *name)
+static int elevator_change(struct request_queue *q,
+			   struct elv_change_ctx *ctx)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 	unsigned int memflags;
@@ -721,7 +724,7 @@ static int elevator_change(struct request_queue *q, const char *name)
 
 	memflags = blk_mq_freeze_queue(q);
 	mutex_lock(&q->elevator_lock);
-	ret = __elevator_change(q, name, false);
+	ret = __elevator_change(q, ctx);
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
 exit:
@@ -729,7 +732,7 @@ static int elevator_change(struct request_queue *q, const char *name)
 	return ret;
 }
 
-static void elv_iosched_load_module(char *elevator_name)
+static void elv_iosched_load_module(const char *elevator_name)
 {
 	struct elevator_type *found;
 
@@ -746,7 +749,9 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 {
 	struct request_queue *q = disk->queue;
 	char elevator_name[ELV_NAME_MAX];
-	char *name;
+	struct elv_change_ctx ctx = {
+		.uevent = true,
+	};
 	int ret;
 
 	/*
@@ -755,11 +760,11 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	 * queue is the one for the device storing the module file.
 	 */
 	strscpy(elevator_name, buf, sizeof(elevator_name));
-	name = strstrip(elevator_name);
+	ctx.name = strstrip(elevator_name);
 
-	elv_iosched_load_module(name);
+	elv_iosched_load_module(ctx.name);
 
-	ret = elevator_change(q, name);
+	ret = elevator_change(q, &ctx);
 	if (!ret)
 		ret = count;
 	return ret;
diff --git a/block/elevator.h b/block/elevator.h
index 9198676644a9..63fc4cad16cc 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -122,6 +122,13 @@ struct elevator_queue
 
 #define ELEVATOR_FLAG_REGISTERED	0
 
+/* Holding context data for changing elevator */
+struct elv_change_ctx {
+	const char *name;
+	bool force;
+	bool uevent;
+};
+
 /*
  * block elevator interface
  */
-- 
2.47.0

