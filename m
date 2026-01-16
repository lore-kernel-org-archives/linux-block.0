Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D99632E14F
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573210; cv=none; b=G0aictBIk9c2fJVhUImvovysceUy5FyMLLecw6alhN6gKS3gyVv316yJHcUJ9yef11mr1febwzF66eNrjyshXKD+UdlQ+E6fowKksquVn1Nm2aJb1v39pCq+qDg+tCzBM92G19WnYrn9OYBurWUppAatF7t585NzeaiX8fKAcps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573210; c=relaxed/simple;
	bh=m/eugro36n0LDRD4wTq3HCs66o3SOzAkHmUBKk5xSjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtniAlYqhSWkM7vd/x449TH4Pp8nSAJphKQK4i3ZZteckTPeJRsbyPlerlO6YfzWPpkvGN+K65G3N0FWonbU3XzByW72wvnG01RvnIxnspOpjOkB1a8iUOj4j4l9jwAcenEwYANqGEV/a4G9i3zpLDIaTh4+YRte5eIy2EZEWo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YrCBbwBt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YrCBbwBt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768573205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/PDWMQ0VPDDXjZ7ZyeuG58NrTFYyeEpZo6N62poyYA=;
	b=YrCBbwBtWCLPVpKHAjPmyF5tNF+Fg5T9mHdoXW7kcxvAioUgHkkFGjZ83PMTa07Pvh97lk
	DKeWaCQqTJo5LeZU7/dtB2CvLgaSUhHI8EiApEA7vhMP0kAzu9DMksGEvZlVhIvj9vY/i/
	FkGOXtTd0csAfTDmSuOhU3ex17yZF4A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-z-GQ7qxJPoaeRcGGgKjl7w-1; Fri,
 16 Jan 2026 09:20:02 -0500
X-MC-Unique: z-GQ7qxJPoaeRcGGgKjl7w-1
X-Mimecast-MFC-AGG-ID: z-GQ7qxJPoaeRcGGgKjl7w_1768573201
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 947271956063;
	Fri, 16 Jan 2026 14:20:01 +0000 (UTC)
Received: from localhost (unknown [10.72.116.198])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 675F819560A7;
	Fri, 16 Jan 2026 14:19:59 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 11/24] ublk: add new feature UBLK_F_BATCH_IO
Date: Fri, 16 Jan 2026 22:18:44 +0800
Message-ID: <20260116141859.719929-12-ming.lei@redhat.com>
In-Reply-To: <20260116141859.719929-1-ming.lei@redhat.com>
References: <20260116141859.719929-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add new feature UBLK_F_BATCH_IO which replaces the following two
per-io commands:

	- UBLK_U_IO_FETCH_REQ

	- UBLK_U_IO_COMMIT_AND_FETCH_REQ

with three per-queue batch io uring_cmd:

	- UBLK_U_IO_PREP_IO_CMDS

	- UBLK_U_IO_COMMIT_IO_CMDS

	- UBLK_U_IO_FETCH_IO_CMDS

Then ublk can deliver batch io commands to ublk server in single
multishort uring_cmd, also allows to prepare & commit multiple
commands in batch style via single uring_cmd, communication cost is
reduced a lot.

This feature also doesn't limit task context any more for all supported
commands, so any allowed uring_cmd can be issued in any task context.
ublk server implementation becomes much easier.

Meantime load balance becomes much easier to support with this feature.
The command `UBLK_U_IO_FETCH_IO_CMDS` can be issued from multiple task
contexts, so each task can adjust this command's buffer length or number
of inflight commands for controlling how much load is handled by current
task.

Later, priority parameter will be added to command `UBLK_U_IO_FETCH_IO_CMDS`
for improving load balance support.

UBLK_U_IO_NEED_GET_DATA isn't supported in batch io yet, but it may be
enabled in future via its batch pair.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 60 ++++++++++++++++++++++++++++++-----
 include/uapi/linux/ublk_cmd.h | 15 +++++++++
 2 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 602666c0c676..2783af67ed10 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -79,7 +79,8 @@
 		| UBLK_F_PER_IO_DAEMON \
 		| UBLK_F_BUF_REG_OFF_DAEMON \
 		| (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRITY : 0) \
-		| UBLK_F_SAFE_STOP_DEV)
+		| UBLK_F_SAFE_STOP_DEV \
+		| UBLK_F_BATCH_IO)
 
 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
