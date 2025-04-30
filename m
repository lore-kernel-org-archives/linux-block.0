Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AA5210FB
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 04:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745987784; cv=none; b=ZfYmQKcPzCYJonXGMcVinW4AvgxWKCeGinVWZBhEW66uSDC6rH1vOiSqvJS5aDJm58RcV5FbUGZmyPhH6+p7gPbxXNDjuf1C4BBMQST/DbxCMViF//gOnb1a+8nqZSOVs56ulP2cKH0zNKOJW/JdUS6x1RI2wskFk9HlLTi+Xwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745987784; c=relaxed/simple;
	bh=HXkdwL4mPrkyF594Ev2NRH2W3qjEETBbZNa8ppInXRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GleS5ZTMO7LZA9QTDAP+TVW+M687Z0yfsgrR1aa/uw/MFKf93MhANE93iakllANmeI0FfPK+FMX8ZEBOdJ9Z6NfrKJO0Jm+mfTLp7TzeCD1sznZ2lnypqx7X3GLzRZfSb+jhU8DvFGD1/s9+xbCj/Wg1aPBG0DB/rZjR5xSnEIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G682oqPU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G682oqPU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745987781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q8zCwz/wcGf6npt9J4hE1hCR+YRamJt7nGhmzbw9R8k=;
	b=G682oqPUm2b0zN+GcEceglMdx3/UI7VIeYb/n+stJccXDuQuRkem0cKpJiInJpA3MGJYvy
	FmnRAEcF9Ildo9fODJEni9leXkh9maSzlWTTPfi0168GgomHYXpP57wLsoKEwhe0WkcC05
	w0jg4hV0VWWlC3W9nZY5AZrWw69YWJA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-qiWo_hjbNfej6feOUvghQQ-1; Wed,
 30 Apr 2025 00:36:17 -0400
X-MC-Unique: qiWo_hjbNfej6feOUvghQQ-1
X-Mimecast-MFC-AGG-ID: qiWo_hjbNfej6feOUvghQQ_1745987775
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA9BE195608C;
	Wed, 30 Apr 2025 04:36:15 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CCFFE180045C;
	Wed, 30 Apr 2025 04:36:14 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 10/24] block: fold elevator_disable into elevator_switch
Date: Wed, 30 Apr 2025 12:35:12 +0800
Message-ID: <20250430043529.1950194-11-ming.lei@redhat.com>
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

From: Christoph Hellwig <hch@lst.de>

This removes duplicate code, and keeps the callers tidy.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 61 ++++++++++++++++++------------------------------
 1 file changed, 23 insertions(+), 38 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 3ab4ed17de0f..df3e59107a2a 100644
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

