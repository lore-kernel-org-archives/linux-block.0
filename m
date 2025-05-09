Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40093234964
	for <linux-block@vger.kernel.org>; Fri,  9 May 2025 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803206; cv=none; b=jJPf6t/HACA7b6oXilLN947NqxIG9JMiFc+26LtIvDWATboTJTw+fiJ5/J6cWmgJUMnFkhnG2fbfU5Q3iqkKlpr3Bav7pnbmQJTKVHZVT5QV6oXaNUMn0LpHS4WMmoT6ZrS5QUoMV8aCuswzqkpkjUbq9SVv3y2JmRJ/Wf9bxvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803206; c=relaxed/simple;
	bh=1qQaELpycXrPe9Lmo6gyuhVmSDaSjF7mdMUJgqS0Fb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iahkNVx5xQRKVVBkr8aRhmelh8ePx+grdyF6I+7jJXLXRbWxGHDrw9rMEvCKmPUMgkP+hVK8XxPmmayfxqyU2PZ781dYfc61/Yb5ZD9AWppVope9hXVOkMsuSm6aUhKZihecW/OticdFzmAhwhO7DEh0wjSw7vr/h1s22rD7jsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Je9xLVIi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Je9xLVIi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746803203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rF0Hqb+Pcsb9MS/1Mg3nugClG7I3XO88AKi0VdzdhBU=;
	b=Je9xLVIioDCdUsE9vqA+92rx811fPI5fX3HIu4EoHvENtPsGaDksO+e/HtrCequyeKyo3r
	ts/tuzzX24Lvhh4daIOGA+51tcOxKfsaLP6kxG7tZpKa6pgBBnqkyGQMOGkDPHfDHdGUjz
	ysgvd8Zw0zutbRsA9ars8eAad+Z/ZmE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-tNqJWxX3M_SzdJCCyunb-A-1; Fri,
 09 May 2025 11:06:38 -0400
X-MC-Unique: tNqJWxX3M_SzdJCCyunb-A-1
X-Mimecast-MFC-AGG-ID: tNqJWxX3M_SzdJCCyunb-A_1746803197
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A0F71800447;
	Fri,  9 May 2025 15:06:37 +0000 (UTC)
Received: from localhost (unknown [10.72.116.140])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 66726180045B;
	Fri,  9 May 2025 15:06:35 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 4/6] ublk: register buffer to local io_uring with provided buf index via UBLK_F_AUTO_BUF_REG
Date: Fri,  9 May 2025 23:06:07 +0800
Message-ID: <20250509150611.3395206-5-ming.lei@redhat.com>
In-Reply-To: <20250509150611.3395206-1-ming.lei@redhat.com>
References: <20250509150611.3395206-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
 drivers/block/ublk_drv.c      | 71 +++++++++++++++++++++++----
 include/uapi/linux/ublk_cmd.h | 90 +++++++++++++++++++++++++++++++++++
 2 files changed, 151 insertions(+), 10 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 1f98e561dc38..17c41a7fa870 100644
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
+	unsigned short buf_index;
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
@@ -1175,20 +1182,38 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 		blk_mq_end_request(rq, BLK_STS_IOERR);
 }
 
+static void ublk_auto_buf_reg_fallback(struct request *req, struct ublk_io *io,
+				       unsigned int issue_flags)
+{
+	const struct ublk_queue *ubq = req->mq_hctx->driver_data;
+	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
+	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
+
+	iod->op_flags |= UBLK_IO_F_NEED_REG_BUF;
+	refcount_set(&data->ref, 1);
+	ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags);
+}
+
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
-		blk_mq_end_request(req, BLK_STS_IOERR);
+		if (pdu->buf.flags & UBLK_AUTO_BUF_REG_FALLBACK)
+			ublk_auto_buf_reg_fallback(req, io, issue_flags);
+		else
+			blk_mq_end_request(req, BLK_STS_IOERR);
 		return false;
 	}
 	/* one extra reference is dropped by ublk_io_release */
 	refcount_set(&data->ref, 2);
+	/* store buffer index in request payload */
+	data->buf_index = pdu->buf.index;
 	io->flags |= UBLK_IO_FLAG_AUTO_BUF_REG;
 	return true;
 }
