Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9241F930
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291895; cv=none; b=oPoktwg8ImaxqfQ9QjxpIeGOSS6UGXw1isY0CFtqnJhoQYtVBRa8G8smfU7wxO1TORvdsrAA63bG9I2vZDTiR88o8N9IOQX2JdZ4A1H09cBstBNXT7JgjlUzhEAP6uWdnYQRhHJ24/Bi0eDxzhBI3FnQSMj03l9YtQHd1SlQFXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291895; c=relaxed/simple;
	bh=R7JM6IoWeIAw9tOs7WOhhuoQMfvBtFgKweDXdwAbERg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTXl8FTZ+atlMpvTBFNbVUZ3PqhaRIsrI/GNNnKZ2PU+gkshrlszT9bFv9hArYHZPx6+plk6Uj5xz93+Jz7VWIT88ZcODdiuJ84wG0IZ5G+T/3aVjkEKPjyQTxPjHxQOO/vbJ/QiFw/f17clbO7fgWLXTB4tptdu0RVhHhSamIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XHpNd1eX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHpNd1eX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744291892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Usj3xW4j7dvSx1IAVd2APO2KC2STys+e2IkRdQ7SDgI=;
	b=XHpNd1eXi2y8gsvVntkT0dQz7zmSxQuuZiZCJW5ce7Zs/wZsw78MK1sdu6QD1Pr1CpYeJy
	UOH8jv/GorsqGF9PHTQT8OctREUHQphbUqrLVjckJZrYRJ04sTWLhGEbzBcK/Op7/9BPjV
	3AsFQrB5EgP1phEWbnlq82/WAOPN0qU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-2tNjr1z6NN-JdAS5q233xQ-1; Thu,
 10 Apr 2025 09:31:29 -0400
X-MC-Unique: 2tNjr1z6NN-JdAS5q233xQ-1
X-Mimecast-MFC-AGG-ID: 2tNjr1z6NN-JdAS5q233xQ_1744291888
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD1391801A00;
	Thu, 10 Apr 2025 13:31:27 +0000 (UTC)
Received: from localhost (unknown [10.72.120.20])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8ECAB1808882;
	Thu, 10 Apr 2025 13:31:26 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 08/15] block: add `struct elev_change_ctx` for unifying elevator change
Date: Thu, 10 Apr 2025 21:30:20 +0800
Message-ID: <20250410133029.2487054-9-ming.lei@redhat.com>
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

Add `struct elev_change_ctx` and prepare for unifying elevator change,
with this way, any input & output parameter can be provided & observed
in top caller.

This way also helps to move kobject & debugfs things out of
->elevator_lock.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c   | 10 +++++++---
 block/blk.h      |  4 ++--
 block/elevator.c | 33 +++++++++++++++++++--------------
 block/elevator.h |  7 +++++++
 4 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b7e3cd355e66..608a74e3a87c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4985,12 +4985,16 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	}
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		const char *name = "none";
+		struct elev_change_ctx ctx = {
+			.name	= "none",
+			.force	= 1,
+			.uevent	= 1,
+		};
 
 		mutex_lock(&q->elevator_lock);
 		if (q->elevator && !blk_queue_dying(q))
-			name = q->elevator->type->elevator_name;
-		__elevator_change(q, name, true);
+			ctx.name = q->elevator->type->elevator_name;
+		__elevator_change(q, &ctx);
 		mutex_unlock(&q->elevator_lock);
 	}
 
diff --git a/block/blk.h b/block/blk.h
index 0c3cc1af2525..922a429b5363 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -12,6 +12,7 @@
 #include "blk-crypto-internal.h"
 
 struct elevator_type;
+struct elev_change_ctx;
 
 #define	BLK_DEV_MAX_SECTORS	(LLONG_MAX >> 9)
 #define	BLK_MIN_SEGMENT_SIZE	4096
@@ -319,8 +320,7 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 
 bool blk_insert_flush(struct request *rq);
 
-int __elevator_change(struct request_queue *q, const char *elevator_name,
-		      bool force);
+int __elevator_change(struct request_queue *q, struct elev_change_ctx *ctx);
 void elevator_exit(struct request_queue *q);
 int elv_register_queue(struct request_queue *q, bool uevent);
 void elv_unregister_queue(struct request_queue *q);
