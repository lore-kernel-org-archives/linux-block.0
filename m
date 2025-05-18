Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6223C14EC5B
	for <linux-block@vger.kernel.org>; Sun, 18 May 2025 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747574024; cv=none; b=U6CIi7SZ3KsbqtluhuCi/DXxdBKeeJ16tAESXRN99BdkvyoJMszb9D0TFe25nVEIx7Mi8T1k3hdGWLTZ/8z5jd1/5+TmfSQhkn3DlpTPqqono0EUu4g8jkYmBWXteDrv2EOsvYUFkLuBbwPPxPNa9Htn2yuJyTaA0QpYZYF2Z0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747574024; c=relaxed/simple;
	bh=bD3ZugrJ0st70EsODX+cx67wmjdw8VSpyZsH5i1A72k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWxFnQ5QOSbnZiJ0aWZ/naCFcBgr699Lcz85k3me/yhsP+wvFgJtZxBbUrvdnUziG5bSt3RKuYJo+Hl1vEoFKy2ddxhGrGlBnZpmojV/H9XyjIs1YcuioTtGkWmotSs4/CiucxmsFaNFGTqRoxEmiiz4oRRpIgDT7llEMT8wijw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VlFdsZyz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlFdsZyz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747574020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WrgMkDrWMyFx8LEZzwG0KUvvmmSROeliwauXE8ZM/Gc=;
	b=VlFdsZyzYPqpBItxIba7AOy00AOJz7yrtmBJKTclDHr3yx0uHKtXPA8DC4SvMEqn8TThk2
	5OjSNNWWnlPwFgUlaZ/8ouX83I8+T1jiejXYdfiN1Vi+U/A5ni5j7WHjRIUDIJvmGz58Hk
	f6kcTX7UR4ga9Vzc5MwyOu8OtA0TU4g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-6kk6ToXDMJWpDQaFRqXJSg-1; Sun,
 18 May 2025 09:13:36 -0400
X-MC-Unique: 6kk6ToXDMJWpDQaFRqXJSg-1
X-Mimecast-MFC-AGG-ID: 6kk6ToXDMJWpDQaFRqXJSg_1747574016
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E46021956086;
	Sun, 18 May 2025 13:13:35 +0000 (UTC)
Received: from localhost (unknown [10.72.116.32])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C70AC19560AB;
	Sun, 18 May 2025 13:13:33 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 3/6] ublk: register buffer to local io_uring with provided buf index via UBLK_F_AUTO_BUF_REG
Date: Sun, 18 May 2025 21:12:58 +0800
Message-ID: <20250518131303.195957-4-ming.lei@redhat.com>
In-Reply-To: <20250518131303.195957-1-ming.lei@redhat.com>
References: <20250518131303.195957-1-ming.lei@redhat.com>
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
 drivers/block/ublk_drv.c      | 54 ++++++++++++++++++++++++-----
 include/uapi/linux/ublk_cmd.h | 64 +++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 9 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d0fd783c5404..0c8c18ea25bc 100644
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
 
+static inline bool ublk_set_auto_buf_reg(struct io_uring_cmd *cmd)
+{
+	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+
+	pdu->buf = ublk_sqe_addr_to_auto_buf_reg(READ_ONCE(cmd->sqe->addr));
+
+	if (pdu->buf.reserved0 || pdu->buf.reserved1)
+		return false;
+
+	return true;
+}
+
 static void ublk_io_release(void *priv)
 {
 	struct request *rq = priv;
@@ -2041,9 +2063,13 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 	return ret;
 }
 
-static void ublk_auto_buf_unreg(struct ublk_io *io, unsigned int issue_flags)
+static void ublk_auto_buf_unreg(struct ublk_io *io, struct request *req,
+				unsigned int issue_flags)
 {
-	WARN_ON_ONCE(io_buffer_unregister_bvec(io->cmd, 0, issue_flags));
+	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
+
+	WARN_ON_ONCE(io_buffer_unregister_bvec(io->cmd, data->buf_index,
+				issue_flags));
 	io->flags &= ~UBLK_IO_FLAG_AUTO_BUF_REG;
 }
 
@@ -2080,7 +2106,7 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 		req->__sector = ub_cmd->zone_append_lba;
 
 	if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG)
-		ublk_auto_buf_unreg(io, issue_flags);
+		ublk_auto_buf_unreg(io, req, issue_flags);
 
 	if (likely(!blk_should_fake_timeout(req->q)))
 		ublk_put_req_ref(ubq, req);
@@ -2182,6 +2208,11 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	default:
 		goto out;
 	}
+
+	/* we can't set data for auto_buf_reg until old data is consumed */
+	if (ublk_support_auto_buf_reg(ubq) && !ublk_set_auto_buf_reg(cmd))
+		return -EINVAL;
+
 	ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 	return -EIOCBQUEUED;
 
@@ -2792,8 +2823,11 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
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
 
@@ -2851,7 +2885,8 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 		UBLK_F_URING_CMD_COMP_IN_TASK;
 
 	/* GET_DATA isn't needed any more with USER_COPY or ZERO COPY */
-	if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY))
+	if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY |
+				UBLK_F_AUTO_BUF_REG))
 		ub->dev_info.flags &= ~UBLK_F_NEED_GET_DATA;
 
 	/*
@@ -3378,6 +3413,7 @@ static int __init ublk_init(void)
 
 	BUILD_BUG_ON((u64)UBLKSRV_IO_BUF_OFFSET +
 			UBLKSRV_IO_BUF_TOTAL_SIZE < UBLKSRV_IO_BUF_OFFSET);
+	BUILD_BUG_ON(sizeof(struct ublk_auto_buf_reg) != 8);
 
 	init_waitqueue_head(&ublk_idr_wq);
 
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index be5c6c6b16e0..663187cdfa52 100644
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
+ * - pass flags from `ublk_auto_buf_reg.flags` if needed
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

