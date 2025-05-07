Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF8C2BB13
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 04:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746592787; cv=none; b=g25js3gTX2kGfOU08XeaFVLcRmHNo4RvbFgUJmFKHVVkk1VBCkERhq1u62a74CNgroaZOQJtDFOmAKXXqQL9U05OaWerRFXbS4/RZEgSqCnIGrVLdTMref3T6saUsi7Hwvso1RHF2055kU8WJ4eSBajQjwGnNiJhBwrnabXc1vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746592787; c=relaxed/simple;
	bh=QsP0F+bq83Qo7VfQlgaIaDQXiiNOXs6R4rVyS9hv4Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMZ+G22/zX3SufFgL4eKvjYkc6jgszQofoOs4sK3DnEsOXAL7aeRvLvUjLXHF6qbaLkBuJk4zpjvVU67CZgtsYmNq8fgWTuGR0z4Mmib2wuauPxqoqs5JeV6KIEWcRQa4436AyoncScx+IAszkhvrL/Vxk3sd9s16b3BWJpWilw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OaBPoKFT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OaBPoKFT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746592782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1fyWgUDEGfUhxOPV56R4ymCMLYEa9WkUjUI6XApecE=;
	b=OaBPoKFTla2v9yFGKV+yu5DvJBzDOS0R3+lQyJ+ji5d9D6vlYkBxeIVZa7hw/ZvCNEp+yy
	1hhLbrYdmuy2Z2lpPo2gMjqShYyWWOayYRIw1A8e7Fr+2MGOyQy4JeOXUmUyhf9RNbeGVO
	AkfLP5INYSx+gF+8L+ZXZ3xyV42+l+U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-lR33hrMBOG68l_fkbSVC-g-1; Wed,
 07 May 2025 00:39:38 -0400
X-MC-Unique: lR33hrMBOG68l_fkbSVC-g-1
X-Mimecast-MFC-AGG-ID: lR33hrMBOG68l_fkbSVC-g_1746592777
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB9B6195DE15;
	Wed,  7 May 2025 04:39:36 +0000 (UTC)
Received: from localhost (unknown [10.72.116.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E0D9718002B4;
	Wed,  7 May 2025 04:39:35 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 4/6] ublk: register buffer to local io_uring with provided buf index via UBLK_F_AUTO_BUF_REG
Date: Wed,  7 May 2025 12:38:55 +0800
Message-ID: <20250507043859.2978132-5-ming.lei@redhat.com>
In-Reply-To: <20250507043859.2978132-1-ming.lei@redhat.com>
References: <20250507043859.2978132-1-ming.lei@redhat.com>
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

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 59 +++++++++++++++++++++++++-------
 include/uapi/linux/ublk_cmd.h | 64 +++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+), 12 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 87de455bec46..f2a57e633823 100644
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
@@ -146,7 +147,16 @@ struct ublk_uring_cmd_pdu {
 
 struct ublk_io {
 	/* userspace buffer address from io cmd */
-	__u64	addr;
+	union {
+		__u64	addr;
+
+		/*
+		 * Shared space with `addr`, see comment on
+		 * `struct ublksrv_io_cmd` for the reason why it is safe to
+		 * reuse '->addr' space
+		 */
+		struct ublk_auto_buf_reg buf;
+	};
 	unsigned int flags;
 	int res;
 
@@ -631,7 +641,7 @@ static inline bool ublk_support_zero_copy(const struct ublk_queue *ubq)
 
 static inline bool ublk_support_auto_buf_reg(const struct ublk_queue *ubq)
 {
-	return false;
+	return ubq->flags & UBLK_F_AUTO_BUF_REG;
 }
 
 static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
@@ -1176,16 +1186,31 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
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
 	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
 	int ret;
 
-	ret = io_buffer_register_bvec(io->cmd, req, ublk_io_release, 0,
-				      issue_flags);
+	ret = io_buffer_register_bvec(io->cmd, req, ublk_io_release,
+				      io->buf.index, issue_flags);
 	if (ret) {
-		blk_mq_end_request(req, BLK_STS_IOERR);
+		if (io->buf.flags & UBLK_AUTO_BUF_REG_FALLBACK)
+			ublk_auto_buf_reg_fallback(req, io, issue_flags);
+		else
+			blk_mq_end_request(req, BLK_STS_IOERR);
 		return false;
 	}
 	/* one extra reference is dropped by ublk_io_release */
@@ -2028,7 +2053,7 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 		 */
 		if (!buf_addr && !ublk_need_get_data(ubq))
 			goto out;
-	} else if (buf_addr) {
+	} else if (buf_addr && !ublk_support_auto_buf_reg(ubq)) {
 		/* User copy requires addr to be unset */
 		ret = -EINVAL;
 		goto out;
@@ -2044,7 +2069,7 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 static void ublk_auto_buf_unreg(struct ublk_io *io, struct io_uring_cmd *cmd,
 				struct request *req, unsigned int issue_flags)
 {
-	WARN_ON_ONCE(io_buffer_unregister_bvec(cmd, 0, issue_flags));
+	WARN_ON_ONCE(io_buffer_unregister_bvec(cmd, io->buf.index, issue_flags));
 	io->flags &= ~UBLK_IO_FLAG_AUTO_BUF_REG;
 }
 
@@ -2063,7 +2088,8 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 		if (!ub_cmd->addr && (!ublk_need_get_data(ubq) ||
 					req_op(req) == REQ_OP_READ))
 			return -EINVAL;
-	} else if (req_op(req) != REQ_OP_ZONE_APPEND && ub_cmd->addr) {
+	} else if ((req_op(req) != REQ_OP_ZONE_APPEND &&
+				!ublk_support_auto_buf_reg(ubq)) && ub_cmd->addr) {
 		/*
 		 * User copy requires addr to be unset when command is
 		 * not zone append
@@ -2807,8 +2833,11 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
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
 
@@ -2866,17 +2895,22 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 		UBLK_F_URING_CMD_COMP_IN_TASK;
 
 	/* GET_DATA isn't needed any more with USER_COPY or ZERO COPY */
-	if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY))
+	if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY |
+				UBLK_F_AUTO_BUF_REG))
 		ub->dev_info.flags &= ~UBLK_F_NEED_GET_DATA;
 
 	/*
 	 * Zoned storage support requires reuse `ublksrv_io_cmd->addr` for
 	 * returning write_append_lba, which is only allowed in case of
 	 * user copy or zero copy
+	 *
+	 * UBLK_F_AUTO_BUF_REG can't be enabled for zoned because it need
+	 * the space for getting ring_fd and buffer index.
 	 */
 	if (ublk_dev_is_zoned(ub) &&
 	    (!IS_ENABLED(CONFIG_BLK_DEV_ZONED) || !(ub->dev_info.flags &
-	     (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY)))) {
+	     (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY)) ||
+	     (ub->dev_info.flags & UBLK_F_AUTO_BUF_REG))) {
 		ret = -EINVAL;
 		goto out_free_dev_number;
 	}
