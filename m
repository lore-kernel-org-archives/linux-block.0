Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC8D2BF00D
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 07:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755244611; cv=none; b=h2BdsviYV9cVp1txiEcIE249/R59klcq4Zn4D39kOeXDEotTYCD7oDVm9EWuCI8WgH1TGSetsjxSsxLZHOcYuhgkNfncxHIhCfrI/g1VfKFIaq/+/7gfG+vNS25qhfzQIaiG7SLz/RkMxZsQHczn77+RoCkGeM0kJdRLFJTTjqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755244611; c=relaxed/simple;
	bh=ej/G+JfUURwKhwbXMGuX/6ZSVouqwIMP5mPhvQx5ww0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Np2m+hYL4FwvJs6AjgHD+uBByauPl0apwgFsezPAlPxcuQDcJz4nB2zc7cH3Ow3Jp/wTrR+sCr+oCutu2nXNhkHloAxhcomI2aG/SqkhcT/LfUTGKMVqhggoit4qPhj6WEcmk0ukt03zp8DYdNyI6nnIRvdfNNFi3vgDeCijN9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yvnwog5v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yvnwog5v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755244607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EWsDiF5vtRFCTtnGcJOw9iCTkMsbr+/TFWlpxyZYcng=;
	b=Yvnwog5v2M6aIp/cWQP75qPbv36r5RiM66eAyOiL2T6mU8EBZ7n1ejFit4YN2W+80yQ6IT
	a8m3JZevn1jDfXfe2CG58NWEj9A0dyPpSQrsFJN/4sF8ZoyLKzzNtf9WAhVWk3zX5Z4AU2
	2n+dKnbt+ClR7E2pAGkdthtBfGSL+cg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-GGN4v-dMP-S8NfMvDMS_wg-1; Fri,
 15 Aug 2025 03:56:45 -0400
X-MC-Unique: GGN4v-dMP-S8NfMvDMS_wg-1
X-Mimecast-MFC-AGG-ID: GGN4v-dMP-S8NfMvDMS_wg_1755244604
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E39D419775A6;
	Fri, 15 Aug 2025 07:56:43 +0000 (UTC)
Received: from localhost (unknown [10.72.116.153])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF62130001A2;
	Fri, 15 Aug 2025 07:56:41 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH] blk-mq: fix lockdep warning in __blk_mq_update_nr_hw_queues
Date: Fri, 15 Aug 2025 15:56:36 +0800
Message-ID: <20250815075636.304660-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Commit 5989bfe6ac6b ("block: restore two stage elevator switch while
running nr_hw_queue update") reintroduced a lockdep warning by calling
blk_mq_freeze_queue_nomemsave() before switching the I/O scheduler.

The function blk_mq_elv_switch_none() calls elevator_change_done().
Running this while the queue is frozen causes a lockdep warning.

Fix this by reordering the operations: first, switch the I/O scheduler
to 'none', and then freeze the queue. This ensures that elevator_change_done()
is not called on an already frozen queue. And this way is safe because
elevator_set_none() does freeze queue before switching to none.

Also we still have to rely on blk_mq_elv_switch_back() for switching
back, and it has to cover unfrozen queue case.

Cc: Nilay Shroff <nilay@linux.ibm.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Fixes: 5989bfe6ac6b ("block: restore two stage elevator switch while running nr_hw_queue update")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c   | 13 +++++++------
 block/blk.h      |  2 +-
 block/elevator.c | 12 +++++++++---
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b67d6c02eceb..9c62781c6b8c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4974,13 +4974,13 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
  * Switch back to the elevator type stored in the xarray.
  */
 static void blk_mq_elv_switch_back(struct request_queue *q,
-		struct xarray *elv_tbl, struct xarray *et_tbl)
+		struct xarray *elv_tbl, struct xarray *et_tbl, bool frozen)
 {
 	struct elevator_type *e = xa_load(elv_tbl, q->id);
 	struct elevator_tags *t = xa_load(et_tbl, q->id);
 
 	/* The elv_update_nr_hw_queues unfreezes the queue. */
-	elv_update_nr_hw_queues(q, e, t);
+	elv_update_nr_hw_queues(q, e, t, frozen);
 
 	/* Drop the reference acquired in blk_mq_elv_switch_none. */
 	if (e)
@@ -5033,6 +5033,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	unsigned int memflags;
 	int i;
 	struct xarray elv_tbl, et_tbl;
+	bool queues_frozen = false;
 
 	lockdep_assert_held(&set->tag_list_lock);
 
@@ -5056,9 +5057,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_sysfs_unregister_hctxs(q);
 	}
 
-	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		blk_mq_freeze_queue_nomemsave(q);
-
 	/*
 	 * Switch IO scheduler to 'none', cleaning up the data associated
 	 * with the previous scheduler. We will switch back once we are done
@@ -5068,6 +5066,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		if (blk_mq_elv_switch_none(q, &elv_tbl))
 			goto switch_back;
 
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		blk_mq_freeze_queue_nomemsave(q);
+	queues_frozen = true;
 	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0)
 		goto switch_back;
 
@@ -5092,7 +5093,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 switch_back:
 	/* The blk_mq_elv_switch_back unfreezes queue for us. */
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		blk_mq_elv_switch_back(q, &elv_tbl, &et_tbl);
+		blk_mq_elv_switch_back(q, &elv_tbl, &et_tbl, queues_frozen);
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_sysfs_register_hctxs(q);
diff --git a/block/blk.h b/block/blk.h
index 0a2eccf28ca4..601db258c00d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -332,7 +332,7 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 bool blk_insert_flush(struct request *rq);
 
 void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e,
-		struct elevator_tags *t);
+		struct elevator_tags *t, bool frozen);
 void elevator_set_default(struct request_queue *q);
 void elevator_set_none(struct request_queue *q);
 
diff --git a/block/elevator.c b/block/elevator.c
index fe96c6f4753c..0644b2d35ecb 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -706,24 +706,30 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
  * reattachment when nr_hw_queues changes.
  */
 void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e,
-		struct elevator_tags *t)
+		struct elevator_tags *t, bool frozen)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 	struct elv_change_ctx ctx = {};
 	int ret = -ENODEV;
 
-	WARN_ON_ONCE(q->mq_freeze_depth == 0);
+	WARN_ON_ONCE(frozen == (q->mq_freeze_depth == 0));
 
 	if (e && !blk_queue_dying(q) && blk_queue_registered(q)) {
 		ctx.name = e->elevator_name;
 		ctx.et = t;
 
+		/* elevator switch requires queue to be frozen */
+		if (!frozen) {
+			blk_mq_freeze_queue_nomemsave(q);
+			frozen = true;
+		}
 		mutex_lock(&q->elevator_lock);
 		/* force to reattach elevator after nr_hw_queue is updated */
 		ret = elevator_switch(q, &ctx);
 		mutex_unlock(&q->elevator_lock);
 	}
-	blk_mq_unfreeze_queue_nomemrestore(q);
+	if (frozen)
+		blk_mq_unfreeze_queue_nomemrestore(q);
 	if (!ret)
 		WARN_ON_ONCE(elevator_change_done(q, &ctx));
 	/*
-- 
2.50.1

