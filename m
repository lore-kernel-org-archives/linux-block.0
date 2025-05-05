Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF3C2505D6
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454710; cv=none; b=Kf433uSSc+aq9HoSlbTWHzoiaYSBl/r5A+biewASfDShm9pZN6CEdKNKnwV74ZtZRx4vto0AuqWwhf4fP+D5U4OLUJQ4I3QklwAxnhPeA2Pj+TlqTjuRUVB0KVYzhZq8O5Nq5tM6RE45yp4u1fgzNdMELrXsj3PemgdMDZc6A4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454710; c=relaxed/simple;
	bh=3GwuOEhc3J2xtU/6YgywJF0rYg2fiNDBMbpsId1R9ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLF5So0fQ0afqlv9J1TInmVWZsLRf13Ouw1Ypuu6WavdOrCJN/HvUKLaTGwb2BaW8G/9lY79TQ9H2tXwpsvPxlnQO42XiLupSYASwEahBiGuDqZTxHKMA2DogT8F9WPLw9ys5u686DPnIdAZJKKo6ffhCJC3BM/J2ayjUPp6MBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=geJ1I3o4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="geJ1I3o4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746454706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ebll5b99Xf0YQtV0Lz7U20DRRkzegA4hSovpqKQzJHA=;
	b=geJ1I3o4aIVYTGdb90F+vVcWBAn8O77SrRR000cwcbs0RnNX1+1R9E2jSQPIZzwBFqxlXP
	0dmYCL4Vp7oBJUJg2t68haMOcko6VycJHJAknSqYHdOjKpHNH2zixdqLaUZscq7BtkN4zI
	YRb/Pbzig0/gXtoFAo0CHA8kIiL69sY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-dAsKIS7fNDKn8QSmwoHsNA-1; Mon,
 05 May 2025 10:18:23 -0400
X-MC-Unique: dAsKIS7fNDKn8QSmwoHsNA-1
X-Mimecast-MFC-AGG-ID: dAsKIS7fNDKn8QSmwoHsNA_1746454702
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0CC01956086;
	Mon,  5 May 2025 14:18:21 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 56B6D1956094;
	Mon,  5 May 2025 14:18:19 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 02/25] block: move ELEVATOR_FLAG_DISABLE_WBT a request queue flag
Date: Mon,  5 May 2025 22:17:40 +0800
Message-ID: <20250505141805.2751237-3-ming.lei@redhat.com>
In-Reply-To: <20250505141805.2751237-1-ming.lei@redhat.com>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

ELEVATOR_FLAG_DISABLE_WBT is only used by BFQ to disallow wbt when BFQ is
in use. The flag is set in BFQ's init(), and cleared in BFQ's exit().

Making it as request queue flag, so that we can avoid to deal with elevator
switch race. Also it isn't graceful to checking one scheduler flag in
wbt_enable_default().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bfq-iosched.c    | 4 ++--
 block/blk-mq-debugfs.c | 1 +
 block/blk-wbt.c        | 3 +--
 block/elevator.h       | 1 -
 include/linux/blkdev.h | 3 +++
 5 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index abd80dc13562..cc6f59836dcd 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7210,7 +7210,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
 #endif
 
 	blk_stat_disable_accounting(bfqd->queue);
-	clear_bit(ELEVATOR_FLAG_DISABLE_WBT, &e->flags);
+	blk_queue_flag_clear(QUEUE_FLAG_DISABLE_WBT_DEF, bfqd->queue);
 	wbt_enable_default(bfqd->queue->disk);
 
 	kfree(bfqd);
@@ -7397,7 +7397,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	/* We dispatch from request queue wide instead of hw queue */
 	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
 
-	set_bit(ELEVATOR_FLAG_DISABLE_WBT, &eq->flags);
+	blk_queue_flag_set(QUEUE_FLAG_DISABLE_WBT_DEF, q);
 	wbt_disable_default(q->disk);
 	blk_stat_enable_accounting(q);
 
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 3421b5521fe2..7710c409e432 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -93,6 +93,7 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
 	QUEUE_FLAG_NAME(HCTX_ACTIVE),
 	QUEUE_FLAG_NAME(SQ_SCHED),
+	QUEUE_FLAG_NAME(DISABLE_WBT_DEF),
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
index f3d74f9dae8e..9c373cf0eb47 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -644,6 +644,7 @@ enum {
 	QUEUE_FLAG_RQ_ALLOC_TIME,	/* record rq->alloc_time_ns */
 	QUEUE_FLAG_HCTX_ACTIVE,		/* at least one blk-mq hctx is active */
 	QUEUE_FLAG_SQ_SCHED,		/* single queue style io dispatch */
+	QUEUE_FLAG_DISABLE_WBT_DEF,	/* for sched to disable/enable wbt */
 	QUEUE_FLAG_MAX
 };
 
@@ -679,6 +680,8 @@ void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
 #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
 #define blk_queue_skip_tagset_quiesce(q) \
 	((q)->limits.features & BLK_FEAT_SKIP_TAGSET_QUIESCE)
+#define blk_queue_disable_wbt(q)	\
+	test_bit(QUEUE_FLAG_DISABLE_WBT_DEF, &(q)->queue_flags)
 
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
-- 
2.47.0

