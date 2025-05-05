Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0287625C70B
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454770; cv=none; b=nV/DT/bkq5RqGjT5aKTZzfBUFAOCYkbui0IKBcJpUneqXV/0T4nA15AJKzXoHHYSAiu7pfkE6YnVjUGiw/vwUT7ks+ckpsf1RCffGNmWYOjYjKs7r+rtZual73b56HYrwn+m/vIb0P6bp2PK6/ER5yaInY8OZLS5kHahebsER+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454770; c=relaxed/simple;
	bh=snWEanqTUQz3GToEZBWGGUu2WXF1D3FUaz7FRZiTPGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDqOw5iCZq1lnhf+nrm4h9PNLrrjWm77RnWeJJOBZWhi/y3cYS1y47W5L0sKzgnWeQboLXFIxwRMX9tKr4ycXolhQiMUXdpLvLLFOEYz1sz90pabP0V7fiiSN6wyJhu45lOnxXrfP0r5gXq4o7V/h6M6gzw2gquOHiLqu+HQVDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QlgkdNmd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlgkdNmd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746454766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNHkETn44DMI4u11+19zev0YfwFpXtpNeWRwa6/rdKQ=;
	b=QlgkdNmduAgt0lgSW/6aqxaTH0YPuX5vzxYPRQhlism8yJLVOB6Lv9HzUFd1cvTlKHfecz
	kAXWk6wym2bOF2o4dZMhfzuouyF87FuAjUDhRQZa4GFFiGwNjvZaiKYf+aBw2/Cn+eP5Ga
	ZCLFeOXBpuDMU1CpLA8PaMaDmcMsj/s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-DMWEW769NEeR5NPBYK7k-w-1; Mon,
 05 May 2025 10:19:21 -0400
X-MC-Unique: DMWEW769NEeR5NPBYK7k-w-1
X-Mimecast-MFC-AGG-ID: DMWEW769NEeR5NPBYK7k-w_1746454760
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6249E1800EC9;
	Mon,  5 May 2025 14:19:20 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 81ED21954B07;
	Mon,  5 May 2025 14:19:19 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 15/25] block: add `struct elv_change_ctx` for unifying elevator change
Date: Mon,  5 May 2025 22:17:53 +0800
Message-ID: <20250505141805.2751237-16-ming.lei@redhat.com>
In-Reply-To: <20250505141805.2751237-1-ming.lei@redhat.com>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add `struct elv_change_ctx` and prepare for unifying elevator change by
elevator_change(). With this way, any input & output parameter can
be provided & observed in top helper.

This way helps to move kobject add/delete & debugfs register/unregister
out of ->elevator_lock & freezing queue.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index cb54a3791fe5..6cfac8f77d9f 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -45,6 +45,12 @@
 #include "blk-wbt.h"
 #include "blk-cgroup.h"
 
+/* Holding context data for changing elevator */
+struct elv_change_ctx {
+	const char *name;
+	bool no_uevent;
+};
+
 static DEFINE_SPINLOCK(elv_list_lock);
 static LIST_HEAD(elv_list);
 
@@ -621,7 +627,7 @@ void elevator_init_mq(struct request_queue *q)
  * If switching fails, we are most likely running out of memory and not able
  * to restore the old io scheduler, so leaving the io scheduler being none.
  */
-static int elevator_switch(struct request_queue *q, const char *name)
+static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 {
 	struct elevator_type *new_e = NULL;
 	int ret = 0;
@@ -629,8 +635,8 @@ static int elevator_switch(struct request_queue *q, const char *name)
 	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 	lockdep_assert_held(&q->elevator_lock);
 
-	if (strncmp(name, "none", 4)) {
-		new_e = elevator_find_get(name);
+	if (strncmp(ctx->name, "none", 4)) {
+		new_e = elevator_find_get(ctx->name);
 		if (!new_e)
 			return -EINVAL;
 	}
@@ -646,7 +652,7 @@ static int elevator_switch(struct request_queue *q, const char *name)
 		ret = blk_mq_init_sched(q, new_e);
 		if (ret)
 			goto out_unfreeze;
-		ret = elv_register_queue(q, true);
+		ret = elv_register_queue(q, !ctx->no_uevent);
 		if (ret) {
 			elevator_exit(q);
 			goto out_unfreeze;
@@ -656,7 +662,7 @@ static int elevator_switch(struct request_queue *q, const char *name)
 		q->elevator = NULL;
 		q->nr_requests = q->tag_set->queue_depth;
 	}
-	blk_add_trace_msg(q, "elv switch: %s", name);
+	blk_add_trace_msg(q, "elv switch: %s", ctx->name);
 
 out_unfreeze:
 	blk_mq_unquiesce_queue(q);
@@ -674,7 +680,7 @@ static int elevator_switch(struct request_queue *q, const char *name)
 /*
  * Switch this queue to the given IO scheduler.
  */
-static int elevator_change(struct request_queue *q, const char *elevator_name)
+static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 {
 	unsigned int memflags;
 	int ret = 0;
@@ -683,9 +689,8 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
 
 	memflags = blk_mq_freeze_queue(q);
 	mutex_lock(&q->elevator_lock);
-	if (!(q->elevator && elevator_match(q->elevator->type,
-				elevator_name)))
-		ret = elevator_switch(q, elevator_name);
+	if (!(q->elevator && elevator_match(q->elevator->type, ctx->name)))
+		ret = elevator_switch(q, ctx);
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
 	return ret;
@@ -701,15 +706,17 @@ void elv_update_nr_hw_queues(struct request_queue *q)
 
 	mutex_lock(&q->elevator_lock);
 	if (q->elevator && !blk_queue_dying(q) && !blk_queue_registered(q)) {
-		const char *name = q->elevator->type->elevator_name;
+		struct elv_change_ctx ctx = {
+			.name = q->elevator->type->elevator_name,
+		};
 
 		/* force to reattach elevator after nr_hw_queue is updated */
-		elevator_switch(q, name);
+		elevator_switch(q, &ctx);
 	}
 	mutex_unlock(&q->elevator_lock);
 }
 
-static void elv_iosched_load_module(char *elevator_name)
+static void elv_iosched_load_module(const char *elevator_name)
 {
 	struct elevator_type *found;
 
@@ -725,7 +732,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 			  size_t count)
 {
 	char elevator_name[ELV_NAME_MAX];
-	char *name;
+	struct elv_change_ctx ctx = {};
 	int ret;
 	struct request_queue *q = disk->queue;
 	struct blk_mq_tag_set *set = q->tag_set;
@@ -740,12 +747,12 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	 * queue is the one for the device storing the module file.
 	 */
 	strscpy(elevator_name, buf, sizeof(elevator_name));
-	name = strstrip(elevator_name);
+	ctx.name = strstrip(elevator_name);
 
-	elv_iosched_load_module(name);
+	elv_iosched_load_module(ctx.name);
 
 	down_read(&set->update_nr_hwq_lock);
-	ret = elevator_change(q, name);
+	ret = elevator_change(q, &ctx);
 	if (!ret)
 		ret = count;
 	up_read(&set->update_nr_hwq_lock);
-- 
2.47.0

