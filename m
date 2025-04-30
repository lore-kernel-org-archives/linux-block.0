Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4251D1D89E3
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 04:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745987799; cv=none; b=ty+NJXseKTlmmEuW18bKWZ4evsttBLD334JqXx+WZNfI5tBTAih6chrR8iG8Wxv8bh3q+Pmg8K00cSX6jPtp2Kglxtwu0f3nP3fJ6FVuclkkWTU6ons0TSLNpPNAUmEOPHpv/eBw4G4toZyB8IWPkQVs7QH7PcAX19ft5R3iP7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745987799; c=relaxed/simple;
	bh=oZLt5dErTn1G+Am9g+Gn9jEn+6BV3guycHuYTl9B/os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUA3j6CDYYoHMsbhlIlrgToFZwiHXIFvuTLenzWMOLvYHBmtcnfHqhil0gw73pRk6hVUhzZi8jDFVIwSk60lDZTBCQ+emWgq+hVRSLYidTDvUrCGITPVEE2cTf38nL1jhS56yZjf+wOr2d/8koUf7eOyIvab1tbcgWaG6nmILKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QiAX31Wx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QiAX31Wx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745987797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HDYFCy+xblmLs8vEXS3/XpEjiyC2tBs79sdKmP+fNV0=;
	b=QiAX31WxF5qoHlC5WY9+KUXJu9zqmkjkR4R1Q+ahu5qPyE2KL1Elp70KQs9/c9uwq5cAan
	7IqyMSojdUym0052ZfxRu3Up5ZOblL9v4oqa3Pm1hrOFj6ckzItmzTP9gYbRR1hbsVNXFg
	OrUqutKAU5l7XrqKJRGqKg+vnZSpVys=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-Qyi3Zov3Oo-WTwvi5BeZ-w-1; Wed,
 30 Apr 2025 00:36:31 -0400
X-MC-Unique: Qyi3Zov3Oo-WTwvi5BeZ-w-1
X-Mimecast-MFC-AGG-ID: Qyi3Zov3Oo-WTwvi5BeZ-w_1745987789
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD7A91956094;
	Wed, 30 Apr 2025 04:36:29 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 04F6518001D5;
	Wed, 30 Apr 2025 04:36:28 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V4 14/24] block: add `struct elv_change_ctx` for unifying elevator change
Date: Wed, 30 Apr 2025 12:35:16 +0800
Message-ID: <20250430043529.1950194-15-ming.lei@redhat.com>
In-Reply-To: <20250430043529.1950194-1-ming.lei@redhat.com>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add `struct elv_change_ctx` and prepare for unifying elevator change by
elevator_change(). With this way, any input & output parameter can
be provided & observed in top helper.

This way helps to move kobject add/delete & debugfs register/unregister
out of ->elevator_lock & freezing queue.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index df1f5451fc5e..5188bb0119f0 100644
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
@@ -697,19 +702,21 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
  */
 void elv_update_nr_hw_queues(struct request_queue *q)
 {
-	const char *name = "none";
+	struct elv_change_ctx ctx = {
+		.name	= "none",
+	};
 
 	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 
 	mutex_lock(&q->elevator_lock);
 	if (q->elevator && !blk_queue_dying(q) && !blk_queue_registered(q))
-		name = q->elevator->type->elevator_name;
+		ctx.name = q->elevator->type->elevator_name;
 	/* force to reattach elevator after nr_hw_queue is updated */
-	elevator_switch(q, name);
+	elevator_switch(q, &ctx);
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
 
 	down_read_nested(&set->update_nr_hwq_lock, 1);
-	ret = elevator_change(q, name);
+	ret = elevator_change(q, &ctx);
 	if (!ret)
 		ret = count;
 	up_read(&set->update_nr_hwq_lock);
-- 
2.47.0

