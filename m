Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E2031BCA9
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573186; cv=none; b=Kku/j2GO+nFrD1dWoK+HrXEg5+7/6CTdvlRDr4skQByCGUL8+Dfo2zdYWzrIfoYiJ4YcjIMiiIdf1NDEzy4aTvguiRYZE/sbr6QiB6ffn6VEwnQSjiaRwWewKdiPZcfWfWQEHXI7xpgjtRh2pamQRF6oAMojyLm9KjEElYciq8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573186; c=relaxed/simple;
	bh=z/yryDXMsrJuxRHm1l+e/l9tX9n1N9oalie5IMQCcyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9o8OhElaIE7uSKc/BqygGBqZx8JRBWNJFIuhkpsNgNMG23Fr48vvKhWUsNyg4/mPR+FafgXNVgMJoygrpKUKiDUtQS3XpgwY2aPV/F0Ld7cVzxMdmbMDUPvJLujrtQh9SMX4PLf9zmL7AA0pJ22sfH5psVCDTZ/0GuNvjNXBwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UONSv7P8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UONSv7P8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768573183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cnOmStHpZBde5gVANMsOomf93RcYMVOazEra5U3dmSQ=;
	b=UONSv7P8M+YbRoS04ZRYbJznKKwZcnezbNBPHPV1b3aAN8Z3bZpnIRMsL3SOg9GlK+0s9X
	1PPe9RG9foneuh7qO1RnLf6h2tFoWK0q1+BTNlZ/7SuGaylNRleUQ/hKvmv5999HzSnVNo
	hcJd8j0N0TAA9LJgCdzDmS5c7L01ntc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-fm_lDAY_M7WjByl3atVqAg-1; Fri,
 16 Jan 2026 09:19:42 -0500
X-MC-Unique: fm_lDAY_M7WjByl3atVqAg-1
X-Mimecast-MFC-AGG-ID: fm_lDAY_M7WjByl3atVqAg_1768573180
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 382F71956061;
	Fri, 16 Jan 2026 14:19:40 +0000 (UTC)
Received: from localhost (unknown [10.72.116.198])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C6C330002D6;
	Fri, 16 Jan 2026 14:19:33 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 05/24] ublk: handle UBLK_U_IO_COMMIT_IO_CMDS
Date: Fri, 16 Jan 2026 22:18:38 +0800
Message-ID: <20260116141859.719929-6-ming.lei@redhat.com>
In-Reply-To: <20260116141859.719929-1-ming.lei@redhat.com>
References: <20260116141859.719929-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Handle UBLK_U_IO_COMMIT_IO_CMDS by walking the uring_cmd fixed buffer:

- read each element into one temp buffer in batch style

- parse and apply each element for committing io result

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 103 +++++++++++++++++++++++++++++++++-
 include/uapi/linux/ublk_cmd.h |   8 +++
 2 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6aef1a856a80..d919e04885b6 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2267,7 +2267,7 @@ static inline int ublk_set_auto_buf_reg(struct ublk_io *io, struct io_uring_cmd
 	return 0;
 }
 
-static int ublk_handle_auto_buf_reg(struct ublk_io *io,
+static void ublk_clear_auto_buf_reg(struct ublk_io *io,
 				    struct io_uring_cmd *cmd,
 				    u16 *buf_idx)
 {
@@ -2287,7 +2287,13 @@ static int ublk_handle_auto_buf_reg(struct ublk_io *io,
 		if (io->buf_ctx_handle == io_uring_cmd_ctx_handle(cmd))
 			*buf_idx = io->buf.auto_reg.index;
 	}
+}
 
+static int ublk_handle_auto_buf_reg(struct ublk_io *io,
+				    struct io_uring_cmd *cmd,
+				    u16 *buf_idx)
+{
+	ublk_clear_auto_buf_reg(io, cmd, buf_idx);
 	return ublk_set_auto_buf_reg(io, cmd);
 }
 
@@ -2720,6 +2726,17 @@ static inline __u64 ublk_batch_buf_addr(const struct ublk_batch_io *uc,
 	return 0;
 }
 
+static inline __u64 ublk_batch_zone_lba(const struct ublk_batch_io *uc,
+					const struct ublk_elem_header *elem)
+{
+	const void *buf = elem;
+
+	if (uc->flags & UBLK_BATCH_F_HAS_ZONE_LBA)
+		return *(const __u64 *)(buf + sizeof(*elem) +
+				8 * !!(uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR));
+	return -1;
+}
+
 static struct ublk_auto_buf_reg
 ublk_batch_auto_buf_reg(const struct ublk_batch_io *uc,
 			const struct ublk_elem_header *elem)
@@ -2875,6 +2892,84 @@ static int ublk_handle_batch_prep_cmd(const struct ublk_batch_io_data *data)
 	return ret;
 }
 
