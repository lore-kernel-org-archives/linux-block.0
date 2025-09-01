Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1297F3126BA
	for <linux-block@vger.kernel.org>; Mon,  1 Sep 2025 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721013; cv=none; b=Y3y/NzFoaLVwVgZ6lX/9OotwGQhjq+NLjbLe396P/zJsLI/28Y7Wh1frJN2LdQWUKTw9pDaN+ee9JeJuj7TPs1ooDVrCJQ9Y1LGGlAU3hvXPoEZ2FR2pVVm/hvLT4cvGDfNVGYpDpkApurqYcq5N16nEC2FwLX94ebs6H/Yj8vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721013; c=relaxed/simple;
	bh=p6sPjMd7Fssh8bcoFikBafAqlPsSLc7HZRlXuHUYDrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzZ5B+soIgr/VL1T8fUud2gQ3JnrXMrO7E+blrOrkIal27oKDRnxHYXlzCVPMOiyPSDJ2G9w4rH7jzAju0ajxUbKUOQzlIttDICXYgXmoRppikMPdrhVn/Cpd5cAswNC2Cs4oj970qayQNHy2om5oZYVKW2GdQ/lBJajeIT0M3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KF1A5JOp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KF1A5JOp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756721011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVqumMkg1ChhFmaEdkJtFR21Z1YOLuAnEHVpSo1MyHM=;
	b=KF1A5JOp/opdjFm020wqweQoTXjbeShkVUMucM/k1sgUZvMDcCWIEm/bMdPDbJ0riouPNc
	aZurRDnNUKr8U9CuvjzuAgaxrmprKFxajBDmOjTHB5laEWiDzUZi4VS+6PbrzUPJWaWop5
	/joOrQKxe1bOm3Fg22AZqBbZlcxiPYo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-SxMi7sWKO4CnQMKuWnExCA-1; Mon,
 01 Sep 2025 06:03:27 -0400
X-MC-Unique: SxMi7sWKO4CnQMKuWnExCA-1
X-Mimecast-MFC-AGG-ID: SxMi7sWKO4CnQMKuWnExCA_1756721006
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCA74195C279;
	Mon,  1 Sep 2025 10:03:26 +0000 (UTC)
Received: from localhost (unknown [10.72.116.17])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E1BCD1800446;
	Mon,  1 Sep 2025 10:03:25 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 09/23] ublk: handle UBLK_U_IO_COMMIT_IO_CMDS
Date: Mon,  1 Sep 2025 18:02:26 +0800
Message-ID: <20250901100242.3231000-10-ming.lei@redhat.com>
In-Reply-To: <20250901100242.3231000-1-ming.lei@redhat.com>
References: <20250901100242.3231000-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Handle UBLK_U_IO_COMMIT_IO_CMDS by walking the uring_cmd fixed buffer:

- read each element into one temp buffer in batch style

- parse and apply each element for committing io result

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 120 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h |   8 +++
 2 files changed, 124 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index a4bae3d1562a..fae016b67254 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2083,9 +2083,9 @@ static inline int ublk_set_auto_buf_reg(struct ublk_io *io, struct io_uring_cmd
 	return 0;
 }
 
-static int ublk_handle_auto_buf_reg(struct ublk_io *io,
-				    struct io_uring_cmd *cmd,
-				    u16 *buf_idx)
+static void __ublk_handle_auto_buf_reg(struct ublk_io *io,
+				       struct io_uring_cmd *cmd,
+				       u16 *buf_idx)
 {
 	if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG) {
 		io->flags &= ~UBLK_IO_FLAG_AUTO_BUF_REG;
@@ -2103,7 +2103,13 @@ static int ublk_handle_auto_buf_reg(struct ublk_io *io,
 		if (io->buf_ctx_handle == io_uring_cmd_ctx_handle(cmd))
 			*buf_idx = io->buf.auto_reg.index;
 	}
+}
 
+static int ublk_handle_auto_buf_reg(struct ublk_io *io,
+				    struct io_uring_cmd *cmd,
+				    u16 *buf_idx)
+{
+	__ublk_handle_auto_buf_reg(io, cmd, buf_idx);
 	return ublk_set_auto_buf_reg(io, cmd);
 }
 
@@ -2563,6 +2569,17 @@ static inline __u64 ublk_batch_buf_addr(const struct ublk_batch_io *uc,
 	return -1;
 }
 
+static inline __u64 ublk_batch_zone_lba(const struct ublk_batch_io *uc,
+					const struct ublk_elem_header *elem)
+{
+	const void *buf = (const void *)elem;
+
+	if (uc->flags & UBLK_BATCH_F_HAS_ZONE_LBA)
+		return *(__u64 *)(buf + sizeof(*elem) +
+				8 * !!(uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR));
+	return -1;
+}
+
 static struct ublk_auto_buf_reg
 ublk_batch_auto_buf_reg(const struct ublk_batch_io *uc,
 			const struct ublk_elem_header *elem)
@@ -2718,6 +2735,101 @@ static int ublk_handle_batch_prep_cmd(struct ublk_batch_io_data *data)
 	return ret;
 }
 
