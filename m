Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6CC1DF979
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 01:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937498; cv=none; b=BW3WdBRGxC9etbTAsksLCJwa97+Uf88FivqfUALPRlXjRJFjN51XFwMFA9QUdB1WpdEioWDIqEBUcIJVerdw3War6xHO7+g82JBgohoDl/OukGJv46LwmYnRMOfd1RwC7D6W9biPoSTFmpWmRyGQKngDB05WO7dw+9VJOhipDg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937498; c=relaxed/simple;
	bh=OIfKaBLMIgjV4kkF93xOGM1L7x3Zb+8rklxAyZh62KA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnltq/ytp2BEKM1JEvAF49f06YnYiKMlfA0qdmL2yGSiUO3GZqYPJkK75s7u56BkqgYp3RXil7MXP5dOcUJ0gcAIi670N+Kw9HH4u0PwhEUU8O0LZLB7DCZOmcP7ci4+qfsuDZhLnBuL9OKRKaldn0ecCYbK3cs+jK0MQ8I8oGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i0nSssoW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0nSssoW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751937495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZMSYR7bqAUWxONAwV9N2E6BUFAbyTaCjzVkR3E4geQ=;
	b=i0nSssoW86cbIbXbSQBZkhrrGhrJFZO1dqlK2R531jtXYYqeGf8JS0fhZhzPtaMrVE4D7G
	wSKbXamrq5r4kvNUkHZId1C3eNsL5pdb1iWf350Zy7XNX97KhpHCLYdY+CZrhBmLDvpPz9
	Q8jbIH0lAohfEdrOI3KpPR/X/4bdP4g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-9khtegzGNAupAYkxiNZLaQ-1; Mon,
 07 Jul 2025 21:18:13 -0400
X-MC-Unique: 9khtegzGNAupAYkxiNZLaQ-1
X-Mimecast-MFC-AGG-ID: 9khtegzGNAupAYkxiNZLaQ_1751937492
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF20A180135B;
	Tue,  8 Jul 2025 01:18:12 +0000 (UTC)
Received: from localhost (unknown [10.72.116.39])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C3B7B3000218;
	Tue,  8 Jul 2025 01:18:11 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 05/16] ublk: move auto buffer register handling into one dedicated helper
Date: Tue,  8 Jul 2025 09:17:32 +0800
Message-ID: <20250708011746.2193389-6-ming.lei@redhat.com>
In-Reply-To: <20250708011746.2193389-1-ming.lei@redhat.com>
References: <20250708011746.2193389-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Move check & clearing UBLK_IO_FLAG_AUTO_BUF_REG to
ublk_handle_auto_buf_reg(), also return buffer index from this helper.

Also move ublk_set_auto_buf_reg() to this single helper too.

Add ublk_config_io_buf() for setting up ublk io buffer, covers both
ublk buffer copy or auto buffer register.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 131 ++++++++++++++++++++++-----------------
 1 file changed, 75 insertions(+), 56 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 41248b0d1182..dab02a8be41a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -48,6 +48,8 @@
 
 #define UBLK_MINORS		(1U << MINORBITS)
 
+#define UBLK_INVALID_BUF_IDX 	((u16)-1)
+
 /* private ioctl command mirror */
 #define UBLK_CMD_DEL_DEV_ASYNC	_IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
 #define UBLK_CMD_UPDATE_SIZE	_IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
@@ -2002,16 +2004,52 @@ static inline int ublk_check_cmd_op(u32 cmd_op)
 	return 0;
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
+	if (pdu->buf.flags & ~UBLK_AUTO_BUF_REG_F_MASK)
+		return -EINVAL;
+	return 0;
+}
+
+static int ublk_handle_auto_buf_reg(struct ublk_io *io,
+				    struct io_uring_cmd *cmd,
+				    u16 *buf_idx)
+{
+	if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG) {
+		io->flags &= ~UBLK_IO_FLAG_AUTO_BUF_REG;
+
+		/*
+		 * `UBLK_F_AUTO_BUF_REG` only works iff `UBLK_IO_FETCH_REQ`
+		 * and `UBLK_IO_COMMIT_AND_FETCH_REQ` are issued from same
+		 * `io_ring_ctx`.
+		 *
+		 * If this uring_cmd's io_ring_ctx isn't same with the
+		 * one for registering the buffer, it is ublk server's
+		 * responsibility for unregistering the buffer, otherwise
+		 * this ublk request gets stuck.
+		 */
+		if (io->buf_ctx_handle == io_uring_cmd_ctx_handle(cmd))
+			*buf_idx = io->buf_index;
+	}
+
+	return ublk_set_auto_buf_reg(cmd);
+}
+
 /* Once we return, `io->req` can't be used any more */
 static inline struct request *
-ublk_fill_io_cmd(struct ublk_io *io, struct io_uring_cmd *cmd,
-		 unsigned long buf_addr, int result)
+ublk_fill_io_cmd(struct ublk_io *io, struct io_uring_cmd *cmd, int result)
 {
 	struct request *req = io->req;
 
 	io->cmd = cmd;
 	io->flags |= UBLK_IO_FLAG_ACTIVE;
-	io->addr = buf_addr;
 	io->res = result;
 
 	/* now this cmd slot is owned by ublk driver */
@@ -2020,6 +2058,22 @@ ublk_fill_io_cmd(struct ublk_io *io, struct io_uring_cmd *cmd,
 	return req;
 }
 
+static inline int
+ublk_config_io_buf(const struct ublk_queue *ubq, struct ublk_io *io,
+		   struct io_uring_cmd *cmd, unsigned long buf_addr,
+		   u16 *buf_idx)
+{
+	if (ublk_support_auto_buf_reg(ubq)) {
+		int ret = ublk_handle_auto_buf_reg(io, cmd, buf_idx);
+
+		if (ret)
+			return ret;
+	} else {
+		io->addr = buf_addr;
+	}
+	return 0;
+}
+
 static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
 				    unsigned int issue_flags,
 				    struct ublk_queue *ubq, unsigned int tag)
