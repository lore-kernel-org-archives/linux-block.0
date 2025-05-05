Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F146259C85
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454758; cv=none; b=a7Cj+8cvaJLuZzujZPvTbMIiJUK19RQBQkR9qHlgaB0rTr0DhMwp/tSW1okVIVtaHukkXWNhDcW3yonloRNKt+Qg7HqfiYYC0UlK0Eo4asDhS32uSUG9l/UI2AzPxm1SKesi2y406ALBUgdrMpqw6ATy56JrWpoASBGUZzJMcD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454758; c=relaxed/simple;
	bh=yc3zSVB71fDhI1nebpWSJl0uVgvH+D5uJ1nW+yjGofE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gg1Hxrv603jMj4z7LuDC1DvvJWcr1+ZxUYo+mD4M28QkDNKOvVYyKR1FPseGlTbiDz7toxKvr+SJqzr8ew13nyqzRCGdUDR5+4sussL4hq2AgChXRLXlrkPM4ybeER7m1MFSko+/Z8r2a8UPBAjB7Ce6Ds15MaCAiOcLmIt5rd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OxihB4gD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxihB4gD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746454755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AITgVomnchHmnhwitqPZLFzO7GRJRdxTkBbRl+Yit9E=;
	b=OxihB4gDsdOkkN4pDl8rHuYsYG2tlJraZMPsHXXmcv1kqHV4Jxv9MO6h+5tEQYiT4Vfyc6
	zCkAch+syb4GJF4akBbkT6yLlir6Ab5KknR2ehZfQQHRwAv/hZHHTPugbacZllnlHnACLn
	RVRGQ8qN9s3mzNHKTJ2XFnCuHmEJ/ns=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-HbBDfN3-Osij6JbC0lAKjQ-1; Mon,
 05 May 2025 10:19:13 -0400
X-MC-Unique: HbBDfN3-Osij6JbC0lAKjQ-1
X-Mimecast-MFC-AGG-ID: HbBDfN3-Osij6JbC0lAKjQ_1746454752
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87B8F1800875;
	Mon,  5 May 2025 14:19:12 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6CDA219560A3;
	Mon,  5 May 2025 14:19:11 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 13/25] block: simplify elevator reattachment for updating nr_hw_queues
Date: Mon,  5 May 2025 22:17:51 +0800
Message-ID: <20250505141805.2751237-14-ming.lei@redhat.com>
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

In blk_mq_update_nr_hw_queues(), nr_hw_queues changes and elevator data
depends on it, and elevator has to be reattached, so call elevator_switch()
to force attachment.

Add elv_update_nr_hw_queues() simply for blk_mq_update_nr_hw_queues() to
reattach elevator, since elevator switch isn't likely when running
blk_mq_update_nr_hw_queues(). This way removes the current switch
none and switch back code.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c   | 90 +-----------------------------------------------
 block/blk.h      |  3 +-
 block/elevator.c | 20 ++++++++++-
 3 files changed, 21 insertions(+), 92 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 20bf2d797bdf..29f67b0e1fd5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4989,88 +4989,10 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 	return ret;
 }
 
