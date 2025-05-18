Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E55D14EC5B
	for <linux-block@vger.kernel.org>; Sun, 18 May 2025 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747574028; cv=none; b=Ubns0PdQZyA9Czm00/230wSfUBnWvPIbbl0lLj/ABdgexQc1EiaonlyfR62EwJKORMtNsPsEdGkx0J20OXGzQ2gjxNOatiLFFdtll6jf/+UpSp2/3GG0N9SYQmXcOGeBgtOWRdjn5Va5xJ/pTtU/lIjsoPyJsLCC1ejX5HClqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747574028; c=relaxed/simple;
	bh=nlu8kPQERcDsZ08b6DyJCL5Oi8PY5VPerFOrH6qfdp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7HdOsdU5CUGMOyARDh4FC5qwGCEvTdjIQz5X9lRq20QGEwAPTjTdOvmCE0h9v7GC/tOEvBtF9w9OQeVao0OA2w3AptkuCy+0OIrEGObvaq9wvHz4SmsYXH7mUO3gWKwJR/K7lb/nqz94xaaGf6NWZRQrTRikjQo58hofYah8sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SmGsOn8Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmGsOn8Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747574026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BPtesizJPLkPX4uFo+A4CesqRsxKRCY/Os3CvLTziUc=;
	b=SmGsOn8ZGcVqDQ14yG1Cow8KMPg2J2TYPh9UeWI0TadfmjiHkfbcM9ubqKIn5TtAJG1ae+
	e+HXR7P3GsYz8eKIunys1MQEfJjU686pvJfgZe+CB7QWYXzV0RcnPiazJ1ulzSIX1sF4NB
	UbQ+o1+9QCAV5Gd8Xu2htLmsrq+GReo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-St00OjsON6Kc8TkcRwVKXA-1; Sun,
 18 May 2025 09:13:42 -0400
X-MC-Unique: St00OjsON6Kc8TkcRwVKXA-1
X-Mimecast-MFC-AGG-ID: St00OjsON6Kc8TkcRwVKXA_1747574021
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BFAD18004AD;
	Sun, 18 May 2025 13:13:41 +0000 (UTC)
Received: from localhost (unknown [10.72.116.32])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 31CDC18003FC;
	Sun, 18 May 2025 13:13:38 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 4/6] ublk: support UBLK_AUTO_BUF_REG_FALLBACK
Date: Sun, 18 May 2025 21:12:59 +0800
Message-ID: <20250518131303.195957-5-ming.lei@redhat.com>
In-Reply-To: <20250518131303.195957-1-ming.lei@redhat.com>
References: <20250518131303.195957-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

For UBLK_F_AUTO_BUF_REG, buffer is registered to uring_cmd context
automatically with the provided buffer index. User may provide one wrong
buffer index, or the specified buffer is registered by application already.

Add UBLK_AUTO_BUF_REG_FALLBACK for supporting to auto buffer registering
fallback by completing the uring_cmd and telling ublk server the
register failure via UBLK_AUTO_BUF_REG_FALLBACK, then ublk server still
can register the buffer from userspace.

So we can provide reliable way for supporting auto buffer register.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 16 ++++++++++++++++
 include/uapi/linux/ublk_cmd.h | 32 +++++++++++++++++++++++++++++---
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 0c8c18ea25bc..9bff2f8183d9 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1182,6 +1182,16 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 		blk_mq_end_request(rq, BLK_STS_IOERR);
 }
 
+static void ublk_auto_buf_reg_fallback(struct request *req, struct ublk_io *io)
+{
+	const struct ublk_queue *ubq = req->mq_hctx->driver_data;
+	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
+	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
+
+	iod->op_flags |= UBLK_IO_F_NEED_REG_BUF;
+	refcount_set(&data->ref, 1);
+}
+
 static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
 			      unsigned int issue_flags)
 {
@@ -1192,6 +1202,10 @@ static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
 	ret = io_buffer_register_bvec(io->cmd, req, ublk_io_release,
 				      pdu->buf.index, issue_flags);
 	if (ret) {
+		if (pdu->buf.flags & UBLK_AUTO_BUF_REG_FALLBACK) {
+			ublk_auto_buf_reg_fallback(req, io);
+			return true;
+		}
 		blk_mq_end_request(req, BLK_STS_IOERR);
 		return false;
 	}
@@ -1971,6 +1985,8 @@ static inline bool ublk_set_auto_buf_reg(struct io_uring_cmd *cmd)
 	if (pdu->buf.reserved0 || pdu->buf.reserved1)
 		return false;
 
+	if (pdu->buf.flags & ~UBLK_AUTO_BUF_REG_F_MASK)
+		return false;
 	return true;
 }
 
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 663187cdfa52..637e302544db 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -328,6 +328,17 @@ struct ublksrv_ctrl_dev_info {
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
@@ -362,10 +373,23 @@ static inline __u32 ublksrv_get_flags(const struct ublksrv_io_desc *iod)
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
 struct ublk_auto_buf_reg {
 	/* index for registering the delivered request buffer */
 	__u16  index;
-	__u16   reserved0;
+	__u8   flags;
+	__u8   reserved0;
 
 	/*
 	 * io_ring FD can be passed via the reserve field in future for
@@ -379,6 +403,7 @@ struct ublk_auto_buf_reg {
  * uring_cmd's sqe->addr:
  *
  * 	- bit0 ~ bit15: buffer index
+ * 	- bit16 ~ bit23: flags
  * 	- bit24 ~ bit31: reserved0
  * 	- bit32 ~ bit63: reserved1
  */
@@ -387,7 +412,8 @@ static inline struct ublk_auto_buf_reg ublk_sqe_addr_to_auto_buf_reg(
 {
 	struct ublk_auto_buf_reg reg = {
 		.index = sqe_addr & 0xffff,
-		.reserved0 = (sqe_addr >> 16) & 0xffff,
+		.flags = (sqe_addr >> 16) & 0xff,
+		.reserved0 = (sqe_addr >> 24) & 0xff,
 		.reserved1 = sqe_addr >> 32,
 	};
 
@@ -397,7 +423,7 @@ static inline struct ublk_auto_buf_reg ublk_sqe_addr_to_auto_buf_reg(
 static inline __u64
 ublk_auto_buf_reg_to_sqe_addr(const struct ublk_auto_buf_reg *buf)
 {
-	__u64 addr = buf->index | (__u64)buf->reserved0 << 16 |
+	__u64 addr = buf->index | (__u64)buf->flags << 16 | (__u64)buf->reserved0 << 24 |
 		(__u64)buf->reserved1 << 32;
 
 	return addr;
-- 
2.47.0

