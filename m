Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B083B214225
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994259; cv=none; b=u6QBSQKqCbmTkU0c151zdt5uLPsBXIUQ31PpeuvGFXec4/S5sFlHOppPN1VcldkhFo1IQEmr2cinKLsvBtIFaDmgmOIN/3Nrp/4P5Y4zB38iXJ26n0KMPmK1awiD6wJzSI9yMVkf+1VR1nSDUffLuyjYcbTyoX7LZv46OivPxGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994259; c=relaxed/simple;
	bh=mXr71+aN2L7L1lCan/kiXDty06gdGQlsari5pVPMX78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4B+YjHCL1lBrdvAxFIJuRcLmMisZhhamVFOuwbLPcRl0EhiMdxyL++D17aRCkNdXy+i2d5EVRAnuTE9l+PBRQUfvX8j+QLHcCZvi5/P1TzwruCxBM9c0Cr9KDWamPy15iTwMqlETYEjIl0qaEdU5ab5/+7AvcsTsdG1aWISYnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AktFcZoN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AktFcZoN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744994256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5R8mslqCpCba75gYztodtEGAhBuZSV74Sqy7kHA2mU=;
	b=AktFcZoNRqJh/8i49Ua3gjZRudCScxKBsamH+QO0tKLNarznmyWc1bi1kKQSLhFn0lAUVO
	j6DU9m1aYl5Quzl2+39c6xGcojpzsP6mdcxYdKlZoRQN8WO06xDCqhZwZ0Iqe6dyflIiVl
	XZKN+DA2TVbB/sAXcj6sB0bXeO45S/g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-ByuW0vB-MU-TBW73pb416w-1; Fri,
 18 Apr 2025 12:37:32 -0400
X-MC-Unique: ByuW0vB-MU-TBW73pb416w-1
X-Mimecast-MFC-AGG-ID: ByuW0vB-MU-TBW73pb416w_1744994251
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D433A1956094;
	Fri, 18 Apr 2025 16:37:30 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D5B030002C2;
	Fri, 18 Apr 2025 16:37:28 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 02/20] block: move ELEVATOR_FLAG_DISABLE_WBT as request queue flag
Date: Sat, 19 Apr 2025 00:36:43 +0800
Message-ID: <20250418163708.442085-3-ming.lei@redhat.com>
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

ELEVATOR_FLAG_DISABLE_WBT is only used by BFQ to disallow wbt when BFQ is
in use. The flag is set in BFQ's init(), and cleared in BFQ's exit().

Making it as request queue flag, so that we can avoid to deal with elevator
switch race. Also it isn't graceful to checking one scheduler flag in
wbt_enable_default().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bfq-iosched.c    | 4 ++--
 block/blk-mq-debugfs.c | 1 +
 block/blk-wbt.c        | 3 +--
 block/elevator.h       | 1 -
 include/linux/blkdev.h | 3 +++
 5 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index abd80dc13562..40e4106a71e7 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7210,7 +7210,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
 #endif
 
 	blk_stat_disable_accounting(bfqd->queue);
-	clear_bit(ELEVATOR_FLAG_DISABLE_WBT, &e->flags);
+	blk_queue_flag_clear(QUEUE_FLAG_DISABLE_WBT, bfqd->queue);
 	wbt_enable_default(bfqd->queue->disk);
 
 	kfree(bfqd);
@@ -7397,7 +7397,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	/* We dispatch from request queue wide instead of hw queue */
 	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
 
-	set_bit(ELEVATOR_FLAG_DISABLE_WBT, &eq->flags);
+	blk_queue_flag_set(QUEUE_FLAG_DISABLE_WBT, q);
 	wbt_disable_default(q->disk);
 	blk_stat_enable_accounting(q);
 
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 3421b5521fe2..31e249a18407 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -93,6 +93,7 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
 	QUEUE_FLAG_NAME(HCTX_ACTIVE),
 	QUEUE_FLAG_NAME(SQ_SCHED),
+	QUEUE_FLAG_NAME(DISABLE_WBT),
 };
 #undef QUEUE_FLAG_NAME
 
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index f1754d07f7e0..29cd2e33666f 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -704,8 +704,7 @@ void wbt_enable_default(struct gendisk *disk)
 	struct rq_qos *rqos;
 	bool enable = IS_ENABLED(CONFIG_BLK_WBT_MQ);
 
-	if (q->elevator &&
-	    test_bit(ELEVATOR_FLAG_DISABLE_WBT, &q->elevator->flags))
+	if (blk_queue_disable_wbt(q))
 		enable = false;
 
 	/* Throttling already enabled? */
diff --git a/block/elevator.h b/block/elevator.h
index e4e44dfac503..e27af5492cdb 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -121,7 +121,6 @@ struct elevator_queue
 };
 
 #define ELEVATOR_FLAG_REGISTERED	0
-#define ELEVATOR_FLAG_DISABLE_WBT	1
 
 /*
  * block elevator interface
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e39c45bc0a97..10410d9b03ad 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -644,6 +644,7 @@ enum {
 	QUEUE_FLAG_RQ_ALLOC_TIME,	/* record rq->alloc_time_ns */
 	QUEUE_FLAG_HCTX_ACTIVE,		/* at least one blk-mq hctx is active */
 	QUEUE_FLAG_SQ_SCHED,		/* single queue style io dispatch */
+	QUEUE_FLAG_DISABLE_WBT,		/* for sched to disable/enable wbt */
 	QUEUE_FLAG_MAX
 };
 
@@ -679,6 +680,8 @@ void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
 #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
 #define blk_queue_skip_tagset_quiesce(q) \
 	((q)->limits.features & BLK_FEAT_SKIP_TAGSET_QUIESCE)
+#define blk_queue_disable_wbt(q)	\
+	test_bit(QUEUE_FLAG_DISABLE_WBT, &(q)->queue_flags)
 
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
-- 
2.47.0

