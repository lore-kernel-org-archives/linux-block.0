Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAF6310640
	for <linux-block@vger.kernel.org>; Mon,  1 Sep 2025 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721016; cv=none; b=FHeXXJA4O5M468/GWQQeTTaFB9tumPBlrLFfJbX5Rv95/hos066CYO2tZNJCsT6iicMqIRPl3eFDuZEzW6z6WNJMod7AOHmZ0AttkD3bg5KWL6bbaDkhQooIiyL0JkmRuE+uMjNE4KJcA3/fLmMcmsxK/0PUzyr5MdCEbs83YvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721016; c=relaxed/simple;
	bh=yPu4jfhA+EMN18LiNE0SernJ/EuOVyIbcYdiKj4Eqy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9g+Y2pnMVHjVXQ35PycJJ/KhFfEisXlKw0MB25XTBgZYVAo8tpOXp7IpkfLpkyxwdo0vNYEzIbNFlHJXOOtzEcYZugmyWDekSDoPCb0BvP+5r6BsexUBvRRvffiJ4k4ajbWtakpYwnkZGiNf1Y22VNcM8F6Ycy0YPpzYJAo7PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CBPBTL+p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBPBTL+p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756721014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MvkM7K1D2Ji+DuiHhmgJvpiE90CpPW2Jr2DphxiYEaA=;
	b=CBPBTL+pcPAaOZri5+FEvjIYcx2oREziIxpwc1UJjzkE8UOZHUspepIsbFAvr1Alxq1H7g
	xJH5tUx1UhiONFkTki5ZUXQk4mhJhiWGHzdKefVSlldzeOAI6o0tPzuSIWEMWCU/GOeX+3
	0uqDUkFjQZrwGofyNNtyz+WeTa5/KhM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160--5Q0C6LIMBGzK_EThzx8dQ-1; Mon,
 01 Sep 2025 06:03:33 -0400
X-MC-Unique: -5Q0C6LIMBGzK_EThzx8dQ-1
X-Mimecast-MFC-AGG-ID: -5Q0C6LIMBGzK_EThzx8dQ_1756721012
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAA8B180035C;
	Mon,  1 Sep 2025 10:03:31 +0000 (UTC)
Received: from localhost (unknown [10.72.116.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C6CD71955EA4;
	Mon,  1 Sep 2025 10:03:30 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 10/23] ublk: add io events fifo structure
Date: Mon,  1 Sep 2025 18:02:27 +0800
Message-ID: <20250901100242.3231000-11-ming.lei@redhat.com>
In-Reply-To: <20250901100242.3231000-1-ming.lei@redhat.com>
References: <20250901100242.3231000-1-ming.lei@redhat.com>
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
 drivers/block/ublk_drv.c | 55 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index fae016b67254..0f955592ebd5 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -44,6 +44,7 @@
 #include <linux/task_work.h>
 #include <linux/namei.h>
 #include <linux/kref.h>
+#include <linux/kfifo.h>
 #include <uapi/linux/ublk_cmd.h>
 
 #define UBLK_MINORS		(1U << MINORBITS)
@@ -220,6 +221,22 @@ struct ublk_queue {
 	unsigned short nr_io_ready;	/* how many ios setup */
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
 
@@ -291,6 +308,31 @@ static inline void ublk_io_unlock(struct ublk_io *io)
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
@@ -3071,6 +3113,8 @@ static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
 
 	if (ubq->io_cmd_buf)
 		free_pages((unsigned long)ubq->io_cmd_buf, get_order(size));
+	if (ublk_support_batch_io(ubq))
+		ublk_io_evts_deinit(ubq);
 }
 
 static int ublk_init_queue(struct ublk_device *ub, int q_id)
@@ -3078,7 +3122,7 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
 	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO;
 	void *ptr;
-	int size, i;
+	int size, i, ret = 0;
 
 	spin_lock_init(&ubq->cancel_lock);
 	ubq->flags = ub->dev_info.flags;
@@ -3095,7 +3139,16 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 
 	ubq->io_cmd_buf = ptr;
 	ubq->dev = ub;
+
+	if (ublk_support_batch_io(ubq)) {
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

