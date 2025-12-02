Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E7D3101CE
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764678028; cv=none; b=mZA9CLF5QNtpzBexicNkviki7iQZ7tHrrwYM4rhfFsSbJMFPkwexgUHbucYTeP6mRpf/Rq0Dj43LUFXbTorTSkSS2WrGdHwjgo/iP1u46fYCwglXtQlZuwbVR2hjXn3I0LSxhsDQEVUrAsmvJphQGqanp9PtGY2pm9oLjSJfRFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764678028; c=relaxed/simple;
	bh=up+/eJKqC5orCbi/icmN0bGWIdltEm/3cOph62i3EKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIm4G1rqbH+h4iMZJDhVjksgKqnpIC8s2boDmIl4jHJBLMhqB2be2e0MAPfqoyo0Cd53zdcuLujwwqZOz7NqSnYf/tFL2Wi7zb/YKFCVURpzcmsyk9dT4vOgOngTqx2DGy2G+oXqGN3IC6UAeXQsH9ZN4xt61PoXB6N/mR6Lgbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLjofMgp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLjofMgp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764678026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+sCdCjDC9XGZ7xVIcyN5jXfX759B4V8bALWspomGuFg=;
	b=RLjofMgp5g7LH5loHIF1djX5AD5eqEBJEwyMWJM9u1NfQbJIGpOpVdFJiN+o2nMLyDSGcN
	DOOq8CUgeMhjRsu2vd+EKLuPqfTlup0rKekXK+YIo87bwB4HV7z5jN20PmncFVLGC1AU2g
	b/hq6vOAZgr2ZFGFdS5wg9qqa1kOntw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-KZ44Uf7iOLG6uksByGpWwg-1; Tue,
 02 Dec 2025 07:20:24 -0500
X-MC-Unique: KZ44Uf7iOLG6uksByGpWwg-1
X-Mimecast-MFC-AGG-ID: KZ44Uf7iOLG6uksByGpWwg_1764678023
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4883195608F;
	Tue,  2 Dec 2025 12:20:23 +0000 (UTC)
Received: from localhost (unknown [10.72.116.20])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F13AF195608E;
	Tue,  2 Dec 2025 12:20:20 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 05/21] ublk: handle UBLK_U_IO_COMMIT_IO_CMDS
Date: Tue,  2 Dec 2025 20:18:59 +0800
Message-ID: <20251202121917.1412280-6-ming.lei@redhat.com>
In-Reply-To: <20251202121917.1412280-1-ming.lei@redhat.com>
References: <20251202121917.1412280-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Handle UBLK_U_IO_COMMIT_IO_CMDS by walking the uring_cmd fixed buffer:

- read each element into one temp buffer in batch style

- parse and apply each element for committing io result

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 103 +++++++++++++++++++++++++++++++++-
 include/uapi/linux/ublk_cmd.h |   8 +++
 2 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 380553a6f299..5cc95e13295d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2098,7 +2098,7 @@ static inline int ublk_set_auto_buf_reg(struct ublk_io *io, struct io_uring_cmd
 	return 0;
 }
 
-static int ublk_handle_auto_buf_reg(struct ublk_io *io,
+static void ublk_clear_auto_buf_reg(struct ublk_io *io,
 				    struct io_uring_cmd *cmd,
 				    u16 *buf_idx)
 {
@@ -2118,7 +2118,13 @@ static int ublk_handle_auto_buf_reg(struct ublk_io *io,
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
 
@@ -2553,6 +2559,17 @@ static inline __u64 ublk_batch_buf_addr(const struct ublk_batch_io *uc,
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
@@ -2708,6 +2725,84 @@ static int ublk_handle_batch_prep_cmd(const struct ublk_batch_io_data *data)
 	return ret;
 }
 
+static int ublk_batch_commit_io_check(const struct ublk_queue *ubq,
+				      struct ublk_io *io,
+				      union ublk_io_buf *buf)
+{
+	if (io->flags & UBLK_IO_FLAG_ACTIVE)
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
@@ -2783,7 +2878,7 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
 		ret = ublk_check_batch_cmd(&data);
 		if (ret)
 			goto out;
-		ret = -EOPNOTSUPP;
+		ret = ublk_handle_batch_commit_cmd(&data);
 		break;
 	default:
 		ret = -EOPNOTSUPP;
@@ -3444,6 +3539,10 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
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
index c96c299057c3..295ec8f34173 100644
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

