Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43128326D69
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573185; cv=none; b=OZnufWKh6c/ZnYkmMsKRruJHbWzuAcYGV+TV9I93ezSZIQPnTHW6IH3isM1CdO9QTTy7sf1zkPvyfjZRyhCUL4i7FO63QnR9m9zytbuPOPRto8J22CrX8BQLAuhDlxhOTrgzl4GVoOGE6Buu0ZMDzxBorT8ovleJ5Pt5bgGEmzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573185; c=relaxed/simple;
	bh=Kgp+HGPd/3a/6hcPQbZlav4uxRgV37FBVzvGL9X+z7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCjvX/+f24x5nq4urpvsVs3yobOT5RtjGzX5O4wqpNsYqvxOgDQjWe70sL0uEMmrrmhROBTlizyGqd4jBxVlzipEIwGNbg/8TgegaBFLyfsoL1jkgN8IY/hDd2H1WssV34wDvO8mbbQgMjCE2izqa1pqV1CZu4coUt9hu+f9e1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KF+ny0kV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KF+ny0kV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768573182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQXiwHVEFI7Og7pFs8eMsb2teoH0NxTZnACAUY0Zif0=;
	b=KF+ny0kV2wSpe+mb97bUNU0RKxzj6ikaDdC0wBIGBGlFYLE8RC+TLPvk1kbexikZZscxQD
	ML6aBtYMSPz/+dqTOVEL8IYgX9Tr/HOVwxFRkH6GR9f8Xo2aeu+L0To3mmyY7JYZ3LgmW1
	fTwKRWHIPXP3KWHQTyaA/J7fGk6X2jA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-cCF3mb3AOpGiW3KouhLtEg-1; Fri,
 16 Jan 2026 09:19:41 -0500
X-MC-Unique: cCF3mb3AOpGiW3KouhLtEg-1
X-Mimecast-MFC-AGG-ID: cCF3mb3AOpGiW3KouhLtEg_1768573180
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02FA01956058;
	Fri, 16 Jan 2026 14:19:40 +0000 (UTC)
Received: from localhost (unknown [10.72.116.198])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 32F253001DB9;
	Fri, 16 Jan 2026 14:19:37 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 06/24] ublk: add io events fifo structure
Date: Fri, 16 Jan 2026 22:18:39 +0800
Message-ID: <20260116141859.719929-7-ming.lei@redhat.com>
In-Reply-To: <20260116141859.719929-1-ming.lei@redhat.com>
References: <20260116141859.719929-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add ublk io events fifo structure and prepare for supporting command
batch, which will use io_uring multishot uring_cmd for fetching one
batch of io commands each time.

One nice feature of kfifo is to allow multiple producer vs single
consumer. We just need lock the producer side, meantime the single
consumer can be lockless.

The producer is actually from ublk_queue_rq() or ublk_queue_rqs(), so
lock contention can be eased by setting proper blk-mq nr_queues.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 69 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d919e04885b6..e5db5a552357 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -44,6 +44,7 @@
 #include <linux/task_work.h>
 #include <linux/namei.h>
 #include <linux/kref.h>
+#include <linux/kfifo.h>
 #include <linux/blk-integrity.h>
 #include <uapi/linux/fs.h>
 #include <uapi/linux/ublk_cmd.h>
@@ -223,6 +224,24 @@ struct ublk_queue {
 	bool fail_io; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
 	spinlock_t		cancel_lock;
 	struct ublk_device *dev;
+
+	/*
+	 * For supporting UBLK_F_BATCH_IO only.
+	 *
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
 
@@ -291,6 +310,26 @@ static inline void ublk_io_unlock(struct ublk_io *io)
 	spin_unlock(&io->lock);
 }
 
+/* Initialize the event queue */
+static inline int ublk_io_evts_init(struct ublk_queue *q, unsigned int size,
+				    int numa_node)
+{
+	spin_lock_init(&q->evts_lock);
+	return kfifo_alloc_node(&q->evts_fifo, size, GFP_KERNEL, numa_node);
+}
+
+/* Check if event queue is empty */
+static inline bool ublk_io_evts_empty(const struct ublk_queue *q)
+{
+	return kfifo_is_empty(&q->evts_fifo);
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
@@ -3183,14 +3222,10 @@ static const struct file_operations ublk_ch_batch_io_fops = {
 	.mmap = ublk_ch_mmap,
 };
 
-static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
+static void __ublk_deinit_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 {
-	struct ublk_queue *ubq = ub->queues[q_id];
 	int size, i;
 
-	if (!ubq)
-		return;
-
 	size = ublk_queue_cmd_buf_size(ub);
 
 	for (i = 0; i < ubq->q_depth; i++) {
@@ -3204,7 +3239,20 @@ static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
 	if (ubq->io_cmd_buf)
 		free_pages((unsigned long)ubq->io_cmd_buf, get_order(size));
 
+	if (ublk_dev_support_batch_io(ub))
+		ublk_io_evts_deinit(ubq);
+
 	kvfree(ubq);
+}
+
+static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
+{
+	struct ublk_queue *ubq = ub->queues[q_id];
+
+	if (!ubq)
+		return;
+
+	__ublk_deinit_queue(ub, ubq);
 	ub->queues[q_id] = NULL;
 }
 
@@ -3228,7 +3276,7 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 	struct ublk_queue *ubq;
 	struct page *page;
 	int numa_node;
-	int size, i;
+	int size, i, ret;
 
 	/* Determine NUMA node based on queue's CPU affinity */
 	numa_node = ublk_get_queue_numa_node(ub, q_id);
@@ -3256,9 +3304,18 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
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
+	__ublk_deinit_queue(ub, ubq);
+	return ret;
 }
 
 static void ublk_deinit_queues(struct ublk_device *ub)
-- 
2.47.0

