Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C09E2F4A
	for <linux-block@vger.kernel.org>; Wed,  2 Apr 2025 04:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743568786; cv=none; b=fZ/5vcbVayuQVeze29yMuqp2FLrUEZ7YOA+Hj9Tf4gHqWGbZ+qP8CZsBXx4aQT70EpqX+RCk+yOoid7aMydL8QUy64ePoiXspnVXmz8ZtXwvq39QXKfyveP9K61yI0qehR1cKTj87h3xwlpmLszJe/0kzKv0+eJtTNSZ+4y9mMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743568786; c=relaxed/simple;
	bh=mw6/Fg6GE7l0Yp/L7bvUaaarqJKD35XZIBiGEBTHp58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2diwMbetea2jTnyqzqP6cSijh49EF2XboP3EaezzvvAuhXEoeOhppvKd+6e6xroJe87bnyssqWX+0znwDwS1H0i9qSipnYOJHmS/29KKfaD2rPqb4lFiwBSUb2BCbDwCttqt17k/TmeaX1dBZN7Xbcagg0XTGnuekPU1G1IFmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N7p/tC4B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7p/tC4B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743568783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nbIIzXCwOjY03btKbmxu74XAzkNBnSudwJ3b1AWeO+U=;
	b=N7p/tC4Bqq5VnYbQPOS9Jp+0viM6eyVhwFp6AFfYVhT6DDBboq1mq/LiIeJqIu0Z8fNpQo
	xox1/KajhF0a+yXzYxfVoKf0VUcfgIrwt1j10e5yI04/ha0YAqBEB4Fcs+Uhk2aPUGVGaw
	U1yNoGvnKADiulQvUP8AEr46RQEGlC8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-_aOB8zU_PK6ZfFRzMXl3AA-1; Wed,
 02 Apr 2025 00:39:40 -0400
X-MC-Unique: _aOB8zU_PK6ZfFRzMXl3AA-1
X-Mimecast-MFC-AGG-ID: _aOB8zU_PK6ZfFRzMXl3AA_1743568778
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 295991956080;
	Wed,  2 Apr 2025 04:39:38 +0000 (UTC)
Received: from localhost (unknown [10.72.120.17])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9CF251956094;
	Wed,  2 Apr 2025 04:39:36 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/3] block: add blk_mq_enter_no_io() and blk_mq_exit_no_io()
Date: Wed,  2 Apr 2025 12:38:47 +0800
Message-ID: <20250402043851.946498-2-ming.lei@redhat.com>
In-Reply-To: <20250402043851.946498-1-ming.lei@redhat.com>
References: <20250402043851.946498-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add blk_mq_enter_no_io() and blk_mq_exit_no_io() for preventing queue
from handling any FS or passthrough IO, meantime the queue is kept in
non-freeze state.

The added two APIs are for avoiding many potential lock risk related
with freeze lock.

Also add two variants of memsave version.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c       |  6 ++++--
 block/blk-mq.c         | 18 ++++++++++++++++--
 block/blk-mq.h         | 19 +++++++++++++++++++
 block/blk.h            |  5 +++--
 include/linux/blkdev.h |  8 ++++++++
 5 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 4623de79effa..a54a18fada8a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -319,7 +319,8 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 		smp_rmb();
 		wait_event(q->mq_freeze_wq,
 			   (!q->mq_freeze_depth &&
-			    blk_pm_resume_queue(pm, q)) ||
+			    (blk_pm_resume_queue(pm, q) ||
+			     !blk_queue_no_io(q))) ||
 			   blk_queue_dying(q));
 		if (blk_queue_dying(q))
 			return -ENODEV;
@@ -352,7 +353,8 @@ int __bio_queue_enter(struct request_queue *q, struct bio *bio)
 		smp_rmb();
 		wait_event(q->mq_freeze_wq,
 			   (!q->mq_freeze_depth &&
-			    blk_pm_resume_queue(false, q)) ||
+			    (blk_pm_resume_queue(false, q) ||
+			     !blk_queue_no_io(q))) ||
 			   test_bit(GD_DEAD, &disk->state));
 		if (test_bit(GD_DEAD, &disk->state))
 			goto dead;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ae8494d88897..075ee51066b3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -222,8 +222,7 @@ bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 	bool unfreeze;
 
 	mutex_lock(&q->mq_freeze_lock);
-	if (force_atomic)
-		q->q_usage_counter.data->force_atomic = true;
+	q->q_usage_counter.data->force_atomic = force_atomic;
 	q->mq_freeze_depth--;
 	WARN_ON_ONCE(q->mq_freeze_depth < 0);
 	if (!q->mq_freeze_depth) {
@@ -278,6 +277,21 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
+void blk_mq_enter_no_io(struct request_queue *q)
+{
+	blk_mq_freeze_queue_nomemsave(q);
+	q->no_io = true;
+	if (__blk_mq_unfreeze_queue(q, true))
+		blk_unfreeze_release_lock(q);
+}
+
+void blk_mq_exit_no_io(struct request_queue *q)
+{
+	blk_mq_freeze_queue_nomemsave(q);
+	q->no_io = false;
+	blk_mq_unfreeze_queue_nomemrestore(q);
+}
+
 /**
  * blk_mq_wait_quiesce_done() - wait until in-progress quiesce is done
  * @set: tag_set to wait on
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 3011a78cf16a..f49070c8c05f 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -452,4 +452,23 @@ static inline bool blk_mq_can_poll(struct request_queue *q)
 		q->tag_set->map[HCTX_TYPE_POLL].nr_queues;
 }
 
+void blk_mq_enter_no_io(struct request_queue *q);
+void blk_mq_exit_no_io(struct request_queue *q);
+
+static inline unsigned int __must_check
+blk_mq_enter_no_io_memsave(struct request_queue *q)
+{
+	unsigned int memflags = memalloc_noio_save();
+
+	blk_mq_enter_no_io(q);
+	return memflags;
+}
+
+static inline void
+blk_mq_exit_no_io_memrestore(struct request_queue *q, unsigned int memflags)
+{
+	blk_mq_exit_no_io(q);
+	memalloc_noio_restore(memflags);
+}
+
 #endif
diff --git a/block/blk.h b/block/blk.h
index 006e3be433d2..7d0994c1d3ad 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -56,8 +56,9 @@ static inline bool blk_try_enter_queue(struct request_queue *q, bool pm)
 	 * The code that increments the pm_only counter must ensure that the
 	 * counter is globally visible before the queue is unfrozen.
 	 */
-	if (blk_queue_pm_only(q) &&
-	    (!pm || queue_rpm_status(q) == RPM_SUSPENDED))
+	if ((blk_queue_pm_only(q) &&
+	    (!pm || queue_rpm_status(q) == RPM_SUSPENDED)) ||
+			blk_queue_no_io(q))
 		goto fail_put;
 
 	rcu_read_unlock();
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e39c45bc0a97..1b8fd63eee80 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -498,6 +498,13 @@ struct request_queue {
 
 	int			quiesce_depth;
 
+	/*
+	 * Prevent queue from handling IO
+	 *
+	 * keep it in same cache line with q_usage_counter
+	 */
+	bool			no_io;
+
 	struct gendisk		*disk;
 
 	/*
@@ -679,6 +686,7 @@ void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
 #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
 #define blk_queue_skip_tagset_quiesce(q) \
 	((q)->limits.features & BLK_FEAT_SKIP_TAGSET_QUIESCE)
+#define blk_queue_no_io(q)	(q->no_io)
 
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
-- 
2.47.0

