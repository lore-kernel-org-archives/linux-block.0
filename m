Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54892213E77
	for <linux-block@vger.kernel.org>; Tue, 20 May 2025 04:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747716933; cv=none; b=Qii6Vy64AYJSW9UxWJgsbTCzQHwwakiYzX6JQAZJQyW6Lge81ujd25/XPWnf5BNbk8WHGABMTsajZ8gNqWTlzZu6FD80PRSg1obr08A3fstS9C4BPTiRHWQnyzpDsxQajCvYKGDClpctKWMMWHZZ7CwGWF+/cuBYJcYsKf7Y/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747716933; c=relaxed/simple;
	bh=dlEWQwlNysS3Zm6UDiOyt5qD9PSqLjS/Nt60Sgv5bqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGMbQOJm1PioK604gWv+Ws2BvKgpmAk7CBSUnGaB+wvHZHiBGHzaua1h4Ts4RuhHWOjdmz6mr+trZ7ae8t2UePvs9rymhHgA6lrbKw/RojzEH0kbIKXM70gYJwkquJic1MeC5su/yRgjg+t861pDhVGobqD21EX0ohTUU7aR0YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQPdTky8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQPdTky8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747716930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+oNrhl5xLKoezaxMlXciFsjIcbLNEJSvBnLiPmVXfG0=;
	b=IQPdTky8/p+VulRwV8VV7CXHaaSxQb8VOMy4VAtDTj25gCH8J+M/lld3hacO97nQF4fEZy
	soke4VSB7kNeTDPMfuIi3lGYCT4zRX/2jq8TKjkmut8kkiYxsRTXZPZVt8H+VsYzZH+F7N
	ykhKqmubs4Bfe1u346R3Wc8/J/33Y7s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-Mbia8KUgNxyDT_Yy04tDZw-1; Tue,
 20 May 2025 00:55:25 -0400
X-MC-Unique: Mbia8KUgNxyDT_Yy04tDZw-1
X-Mimecast-MFC-AGG-ID: Mbia8KUgNxyDT_Yy04tDZw_1747716924
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 174C71956086;
	Tue, 20 May 2025 04:55:24 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C755B19560AE;
	Tue, 20 May 2025 04:55:22 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 4/6] ublk: support UBLK_AUTO_BUF_REG_FALLBACK
Date: Tue, 20 May 2025 12:54:34 +0800
Message-ID: <20250520045455.515691-5-ming.lei@redhat.com>
In-Reply-To: <20250520045455.515691-1-ming.lei@redhat.com>
References: <20250520045455.515691-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
 drivers/block/ublk_drv.c      | 16 ++++++++++++++
 include/uapi/linux/ublk_cmd.h | 39 ++++++++++++++++++++++++++++++++---
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 1aabc655652b..2474788ef263 100644
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
@@ -1971,6 +1985,8 @@ static inline int ublk_set_auto_buf_reg(struct io_uring_cmd *cmd)
 	if (pdu->buf.reserved0 || pdu->buf.reserved1)
 		return -EINVAL;
 
+	if (pdu->buf.flags & ~UBLK_AUTO_BUF_REG_F_MASK)
+		return -EINVAL;
 	return 0;
 }
 
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index f6f516b1223b..c4b9942697fc 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -236,9 +236,16 @@
  *
  * - all reserved fields in `ublk_auto_buf_reg` need to be zeroed
  *
+ * - pass flags from `ublk_auto_buf_reg.flags` if needed
+ *
  * This way avoids extra cost from two uring_cmd, but also simplifies backend
  * implementation, such as, the dependency on IO_REGISTER_IO_BUF and
  * IO_UNREGISTER_IO_BUF becomes not necessary.
+ *
+ * If wrong data or flags are provided, both IO_FETCH_REQ and
+ * IO_COMMIT_AND_FETCH_REQ are failed, for the latter, the ublk IO request
+ * won't be completed until new IO_COMMIT_AND_FETCH_REQ command is issued
+ * successfully
  */
 #define UBLK_F_AUTO_BUF_REG 	(1ULL << 11)
 
@@ -328,6 +335,17 @@ struct ublksrv_ctrl_dev_info {
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
@@ -362,10 +380,23 @@ static inline __u32 ublksrv_get_flags(const struct ublksrv_io_desc *iod)
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
@@ -379,6 +410,7 @@ struct ublk_auto_buf_reg {
  * uring_cmd's sqe->addr:
  *
  * 	- bit0 ~ bit15: buffer index
+ * 	- bit16 ~ bit23: flags
  * 	- bit24 ~ bit31: reserved0
  * 	- bit32 ~ bit63: reserved1
  */
@@ -387,7 +419,8 @@ static inline struct ublk_auto_buf_reg ublk_sqe_addr_to_auto_buf_reg(
 {
 	struct ublk_auto_buf_reg reg = {
 		.index = sqe_addr & 0xffff,
-		.reserved0 = (sqe_addr >> 16) & 0xffff,
+		.flags = (sqe_addr >> 16) & 0xff,
+		.reserved0 = (sqe_addr >> 24) & 0xff,
 		.reserved1 = sqe_addr >> 32,
 	};
 
@@ -397,7 +430,7 @@ static inline struct ublk_auto_buf_reg ublk_sqe_addr_to_auto_buf_reg(
 static inline __u64
 ublk_auto_buf_reg_to_sqe_addr(const struct ublk_auto_buf_reg *buf)
 {
-	__u64 addr = buf->index | (__u64)buf->reserved0 << 16 |
+	__u64 addr = buf->index | (__u64)buf->flags << 16 | (__u64)buf->reserved0 << 24 |
 		(__u64)buf->reserved1 << 32;
 
 	return addr;
-- 
2.47.0

