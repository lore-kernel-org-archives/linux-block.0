Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B002E1DE4F3
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508159; cv=none; b=MiBUAzo1vNFREI4wnoaT9ITeqlztXbHGIZNoLuPCblGQY9HtUAEssYIBMf8ieKXaYObL2KCjl659nccRNcVFjlj/+hX2WhBFs1xmCl7KstnfHkf1JfT7ea7OThPxpjDCnWFWozwa9wjphGMxAsMS2/XDEQAUUUzupyBTiFq/vlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508159; c=relaxed/simple;
	bh=9Y+uLVgpMFwu+BOFROPLqgK/uDrV63DEZTeglMKl+6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Epf1NgCrmQFWJ1gVicTDdCv8Lu6PAiTi6g42YIHPyP2AEB+PbJ9x5V1ZNrKo/AKp5Wd1aDRVcmrVhn2PzFpyQbKvsyzA3m9VdjZNa3kUshY0ZhjvV1jv682W9m0QRGPn8KD7RMTd/HViti2omBCZUYmPhjmqtqnN/6jlSxAin7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LrQtX6ax; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LrQtX6ax"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745508156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NBBnsgr6PcXLV6GPho/rGat72Y6TJBBkBDUfDVtbHC4=;
	b=LrQtX6axaTWiVw9yDTcLrM9P4Xh4nfhCHcAOrekrrPqgVVGE1iyv1t2YSZUtmRAv3bnoL8
	n2UaWuhlRbqmO9noEW2S1TzKFcJgAR5inv3+hEE9ia6+KH/n70zHHMRPLd79S5IqKPlqwJ
	eXhvsaXadEIxGDu8uea0qdgHu6N1koA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-dj9Pr3V2M36LIGH2xVmxTA-1; Thu,
 24 Apr 2025 11:22:33 -0400
X-MC-Unique: dj9Pr3V2M36LIGH2xVmxTA-1
X-Mimecast-MFC-AGG-ID: dj9Pr3V2M36LIGH2xVmxTA_1745508151
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19E1A18004A7;
	Thu, 24 Apr 2025 15:22:31 +0000 (UTC)
Received: from localhost (unknown [10.72.116.90])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 37F8219560AB;
	Thu, 24 Apr 2025 15:22:29 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 09/20] block: simplify elevator reattachment for updating nr_hw_queues
Date: Thu, 24 Apr 2025 23:21:32 +0800
Message-ID: <20250424152148.1066220-10-ming.lei@redhat.com>
In-Reply-To: <20250424152148.1066220-1-ming.lei@redhat.com>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

In blk_mq_update_nr_hw_queues(), nr_hw_queues changes and elevator data
depends on it, so elevator has to be reattached.

Now elevator switch isn't allowed during blk_mq_update_nr_hw_queues(), so
we can simply call elevator_change() to reattach elevator sched tags after
nr_hw_queues is updated.

Add elv_update_nr_hw_queues() for blk_mq_update_nr_hw_queues() to
reattach elevator.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c   | 90 +-----------------------------------------------
 block/blk.h      |  3 +-
 block/elevator.c | 32 +++++++++++++----
 3 files changed, 28 insertions(+), 97 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1ed2d183f912..3afcddd21586 100644
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
index 006e3be433d2..2969f4427996 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -319,8 +319,7 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 
 bool blk_insert_flush(struct request *rq);
 
-int elevator_switch(struct request_queue *q, struct elevator_type *new_e);
-void elevator_disable(struct request_queue *q);
+void elv_update_nr_hw_queues(struct request_queue *q);
 void elevator_exit(struct request_queue *q);
 int elv_register_queue(struct request_queue *q, bool uevent);
 void elv_unregister_queue(struct request_queue *q);
diff --git a/block/elevator.c b/block/elevator.c
index 56da6ab7691a..5705f7056516 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -621,7 +621,7 @@ void elevator_init_mq(struct request_queue *q)
  * If switching fails, we are most likely running out of memory and not able
  * to restore the old io scheduler, so leaving the io scheduler being none.
  */
-int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
+static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 {
 	int ret;
 
@@ -657,7 +657,7 @@ int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 	return ret;
 }
 
-void elevator_disable(struct request_queue *q)
+static void elevator_disable(struct request_queue *q)
 {
 	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 	lockdep_assert_held(&q->elevator_lock);
@@ -677,7 +677,8 @@ void elevator_disable(struct request_queue *q)
 /*
  * Switch this queue to the given IO scheduler.
  */
-static int elevator_change(struct request_queue *q, const char *elevator_name)
+static int __elevator_change(struct request_queue *q,
+			     const char *elevator_name)
 {
 	struct elevator_type *e;
 	int ret;
@@ -692,9 +693,6 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
 		return 0;
 	}
 
-	if (q->elevator && elevator_match(q->elevator->type, elevator_name))
-		return 0;
-
 	e = elevator_find_get(elevator_name);
 	if (!e)
 		return -EINVAL;
@@ -703,6 +701,28 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
 	return ret;
 }
 
+static int elevator_change(struct request_queue *q, const char *elevator_name)
+{
+	if (!q->elevator || !elevator_match(q->elevator->type, elevator_name))
+		return __elevator_change(q, elevator_name);
+	return 0;
+}
+
+/*
+ * The I/O scheduler depends on the number of hardware queues, this forces a
+ * reattachment when nr_hw_queues changes.
+ */
+void elv_update_nr_hw_queues(struct request_queue *q)
+{
+	const char *name = "none";
+
+	mutex_lock(&q->elevator_lock);
+	if (q->elevator && !blk_queue_dying(q))
+		name = q->elevator->type->elevator_name;
+	__elevator_change(q, name);
+	mutex_unlock(&q->elevator_lock);
+}
+
 static void elv_iosched_load_module(char *elevator_name)
 {
 	struct elevator_type *found;
-- 
2.47.0

