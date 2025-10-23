Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA452FD1DA
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233622; cv=none; b=p1cglgqaOVxVYNfebINQZf/H1bTVRFCGE7weD0xZiu27kEoBUTvXBegQ3QJlX/DmDIgQCuDTWEjZEsRXqzI/QeA1CEJbdsNs2UyfMIfM4MaAZ4RgenqBlC5Jjr2NZG1N7V5+0IWQqAev9HfpJEO43WPC3VTDIA8nEPgFDCEMojg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233622; c=relaxed/simple;
	bh=rgfztlgr1CotS5TMvQDg0bUNrZgLcUEvHMy6Brf6u9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwSWZXF9cuXFIQvMoEW7PGrK/oxouz9l8COZS2iCmcFYr1E+XSfci56rj7XYY5kYJKcYf3/KmzeN1xO2EcDIYEHA550kms3+1lHzZOBY9C1kE0oU85RbGRYgRuo8Npp2vUcWmTjU8smoUmzRFxXfQCxwL8v6i+HNdT103kUb0jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OqAg9vIi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqAg9vIi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761233619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVmrY7VDX2il5KHZQUdKjDmTByKEmMAg3ftRFiLngPc=;
	b=OqAg9vIimtRIYrOFGD7PzviiUG8KhtOaKkSyvqK2sUX15NCFPSTxcmkAlwBMcJJR3kE4Ig
	vK0Gezhol/JkJJlb4BNwmhbtDaJMWxmvEqPKTMPXUlPNuIon5y9nTBra7rWyxID9xSUSP7
	ZrDpRnFEI2jJ4MyylERUvcUT9mFv6OU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-hwTwo4ISMNCKgInwhN9YPA-1; Thu,
 23 Oct 2025 11:33:35 -0400
X-MC-Unique: hwTwo4ISMNCKgInwhN9YPA-1
X-Mimecast-MFC-AGG-ID: hwTwo4ISMNCKgInwhN9YPA_1761233614
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2499919541A1;
	Thu, 23 Oct 2025 15:33:34 +0000 (UTC)
Received: from localhost (unknown [10.72.120.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 038E5180057E;
	Thu, 23 Oct 2025 15:33:32 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 11/25] ublk: add io events fifo structure
Date: Thu, 23 Oct 2025 23:32:16 +0800
Message-ID: <20251023153234.2548062-12-ming.lei@redhat.com>
In-Reply-To: <20251023153234.2548062-1-ming.lei@redhat.com>
References: <20251023153234.2548062-1-ming.lei@redhat.com>
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
 drivers/block/ublk_drv.c | 55 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3066bfa19f99..a17056f592bc 100644
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
 	struct ublk_io ios[];
 };
 
@@ -283,6 +300,31 @@ static inline void ublk_io_unlock(struct ublk_io *io)
 	spin_unlock(&io->lock);
 }
 
+/* Initialize the queue */
+static inline int ublk_io_evts_init(struct ublk_queue *q, unsigned int size)
+{
+	spin_lock_init(&q->evts_lock);
+	return kfifo_alloc(&q->evts_fifo, size, GFP_KERNEL);
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
@@ -3143,6 +3185,8 @@ static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
 
 	if (ubq->io_cmd_buf)
 		free_pages((unsigned long)ubq->io_cmd_buf, get_order(size));
+	if (ublk_dev_support_batch_io(ub))
+		ublk_io_evts_deinit(ubq);
 }
 
 static int ublk_init_queue(struct ublk_device *ub, int q_id)
@@ -3150,7 +3194,7 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
 	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO;
 	void *ptr;
-	int size, i;
+	int size, i, ret = 0;
 
 	spin_lock_init(&ubq->cancel_lock);
 	ubq->flags = ub->dev_info.flags;
@@ -3167,7 +3211,16 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 
 	ubq->io_cmd_buf = ptr;
 	ubq->dev = ub;
+
+	if (ublk_dev_support_batch_io(ub)) {
+		ret = ublk_io_evts_init(ubq, ubq->q_depth);
+		if (ret)
+			goto fail;
+	}
 	return 0;
+fail:
+	ublk_deinit_queue(ub, q_id);
+	return ret;
 }
 
 static void ublk_deinit_queues(struct ublk_device *ub)
-- 
2.47.0

