Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48D92D1F69
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940365; cv=none; b=d9EQvGx6l0lAmBiF9kziOIuGoAtpQM+/fw6OfUBQBoskReLGiM/AwSXJM4B/pg9DuBx76+D9uT/C+iwbZafABRoOtntDnh3c7C5YAShDmeKSHwIbejZHZKpknWCVH8bhMsHea83Dv/19UH9L/XfOrv6HOt48N8pKqPd/65p2Sos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940365; c=relaxed/simple;
	bh=dMkaK5OUput2VSeis2bNSYp5O5DxLH+EYr9nYq99Zpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvjeH1hyB/C5Sw8nUeqYhLfqwF3hLV4nmdsIHX3xPQ0vrTBAIFcSFVnslbzmy7PqZMuFDhyTOVAcWCEYqDB/IY4DDjnLRrA6lUHpqu1jVQGeZm83sQn/SxhZWH6t+QJ30dJfaBzEGCNoQNAxf1yDaVRiIUT6Sir4brZJ5H16Epw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QXOWBQWp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXOWBQWp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762940362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c+AhtJDLbVgh/6p7KOmSU+uoQLyXcyKV3VCau+eG/PY=;
	b=QXOWBQWprZmXqEXO3yIX0i25LLZqr30FazAm0hnUQvf8LUWglhnQKcIHGayOQ1z8uRBIs8
	bXMhCNhmulbXGZcY5qp+QCoN5Fms9LNon2e4CCuCDnY1C5szr3tdfWvI3Ru3ib3YYibonI
	zz4s+RxBX8LMQT0naA4jayRr+HJ3+JI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-uMArkx-WM4yAeTn0t6sU2g-1; Wed,
 12 Nov 2025 04:39:20 -0500
X-MC-Unique: uMArkx-WM4yAeTn0t6sU2g-1
X-Mimecast-MFC-AGG-ID: uMArkx-WM4yAeTn0t6sU2g_1762940359
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 926621956080;
	Wed, 12 Nov 2025 09:39:19 +0000 (UTC)
Received: from localhost (unknown [10.72.116.179])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 91CAA19560A2;
	Wed, 12 Nov 2025 09:39:18 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 12/27] ublk: add io events fifo structure
Date: Wed, 12 Nov 2025 17:37:50 +0800
Message-ID: <20251112093808.2134129-13-ming.lei@redhat.com>
In-Reply-To: <20251112093808.2134129-1-ming.lei@redhat.com>
References: <20251112093808.2134129-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
index f79efbaba340..840d6a16bd4b 100644
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
@@ -3076,6 +3119,9 @@ static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
 	if (ubq->io_cmd_buf)
 		free_pages((unsigned long)ubq->io_cmd_buf, get_order(size));
 
+	if (ublk_dev_support_batch_io(ub))
+		ublk_io_evts_deinit(ubq);
+
 	kvfree(ubq);
 	ub->queues[q_id] = NULL;
 }
@@ -3100,7 +3146,7 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 	struct ublk_queue *ubq;
 	struct page *page;
 	int numa_node;
-	int size, i;
+	int size, i, ret = -ENOMEM;
 
 	/* Determine NUMA node based on queue's CPU affinity */
 	numa_node = ublk_get_queue_numa_node(ub, q_id);
@@ -3119,18 +3165,27 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 
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