@@ -1952,6 +1977,20 @@ static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
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
+	if (pdu->buf.flags & ~UBLK_AUTO_BUF_REG_F_MASK)
+		return false;
+	return true;
+}
+
 static void ublk_io_release(void *priv)
 {
 	struct request *rq = priv;
@@ -2041,9 +2080,13 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
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
 
@@ -2080,7 +2123,7 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 		req->__sector = ub_cmd->zone_append_lba;
 
 	if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG)
-		ublk_auto_buf_unreg(io, issue_flags);
+		ublk_auto_buf_unreg(io, req, issue_flags);
 
 	if (likely(!blk_should_fake_timeout(req->q)))
 		ublk_put_req_ref(ubq, req);
@@ -2196,6 +2239,10 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	default:
 		goto out;
 	}
+
+	if (ublk_support_auto_buf_reg(ubq) && !ublk_set_auto_buf_reg(cmd))
+		return -EINVAL;
+
 	ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 	return -EIOCBQUEUED;
 
@@ -2806,8 +2853,11 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
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
 
@@ -2865,7 +2915,8 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 		UBLK_F_URING_CMD_COMP_IN_TASK;
 
 	/* GET_DATA isn't needed any more with USER_COPY or ZERO COPY */
-	if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY))
+	if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY |
+				UBLK_F_AUTO_BUF_REG))
 		ub->dev_info.flags &= ~UBLK_F_NEED_GET_DATA;
 
 	/*
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index be5c6c6b16e0..ecd7ab8c00ca 100644
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
@@ -305,6 +328,17 @@ struct ublksrv_ctrl_dev_info {
 #define		UBLK_IO_F_FUA			(1U << 13)
 #define		UBLK_IO_F_NOUNMAP		(1U << 15)
 #define		UBLK_IO_F_SWAP			(1U << 16)
+/*
+ * For UBLK_F_AUTO_BUF_REG & UBLK_AUTO_BUF_REG_FALLBACK only.
+ *
+ * This flag is set if auto buffer register is failed & ublk server passes
+ * UBLK_AUTO_BUF_REG_FALLBACK, and ublk server need to register buffer
+ * manually for handling the delivered IO command if this flag is observed
+ *
+ * ublk server has to check this flag if UBLK_AUTO_BUF_REG_FALLBACK is
+ * passed in.
+ */
+#define		UBLK_IO_F_NEED_REG_BUF		(1U << 17)
 
 /*
  * io cmd is described by this structure, and stored in share memory, indexed
@@ -339,6 +373,62 @@ static inline __u32 ublksrv_get_flags(const struct ublksrv_io_desc *iod)
 	return iod->op_flags >> 8;
 }
 
+/*
+ * If this flag is set, fallback by completing the uring_cmd and setting
+ * `UBLK_IO_F_NEED_REG_BUF` in case of auto-buf-register failure;
+ * otherwise the client ublk request is failed silently
+ *
+ * If ublk server passes this flag, it has to check if UBLK_IO_F_NEED_REG_BUF
+ * is set in `ublksrv_io_desc.op_flags`. If UBLK_IO_F_NEED_REG_BUF is set,
+ * ublk server needs to register io buffer manually for handling IO command.
+ */
+#define UBLK_AUTO_BUF_REG_FALLBACK 	(1 << 0)
+#define UBLK_AUTO_BUF_REG_F_MASK 	UBLK_AUTO_BUF_REG_FALLBACK
+
+struct ublk_auto_buf_reg {
+	/* index for registering the delivered request buffer */
+	__u16  index;
+	__u8   flags;
+	__u8   reserved0;
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
+ * 	- bit16 ~ bit23: flags
+ * 	- bit24 ~ bit31: reserved0
+ * 	- bit32 ~ bit63: reserved1
+ */
+static inline struct ublk_auto_buf_reg ublk_sqe_addr_to_auto_buf_reg(
+		__u64 sqe_addr)
+{
+	struct ublk_auto_buf_reg reg = {
+		.index = sqe_addr & 0xffff,
+		.flags = (sqe_addr >> 16) & 0xff,
+		.reserved0 = (sqe_addr >> 24) & 0xff,
+		.reserved1 = sqe_addr >> 32,
+	};
+
+	return reg;
+}
+
+static inline __u64
+ublk_auto_buf_reg_to_sqe_addr(const struct ublk_auto_buf_reg *buf)
+{
+	__u64 addr = buf->index | buf->flags << 16 | buf->reserved0 << 24 |
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

