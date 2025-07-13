Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FBC8836
	for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752417298; cv=none; b=dnhXdgoE5fAKoCDcK9uUfHipvR3D1ge+PDuHMmuiyX4ufjNKcvH3Gac94N5c/LZdYCG+Ez8wg9lx2ZXCoD9fcckm4fuVXrAxpO/CCQv/0llnFb2Wp0TT16eSmyaV27jhCcRpH4id/FbowPe4ZzxJAyeZQNawLvSjhwzOPvMF5iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752417298; c=relaxed/simple;
	bh=A0v7lppfGMyF2PQBiJhXxrQQboXxvHqXOVp7jIX3IRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGpE4/FG8olJC3+cYR57aPnmJzEBwkjMsRJLQ9raTEMCXqKI5oAcIIKxrTo+fbCd/xuNYA4mOENGIYYCJwckKOM9Px5lHAhY/NNOIcu8D28RK70dJb5uR9tyBtsiKvrCV7lXMQSHcel6XdjLYXCtGwiltSnPbBQOMbeWr8YQFOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1RqjENz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1RqjENz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752417296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C3HidXS/E2aZrRwD/G4YV6W/ctZNiB/LkgTSbYiKfo0=;
	b=I1RqjENz6DFtEx2FJVAVF0qiSJ5obKCrkwZ34WqjrR6zlPfqKudoELqj6jk+Iu6PhoMX34
	xfgJslWbEJSm+kYEDiYUEYIN8SGIQEjYJg8vrc8XrsRBqGp4xjD0XbBVjEqtB8PQ+Lg0mN
	ExXuB1j+tyG4LcTSyvmb0+cs9UMXeeQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636--DE5Lk4sM2GaYxeMIu8s6g-1; Sun,
 13 Jul 2025 10:34:52 -0400
X-MC-Unique: -DE5Lk4sM2GaYxeMIu8s6g-1
X-Mimecast-MFC-AGG-ID: -DE5Lk4sM2GaYxeMIu8s6g_1752417291
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AB86180047F;
	Sun, 13 Jul 2025 14:34:51 +0000 (UTC)
Received: from localhost (unknown [10.72.116.36])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1543919560A3;
	Sun, 13 Jul 2025 14:34:48 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 06/17] ublk: move auto buffer register handling into one dedicated helper
Date: Sun, 13 Jul 2025 22:34:01 +0800
Message-ID: <20250713143415.2857561-7-ming.lei@redhat.com>
In-Reply-To: <20250713143415.2857561-1-ming.lei@redhat.com>
References: <20250713143415.2857561-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Move check & clearing UBLK_IO_FLAG_AUTO_BUF_REG to
ublk_handle_auto_buf_reg(), also return buffer index from this helper.

Also move ublk_set_auto_buf_reg() to this single helper too.

Add ublk_config_io_buf() for setting up ublk io buffer, covers both
ublk buffer copy or auto buffer register.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 127 ++++++++++++++++++++++-----------------
 1 file changed, 71 insertions(+), 56 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 62393c64f17d..f70fab36fbc7 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -48,6 +48,8 @@
 
 #define UBLK_MINORS		(1U << MINORBITS)
 
+#define UBLK_INVALID_BUF_IDX 	((u16)-1)
+
 /* private ioctl command mirror */
 #define UBLK_CMD_DEL_DEV_ASYNC	_IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
 #define UBLK_CMD_UPDATE_SIZE	_IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
@@ -2009,10 +2011,47 @@ static inline int ublk_check_cmd_op(u32 cmd_op)
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
-		 unsigned long buf_addr)
+ublk_fill_io_cmd(struct ublk_io *io, struct io_uring_cmd *cmd)
 {
 	struct request *req = io->req;
 
@@ -2020,11 +2059,22 @@ ublk_fill_io_cmd(struct ublk_io *io, struct io_uring_cmd *cmd,
 	io->flags |= UBLK_IO_FLAG_ACTIVE;
 	/* now this cmd slot is owned by ublk driver */
 	io->flags &= ~UBLK_IO_FLAG_OWNED_BY_SRV;
-	io->addr = buf_addr;
 
 	return req;
 }
 
+static inline int
+ublk_config_io_buf(const struct ublk_queue *ubq, struct ublk_io *io,
+		   struct io_uring_cmd *cmd, unsigned long buf_addr,
+		   u16 *buf_idx)
+{
+	if (ublk_support_auto_buf_reg(ubq))
+		return ublk_handle_auto_buf_reg(io, cmd, buf_idx);
+
+	io->addr = buf_addr;
+	return 0;
+}
+
 static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
 				    unsigned int issue_flags,
 				    struct ublk_queue *ubq, unsigned int tag)
@@ -2040,20 +2090,6 @@ static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
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
@@ -2174,13 +2210,11 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 		goto out;
 	}
 
-	if (ublk_support_auto_buf_reg(ubq)) {
-		ret = ublk_set_auto_buf_reg(cmd);
-		if (ret)
-			goto out;
-	}
+	ublk_fill_io_cmd(io, cmd);
+	ret = ublk_config_io_buf(ubq, io, cmd, buf_addr, NULL);
+	if (ret)
+		goto out;
 
-	ublk_fill_io_cmd(io, cmd, buf_addr);
 	WRITE_ONCE(io->task, get_task_struct(current));
 	ublk_mark_io_ready(ub, ubq);
 out:
@@ -2212,35 +2246,13 @@ static int ublk_check_commit_and_fetch(const struct ublk_queue *ubq,
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
@@ -2249,7 +2261,6 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 		ublk_sub_req_ref(io, req);
 	else
 		__ublk_complete_rq(req);
-	return 0;
 }
 
 static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io,
@@ -2274,6 +2285,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       const struct ublksrv_io_cmd *ub_cmd)
 {
+	u16 buf_idx = UBLK_INVALID_BUF_IDX;
 	struct ublk_device *ub = cmd->file->private_data;
 	struct ublk_queue *ubq;
 	struct ublk_io *io;
@@ -2353,9 +2365,10 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		if (ret)
 			goto out;
 		io->res = ub_cmd->result;
-		req = ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
-		ret = ublk_commit_and_fetch(ubq, io, cmd, req, issue_flags,
-					    ub_cmd->zone_append_lba);
+		req = ublk_fill_io_cmd(io, cmd);
+		ret = ublk_config_io_buf(ubq, io, cmd, ub_cmd->addr, &buf_idx);
+		ublk_commit_and_fetch(ubq, io, cmd, req, issue_flags,
+				      ub_cmd->zone_append_lba, buf_idx);
 		if (ret)
 			goto out;
 		break;
@@ -2365,7 +2378,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		 * uring_cmd active first and prepare for handling new requeued
 		 * request
 		 */
-		req = ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
+		req = ublk_fill_io_cmd(io, cmd);
+		ret = ublk_config_io_buf(ubq, io, cmd, ub_cmd->addr, NULL);
+		WARN_ON_ONCE(ret);
 		if (likely(ublk_get_data(ubq, io, req))) {
 			__ublk_prep_compl_io_cmd(io, req);
 			return UBLK_IO_RES_OK;
-- 
2.47.0

