Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB602144D6
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994322; cv=none; b=CpQvAtsrU84HaTWdM6vZMmyaP+mA/KQs0wq24Obo94lqoaW0xqAYd3Tibr7DY6Ur7oUaZR7OHjLyFD68ZfYTD0MU3Q33P7EMwbE+DLMU7HrRllLd0XF/mi9ik35cq6qsNQCfmC5t0CkWGcGXnBtcJ1jv00cT/KiGubZFZ6Is++o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994322; c=relaxed/simple;
	bh=qIuSPA71+8nJuqcbk1+fokcRFUpBhglUZPGljLPSrf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtjH7SNWR/noAKAOAQbKxzZz44C7y1ev5Na1jGxSEG25oe3SYV3Uj1jxlhERhZh5JHhCWGiVRR/8dCx57jqpZTeRpeEMo6qYROOPNxPKGl9ToackTBKkzSj7Zli3+3De8iwA4EXZLcjd3AMiH7hWwJKZHWViuw8adWM0n082z24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KVgBKL8y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KVgBKL8y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744994319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N1pSGQSZdF+YKyoAaPhYH4SBdfrMEc0N0nBXvfyV1tA=;
	b=KVgBKL8yrsQru39rzV0fSguD9l27TgSxLOk9xvZ0Vt6sw+THkEHx5PWZ6zB2uqbom87D6e
	qIN4bc4QazIxuEiKYkOwP822Ut0Iv/SAGRlf0a/UhLeFqKwdBJND4+SaDRzflPDVLISC6A
	ObMVqzBjCh0jxoSF0OjZz2BHvNQnFCc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-xQtKnscLMD2HQ8a157abSg-1; Fri,
 18 Apr 2025 12:38:35 -0400
X-MC-Unique: xQtKnscLMD2HQ8a157abSg-1
X-Mimecast-MFC-AGG-ID: xQtKnscLMD2HQ8a157abSg_1744994314
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B55B1800368;
	Fri, 18 Apr 2025 16:38:34 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2ABD630002C2;
	Fri, 18 Apr 2025 16:38:32 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 18/20] block: remove several ->elevator_lock
Date: Sat, 19 Apr 2025 00:36:59 +0800
Message-ID: <20250418163708.442085-19-ming.lei@redhat.com>
In-Reply-To: <20250418163708.442085-1-ming.lei@redhat.com>
References: <20250418163708.442085-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Both blk_mq_map_swqueue() and blk_mq_realloc_hw_ctxs() are called before
the request queue is added to tagset list, so the two won't run concurrently
with blk_mq_update_nr_hw_queues().

When the two functions are only called from queue initialization or
blk_mq_update_nr_hw_queues(), elevator switch can't happen.

So remove these ->elevator_lock uses.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8d08127e40be..4de3287ce6e3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4092,8 +4092,6 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 	struct blk_mq_ctx *ctx;
 	struct blk_mq_tag_set *set = q->tag_set;
 
-	mutex_lock(&q->elevator_lock);
-
 	queue_for_each_hw_ctx(q, hctx, i) {
 		cpumask_clear(hctx->cpumask);
 		hctx->nr_ctx = 0;
@@ -4198,8 +4196,6 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 		hctx->next_cpu = blk_mq_first_mapped_cpu(hctx);
 		hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
 	}
-
-	mutex_unlock(&q->elevator_lock);
 }
 
 /*
@@ -4503,16 +4499,9 @@ static void __blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
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
@@ -4544,7 +4533,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 
 	xa_init(&q->hctx_table);
 
-	blk_mq_realloc_hw_ctxs(set, q, false);
+	blk_mq_realloc_hw_ctxs(set, q);
 	if (!q->nr_hw_queues)
 		goto err_hctxs;
 
@@ -4961,7 +4950,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 fallback:
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		blk_mq_realloc_hw_ctxs(set, q, true);
+		blk_mq_realloc_hw_ctxs(set, q);
 
 		if (q->nr_hw_queues != set->nr_hw_queues) {
 			int i = prev_nr_hw_queues;
-- 
2.47.0

