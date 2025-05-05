Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A31A25C713
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454801; cv=none; b=DEUgYTUrTKjzNF6FCw5T6l7aNhAu1ucxpzFAVebSCxPfk5R6LWjKQVjtQmruySr/i98mNmlZRHS8xnPxhE3uNG5ZWlwXmtiQPJoOHim51i4vbRY/DoeQPAYTUI/8znsuEcVvHenGg9+66JYohuahcz5gNCXqG+cVHJrVgMDOVVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454801; c=relaxed/simple;
	bh=UPbN3iTzhVmlkTdY1byr99Ttly6KW9kmbO+HARvkBBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNe5AFqrm4uSwrYuP43PkNf6GUMBNdMfvjduenho1TBOR6B1FzvFHtYuMNJekVRQpmpZ+9XDyVhFh0oiN+XEYSbK6BMrPtxZZJO6HsZnzcg4zB6AOFuzIwTYZYxAFukDccG6Bs8N+ybJU1j3kr2ITqdLQc+1JXokfgLMOTi+INw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N0hGSuAR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0hGSuAR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746454798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8k5OJcjA26Jm9lCqbazgSUVhovviojJC1JFAB4GT1dg=;
	b=N0hGSuARONwQg5ABVxg9mZ6TgF5ti3uaYBjMgulTmNoWu+dMKTRPaAe9PVa3fdtGPifrhI
	1eBCZgLOzqwubFbEbVaqZ+SdAa141NUCRjtQLu7lhbyjzGlTCyPc8AvlB7RD5zheoCmSQy
	/AphNptZ7HWpBQjCLWwapr2DFHs4WFU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-i2ZrIR2XP56FGVa2-A9fTQ-1; Mon,
 05 May 2025 10:19:55 -0400
X-MC-Unique: i2ZrIR2XP56FGVa2-A9fTQ-1
X-Mimecast-MFC-AGG-ID: i2ZrIR2XP56FGVa2-A9fTQ_1746454794
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4F161955F04;
	Mon,  5 May 2025 14:19:53 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E434D1956096;
	Mon,  5 May 2025 14:19:52 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 23/25] block: don't acquire ->elevator_lock in blk_mq_map_swqueue and blk_mq_realloc_hw_ctxs
Date: Mon,  5 May 2025 22:18:01 +0800
Message-ID: <20250505141805.2751237-24-ming.lei@redhat.com>
In-Reply-To: <20250505141805.2751237-1-ming.lei@redhat.com>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Both blk_mq_map_swqueue() and blk_mq_realloc_hw_ctxs() are called before
the request queue is added to tagset list, so the two won't run concurrently
with blk_mq_update_nr_hw_queues().

When the two functions are only called from queue initialization or
blk_mq_update_nr_hw_queues(), elevator switch can't happen.

So remove ->elevator_lock uses from the two functions.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 32526d120bf4..c6098e569c02 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4158,8 +4158,6 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 	struct blk_mq_ctx *ctx;
 	struct blk_mq_tag_set *set = q->tag_set;
 
-	mutex_lock(&q->elevator_lock);
-
 	queue_for_each_hw_ctx(q, hctx, i) {
 		cpumask_clear(hctx->cpumask);
 		hctx->nr_ctx = 0;
@@ -4264,8 +4262,6 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 		hctx->next_cpu = blk_mq_first_mapped_cpu(hctx);
 		hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
 	}
-
-	mutex_unlock(&q->elevator_lock);
 }
 
 /*
@@ -4569,16 +4565,9 @@ static void __blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 }
 
 static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
-				   struct request_queue *q, bool lock)
+				   struct request_queue *q)
 {
-	if (lock) {
-		/* protect against switching io scheduler  */
-		mutex_lock(&q->elevator_lock);
-		__blk_mq_realloc_hw_ctxs(set, q);
-		mutex_unlock(&q->elevator_lock);
-	} else {
-		__blk_mq_realloc_hw_ctxs(set, q);
-	}
+	__blk_mq_realloc_hw_ctxs(set, q);
 
 	/* unregister cpuhp callbacks for exited hctxs */
 	blk_mq_remove_hw_queues_cpuhp(q);
@@ -4610,7 +4599,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 
 	xa_init(&q->hctx_table);
 
-	blk_mq_realloc_hw_ctxs(set, q, false);
+	blk_mq_realloc_hw_ctxs(set, q);
 	if (!q->nr_hw_queues)
 		goto err_hctxs;
 
@@ -5021,7 +5010,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 fallback:
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		blk_mq_realloc_hw_ctxs(set, q, true);
+		blk_mq_realloc_hw_ctxs(set, q);
 
 		if (q->nr_hw_queues != set->nr_hw_queues) {
 			int i = prev_nr_hw_queues;
-- 
2.47.0