-/*
- * request_queue and elevator_type pair.
- * It is just used by __blk_mq_update_nr_hw_queues to cache
- * the elevator_type associated with a request_queue.
- */
-struct blk_mq_qe_pair {
-	struct list_head node;
-	struct request_queue *q;
-	struct elevator_type *type;
-};
-
-/*
- * Cache the elevator_type in qe pair list and switch the
- * io scheduler to 'none'
- */
-static bool blk_mq_elv_switch_none(struct list_head *head,
-		struct request_queue *q)
-{
-	struct blk_mq_qe_pair *qe;
-
-	qe = kmalloc(sizeof(*qe), GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY);
-	if (!qe)
-		return false;
-
-	/* Accessing q->elevator needs protection from ->elevator_lock. */
-	mutex_lock(&q->elevator_lock);
-
-	if (!q->elevator) {
-		kfree(qe);
-		goto unlock;
-	}
-
-	INIT_LIST_HEAD(&qe->node);
-	qe->q = q;
-	qe->type = q->elevator->type;
-	/* keep a reference to the elevator module as we'll switch back */
-	__elevator_get(qe->type);
-	list_add(&qe->node, head);
-	elevator_disable(q);
-unlock:
-	mutex_unlock(&q->elevator_lock);
-
-	return true;
-}
-
-static struct blk_mq_qe_pair *blk_lookup_qe_pair(struct list_head *head,
-						struct request_queue *q)
-{
-	struct blk_mq_qe_pair *qe;
-
-	list_for_each_entry(qe, head, node)
-		if (qe->q == q)
-			return qe;
-
-	return NULL;
-}
-
-static void blk_mq_elv_switch_back(struct list_head *head,
-				  struct request_queue *q)
-{
-	struct blk_mq_qe_pair *qe;
-	struct elevator_type *t;
-
-	qe = blk_lookup_qe_pair(head, q);
-	if (!qe)
-		return;
-	t = qe->type;
-	list_del(&qe->node);
-	kfree(qe);
-
-	mutex_lock(&q->elevator_lock);
-	elevator_switch(q, t->elevator_name);
-	/* drop the reference acquired in blk_mq_elv_switch_none */
-	elevator_put(t);
-	mutex_unlock(&q->elevator_lock);
-}
-
 static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 							int nr_hw_queues)
 {
 	struct request_queue *q;
-	LIST_HEAD(head);
 	int prev_nr_hw_queues = set->nr_hw_queues;
 	unsigned int memflags;
 	int i;
@@ -5088,15 +5010,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_freeze_queue_nomemsave(q);
 
-	/*
-	 * Switch IO scheduler to 'none', cleaning up the data associated
-	 * with the previous scheduler. We will switch back once we are done
-	 * updating the new sw to hw queue mappings.
-	 */
-	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		if (!blk_mq_elv_switch_none(&head, q))
-			goto switch_back;
-
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_debugfs_unregister_hctxs(q);
 		blk_mq_sysfs_unregister_hctxs(q);
@@ -5130,9 +5043,8 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_debugfs_register_hctxs(q);
 	}
 
-switch_back:
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		blk_mq_elv_switch_back(&head, q);
+		elv_update_nr_hw_queues(q);
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_unfreeze_queue_nomemrestore(q);
diff --git a/block/blk.h b/block/blk.h
index ac90a8c5a8cf..98fd3a6f5ec9 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -322,8 +322,7 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 
 bool blk_insert_flush(struct request *rq);
 
-int elevator_switch(struct request_queue *q, const char *name);
-void elevator_disable(struct request_queue *q);
+void elv_update_nr_hw_queues(struct request_queue *q);
 void elevator_exit(struct request_queue *q);
 int elv_register_queue(struct request_queue *q, bool uevent);
 void elv_unregister_queue(struct request_queue *q);
diff --git a/block/elevator.c b/block/elevator.c
index 4e58379c4d88..cabd7a8bb76c 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -621,7 +621,7 @@ void elevator_init_mq(struct request_queue *q)
  * If switching fails, we are most likely running out of memory and not able
  * to restore the old io scheduler, so leaving the io scheduler being none.
  */
-int elevator_switch(struct request_queue *q, const char *name)
+static int elevator_switch(struct request_queue *q, const char *name)
 {
 	struct elevator_type *new_e = NULL;
 	int ret = 0;
@@ -682,6 +682,24 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
 	return elevator_switch(q, elevator_name);
 }
 
+/*
+ * The I/O scheduler depends on the number of hardware queues, this forces a
+ * reattachment when nr_hw_queues changes.
+ */
+void elv_update_nr_hw_queues(struct request_queue *q)
+{
+	WARN_ON_ONCE(q->mq_freeze_depth == 0);
+
+	mutex_lock(&q->elevator_lock);
+	if (q->elevator && !blk_queue_dying(q) && !blk_queue_registered(q)) {
+		const char *name = q->elevator->type->elevator_name;
+
+		/* force to reattach elevator after nr_hw_queue is updated */
+		elevator_switch(q, name);
+	}
+	mutex_unlock(&q->elevator_lock);
+}
+
 static void elv_iosched_load_module(char *elevator_name)
 {
 	struct elevator_type *found;
-- 
2.47.0