@@ -3393,6 +3427,7 @@ static int __init ublk_init(void)
 
 	BUILD_BUG_ON((u64)UBLKSRV_IO_BUF_OFFSET +
 			UBLKSRV_IO_BUF_TOTAL_SIZE < UBLKSRV_IO_BUF_OFFSET);
+	BUILD_BUG_ON(sizeof(struct ublk_auto_buf_reg) > sizeof(__u64));
 
 	init_waitqueue_head(&ublk_idr_wq);
 
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index be5c6c6b16e0..a77b0cd7af48 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -219,6 +219,27 @@
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
+ * - pass buffer index from `ublksrv_io_cmd.buf.index`
+ *
+ * - pass flags from `ublksrv_io_cmd.buf.flags` if needed
+ *
+ * This way avoids extra cost from two uring_cmd, but also simplifies backend
+ * implementation, such as, the dependency on IO_REGISTER_IO_BUF and
+ * IO_UNREGISTER_IO_BUF becomes not necessary.
+ *
+ * This feature isn't available for UBLK_F_ZONED
+ */
+#define UBLK_F_AUTO_BUF_REG 	(1ULL << 11)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
@@ -305,6 +326,17 @@ struct ublksrv_ctrl_dev_info {
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
@@ -339,6 +371,30 @@ static inline __u32 ublksrv_get_flags(const struct ublksrv_io_desc *iod)
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
+
+struct ublk_auto_buf_reg {
+	/* index for registering the delivered request buffer */
+	__u16  index;
+	__u8   flags;
+	__u8   _pad;
+
+	/*
+	 * io_ring FD can be passed via the reserve field in future for
+	 * supporting to register io buffer to external io_uring
+	 */
+	__u32  reserved;
+};
+
 /* issued to ublk driver via /dev/ublkcN */
 struct ublksrv_io_cmd {
 	__u16	q_id;
@@ -363,6 +419,14 @@ struct ublksrv_io_cmd {
 		 */
 		__u64	addr;
 		__u64	zone_append_lba;
+
+		/*
+		 * for AUTO_BUF_REG feature, F_ZONED can't be supported,
+		 * meantime ->addr is available for zero copy because
+		 * AUTO_BUF_REG is zero copy too & needn't user backed
+		 * buffer.
+		 */
+		struct ublk_auto_buf_reg auto_buf;
 	};
 };
 
-- 
2.47.0

