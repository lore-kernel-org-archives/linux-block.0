Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B236AD3
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 04:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745987827; cv=none; b=PQZh5B8Y/yp6904iaDhuzNbGWaLqYolWnva57HKSwyvlKIMC7Jh1jxZDbwCL19YT2wnFvpF8tosw/ZoomtdvOzZvYJfaHw9/JMt00NpD7CIFHAO0xpbJJV1W9QaEzVBcMmIjfAWXAC7p57qORZy0UY8WvnpDQFjYOxZovMJZTt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745987827; c=relaxed/simple;
	bh=teGegAnYkf192UAsagneKAJVehhoU7eUsM33FHFgqbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YC3HfifPVByLVAzDRiDdvOY8pnPEqzWtuhUV9d8RGTolFIKJmOZTpsx3rWbrxJTKxh3WVlHNvGZiyEMMR614izczfp8KzgL5/Tq1P7lzvcAZucbbEthMZANtZGxS5v2IB2uim7twYRYV9AhcttkVwB60xOh8xXm3CL3MBLkzh1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YqFi5MOC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YqFi5MOC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745987824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CCQ+Fi2e0gmOJkkf4POtzMsJVzv7tmA+RILZOlFUy30=;
	b=YqFi5MOCt5lJ2yXJeVaDSSQ19aNnurSaMxQhaW04M7LsaJaB3peMPXvS0tZJOPW0DXUXD2
	AFrSoQ5k/+HKsJ0NYRyEzKc0vMU46fBEfzwQyHcLp40m674JGKl8XBTrTGLAXlAQXuRVso
	j1XxeNq6WiUsRqGp9M0gqKe2lvH9IPU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-cfVwBzf3Oy-znZt9p5Y04w-1; Wed,
 30 Apr 2025 00:37:00 -0400
X-MC-Unique: cfVwBzf3Oy-znZt9p5Y04w-1
X-Mimecast-MFC-AGG-ID: cfVwBzf3Oy-znZt9p5Y04w_1745987819
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51BB31956095;
	Wed, 30 Apr 2025 04:36:59 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5273F180045B;
	Wed, 30 Apr 2025 04:36:57 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V4 22/24] block: don't acquire ->elevator_lock in blk_mq_map_swqueue and blk_mq_realloc_hw_ctxs
Date: Wed, 30 Apr 2025 12:35:24 +0800
Message-ID: <20250430043529.1950194-23-ming.lei@redhat.com>
In-Reply-To: <20250430043529.1950194-1-ming.lei@redhat.com>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
index 33bffacc33db..4e6bc065c955 100644
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