+static int ublk_batch_commit_io_check(const struct ublk_queue *ubq,
+				      struct ublk_io *io,
+				      union ublk_io_buf *buf)
+{
+	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
+		return -EBUSY;
+
+	/* BATCH_IO doesn't support UBLK_F_NEED_GET_DATA */
+	if (ublk_need_map_io(ubq) && !buf->addr)
+		return -EINVAL;
+	return 0;
+}
+
+static int ublk_batch_commit_io(struct ublk_queue *ubq,
+				const struct ublk_batch_io_data *data,
+				const struct ublk_elem_header *elem)
+{
+	struct ublk_io *io = &ubq->ios[elem->tag];
+	const struct ublk_batch_io *uc = &data->header;
+	u16 buf_idx = UBLK_INVALID_BUF_IDX;
+	union ublk_io_buf buf = { 0 };
+	struct request *req = NULL;
+	bool auto_reg = false;
+	bool compl = false;
+	int ret;
+
+	if (ublk_dev_support_auto_buf_reg(data->ub)) {
+		buf.auto_reg = ublk_batch_auto_buf_reg(uc, elem);
+		auto_reg = true;
+	} else if (ublk_dev_need_map_io(data->ub))
+		buf.addr = ublk_batch_buf_addr(uc, elem);
+
+	ublk_io_lock(io);
+	ret = ublk_batch_commit_io_check(ubq, io, &buf);
+	if (!ret) {
+		io->res = elem->result;
+		io->buf = buf;
+		req = ublk_fill_io_cmd(io, data->cmd);
+
+		if (auto_reg)
+			ublk_clear_auto_buf_reg(io, data->cmd, &buf_idx);
+		compl = ublk_need_complete_req(data->ub, io);
+	}
+	ublk_io_unlock(io);
+
+	if (unlikely(ret)) {
+		pr_warn_ratelimited("%s: dev %u queue %u io %u: commit failure %d\n",
+			__func__, data->ub->dev_info.dev_id, ubq->q_id,
+			elem->tag, ret);
+		return ret;
+	}
+
+	/* can't touch 'ublk_io' any more */
+	if (buf_idx != UBLK_INVALID_BUF_IDX)
+		io_buffer_unregister_bvec(data->cmd, buf_idx, data->issue_flags);
+	if (req_op(req) == REQ_OP_ZONE_APPEND)
+		req->__sector = ublk_batch_zone_lba(uc, elem);
+	if (compl)
+		__ublk_complete_rq(req, io, ublk_dev_need_map_io(data->ub));
+	return 0;
+}
+
+static int ublk_handle_batch_commit_cmd(const struct ublk_batch_io_data *data)
+{
+	const struct ublk_batch_io *uc = &data->header;
+	struct io_uring_cmd *cmd = data->cmd;
+	struct ublk_batch_io_iter iter = {
+		.uaddr = u64_to_user_ptr(READ_ONCE(cmd->sqe->addr)),
+		.total = uc->nr_elem * uc->elem_bytes,
+		.elem_bytes = uc->elem_bytes,
+	};
+	int ret;
+
+	ret = ublk_walk_cmd_buf(&iter, data, ublk_batch_commit_io);
+
+	return iter.done == 0 ? ret : iter.done;
+}
+
 static int ublk_check_batch_cmd_flags(const struct ublk_batch_io *uc)
 {
 	unsigned elem_bytes = sizeof(struct ublk_elem_header);
@@ -2950,7 +3045,7 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
 		ret = ublk_check_batch_cmd(&data);
 		if (ret)
 			goto out;
-		ret = -EOPNOTSUPP;
+		ret = ublk_handle_batch_commit_cmd(&data);
 		break;
 	default:
 		ret = -EOPNOTSUPP;
@@ -3668,6 +3763,10 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 				UBLK_F_AUTO_BUF_REG))
 		ub->dev_info.flags &= ~UBLK_F_NEED_GET_DATA;
 
+	/* UBLK_F_BATCH_IO doesn't support GET_DATA */
+	if (ublk_dev_support_batch_io(ub))
+		ub->dev_info.flags &= ~UBLK_F_NEED_GET_DATA;
+
 	/*
 	 * Zoned storage support requires reuse `ublksrv_io_cmd->addr` for
 	 * returning write_append_lba, which is only allowed in case of
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 1a3d4d33c1d1..3894d676dd02 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -110,6 +110,14 @@
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

