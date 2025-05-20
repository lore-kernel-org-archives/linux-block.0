Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEE7213E77
	for <linux-block@vger.kernel.org>; Tue, 20 May 2025 04:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747716928; cv=none; b=LtWvjbpCtqvYt3CzEsswHhiK77IqnbznzP+f2dveGUFkqSYN+LftYUb54XA00trd5Pjy95nvjYA2yWx90ujX6Oben7oq0KETI2a6OzKaxKQazCnK+eowyDFdq2GTW5+Qil9WJzHraSaeQWYFpHqGnfoWIy518A16lanHH8ycF7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747716928; c=relaxed/simple;
	bh=69EhnB7CqgJe+tox5cGpnu9rz/nlePX8XE/niVZWuJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uilshoSDSdVooBRFto1YUkWq1kdb/ildm6M+IgLU/Hyf7lnNmoDjgyGSuIWqv5yt+nPqeXPM9mgBqjkf0qpekLRdldIGia4nM2s4710GARtGEB8DPZGSulwEaT4iIC6zHBEz33koTlyOquvXCnV4awF3g+mf6WFC+nNAwQqZZ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HbfBgIUa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbfBgIUa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747716925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKX05YnHfTQ1TgMPXDGuBCUwi5okpiKIgNTLHweWkPg=;
	b=HbfBgIUaNBS4EwNLVSUj7XVyNxlgvj0y2cE0tKICvtgIMjiAonBdJQT0DFr2hhsBvIpxFN
	OI+BtGQmbcod4mhQvfZbSRUtzw6O7FeCcQov6RygviO+brfzJT8vcc2UJPb+Su4EKnPGma
	ZEjEii4oxqz+TETjSS/prOIzzE6ihCs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-zyUrf-gAMByhOtSOS_GE1Q-1; Tue,
 20 May 2025 00:55:21 -0400
X-MC-Unique: zyUrf-gAMByhOtSOS_GE1Q-1
X-Mimecast-MFC-AGG-ID: zyUrf-gAMByhOtSOS_GE1Q_1747716920
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD8C9195608B;
	Tue, 20 May 2025 04:55:19 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A129319560A3;
	Tue, 20 May 2025 04:55:18 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 3/6] ublk: register buffer to local io_uring with provided buf index via UBLK_F_AUTO_BUF_REG
Date: Tue, 20 May 2025 12:54:33 +0800
Message-ID: <20250520045455.515691-4-ming.lei@redhat.com>
In-Reply-To: <20250520045455.515691-1-ming.lei@redhat.com>
References: <20250520045455.515691-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add UBLK_F_AUTO_BUF_REG for supporting to register buffer automatically
to local io_uring context with provided buffer index.

Add UAPI structure `struct ublk_auto_buf_reg` for holding user parameter
to register request buffer automatically, one 'flags' field is defined, and
there is still 32bit available for future extension, such as, adding one
io_ring FD field for registering buffer to external io_uring.

`struct ublk_auto_buf_reg` is populated from ublk uring_cmd's sqe->addr,
and all existing ublk commands are data-less, so it is just fine to reuse
sqe->addr for this purpose.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 56 ++++++++++++++++++++++++++----
 include/uapi/linux/ublk_cmd.h | 64 +++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+), 7 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3e56a9d267fb..1aabc655652b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -66,7 +66,8 @@
 		| UBLK_F_USER_COPY \
 		| UBLK_F_ZONED \
 		| UBLK_F_USER_RECOVERY_FAIL_IO \
-		| UBLK_F_UPDATE_SIZE)
+		| UBLK_F_UPDATE_SIZE \
+		| UBLK_F_AUTO_BUF_REG)
 
 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
@@ -80,6 +81,9 @@
 
 struct ublk_rq_data {
 	refcount_t ref;
+
+	/* for auto-unregister buffer in case of UBLK_F_AUTO_BUF_REG */
+	u16 buf_index;
 };
 
 struct ublk_uring_cmd_pdu {
@@ -101,6 +105,9 @@ struct ublk_uring_cmd_pdu {
 	 * setup in ublk uring_cmd handler
 	 */
 	struct ublk_queue *ubq;
+
+	struct ublk_auto_buf_reg buf;
+
 	u16 tag;
 };
 
@@ -630,7 +637,7 @@ static inline bool ublk_support_zero_copy(const struct ublk_queue *ubq)
 
 static inline bool ublk_support_auto_buf_reg(const struct ublk_queue *ubq)
 {
-	return false;
+	return ubq->flags & UBLK_F_AUTO_BUF_REG;
 }
 
 static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
@@ -1178,17 +1185,20 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
 			      unsigned int issue_flags)
 {
+	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(io->cmd);
 	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
 	int ret;
 
-	ret = io_buffer_register_bvec(io->cmd, req, ublk_io_release, 0,
-				      issue_flags);
+	ret = io_buffer_register_bvec(io->cmd, req, ublk_io_release,
+				      pdu->buf.index, issue_flags);
 	if (ret) {
 		blk_mq_end_request(req, BLK_STS_IOERR);
 		return false;
 	}
 	/* one extra reference is dropped by ublk_io_release */
 	refcount_set(&data->ref, 2);
+	/* store buffer index in request payload */
+	data->buf_index = pdu->buf.index;
 	io->flags |= UBLK_IO_FLAG_AUTO_BUF_REG;
 	return true;
 }
@@ -1952,6 +1962,18 @@ static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
 	io_uring_cmd_mark_cancelable(cmd, issue_flags);
 }
 