@@ -340,12 +341,12 @@ static void ublk_batch_dispatch(struct ublk_queue *ubq,
 
 static inline bool ublk_dev_support_batch_io(const struct ublk_device *ub)
 {
-	return false;
+	return ub->dev_info.flags & UBLK_F_BATCH_IO;
 }
 
 static inline bool ublk_support_batch_io(const struct ublk_queue *ubq)
 {
-	return false;
+	return ubq->flags & UBLK_F_BATCH_IO;
 }
 
 static inline void ublk_io_lock(struct ublk_io *io)
@@ -3573,9 +3574,11 @@ static int ublk_check_batch_cmd_flags(const struct ublk_batch_io *uc)
 
 static int ublk_check_batch_cmd(const struct ublk_batch_io_data *data)
 {
-
 	const struct ublk_batch_io *uc = &data->header;
 
+	if (uc->q_id >= data->ub->dev_info.nr_hw_queues)
+		return -EINVAL;
+
 	if (uc->nr_elem > data->ub->dev_info.queue_depth)
 		return -E2BIG;
 
@@ -3655,6 +3658,9 @@ static int ublk_validate_batch_fetch_cmd(struct ublk_batch_io_data *data)
 {
 	const struct ublk_batch_io *uc = &data->header;
 
+	if (uc->q_id >= data->ub->dev_info.nr_hw_queues)
+		return -EINVAL;
+
 	if (!(data->cmd->flags & IORING_URING_CMD_MULTISHOT))
 		return -EINVAL;
 
@@ -3667,6 +3673,35 @@ static int ublk_validate_batch_fetch_cmd(struct ublk_batch_io_data *data)
 	return 0;
 }
 
+static int ublk_handle_non_batch_cmd(struct io_uring_cmd *cmd,
+				     unsigned int issue_flags)
+{
+	const struct ublksrv_io_cmd *ub_cmd = io_uring_sqe_cmd(cmd->sqe);
+	struct ublk_device *ub = cmd->file->private_data;
+	unsigned tag = READ_ONCE(ub_cmd->tag);
+	unsigned q_id = READ_ONCE(ub_cmd->q_id);
+	unsigned index = READ_ONCE(ub_cmd->addr);
+	struct ublk_queue *ubq;
+	struct ublk_io *io;
+
+	if (cmd->cmd_op == UBLK_U_IO_UNREGISTER_IO_BUF)
+		return ublk_unregister_io_buf(cmd, ub, index, issue_flags);
+
+	if (q_id >= ub->dev_info.nr_hw_queues)
+		return -EINVAL;
+
+	if (tag >= ub->dev_info.queue_depth)
+		return -EINVAL;
+
+	if (cmd->cmd_op != UBLK_U_IO_REGISTER_IO_BUF)
+		return -EOPNOTSUPP;
+
+	ubq = ublk_get_queue(ub, q_id);
+	io = &ubq->ios[tag];
+	return ublk_register_io_buf(cmd, ub, q_id, tag, io, index,
+			issue_flags);
+}
+
 static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
 				       unsigned int issue_flags)
 {
@@ -3691,9 +3726,6 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
 		return 0;
 	}
 
-	if (data.header.q_id >= ub->dev_info.nr_hw_queues)
-		goto out;
-
 	switch (cmd_op) {
 	case UBLK_U_IO_PREP_IO_CMDS:
 		ret = ublk_check_batch_cmd(&data);
@@ -3714,7 +3746,8 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
 		ret = ublk_handle_batch_fetch_cmd(&data);
 		break;
 	default:
-		ret = -EOPNOTSUPP;
+		ret = ublk_handle_non_batch_cmd(cmd, issue_flags);
+		break;
 	}
 out:
 	return ret;
@@ -4446,6 +4479,10 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 		UBLK_F_BUF_REG_OFF_DAEMON |
 		UBLK_F_SAFE_STOP_DEV;
 
+	/* So far, UBLK_F_PER_IO_DAEMON won't be exposed for BATCH_IO */
+	if (ublk_dev_support_batch_io(ub))
+		ub->dev_info.flags &= ~UBLK_F_PER_IO_DAEMON;
+
 	/* GET_DATA isn't needed any more with USER_COPY or ZERO COPY */
 	if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY |
 				UBLK_F_AUTO_BUF_REG))
@@ -4849,6 +4886,13 @@ static int ublk_wait_for_idle_io(struct ublk_device *ub,
 	unsigned int elapsed = 0;
 	int ret;
 
+	/*
+	 * For UBLK_F_BATCH_IO ublk server can get notified with existing
+	 * or new fetch command, so needn't wait any more
+	 */
+	if (ublk_dev_support_batch_io(ub))
+		return 0;
+
 	while (elapsed < timeout_ms && !signal_pending(current)) {
 		unsigned int queues_cancelable = 0;
 		int i;
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 70d8ebbf4326..743d31491387 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -340,6 +340,21 @@
  */
 #define UBLK_F_BUF_REG_OFF_DAEMON (1ULL << 14)
 
+/*
+ * Support the following commands for delivering & committing io command
+ * in batch.
+ *
+ * 	- UBLK_U_IO_PREP_IO_CMDS
+ * 	- UBLK_U_IO_COMMIT_IO_CMDS
+ * 	- UBLK_U_IO_FETCH_IO_CMDS
+ * 	- UBLK_U_IO_REGISTER_IO_BUF
+ * 	- UBLK_U_IO_UNREGISTER_IO_BUF
+ *
+ * The existing UBLK_U_IO_FETCH_REQ, UBLK_U_IO_COMMIT_AND_FETCH_REQ and
+ * UBLK_U_IO_NEED_GET_DATA uring_cmd are not supported for this feature.
+ */
+#define UBLK_F_BATCH_IO		(1ULL << 15)
+
 /*
  * ublk device supports requests with integrity/metadata buffer.
  * Requires UBLK_F_USER_COPY.
-- 
2.47.0

