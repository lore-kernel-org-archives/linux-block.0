Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AC9313261
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764678032; cv=none; b=YvgVXprwR3dsYT+HC4DXDU/6gDcGnOhZ2x7cwl9gTcrgyqhM0XH3YW5VEwWvMKblZ0N9nqwAuyCwUOoucDDM1wYS91w/iAhHR5GfaG+WkRx8gWZsKxl96ahf/CphEBPVNDDDd8rOMZppaC9DThS1yzp39MSl9fb0iS17MB68MEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764678032; c=relaxed/simple;
	bh=7U60lRM6D0vhq6SWFT5gLZSmXP0HBrb5opAIZfh0iFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhyESxMugzsp8O3/YvuJ+MmmNvNL/gD/Jt3NsuCqePX8J2DhS8ULZE5v3YTZhF50MHKo9noXT4H0ChiFFDAvO18yTBpID6Slnd1kRoQrx8WT2oITnPTWojA1Z2Rp0kn7JjK8ZDKRBLIoWQoZ+hSNL4dV+5dVY5OAlgiFAxHpPLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S7DKb9F/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7DKb9F/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764678029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=srxyQS1AR3YDdJgNxuyncCUEmV/iJ1rORZLsNT4OmTo=;
	b=S7DKb9F/t3Ks7vUVvwFaDav5wBaFn9IlJtGMGQy57CCUu6+INUdDkrYWaC6y54KE5smcrZ
	neVEtMEP9CkHkLy6DHsjilzRy3CoGuTJlmbPE5EESkmrpQucV6wKR6Y89vWW7K5gyphM1g
	SsDS679sXUwBs0JmLw9v+XWeDf3E8Qs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-94W9DI03OpyH4aA4uec_uA-1; Tue,
 02 Dec 2025 07:20:28 -0500
X-MC-Unique: 94W9DI03OpyH4aA4uec_uA-1
X-Mimecast-MFC-AGG-ID: 94W9DI03OpyH4aA4uec_uA_1764678027
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 519B5195609F;
	Tue,  2 Dec 2025 12:20:27 +0000 (UTC)
Received: from localhost (unknown [10.72.116.20])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 788E6195608E;
	Tue,  2 Dec 2025 12:20:26 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 06/21] ublk: add io events fifo structure
Date: Tue,  2 Dec 2025 20:19:00 +0800
Message-ID: <20251202121917.1412280-7-ming.lei@redhat.com>
In-Reply-To: <20251202121917.1412280-1-ming.lei@redhat.com>
References: <20251202121917.1412280-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
 drivers/block/ublk_drv.c | 69 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 5cc95e13295d..670233f0ec2a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -44,6 +44,7 @@
 #include <linux/task_work.h>
 #include <linux/namei.h>
 #include <linux/kref.h>
+#include <linux/kfifo.h>
 #include <uapi/linux/ublk_cmd.h>
 
 #define UBLK_MINORS		(1U << MINORBITS)
@@ -217,6 +218,24 @@ struct ublk_queue {
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
 
@@ -282,6 +301,26 @@ static inline void ublk_io_unlock(struct ublk_io *io)
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
@@ -3003,14 +3042,10 @@ static const struct file_operations ublk_ch_batch_io_fops = {
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
@@ -3024,7 +3059,20 @@ static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
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
 
@@ -3048,7 +3096,7 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 	struct ublk_queue *ubq;
 	struct page *page;
 	int numa_node;
-	int size, i;
+	int size, i, ret;
 
 	/* Determine NUMA node based on queue's CPU affinity */
 	numa_node = ublk_get_queue_numa_node(ub, q_id);
@@ -3076,9 +3124,18 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
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