diff --git a/block/elevator.c b/block/elevator.c
index e028d2ff9624..2bc1679dcd1f 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -53,7 +53,8 @@ static LIST_HEAD(elv_list);
  */
 #define rq_hash_key(rq)		(blk_rq_pos(rq) + blk_rq_sectors(rq))
 
-static int elevator_change(struct request_queue *q, const char *name);
+static int elevator_change(struct request_queue *q,
+			   struct elev_change_ctx *ctx);
 
 /*
  * Query io scheduler to see if the current process issuing bio may be
@@ -621,7 +622,8 @@ void elevator_init_mq(struct request_queue *q)
  * If switching fails, we are most likely running out of memory and not able
  * to restore the old io scheduler, so leaving the io scheduler being none.
  */
-static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
+static int elevator_switch(struct request_queue *q, struct elevator_type *new_e,
+			   struct elev_change_ctx *ctx)
 {
 	int ret;
 
@@ -639,7 +641,7 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 	if (ret)
 		goto out_unfreeze;
 
-	ret = elv_register_queue(q, true);
+	ret = elv_register_queue(q, ctx->uevent);
 	if (ret) {
 		elevator_exit(q);
 		goto out_unfreeze;
@@ -677,9 +679,9 @@ static void elevator_disable(struct request_queue *q)
 /*
  * Switch this queue to the given IO scheduler.
  */
-int __elevator_change(struct request_queue *q, const char *elevator_name,
-		      bool force)
+int __elevator_change(struct request_queue *q, struct elev_change_ctx *ctx)
 {
+	const char *elevator_name = ctx->name;
 	struct elevator_type *e;
 	int ret;
 
@@ -689,19 +691,20 @@ int __elevator_change(struct request_queue *q, const char *elevator_name,
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
+			   struct elev_change_ctx *ctx)
 {
 	int ret, idx;
 	unsigned int memflags;
@@ -716,7 +719,7 @@ static int elevator_change(struct request_queue *q, const char *name)
 
 	memflags = blk_mq_freeze_queue(q);
 	mutex_lock(&q->elevator_lock);
-	ret = __elevator_change(q, name, false);
+	ret = __elevator_change(q, ctx);
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
 exit:
@@ -724,7 +727,7 @@ static int elevator_change(struct request_queue *q, const char *name)
 	return ret;
 }
 
-static void elv_iosched_load_module(char *elevator_name)
+static void elv_iosched_load_module(const char *elevator_name)
 {
 	struct elevator_type *found;
 
@@ -741,7 +744,9 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 {
 	struct request_queue *q = disk->queue;
 	char elevator_name[ELV_NAME_MAX];
-	char *name;
+	struct elev_change_ctx ctx = {
+		.uevent = 1,
+	};
 	int ret;
 
 	/*
@@ -750,15 +755,15 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	 * queue is the one for the device storing the module file.
 	 */
 	strscpy(elevator_name, buf, sizeof(elevator_name));
-	name = strstrip(elevator_name);
+	ctx.name = strstrip(elevator_name);
 
-	elv_iosched_load_module(name);
+	elv_iosched_load_module(ctx.name);
 
 	/* Make sure queue is not in the middle of being removed */
 	if (!blk_queue_registered(q))
 		return -ENOENT;
 
-	ret = elevator_change(q, name);
+	ret = elevator_change(q, &ctx);
 	if (!ret)
 		ret = count;
 	return ret;
diff --git a/block/elevator.h b/block/elevator.h
index 80ff9b28a66f..86b4977cf772 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -123,6 +123,13 @@ struct elevator_queue
 #define ELEVATOR_FLAG_REGISTERED	0
 #define ELEVATOR_FLAG_DISABLE_WBT	1
 
+/* Holding data for changing elevator */
+struct elev_change_ctx {
+	const char *name;
+	unsigned int force:1;
+	unsigned int uevent:1;
+};
+
 /*
  * block elevator interface
  */
-- 
2.47.0

