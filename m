Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1532459C9
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233622; cv=none; b=AAIsdoUXpezDbv7EFXE7jSoQvwh8x7J5fPZFYwslS8QRr1i5tb/NXNSI+5kQ1MW/LFrX8GP4jXOZqpF9voULwbLrsrQM0cDX1u1E1hj1FWum94s6UyymB7tplS/j6jxeywEsBECa3t2Ycuj48qpD6YadWPPXa5iYB6RWjRiuVOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233622; c=relaxed/simple;
	bh=7OCK+UwOImocjhhoXPHuMHngSMYejNIji755o4iBgVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7/POaO1C6fyZCZelUkArCocULvKZYWmoQtKeU81gK1mH1b8ICLPoeZ7L801+ijTCMnZZG/ZKLmXhrrT6vhTzJ4FhsMlgU6MBFs3om/9wSRmamiV6G2uYlIp+p2jylTjDFsTLRrcmYqQYGqqToukYjwlKFE631dAFm+elSL0sbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Va82sSqH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Va82sSqH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761233619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZP4W/ovlu2dEawsblUfsyI8T313s0uQ7ghfI7ptDVco=;
	b=Va82sSqHd786dAJmRwodinXJe15QE7yC9/SqpWkx96AB1EhhSlwGW0uIfDkjWz09Xi8som
	RUKYAcfJWEzjsHlFwG/baJB9eM4q42VfeVJ+0oZ42bc+BhA/xME8Dy5GKHMHc9W45W8kpR
	xXRpaiqNrx9YIlP5xNRLDdcmJsM2CuQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-Asc1ZBe1P3yI8GhOeR6FYg-1; Thu,
 23 Oct 2025 11:33:33 -0400
X-MC-Unique: Asc1ZBe1P3yI8GhOeR6FYg-1
X-Mimecast-MFC-AGG-ID: Asc1ZBe1P3yI8GhOeR6FYg_1761233612
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C4A01954102;
	Thu, 23 Oct 2025 15:33:29 +0000 (UTC)
Received: from localhost (unknown [10.72.120.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6785230002D7;
	Thu, 23 Oct 2025 15:33:27 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 10/25] ublk: handle UBLK_U_IO_COMMIT_IO_CMDS
Date: Thu, 23 Oct 2025 23:32:15 +0800
Message-ID: <20251023153234.2548062-11-ming.lei@redhat.com>
In-Reply-To: <20251023153234.2548062-1-ming.lei@redhat.com>
References: <20251023153234.2548062-1-ming.lei@redhat.com>
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

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 121 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h |   8 +++
 2 files changed, 125 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b3d92b0ed42e..3066bfa19f99 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2164,9 +2164,9 @@ static inline int ublk_set_auto_buf_reg(struct ublk_io *io, struct io_uring_cmd
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
@@ -2184,7 +2184,13 @@ static int ublk_handle_auto_buf_reg(struct ublk_io *io,
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
 
@@ -2619,6 +2625,17 @@ static inline __u64 ublk_batch_buf_addr(const struct ublk_batch_io *uc,
 	return 0;
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
@@ -2786,6 +2803,102 @@ static int ublk_handle_batch_prep_cmd(const struct ublk_batch_io_data *data)
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
+			__ublk_handle_auto_buf_reg(io, data->cmd, &buf_idx);
+		compl = ublk_need_complete_req(data->ub, io);
+	}
+	ublk_io_unlock(io);
+
+	if (unlikely(ret)) {
+		pr_warn("%s: dev %u queue %u io %u: commit failure %d\n",
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
+		.total = uc->nr_elem * uc->elem_bytes,
+		.elem_bytes = uc->elem_bytes,
+	};
+	int ret;
+
+	ret = io_uring_cmd_import_fixed(cmd->sqe->addr, iter.total,
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
 	const u16 mask = UBLK_BATCH_F_HAS_BUF_ADDR | UBLK_BATCH_F_HAS_ZONE_LBA;
@@ -2883,7 +2996,7 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
 		ret = ublk_check_batch_cmd(&data);
 		if (ret)
 			goto out;
-		ret = -EOPNOTSUPP;
+		ret = ublk_handle_batch_commit_cmd(&data);
 		break;
 	default:
 		ret = -EOPNOTSUPP;
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