+static inline int ublk_set_auto_buf_reg(struct io_uring_cmd *cmd)
+{
+	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+
+	pdu->buf = ublk_sqe_addr_to_auto_buf_reg(READ_ONCE(cmd->sqe->addr));
+
+	if (pdu->buf.reserved0 || pdu->buf.reserved1)
+		return -EINVAL;
+
+	return 0;
+}
+
 static void ublk_io_release(void *priv)
 {
 	struct request *rq = priv;
@@ -2034,6 +2056,12 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 		goto out;
 	}
 
+	if (ublk_support_auto_buf_reg(ubq)) {
+		ret = ublk_set_auto_buf_reg(cmd);
+		if (ret)
+			return ret;
+	}
+
 	ublk_fill_io_cmd(io, cmd, buf_addr);
 	ublk_mark_io_ready(ub, ubq);
 out:
@@ -2065,11 +2093,20 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 	}
 
 	if (ublk_support_auto_buf_reg(ubq)) {
+		int ret;
+
 		if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG) {
-			WARN_ON_ONCE(io_buffer_unregister_bvec(cmd, 0,
+			struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
+
+			WARN_ON_ONCE(io_buffer_unregister_bvec(cmd,
+						data->buf_index,
 						issue_flags));
 			io->flags &= ~UBLK_IO_FLAG_AUTO_BUF_REG;
 		}
+
+		ret = ublk_set_auto_buf_reg(cmd);
+		if (ret)
+			return ret;
 	}
 
 	ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
@@ -2791,8 +2828,11 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 		 * For USER_COPY, we depends on userspace to fill request
 		 * buffer by pwrite() to ublk char device, which can't be
 		 * used for unprivileged device
+		 *
+		 * Same with zero copy or auto buffer register.
 		 */
-		if (info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY))
+		if (info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY |
+					UBLK_F_AUTO_BUF_REG))
 			return -EINVAL;
 	}
 
@@ -2850,7 +2890,8 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 		UBLK_F_URING_CMD_COMP_IN_TASK;
 
 	/* GET_DATA isn't needed any more with USER_COPY or ZERO COPY */
-	if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY))
+	if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY |
+				UBLK_F_AUTO_BUF_REG))
 		ub->dev_info.flags &= ~UBLK_F_NEED_GET_DATA;
 
 	/*
@@ -3377,6 +3418,7 @@ static int __init ublk_init(void)
 
 	BUILD_BUG_ON((u64)UBLKSRV_IO_BUF_OFFSET +
 			UBLKSRV_IO_BUF_TOTAL_SIZE < UBLKSRV_IO_BUF_OFFSET);
+	BUILD_BUG_ON(sizeof(struct ublk_auto_buf_reg) != 8);
 
 	init_waitqueue_head(&ublk_idr_wq);
 
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index be5c6c6b16e0..f6f516b1223b 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -219,6 +219,29 @@
  */
 #define UBLK_F_UPDATE_SIZE		 (1ULL << 10)
 
+/*
+ * request buffer is registered automatically to uring_cmd's io_uring
+ * context before delivering this io command to ublk server, meantime
+ * it is un-registered automatically when completing this io command.
+ *
+ * For using this feature:
+ *
+ * - ublk server has to create sparse buffer table
+ *
+ * - ublk server passes auto buf register data via uring_cmd's sqe->addr,
+ *   `struct ublk_auto_buf_reg` is populated from sqe->addr, please see
+ *   the definition of ublk_sqe_addr_to_auto_buf_reg()
+ *
+ * - pass buffer index from `ublk_auto_buf_reg.index`
+ *
+ * - all reserved fields in `ublk_auto_buf_reg` need to be zeroed
+ *
+ * This way avoids extra cost from two uring_cmd, but also simplifies backend
+ * implementation, such as, the dependency on IO_REGISTER_IO_BUF and
+ * IO_UNREGISTER_IO_BUF becomes not necessary.
+ */
+#define UBLK_F_AUTO_BUF_REG 	(1ULL << 11)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
@@ -339,6 +362,47 @@ static inline __u32 ublksrv_get_flags(const struct ublksrv_io_desc *iod)
 	return iod->op_flags >> 8;
 }
 
+struct ublk_auto_buf_reg {
+	/* index for registering the delivered request buffer */
+	__u16  index;
+	__u16   reserved0;
+
+	/*
+	 * io_ring FD can be passed via the reserve field in future for
+	 * supporting to register io buffer to external io_uring
+	 */
+	__u32  reserved1;
+};
+
+/*
+ * For UBLK_F_AUTO_BUF_REG, auto buffer register data is carried via
+ * uring_cmd's sqe->addr:
+ *
+ * 	- bit0 ~ bit15: buffer index
+ * 	- bit24 ~ bit31: reserved0
+ * 	- bit32 ~ bit63: reserved1
+ */
+static inline struct ublk_auto_buf_reg ublk_sqe_addr_to_auto_buf_reg(
+		__u64 sqe_addr)
+{
+	struct ublk_auto_buf_reg reg = {
+		.index = sqe_addr & 0xffff,
+		.reserved0 = (sqe_addr >> 16) & 0xffff,
+		.reserved1 = sqe_addr >> 32,
+	};
+
+	return reg;
+}
+
+static inline __u64
+ublk_auto_buf_reg_to_sqe_addr(const struct ublk_auto_buf_reg *buf)
+{
+	__u64 addr = buf->index | (__u64)buf->reserved0 << 16 |
+		(__u64)buf->reserved1 << 32;
+
+	return addr;
+}
+
 /* issued to ublk driver via /dev/ublkcN */
 struct ublksrv_io_cmd {
 	__u16	q_id;
-- 
2.47.0

