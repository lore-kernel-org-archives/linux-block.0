Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B396B29CE6
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 04:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745987791; cv=none; b=g7W+CHyK7Q+pvhGLjS8ZX8DZypPAZvwLE0QIRncNUfdenm8yUbOv7E0hYUPiZhqabKyv7C0cT5EC5akvo+OiutxS5V6BATEcvVUex5C3zhT0ZHKdewjHG114Sm7CC0HPx0SWobfvGm8NmxTTDaTfKu1ZrGKyCOZp7eShApOYijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745987791; c=relaxed/simple;
	bh=mNwcZ12DVIgp1KDt4JOsLn951dBzIXA4pA/eTJKW2CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X01T772cIdFEZj8GHoeMmzr6NMaMDvzdY7FPY0+eTuqsfchSVLAMC9noC2srZ/tmF0aYMYZxoHk6aAnOLK2CTnpU1MvV6zX0jt5NGnaz+fATfC3nz1AQMRvEU6ymFac1rcwMZ7P9zM4Ii07mpvBDREGCNP3Xsh68b+BICusdbeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R0xheYrl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0xheYrl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745987788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0S+DsGS7mWjp4H2IgBQ5ZRk0DJ5l3yun+9LKz49K/Y=;
	b=R0xheYrl8kCVFyrMRrnww2Mtj2tB2bWAtapA1KwDV8Cd5XG0E9ILWgTHKUteiRKM5DZEbR
	jfwEtQAT1LvswrsZ0dMZmg9QhjVKbTkRgrQb2ot9Ea/Qb+Uc8aTIJE+EwsDWeyK0mC0PkB
	rkwAxc9jb5oI9l7FTzh9BCnLb1+SlKg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-B-aV5z2mP4SPNt6tAEFxqQ-1; Wed,
 30 Apr 2025 00:36:24 -0400
X-MC-Unique: B-aV5z2mP4SPNt6tAEFxqQ-1
X-Mimecast-MFC-AGG-ID: B-aV5z2mP4SPNt6tAEFxqQ_1745987782
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEC6619560BC;
	Wed, 30 Apr 2025 04:36:22 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EF7411800359;
	Wed, 30 Apr 2025 04:36:21 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V4 12/24] block: simplify elevator reattachment for updating nr_hw_queues
Date: Wed, 30 Apr 2025 12:35:14 +0800
Message-ID: <20250430043529.1950194-13-ming.lei@redhat.com>
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
index 54f1d8b4e35c..b920eaedbaa9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4943,88 +4943,10 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
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
@@ -5042,15 +4964,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
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
@@ -5084,9 +4997,8 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
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
index ac72c4f5a542..d7c9e1d2f305 100644
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
+	const char *name = "none";
+
+	WARN_ON_ONCE(q->mq_freeze_depth == 0);
+
+	mutex_lock(&q->elevator_lock);
+	if (q->elevator && !blk_queue_dying(q) && !blk_queue_registered(q))
+		name = q->elevator->type->elevator_name;
+	/* force to reattach elevator after nr_hw_queue is updated */
+	elevator_switch(q, name);
+	mutex_unlock(&q->elevator_lock);
+}
+
 static void elv_iosched_load_module(char *elevator_name)
 {
 	struct elevator_type *found;
-- 
2.47.0

