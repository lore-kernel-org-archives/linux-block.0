Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73281178372
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508192; cv=none; b=qGBTYZAPW25HTjIzsm44GKVO1cl/2Cg2/+yqtjAkDHvaWj4E5FdXiv3cBdP9hBfQs8BvQpzvlEWeDlfJbQF2uMlQbKShhaAuJ5j/GRls9MLh66hy2i3QSjcK4AZENTRQbP3Fl8NFXInfTRnQ6kJXAMZ4+9O837ZU2MRCn90Wt4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508192; c=relaxed/simple;
	bh=q6hu2IpFakQNEnSTE44ZUaJVt2Iid/KBdFQI0YHNhwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxOiKSmT3zK3zJiiTr+uMpqM+tU+7FZfYeij3yzP8e61ulW2kIegfUN/Guczh/kO3CHIZpHOv9fYhK6gnx91csQdgdfYnxD+0wdKWXN7makx7ketOtCSVShOG7qRYQSWtsJbeL3trmnXAn7dQpNqzzvYeF54SOstmJiLwX35+Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HLirn6Od; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLirn6Od"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745508189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YA02Werfu4M5OhQnSRT/rkW3dwPFXuwPZU7KVioAlg=;
	b=HLirn6OdJIEtLneVm/xV1X160lbhK1SBevz9gZeX71aFNvoMZxUw6ZYhYO8xEk8H19MDjl
	HQPgdaAbHJ5yfSCkvlskob47cC2SX7/U0HMHmc4zH8/5J/lOZdt4GCib5J5xhSCl+rHo7b
	Zj4qVuY+xzL6fy2jQs3uxyZnWKv83zY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-WyPbGCoaOA21FxiITYJoYw-1; Thu,
 24 Apr 2025 11:23:08 -0400
X-MC-Unique: WyPbGCoaOA21FxiITYJoYw-1
X-Mimecast-MFC-AGG-ID: WyPbGCoaOA21FxiITYJoYw_1745508186
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B91ED19560AE;
	Thu, 24 Apr 2025 15:23:06 +0000 (UTC)
Received: from localhost (unknown [10.72.116.90])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE11419560A3;
	Thu, 24 Apr 2025 15:23:05 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 18/20] block: remove several ->elevator_lock
Date: Thu, 24 Apr 2025 23:21:41 +0800
Message-ID: <20250424152148.1066220-19-ming.lei@redhat.com>
In-Reply-To: <20250424152148.1066220-1-ming.lei@redhat.com>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Both blk_mq_map_swqueue() and blk_mq_realloc_hw_ctxs() are called before
the request queue is added to tagset list, so the two won't run concurrently
with blk_mq_update_nr_hw_queues().

When the two functions are only called from queue initialization or
blk_mq_update_nr_hw_queues(), elevator switch can't happen.

So remove these ->elevator_lock uses.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 420150eb5a45..e08eda094ae7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4112,8 +4112,6 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 	struct blk_mq_ctx *ctx;
 	struct blk_mq_tag_set *set = q->tag_set;
 
-	mutex_lock(&q->elevator_lock);
-
 	queue_for_each_hw_ctx(q, hctx, i) {
 		cpumask_clear(hctx->cpumask);
 		hctx->nr_ctx = 0;
@@ -4218,8 +4216,6 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 		hctx->next_cpu = blk_mq_first_mapped_cpu(hctx);
 		hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
 	}
-
-	mutex_unlock(&q->elevator_lock);
 }
 
 /*
@@ -4523,16 +4519,9 @@ static void __blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
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
@@ -4564,7 +4553,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 
 	xa_init(&q->hctx_table);
 
-	blk_mq_realloc_hw_ctxs(set, q, false);
+	blk_mq_realloc_hw_ctxs(set, q);
 	if (!q->nr_hw_queues)
 		goto err_hctxs;
 
@@ -4975,7 +4964,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 fallback:
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		blk_mq_realloc_hw_ctxs(set, q, true);
+		blk_mq_realloc_hw_ctxs(set, q);
 
 		if (q->nr_hw_queues != set->nr_hw_queues) {
 			int i = prev_nr_hw_queues;
-- 
2.47.0

