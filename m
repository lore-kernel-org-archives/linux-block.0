Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A70318129
	for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524272; cv=none; b=WZi2zJNp3Ygi/jEkdgupSa/i3FPUhnSjd2oZvjaroLMR7o8Tm085N/Yc/CRJHs0b26EetI1Wr4BXfiYxcKn/7QwbG/X4t503s6/OPRze3ObEE4gmFQ0lkqDY7fd49B72djLCo4/jqR5QtEWafiT2TugnnVVUgEfUiYd9viA6zBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524272; c=relaxed/simple;
	bh=pwWXGIejlgiRRcl7cVuLUQd3HXh/UzFwqtQEajDt3TU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fWmKVZiJcQHy0M+UeG027BycvReAi6d4xoQSvVrghURELcg76oVJAhFKglN34Vx9HM1pBHWRN6ON7ocStCUFmRD+lmOO7Ph4rtQX2mh+Cy9ekTEikq/e5fOIcAypbXkhr/8HqVHXLe9eRSOmJZRQq34hCekJFbM7KLQt0W0wr1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O/aPmThv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/aPmThv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760524268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UGKq9guDXFjWy4i1YZYNjQbqbv1+4qmTfLDa3T406A4=;
	b=O/aPmThv60yWCfntAbZimlkMAoxwquC/CkcbqXoMGlqMdCGfySLWsdZMCoWCxhEKHYYJwf
	7fbdoOEdbiUyM77Modh5ouof40LRvHhblUsYQV3cHMB84Z8J0xiqCJ0gCr9LFnOrHIifEO
	xehSWgXvVITZznGZYwCirCeapJwcPns=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-csudgkOzPI26tfoPiUdGJQ-1; Wed,
 15 Oct 2025 06:31:06 -0400
X-MC-Unique: csudgkOzPI26tfoPiUdGJQ-1
X-Mimecast-MFC-AGG-ID: csudgkOzPI26tfoPiUdGJQ_1760524265
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 317221956089;
	Wed, 15 Oct 2025 10:31:05 +0000 (UTC)
Received: from localhost (unknown [10.72.120.29])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CAAD619560B5;
	Wed, 15 Oct 2025 10:31:03 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: Remove elevator_lock usage from blkg_conf frozen operations
Date: Wed, 15 Oct 2025 18:30:39 +0800
Message-ID: <20251015103055.1357105-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Remove the acquisition and release of q->elevator_lock in the
blkg_conf_open_bdev_frozen() and blkg_conf_exit_frozen() functions. The
elevator lock is no longer needed in these code paths since commit
78c271344b6f ("block: move wbt_enable_default() out of queue freezing
from sched ->exit()") which introduces `disk->rqos_state_mutex` for
protecting wbt state change, and not necessary to abuse elevator_lock
for this purpose.

This change helps to solve the lockdep warning reported from Yu Kuai[1].

Pass blktests/throtl with lockdep enabled.

Links: https://lore.kernel.org/linux-block/e5e7ac3f-2063-473a-aafb-4d8d43e5576e@yukuai.org.cn/ [1]
Fixes: commit 78c271344b6f ("block: move wbt_enable_default() out of queue freezing from sched ->exit()")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-cgroup.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index f93de34fe87d..3cffb68ba5d8 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -812,8 +812,7 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
 }
 /*
  * Similar to blkg_conf_open_bdev, but additionally freezes the queue,
- * acquires q->elevator_lock, and ensures the correct locking order
- * between q->elevator_lock and q->rq_qos_mutex.
+ * ensures the correct locking order between freeze queue and q->rq_qos_mutex.
  *
  * This function returns negative error on failure. On success it returns
  * memflags which must be saved and later passed to blkg_conf_exit_frozen
@@ -834,13 +833,11 @@ unsigned long __must_check blkg_conf_open_bdev_frozen(struct blkg_conf_ctx *ctx)
 	 * At this point, we haven’t started protecting anything related to QoS,
 	 * so we release q->rq_qos_mutex here, which was first acquired in blkg_
 	 * conf_open_bdev. Later, we re-acquire q->rq_qos_mutex after freezing
-	 * the queue and acquiring q->elevator_lock to maintain the correct
-	 * locking order.
+	 * the queue to maintain the correct locking order.
 	 */
 	mutex_unlock(&ctx->bdev->bd_queue->rq_qos_mutex);
 
 	memflags = blk_mq_freeze_queue(ctx->bdev->bd_queue);
-	mutex_lock(&ctx->bdev->bd_queue->elevator_lock);
 	mutex_lock(&ctx->bdev->bd_queue->rq_qos_mutex);
 
 	return memflags;
@@ -995,9 +992,8 @@ void blkg_conf_exit(struct blkg_conf_ctx *ctx)
 EXPORT_SYMBOL_GPL(blkg_conf_exit);
 
 /*
- * Similar to blkg_conf_exit, but also unfreezes the queue and releases
- * q->elevator_lock. Should be used when blkg_conf_open_bdev_frozen
- * is used to open the bdev.
+ * Similar to blkg_conf_exit, but also unfreezes the queue. Should be used
+ * when blkg_conf_open_bdev_frozen is used to open the bdev.
  */
 void blkg_conf_exit_frozen(struct blkg_conf_ctx *ctx, unsigned long memflags)
 {
@@ -1005,7 +1001,6 @@ void blkg_conf_exit_frozen(struct blkg_conf_ctx *ctx, unsigned long memflags)
 		struct request_queue *q = ctx->bdev->bd_queue;
 
 		blkg_conf_exit(ctx);
-		mutex_unlock(&q->elevator_lock);
 		blk_mq_unfreeze_queue(q, memflags);
 	}
 }
-- 
2.50.1

