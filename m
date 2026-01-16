Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D04330D29
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573229; cv=none; b=IIflSqf/yNxkiLJjdhQKntLrRCmzPfoO+7QUH/SBJnRLnUoUHT/UJcM3FG8uWCHCEyoCK7omHEgmdUJrR3bd4RMdv2RfGO8Ldh9evtprutCx0v1wwCUcrjkcERAcZJqcNx3KWvS5R+iDjukZJcpvCSIn15h1DEWiudcq5tIayU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573229; c=relaxed/simple;
	bh=oy2NaVPEsjchrE46KIvXYDVptT1DqzAO6KT/rIGX5Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1bsR8FUFuSAP+0zOvSTFMOLjfuvv3NTCG3blfdo0j6Js6EM5Mysfz628ZRPy/Y6s47ieJTpsKkFqiu2iDajeYul4FAqftPV+zQdpyj0A9ISKEeL0UwtpDFK1WJDw6mdY+iueSG4iHpqDDqj4qw5DMPJBEWyZjf2BsopVDhcC60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HS4fKk1M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HS4fKk1M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768573222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3/299Dy7w6XUoNIIDC3vCXVMHSlpTCV/a6Js5/41INo=;
	b=HS4fKk1Mrik+L7AZRUmZi16tbeQv6EU2c7VAO0lJJSE/+Rr5ENmFJVT+CBEjY5uw7bMiFw
	VP2DBmv5rcZ3l56EikAshlIjNjL19vL8VqUHxwH5TvMquTDq8JLCv2Qk5wTCHjuxa090dW
	nAnU2XqKzk011wCSeeCnv1R546eJp10=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-Vo0NQoFfMzOVtmv9lzGmWQ-1; Fri,
 16 Jan 2026 09:20:17 -0500
X-MC-Unique: Vo0NQoFfMzOVtmv9lzGmWQ-1
X-Mimecast-MFC-AGG-ID: Vo0NQoFfMzOVtmv9lzGmWQ_1768573216
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B14E19560A3;
	Fri, 16 Jan 2026 14:20:16 +0000 (UTC)
Received: from localhost (unknown [10.72.116.198])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B18A30002D6;
	Fri, 16 Jan 2026 14:20:14 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 14/24] ublk: fix batch I/O recovery -ENODEV error
Date: Fri, 16 Jan 2026 22:18:47 +0800
Message-ID: <20260116141859.719929-15-ming.lei@redhat.com>
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

During recovery with batch I/O, UBLK_U_IO_FETCH_IO_CMDS command fails with
-ENODEV because ublk_batch_attach() rejects them when ubq->canceling is set.
The canceling flag remains set until all queues are ready.

Fix this by tracking per-queue readiness and clearing ubq->canceling as
soon as each individual queue becomes ready, rather than waiting for all
queues. This allows subsequent UBLK_U_IO_FETCH_IO_CMDS commands to succeed
during recovery.

Changes:
- Add ubq->nr_io_ready to track I/Os ready per queue
- Add ub->nr_queue_ready to track number of ready queues
- Add ublk_queue_ready() helper to check queue readiness
- Redefine ublk_dev_ready() based on queue count instead of I/O count
- Clear ubq->canceling immediately when queue becomes ready
- Add ublk_queue_reset_io_flags() to reset per-queue flags

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 92 ++++++++++++++++++++++++++--------------
 1 file changed, 60 insertions(+), 32 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e6e746cd369e..346596c1e319 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -239,6 +239,7 @@ struct ublk_queue {
 	bool fail_io; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
 	spinlock_t		cancel_lock;
 	struct ublk_device *dev;
+	u32 nr_io_ready;
 
 	/*
 	 * For supporting UBLK_F_BATCH_IO only.
@@ -311,7 +312,7 @@ struct ublk_device {
 	struct ublk_params	params;
 
 	struct completion	completion;
-	u32			nr_io_ready;
+	u32			nr_queue_ready;
 	bool 			unprivileged_daemons;
 	struct mutex cancel_mutex;
 	bool canceling;
@@ -2173,6 +2174,8 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 {
 	int i;
 
+	ubq->nr_io_ready = 0;
+
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
 
@@ -2221,7 +2224,7 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
 
 	/* set to NULL, otherwise new tasks cannot mmap io_cmd_buf */
 	ub->mm = NULL;
-	ub->nr_io_ready = 0;
+	ub->nr_queue_ready = 0;
 	ub->unprivileged_daemons = false;
 	ub->ublksrv_tgid = -1;
 }
@@ -2678,11 +2681,14 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	ublk_cancel_cmd(ubq, pdu->tag, issue_flags);
 }
 
-static inline bool ublk_dev_ready(const struct ublk_device *ub)
+static inline bool ublk_queue_ready(const struct ublk_queue *ubq)
 {
-	u32 total = (u32)ub->dev_info.nr_hw_queues * ub->dev_info.queue_depth;
+	return ubq->nr_io_ready == ubq->q_depth;
+}
 
-	return ub->nr_io_ready == total;
+static inline bool ublk_dev_ready(const struct ublk_device *ub)
+{
+	return ub->nr_queue_ready == ub->dev_info.nr_hw_queues;
 }
 
 static void ublk_cancel_queue(struct ublk_queue *ubq)
@@ -2791,37 +2797,52 @@ static void ublk_stop_dev(struct ublk_device *ub)
 	ublk_cancel_dev(ub);
 }
 
