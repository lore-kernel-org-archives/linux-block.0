Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4CC155725
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291920; cv=none; b=UggKE6fp80OOrMGTcHuK/0uZcR7juiPsbadPqmch9bBAx8cxmDQ57idD3iTb0ia/pz4vFoXG5KrnjuxbseLYF97qr0qwBUsQhxU8MEdLEbrWBoDzNwfBIxv/SKV3wgD53RhY3jtAj49aflLd5EbND/iaryEForVpBSirI1UxQ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291920; c=relaxed/simple;
	bh=5Hvf/YMszIxRm8ZbOrrI4xqZ6200+EzXnKquIG8NtW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SepEUiDkL4DcNR1qF8OdlKgP8s6iRIUpicm6hRd8Yv2Ce3x8ytU5BB69EELKXodTX3Bq73Isy8sMUSuf3pKaF1E32DHGJLTjWqxKjKIYI/0H2JqYi4db11NmCffAtTgDYpwdE4GwLjFW8rxvWn+WkdSweoT/T5/0YhnAtUYRSAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jNGsGMtk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNGsGMtk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744291917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=133+/K49MltfKZhkXEIcW++J9FEWj1MGGw5FK8LNxEg=;
	b=jNGsGMtkOdeQxDE6nMg5mngrSCVnYgzS33ryv2nEeJhL47qHAIyFVa+BZWd/6KYT0xX3pr
	TmmcZoI8dFHWOwnKClm+oOw7ag+dLn17vM8wfI57IzuI5zF5hGsCah22KUwrYXvuMJvITJ
	lObHchPntjX0paURUgBIm+ZrVWus7rU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-hpWabvu7NDGCtm7HL3wqzQ-1; Thu,
 10 Apr 2025 09:31:52 -0400
X-MC-Unique: hpWabvu7NDGCtm7HL3wqzQ-1
X-Mimecast-MFC-AGG-ID: hpWabvu7NDGCtm7HL3wqzQ_1744291911
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F31CC1955BC6;
	Thu, 10 Apr 2025 13:31:50 +0000 (UTC)
Received: from localhost (unknown [10.72.120.20])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C282D1808882;
	Thu, 10 Apr 2025 13:31:49 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 13/15] block: remove several ->elevator_lock
Date: Thu, 10 Apr 2025 21:30:25 +0800
Message-ID: <20250410133029.2487054-14-ming.lei@redhat.com>
In-Reply-To: <20250410133029.2487054-1-ming.lei@redhat.com>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Both blk_mq_map_swqueue() and blk_mq_realloc_hw_ctxs() are only called
from queue initialization or updating nr_hw_queues code, in which
elevator switch can't happen any more.

So remove these ->elevator_lock uses.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0fb72a698d77..812dfe759b89 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4095,8 +4095,6 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 	struct blk_mq_ctx *ctx;
 	struct blk_mq_tag_set *set = q->tag_set;
 
-	mutex_lock(&q->elevator_lock);
-
 	queue_for_each_hw_ctx(q, hctx, i) {
 		cpumask_clear(hctx->cpumask);
 		hctx->nr_ctx = 0;
@@ -4201,8 +4199,6 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 		hctx->next_cpu = blk_mq_first_mapped_cpu(hctx);
 		hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
 	}
-
-	mutex_unlock(&q->elevator_lock);
 }
 
 /*
@@ -4506,16 +4502,9 @@ static void __blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
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
@@ -4547,7 +4536,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 
 	xa_init(&q->hctx_table);
 
-	blk_mq_realloc_hw_ctxs(set, q, false);
+	blk_mq_realloc_hw_ctxs(set, q);
 	if (!q->nr_hw_queues)
 		goto err_hctxs;
 
@@ -4962,7 +4951,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 fallback:
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		blk_mq_realloc_hw_ctxs(set, q, true);
+		blk_mq_realloc_hw_ctxs(set, q);
 
 		if (q->nr_hw_queues != set->nr_hw_queues) {
 			int i = prev_nr_hw_queues;
-- 
2.47.0

