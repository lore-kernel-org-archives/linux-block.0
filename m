Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239E02C21DA
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690415; cv=none; b=lZDx2bt1+ftVcYJZwBUaCLkrvMsVbMkqCZXulmkr3qjbbfITzT9CD8GZWZaEmPeUMeJUxgZaoT7wUoJRQH06tpXlWWKqNkMF6skNqFKNH+EwHexM8M53B3SYOtB+ifG4zjyx8PeQ9OUtKfMB2BFOYbc41W67ywc5jYnfznWmWcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690415; c=relaxed/simple;
	bh=if3Ad8D9MLZgclpENQrpcBjRHrZ0O72fYyvYdbS9nD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=driS8B0VfIgb/TeUT9slX6U6nOsMFT5aearPigMwwco9CCZjAEg0kn1/Dg8aaxyj2m09ACe7RhYCB3xsSYCSLRhujiN5oZPW5zcDZqUNd23ZW3t4DyM0+OYmvZZSw1BUb0dbaHOKzaRqhVZxIZG74mOi8JpMFVsUs+K9XKnEnBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J7HztbR9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7HztbR9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763690413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=APgPdgnWoBJ34YoCRwEfYGiHtu7xr5eSm1q+oTVRq1Y=;
	b=J7HztbR9IGL1VoCp+p2a9Pcn1ZS/Z93SJuhGWtsXqLij+9PrEx7CNSfzgSCazrleN+O+K4
	5CYGMoSdZyyeGn9DPzk5M+yJTixjw699GlG2fMHRdx7uaPPZBvGiGwocZ4xOtZ5bAHwtwK
	kIMTOm829RsdJjC1Xff/cR1v4EhT4dY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-982BNqtBMNK0LZjufiZ3wQ-1; Thu,
 20 Nov 2025 21:00:09 -0500
X-MC-Unique: 982BNqtBMNK0LZjufiZ3wQ-1
X-Mimecast-MFC-AGG-ID: 982BNqtBMNK0LZjufiZ3wQ_1763690408
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0ADA1956058;
	Fri, 21 Nov 2025 02:00:07 +0000 (UTC)
Received: from localhost (unknown [10.72.116.211])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E0D6C1940E82;
	Fri, 21 Nov 2025 02:00:06 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 16/27] ublk: add new feature UBLK_F_BATCH_IO
Date: Fri, 21 Nov 2025 09:58:38 +0800
Message-ID: <20251121015851.3672073-17-ming.lei@redhat.com>
In-Reply-To: <20251121015851.3672073-1-ming.lei@redhat.com>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

UBLK_U_IO_GET_DATA isn't supported in batch io yet, but it may be
enabled in future via its batch pair.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 58 ++++++++++++++++++++++++++++++++---
 include/uapi/linux/ublk_cmd.h | 16 ++++++++++
 2 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 849199771f86..90cd1863bc83 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -74,7 +74,8 @@
 		| UBLK_F_AUTO_BUF_REG \
 		| UBLK_F_QUIESCE \
 		| UBLK_F_PER_IO_DAEMON \
-		| UBLK_F_BUF_REG_OFF_DAEMON)
+		| UBLK_F_BUF_REG_OFF_DAEMON \
+		| UBLK_F_BATCH_IO)
 
 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
@@ -320,12 +321,12 @@ static void ublk_batch_dispatch(struct ublk_queue *ubq,
 
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
@@ -3450,6 +3451,41 @@ static int ublk_validate_batch_fetch_cmd(struct ublk_batch_io_data *data,
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
+	int ret = -EINVAL;
+
+	if (!ub)
+		return ret;
+
+	if (q_id >= ub->dev_info.nr_hw_queues)
+		return ret;
+
+	ubq = ublk_get_queue(ub, q_id);
+	if (tag >= ubq->q_depth)
+		return ret;
+
+	io = &ubq->ios[tag];
+
+	switch (cmd->cmd_op) {
+	case UBLK_U_IO_REGISTER_IO_BUF:
+		return ublk_register_io_buf(cmd, ub, q_id, tag, io, index,
+				issue_flags);
+	case UBLK_U_IO_UNREGISTER_IO_BUF:
+		return ublk_unregister_io_buf(cmd, ub, index, issue_flags);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
 				       unsigned int issue_flags)
 {
@@ -3497,7 +3533,8 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
 		ret = ublk_handle_batch_fetch_cmd(&data);
 		break;
 	default:
-		ret = -EOPNOTSUPP;
+		ret = ublk_handle_non_batch_cmd(cmd, issue_flags);
+		break;
 	}
 out:
 	return ret;
@@ -4163,9 +4200,13 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 
 	ub->dev_info.flags |= UBLK_F_CMD_IOCTL_ENCODE |
 		UBLK_F_URING_CMD_COMP_IN_TASK |
-		UBLK_F_PER_IO_DAEMON |
+		(ublk_dev_support_batch_io(ub) ? 0 : UBLK_F_PER_IO_DAEMON) |
 		UBLK_F_BUF_REG_OFF_DAEMON;
 
+	/* So far, UBLK_F_PER_IO_DAEMON won't be exposed for BATCH_IO */
+	if (ublk_dev_support_batch_io(ub))
+		ub->dev_info.flags &= ~UBLK_F_PER_IO_DAEMON;
+
 	/* GET_DATA isn't needed any more with USER_COPY or ZERO COPY */
 	if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY |
 				UBLK_F_AUTO_BUF_REG))
@@ -4518,6 +4559,13 @@ static int ublk_wait_for_idle_io(struct ublk_device *ub,
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
index cd894c1d188e..5e8b1211b7f4 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -335,6 +335,22 @@
  */
 #define UBLK_F_BUF_REG_OFF_DAEMON (1ULL << 14)
 
+
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
+ * UBLK_U_IO_GET_DATA uring_cmd are not supported for this feature.
+ */
+#define UBLK_F_BATCH_IO		(1ULL << 15)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
-- 
2.47.0