-/* reset ublk io_uring queue & io flags */
-static void ublk_reset_io_flags(struct ublk_device *ub)
+/* reset per-queue io flags */
+static void ublk_queue_reset_io_flags(struct ublk_queue *ubq)
 {
-	int i, j;
+	int j;
 
-	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
-		struct ublk_queue *ubq = ublk_get_queue(ub, i);
-
-		/* UBLK_IO_FLAG_CANCELED can be cleared now */
-		spin_lock(&ubq->cancel_lock);
-		for (j = 0; j < ubq->q_depth; j++)
-			ubq->ios[j].flags &= ~UBLK_IO_FLAG_CANCELED;
-		spin_unlock(&ubq->cancel_lock);
-		ubq->fail_io = false;
-	}
-	mutex_lock(&ub->cancel_mutex);
-	ublk_set_canceling(ub, false);
-	mutex_unlock(&ub->cancel_mutex);
+	/* UBLK_IO_FLAG_CANCELED can be cleared now */
+	spin_lock(&ubq->cancel_lock);
+	for (j = 0; j < ubq->q_depth; j++)
+		ubq->ios[j].flags &= ~UBLK_IO_FLAG_CANCELED;
+	spin_unlock(&ubq->cancel_lock);
+	ubq->fail_io = false;
+	ubq->canceling = false;
 }
 
 /* device can only be started after all IOs are ready */
-static void ublk_mark_io_ready(struct ublk_device *ub)
+static void ublk_mark_io_ready(struct ublk_device *ub, u16 q_id)
 	__must_hold(&ub->mutex)
 {
+	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
+
 	if (!ub->unprivileged_daemons && !capable(CAP_SYS_ADMIN))
 		ub->unprivileged_daemons = true;
 
-	ub->nr_io_ready++;
+	ubq->nr_io_ready++;
+
+	/* Check if this specific queue is now fully ready */
+	if (ublk_queue_ready(ubq)) {
+		ub->nr_queue_ready++;
+
+		/*
+		 * Reset queue flags as soon as this queue is ready.
+		 * This clears the canceling flag, allowing batch FETCH commands
+		 * to succeed during recovery without waiting for all queues.
+		 */
+		ublk_queue_reset_io_flags(ubq);
+	}
+
+	/* Check if all queues are ready */
 	if (ublk_dev_ready(ub)) {
-		/* now we are ready for handling ublk io request */
-		ublk_reset_io_flags(ub);
+		/*
+		 * All queues ready - clear device-level canceling flag
+		 * and complete the recovery/initialization.
+		 */
+		mutex_lock(&ub->cancel_mutex);
+		ub->canceling = false;
+		mutex_unlock(&ub->cancel_mutex);
 		complete_all(&ub->completion);
 	}
 }
@@ -3025,7 +3046,7 @@ static int ublk_check_fetch_buf(const struct ublk_device *ub, __u64 buf_addr)
 }
 
 static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
-			struct ublk_io *io)
+			struct ublk_io *io, u16 q_id)
 {
 	/* UBLK_IO_FETCH_REQ is only allowed before dev is setup */
 	if (ublk_dev_ready(ub))
@@ -3043,13 +3064,13 @@ static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
 		WRITE_ONCE(io->task, NULL);
 	else
 		WRITE_ONCE(io->task, get_task_struct(current));
-	ublk_mark_io_ready(ub);
+	ublk_mark_io_ready(ub, q_id);
 
 	return 0;
 }
 
 static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
-		      struct ublk_io *io, __u64 buf_addr)
+		      struct ublk_io *io, __u64 buf_addr, u16 q_id)
 {
 	int ret;
 
@@ -3059,7 +3080,7 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
 	 * FETCH, so it is fine even for IO_URING_F_NONBLOCK.
 	 */
 	mutex_lock(&ub->mutex);
-	ret = __ublk_fetch(cmd, ub, io);
+	ret = __ublk_fetch(cmd, ub, io, q_id);
 	if (!ret)
 		ret = ublk_config_io_buf(ub, io, cmd, buf_addr, NULL);
 	mutex_unlock(&ub->mutex);
@@ -3165,7 +3186,7 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		ret = ublk_check_fetch_buf(ub, addr);
 		if (ret)
 			goto out;
-		ret = ublk_fetch(cmd, ub, io, addr);
+		ret = ublk_fetch(cmd, ub, io, addr, q_id);
 		if (ret)
 			goto out;
 
@@ -3411,7 +3432,14 @@ static int ublk_batch_unprep_io(struct ublk_queue *ubq,
 {
 	struct ublk_io *io = &ubq->ios[elem->tag];
 
-	data->ub->nr_io_ready--;
+	/*
+	 * If queue was ready before this decrement, it won't be anymore,
+	 * so we need to decrement the queue ready count too.
+	 */
+	if (ublk_queue_ready(ubq))
+		data->ub->nr_queue_ready--;
+	ubq->nr_io_ready--;
+
 	ublk_io_lock(io);
 	io->flags = 0;
 	ublk_io_unlock(io);
@@ -3451,7 +3479,7 @@ static int ublk_batch_prep_io(struct ublk_queue *ubq,
 	}
 
 	ublk_io_lock(io);
-	ret = __ublk_fetch(data->cmd, data->ub, io);
+	ret = __ublk_fetch(data->cmd, data->ub, io, ubq->q_id);
 	if (!ret)
 		io->buf = buf;
 	ublk_io_unlock(io);
-- 
2.47.0

