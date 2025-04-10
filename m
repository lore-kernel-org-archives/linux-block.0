Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0234270EDD
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291888; cv=none; b=dtAgB8B6hWR/IpFUYXIcuVzoqn6uPxD5XmdBFKGxU7nZ96rjvYvS5N+zmhBXa8Y5Zw5J6mHDfkuVDxyS+mnmDspUU+cMEnW1u27taVxNGrCuW3GIMQ6yPbR7JP6Zmb37xN4eHFFLNHVQNYvSkXt/EaUTCJVO7KwuUqxv8Qec2ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291888; c=relaxed/simple;
	bh=bIItKvllyzkv/stnQfIRoG2izOGgwrCVHEYBbl+75sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bR1XoDnVVPUoJTOMCNzDaWBVAuvlWnsdErvNbjXfKxUsKlePDa5xhvFMiEs5qYfB+hzzBA2Q1RyfognGt8vnlzAvLnR7+BEGc7SDssFwzk5KUCjIMxIrgsciaO1PMKCWsgYLbaoXjga2gEuP4aQwdUUMJA1QdL/AKkwRf15yTFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1J9vDxX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1J9vDxX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744291885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iSAjPXD943HbiwtD4xIES+89vR/waJNMHZahYJfS6Kw=;
	b=E1J9vDxX+6/kkOSKuZ8atj28GYwVPyFp1/xSbreroQQB9GzEoPqrPlTOSn8Jk2me3ffCqR
	AfSqEZlEwsnsRc9Yai4rGi0IEs5j1DT21qol3I8gjsbLoic4FWR3OfEoJ33sssbuJ8kzeV
	fUHK9EqgfXhN9PNO3uwDRzlxX0Iy4xw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-TZl929hcPeCoXB1PeJr3-g-1; Thu,
 10 Apr 2025 09:31:18 -0400
X-MC-Unique: TZl929hcPeCoXB1PeJr3-g-1
X-Mimecast-MFC-AGG-ID: TZl929hcPeCoXB1PeJr3-g_1744291874
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06077180882E;
	Thu, 10 Apr 2025 13:31:14 +0000 (UTC)
Received: from localhost (unknown [10.72.120.20])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BC3EE180174E;
	Thu, 10 Apr 2025 13:31:12 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 05/15] block: simplify elevator reset for updating nr_hw_queues
Date: Thu, 10 Apr 2025 21:30:17 +0800
Message-ID: <20250410133029.2487054-6-ming.lei@redhat.com>
In-Reply-To: <20250410133029.2487054-1-ming.lei@redhat.com>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

In blk_mq_update_nr_hw_queues(), nr_hw_queues may change, so elevator has
to be reset after nr_hw_queues is changed.

Now elevator switch isn't allowed during blk_mq_update_nr_hw_queues(), so
we can simply call elevator_change() to reset elevator sched tags after
nr_hw_queues is updated.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c   | 99 +++++-------------------------------------------
 block/blk.h      |  4 +-
 block/elevator.c | 12 +++---
 3 files changed, 18 insertions(+), 97 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4b0707fb7ae3..b7e3cd355e66 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4930,88 +4930,10 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
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
-	elevator_switch(q, t);
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
@@ -5029,15 +4951,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
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
@@ -5071,9 +4984,15 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_debugfs_register_hctxs(q);
 	}
 
-switch_back:
-	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		blk_mq_elv_switch_back(&head, q);
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		const char *name = "none";
+
+		mutex_lock(&q->elevator_lock);
+		if (q->elevator && !blk_queue_dying(q))
+			name = q->elevator->type->elevator_name;
+		__elevator_change(q, name, true);
+		mutex_unlock(&q->elevator_lock);
+	}
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_unfreeze_queue_nomemrestore(q);
diff --git a/block/blk.h b/block/blk.h
index 006e3be433d2..0c3cc1af2525 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -319,8 +319,8 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 
 bool blk_insert_flush(struct request *rq);
 
-int elevator_switch(struct request_queue *q, struct elevator_type *new_e);
-void elevator_disable(struct request_queue *q);
+int __elevator_change(struct request_queue *q, const char *elevator_name,
+		      bool force);
 void elevator_exit(struct request_queue *q);
 int elv_register_queue(struct request_queue *q, bool uevent);
 void elv_unregister_queue(struct request_queue *q);
diff --git a/block/elevator.c b/block/elevator.c
index 7d7b77dd4341..612fa2bdd40d 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -619,7 +619,7 @@ void elevator_init_mq(struct request_queue *q)
  * If switching fails, we are most likely running out of memory and not able
  * to restore the old io scheduler, so leaving the io scheduler being none.
  */
-int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
+static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 {
 	int ret;
 
@@ -655,7 +655,7 @@ int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 	return ret;
 }
 
-void elevator_disable(struct request_queue *q)
+static void elevator_disable(struct request_queue *q)
 {
 	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 	lockdep_assert_held(&q->elevator_lock);
@@ -675,7 +675,8 @@ void elevator_disable(struct request_queue *q)
 /*
  * Switch this queue to the given IO scheduler.
  */
-static int elevator_change(struct request_queue *q, const char *elevator_name)
+int __elevator_change(struct request_queue *q, const char *elevator_name,
+		      bool force)
 {
 	struct elevator_type *e;
 	int ret;
@@ -690,7 +691,8 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
 		return 0;
 	}
 
-	if (q->elevator && elevator_match(q->elevator->type, elevator_name))
+	if (!force && q->elevator &&
+	    elevator_match(q->elevator->type, elevator_name))
 		return 0;
 
 	e = elevator_find_get(elevator_name);
@@ -742,7 +744,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 
 	memflags = blk_mq_freeze_queue(q);
 	mutex_lock(&q->elevator_lock);
-	ret = elevator_change(q, name);
+	ret = __elevator_change(q, name, false);
 	if (!ret)
 		ret = count;
 	mutex_unlock(&q->elevator_lock);
-- 
2.47.0