@@ -2035,20 +2089,6 @@ static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
 	io_uring_cmd_mark_cancelable(cmd, issue_flags);
 }
 
-static inline int ublk_set_auto_buf_reg(struct io_uring_cmd *cmd)
-{
-	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
-
-	pdu->buf = ublk_sqe_addr_to_auto_buf_reg(READ_ONCE(cmd->sqe->addr));
-
-	if (pdu->buf.reserved0 || pdu->buf.reserved1)
-		return -EINVAL;
-
-	if (pdu->buf.flags & ~UBLK_AUTO_BUF_REG_F_MASK)
-		return -EINVAL;
-	return 0;
-}
-
 static void ublk_io_release(void *priv)
 {
 	struct request *rq = priv;
@@ -2169,13 +2209,11 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 		goto out;
 	}
 
-	if (ublk_support_auto_buf_reg(ubq)) {
-		ret = ublk_set_auto_buf_reg(cmd);
-		if (ret)
-			goto out;
-	}
+	ublk_fill_io_cmd(io, cmd, 0);
+	ret = ublk_config_io_buf(ubq, io, cmd, buf_addr, NULL);
+	if (ret)
+		goto out;
 
-	ublk_fill_io_cmd(io, cmd, buf_addr, 0);
 	WRITE_ONCE(io->task, get_task_struct(current));
 	ublk_mark_io_ready(ub, ubq);
 out:
@@ -2207,35 +2245,13 @@ static int ublk_check_commit_and_fetch(const struct ublk_queue *ubq,
 	return 0;
 }
 
-static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
-				 struct ublk_io *io, struct io_uring_cmd *cmd,
-				 struct request *req, unsigned int issue_flags,
-				 __u64 zone_append_lba)
+static void ublk_commit_and_fetch(const struct ublk_queue *ubq,
+				  struct ublk_io *io, struct io_uring_cmd *cmd,
+				  struct request *req, unsigned int issue_flags,
+				  __u64 zone_append_lba, u16 buf_idx)
 {
-	if (ublk_support_auto_buf_reg(ubq)) {
-		int ret;
-
-		/*
-		 * `UBLK_F_AUTO_BUF_REG` only works iff `UBLK_IO_FETCH_REQ`
-		 * and `UBLK_IO_COMMIT_AND_FETCH_REQ` are issued from same
-		 * `io_ring_ctx`.
-		 *
-		 * If this uring_cmd's io_ring_ctx isn't same with the
-		 * one for registering the buffer, it is ublk server's
-		 * responsibility for unregistering the buffer, otherwise
-		 * this ublk request gets stuck.
-		 */
-		if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG) {
-			if (io->buf_ctx_handle == io_uring_cmd_ctx_handle(cmd))
-				io_buffer_unregister_bvec(cmd, io->buf_index,
-						issue_flags);
-			io->flags &= ~UBLK_IO_FLAG_AUTO_BUF_REG;
-		}
-
-		ret = ublk_set_auto_buf_reg(cmd);
-		if (ret)
-			return ret;
-	}
+	if (buf_idx != UBLK_INVALID_BUF_IDX)
+		io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
 
 	if (req_op(req) == REQ_OP_ZONE_APPEND)
 		req->__sector = zone_append_lba;
@@ -2244,7 +2260,6 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 		ublk_sub_req_ref(io, req);
 	else
 		__ublk_complete_rq(req);
-	return 0;
 }
 
 static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io,
@@ -2269,6 +2284,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       const struct ublksrv_io_cmd *ub_cmd)
 {
+	u16 buf_idx = UBLK_INVALID_BUF_IDX;
 	struct ublk_device *ub = cmd->file->private_data;
 	struct ublk_queue *ubq;
 	struct ublk_io *io;
@@ -2347,9 +2363,10 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		ret = ublk_check_commit_and_fetch(ubq, io, ub_cmd->addr);
 		if (ret)
 			goto out;
-		req = ublk_fill_io_cmd(io, cmd, ub_cmd->addr, ub_cmd->result);
-		ret = ublk_commit_and_fetch(ubq, io, cmd, req, issue_flags,
-					    ub_cmd->zone_append_lba);
+		req = ublk_fill_io_cmd(io, cmd, ub_cmd->result);
+		ret = ublk_config_io_buf(ubq, io, cmd, ub_cmd->addr, &buf_idx);
+		ublk_commit_and_fetch(ubq, io, cmd, req, issue_flags,
+				      ub_cmd->zone_append_lba, buf_idx);
 		if (ret)
 			goto out;
 		break;
@@ -2359,7 +2376,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		 * uring_cmd active first and prepare for handling new requeued
 		 * request
 		 */
-		req = ublk_fill_io_cmd(io, cmd, ub_cmd->addr, 0);
+		req = ublk_fill_io_cmd(io, cmd, 0);
+		ret = ublk_config_io_buf(ubq, io, cmd, ub_cmd->addr, NULL);
+		WARN_ON_ONCE(ret);
 		if (likely(ublk_get_data(ubq, io, req))) {
 			__ublk_prep_compl_io_cmd(io, req);
 			return UBLK_IO_RES_OK;
-- 
2.47.0

