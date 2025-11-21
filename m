Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B12BEC5F
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 01:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690399; cv=none; b=pJAU713F9wn5aMmvI67f1dXl2bD/1+xbWu0DZc38xlZ9Jr9rpH+LrEgAxMNY5ePFOv4DnHuwjQ7lVeiG9tZPWLlA+GfDb4A2J0/aPItz2EpOVfpy0u7Bq0jazWYx1ecaa11+Vs0GEUjO9tIjoETLSjro1MF4iCBRy96QDRd4+cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690399; c=relaxed/simple;
	bh=7zvwDyyBODSvYRmv8jqSfpojwR/HIpTaNTnLi8CH9UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUlejOEkooIdAbddz4FK7oUuzd6AEICqt7RQ5n7Qls8Gr4xSRGboynTgzM/i2U9Zw4BgnoALFSHxCXMu1enTOt9G8CPGjmoXYb/yjDwSF797OUQvoNO/oDMvd/uyeLf6ASHH+YcrXMLu1DnhI0pQA7y7sEPyxa0tvtJRlQO793A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QBG+MmzL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBG+MmzL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763690397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ycppPCNc+qj3Td0PdcNTHKzS0HwLiZSsLA49DzWiJto=;
	b=QBG+MmzL1o5E2GaSzhZGD+rP22drv3V9UxxpZzFBW2DcJiEBHlw1gb2MVTwsiuRvEygcTR
	7Xrw7LWAHx9gs0A5Fc+Hf1fozp615jbFFrDe3X/mnb8tMFuCiLj9TzBAS8O1D/eqPOOPY6
	KMfI+KRsX7cicUhYu/ixBjDnv+lGgUU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-F6rDYoGKPMu0-N46NJ1W4Q-1; Thu,
 20 Nov 2025 20:59:53 -0500
X-MC-Unique: F6rDYoGKPMu0-N46NJ1W4Q-1
X-Mimecast-MFC-AGG-ID: F6rDYoGKPMu0-N46NJ1W4Q_1763690392
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DD11180035F;
	Fri, 21 Nov 2025 01:59:52 +0000 (UTC)
Received: from localhost (unknown [10.72.116.211])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5CF1F180049F;
	Fri, 21 Nov 2025 01:59:50 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 12/27] ublk: add io events fifo structure
Date: Fri, 21 Nov 2025 09:58:34 +0800
Message-ID: <20251121015851.3672073-13-ming.lei@redhat.com>
In-Reply-To: <20251121015851.3672073-1-ming.lei@redhat.com>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add ublk io events fifo structure and prepare for supporting command
batch, which will use io_uring multishot uring_cmd for fetching one
batch of io commands each time.

One nice feature of kfifo is to allow multiple producer vs single
consumer. We just need lock the producer side, meantime the single
consumer can be lockless.

The producer is actually from ublk_queue_rq() or ublk_queue_rqs(), so
lock contention can be eased by setting proper blk-mq nr_queues.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 65 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index ea992366af5b..6ff284243630 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -44,6 +44,7 @@
 #include <linux/task_work.h>
 #include <linux/namei.h>
 #include <linux/kref.h>
+#include <linux/kfifo.h>
 #include <uapi/linux/ublk_cmd.h>
 
 #define UBLK_MINORS		(1U << MINORBITS)
@@ -217,6 +218,22 @@ struct ublk_queue {
 	bool fail_io; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
 	spinlock_t		cancel_lock;
 	struct ublk_device *dev;
+
+	/*
+	 * Inflight ublk request tag is saved in this fifo
+	 *
+	 * There are multiple writer from ublk_queue_rq() or ublk_queue_rqs(),
+	 * so lock is required for storing request tag to fifo
+	 *
+	 * Make sure just one reader for fetching request from task work
+	 * function to ublk server, so no need to grab the lock in reader
+	 * side.
+	 */
+	struct {
+		DECLARE_KFIFO_PTR(evts_fifo, unsigned short);
+		spinlock_t evts_lock;
+	}____cacheline_aligned_in_smp;
+
 	struct ublk_io ios[] __counted_by(q_depth);
 };
 
@@ -282,6 +299,32 @@ static inline void ublk_io_unlock(struct ublk_io *io)
 	spin_unlock(&io->lock);
 }
 
+/* Initialize the queue */
+static inline int ublk_io_evts_init(struct ublk_queue *q, unsigned int size,
+				    int numa_node)
+{
+	spin_lock_init(&q->evts_lock);
+	return kfifo_alloc_node(&q->evts_fifo, size, GFP_KERNEL, numa_node);
+}
+
+/* Check if queue is empty */
+static inline bool ublk_io_evts_empty(const struct ublk_queue *q)
+{
+	return kfifo_is_empty(&q->evts_fifo);
+}
+
+/* Check if queue is full */
+static inline bool ublk_io_evts_full(const struct ublk_queue *q)
+{
+	return kfifo_is_full(&q->evts_fifo);
+}
+
+static inline void ublk_io_evts_deinit(struct ublk_queue *q)
+{
+	WARN_ON_ONCE(!kfifo_is_empty(&q->evts_fifo));
+	kfifo_free(&q->evts_fifo);
+}
+
 static inline struct ublksrv_io_desc *
 ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
 {
@@ -3038,6 +3081,9 @@ static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
 	if (ubq->io_cmd_buf)
 		free_pages((unsigned long)ubq->io_cmd_buf, get_order(size));
 
+	if (ublk_dev_support_batch_io(ub))
+		ublk_io_evts_deinit(ubq);
+
 	kvfree(ubq);
 	ub->queues[q_id] = NULL;
 }
@@ -3062,7 +3108,7 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 	struct ublk_queue *ubq;
 	struct page *page;
 	int numa_node;
-	int size, i;
+	int size, i, ret = -ENOMEM;
 
 	/* Determine NUMA node based on queue's CPU affinity */
 	numa_node = ublk_get_queue_numa_node(ub, q_id);
@@ -3081,18 +3127,27 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 
 	/* Allocate I/O command buffer on local NUMA node */
 	page = alloc_pages_node(numa_node, gfp_flags, get_order(size));
-	if (!page) {
-		kvfree(ubq);
-		return -ENOMEM;
-	}
+	if (!page)
+		goto fail_nomem;
 	ubq->io_cmd_buf = page_address(page);
 
 	for (i = 0; i < ubq->q_depth; i++)
 		spin_lock_init(&ubq->ios[i].lock);
 
+	if (ublk_dev_support_batch_io(ub)) {
+		ret = ublk_io_evts_init(ubq, ubq->q_depth, numa_node);
+		if (ret)
+			goto fail;
+	}
 	ub->queues[q_id] = ubq;
 	ubq->dev = ub;
+
 	return 0;
+fail:
+	ublk_deinit_queue(ub, q_id);
+fail_nomem:
+	kvfree(ubq);
+	return ret;
 }
 
 static void ublk_deinit_queues(struct ublk_device *ub)
-- 
2.47.0

