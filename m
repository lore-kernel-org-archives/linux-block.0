Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0C925C822
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454752; cv=none; b=bkrBU3n7ZRsq5oLnDAhFqMOpHQAqrkojBU4qjaEi2W/0WNlD7ic0nGfUvsjS8nK0bcoUH7vyopaWbjwZi416YZe0zYjRKeoQ057Vri77Gsvv2p2ZURdiyno5Eu8jG86JefoBKnBiNiF+1x0bjM4NbTSI6/BlORwvZgufaA2DwTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454752; c=relaxed/simple;
	bh=r+gXJEsOq2+qXL1avMwnnuMqCrUFMyJxZ4yH06ceyqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpnWYdYc6mdbB7BELEuSgxPu11wmLNkoDEZ6/n+jMm+INVvfwrXmnCBMXmoFX4yHDURBcPgVMDx/zOQ/a6B4qCWbzZpqGxIzN+hn+PcshmcStS068xUu1KXaEe3Vug5Y1DIiA107vPvArD5eTsIPj7LoMB4Tab8/+PbWZDpdkbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ju3Imj4q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ju3Imj4q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746454749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ljt8C2K8Wn+0dUvJxWSGsIP2LHtNCMxcqNJlfIadg7M=;
	b=Ju3Imj4qMkTB8tzWeN2GmkMzPTSqS7v38W/rWa0mqVDKd+hXx9QjdkfBD2O79bIH0cpX3q
	zsMWKgjDVf9wmXIRHZzHFlyvHxgKjkqoiQZJttjrwWl/bboDpQpvJZGW0SP5G0HJulgxgD
	oLjhjT/e1DGaVXzN+VypmYijcMd3cFM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-FE2em6JHMEm0RzRg7rOzUw-1; Mon,
 05 May 2025 10:19:05 -0400
X-MC-Unique: FE2em6JHMEm0RzRg7rOzUw-1
X-Mimecast-MFC-AGG-ID: FE2em6JHMEm0RzRg7rOzUw_1746454744
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DAD9195608B;
	Mon,  5 May 2025 14:19:04 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C5CF19560A3;
	Mon,  5 May 2025 14:19:02 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 11/25] block: fold elevator_disable into elevator_switch
Date: Mon,  5 May 2025 22:17:49 +0800
Message-ID: <20250505141805.2751237-12-ming.lei@redhat.com>
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

From: Christoph Hellwig <hch@lst.de>

This removes duplicate code, and keeps the callers tidy.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 61 ++++++++++++++++++------------------------------
 1 file changed, 23 insertions(+), 38 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 286d240a3aef..766deaf34214 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -623,15 +623,17 @@ void elevator_init_mq(struct request_queue *q)
  */
 int elevator_switch(struct request_queue *q, const char *name)
 {
-	struct elevator_type *new_e;
-	int ret;
+	struct elevator_type *new_e = NULL;
+	int ret = 0;
 
 	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 	lockdep_assert_held(&q->elevator_lock);
 
-	new_e = elevator_find_get(name);
-	if (!new_e)
-		return -EINVAL;
+	if (strncmp(name, "none", 4)) {
+		new_e = elevator_find_get(name);
+		if (!new_e)
+			return -EINVAL;
+	}
 
 	blk_mq_quiesce_queue(q);
 
@@ -640,16 +642,21 @@ int elevator_switch(struct request_queue *q, const char *name)
 		elevator_exit(q);
 	}
 
-	ret = blk_mq_init_sched(q, new_e);
-	if (ret)
-		goto out_unfreeze;
-
-	ret = elv_register_queue(q, true);
-	if (ret) {
-		elevator_exit(q);
-		goto out_unfreeze;
+	if (new_e) {
+		ret = blk_mq_init_sched(q, new_e);
+		if (ret)
+			goto out_unfreeze;
+		ret = elv_register_queue(q, true);
+		if (ret) {
+			elevator_exit(q);
+			goto out_unfreeze;
+		}
+	} else {
+		blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
+		q->elevator = NULL;
+		q->nr_requests = q->tag_set->queue_depth;
 	}
-	blk_add_trace_msg(q, "elv switch: %s", new_e->elevator_name);
+	blk_add_trace_msg(q, "elv switch: %s", name);
 
 out_unfreeze:
 	blk_mq_unquiesce_queue(q);
@@ -659,27 +666,11 @@ int elevator_switch(struct request_queue *q, const char *name)
 			new_e->elevator_name);
 	}
 
-	elevator_put(new_e);
+	if (new_e)
+		elevator_put(new_e);
 	return ret;
 }
 
-void elevator_disable(struct request_queue *q)
-{
-	WARN_ON_ONCE(q->mq_freeze_depth == 0);
-	lockdep_assert_held(&q->elevator_lock);
-
-	blk_mq_quiesce_queue(q);
-
-	elv_unregister_queue(q);
-	elevator_exit(q);
-	blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
-	q->elevator = NULL;
-	q->nr_requests = q->tag_set->queue_depth;
-	blk_add_trace_msg(q, "elv switch: none");
-
-	blk_mq_unquiesce_queue(q);
-}
-
 /*
  * Switch this queue to the given IO scheduler.
  */
@@ -689,12 +680,6 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
 	if (!blk_queue_registered(q))
 		return -ENOENT;
 
-	if (!strncmp(elevator_name, "none", 4)) {
-		if (q->elevator)
-			elevator_disable(q);
-		return 0;
-	}
-
 	if (q->elevator && elevator_match(q->elevator->type, elevator_name))
 		return 0;
 
-- 
2.47.0