+static int ublk_batch_commit_io_check(const struct ublk_queue *ubq,
+				      struct ublk_io *io,
+				      union ublk_io_buf *buf)
+{
+	struct request *req = io->req;
+
+	if (!req)
+		return -EINVAL;
+
+	if (io->flags & UBLK_IO_FLAG_ACTIVE)
+		return -EBUSY;
+
+	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
+		return -EINVAL;
+
+	if (ublk_need_map_io(ubq)) {
+		/*
+		 * COMMIT_AND_FETCH_REQ has to provide IO buffer if
+		 * NEED GET DATA is not enabled or it is Read IO.
+		 */
+		if (!buf->addr && (!ublk_need_get_data(ubq) ||
+					req_op(req) == REQ_OP_READ))
+			return -EINVAL;
+	}
+	return 0;
+}
+
+static int ublk_batch_commit_io(struct ublk_io *io,
+				const struct ublk_batch_io_data *data)
+{
+	const struct ublk_batch_io *uc = io_uring_sqe_cmd(data->cmd->sqe);
+	struct ublk_queue *ubq = data->ubq;
+	u16 buf_idx = UBLK_INVALID_BUF_IDX;
+	union ublk_io_buf buf = { 0 };
+	struct request *req = NULL;
+	bool auto_reg = false;
+	bool compl = false;
+	int ret;
+
+	if (ublk_support_auto_buf_reg(data->ubq)) {
+		buf.auto_reg = ublk_batch_auto_buf_reg(uc, data->elem);
+		auto_reg = true;
+	} else if (ublk_need_map_io(data->ubq))
+		buf.addr = ublk_batch_buf_addr(uc, data->elem);
+
+	ublk_io_lock(io);
+	ret = ublk_batch_commit_io_check(ubq, io, &buf);
+	if (!ret) {
+		io->res = data->elem->result;
+		io->buf = buf;
+		req = ublk_fill_io_cmd(io, data->cmd);
+
+		if (auto_reg)
+			__ublk_handle_auto_buf_reg(io, data->cmd, &buf_idx);
+		compl = ublk_need_complete_req(ubq, io);
+	}
+	ublk_io_unlock(io);
+
+	if (unlikely(ret)) {
+		pr_warn("%s: dev %u queue %u io %ld: commit failure %d\n",
+			__func__, ubq->dev->dev_info.dev_id, ubq->q_id,
+			io - ubq->ios, ret);
+		return ret;
+	}
+
+	/* can't touch 'ublk_io' any more */
+	if (buf_idx != UBLK_INVALID_BUF_IDX)
+		io_buffer_unregister_bvec(data->cmd, buf_idx, data->issue_flags);
+	if (req_op(req) == REQ_OP_ZONE_APPEND)
+		req->__sector = ublk_batch_zone_lba(uc, data->elem);
+	if (compl)
+		__ublk_complete_rq(req);
+	return 0;
+}
+
+static int ublk_handle_batch_commit_cmd(struct ublk_batch_io_data *data)
+{
+	struct io_uring_cmd *cmd = data->cmd;
+	const struct ublk_batch_io *uc = io_uring_sqe_cmd(cmd->sqe);
+	struct ublk_batch_io_iter iter = {
+		.total = uc->nr_elem * uc->elem_bytes,
+		.elem_bytes = uc->elem_bytes,
+	};
+	int ret;
+
+	ret = io_uring_cmd_import_fixed(cmd->sqe->addr, cmd->sqe->len,
+			WRITE, &iter.iter, cmd, data->issue_flags);
+	if (ret)
+		return ret;
+
+	ret = ublk_walk_cmd_buf(&iter, data, ublk_batch_commit_io);
+
+	return iter.done == 0 ? ret : iter.done;
+}
+
 static int ublk_check_batch_cmd_flags(const struct ublk_batch_io *uc)
 {
 	const unsigned short mask = UBLK_BATCH_F_HAS_BUF_ADDR |
@@ -2809,7 +2921,7 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
 		ret = ublk_check_batch_cmd(&data, uc);
 		if (ret)
 			goto out;
-		ret = -EOPNOTSUPP;
+		ret = ublk_handle_batch_commit_cmd(&data);
 		break;
 	default:
 		ret = -EOPNOTSUPP;
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 38c8cc10d694..695b38522995 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -109,6 +109,14 @@
  */
 #define	UBLK_U_IO_PREP_IO_CMDS	\
 	_IOWR('u', 0x25, struct ublk_batch_io)
+/*
+ * If failure code is returned, nothing in the command buffer is handled.
+ * Otherwise, the returned value means how many bytes in command buffer
+ * are handled actually, then number of handled IOs can be calculated with
+ * `elem_bytes` for each IO. IOs in the remained bytes are not committed,
+ * userspace has to check return value for dealing with partial committing
+ * correctly.
+ */
 #define	UBLK_U_IO_COMMIT_IO_CMDS	\
 	_IOWR('u', 0x26, struct ublk_batch_io)
 
-- 
2.47.0

