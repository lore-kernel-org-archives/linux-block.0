Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6920A25C83A
	for <linux-block@vger.kernel.org>; Mon,  1 Sep 2025 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721008; cv=none; b=nW6nhFK/Ef7/4niKC4W8cvPoSvxWrsJ1hxPKslgq1Eam5uhW8UwbnwfNbc/rK36rTgkxiMTLEAPpIunCit+XPyugzC2o6KORVfqhGPQiq+1/wpxmmemuzjN+vEFTxaDMCClud20MQOQBQEKcX46J+2i9iw1H1YVlaEiMcxpScEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721008; c=relaxed/simple;
	bh=Jfzn3vh7iO8QCWS6MWg7hJJqksOiy9FU0/wBgzOLlrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iaABHlXJLZ3lImILGnMVQx+zrzZ2gkM2glxEpBOerRR/3IdW5lRNyNxWCXGPgJ7AUT5EEynvYarfDuuPuFGQRHS7Pn6nxi11zW3cFjq/CFH5njHzIyhHQppwuJMQnD86aQAttqFbgCfE5vgekdrSi6qYsYZHA7QsP7fhPouiVOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NxDfJf0x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxDfJf0x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756721005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pfFVFZSAEmqFucmJmOKk6z4j2XI0bKYdWz3hSp7CqwM=;
	b=NxDfJf0x9Y4ykniSQ8IkVuU7rat2VTQWldJXvYWFmYq24haOU8lFgRnD4oGLxcFGMg12Zh
	AmR4i+gDiEomU4yrnWXJ8ClaB2n85iwcDqlqdCiiOMM7stYtEER/6zLWXOA+BbnoyLOqTd
	Ce72NqUuZhTfX01qHv1ezfkLhY46WlU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-zT_GU0j2NZ-6piWsNAgkSQ-1; Mon,
 01 Sep 2025 06:03:24 -0400
X-MC-Unique: zT_GU0j2NZ-6piWsNAgkSQ-1
X-Mimecast-MFC-AGG-ID: zT_GU0j2NZ-6piWsNAgkSQ_1756721003
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 242FC180034D;
	Mon,  1 Sep 2025 10:03:23 +0000 (UTC)
Received: from localhost (unknown [10.72.116.17])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 28472180047F;
	Mon,  1 Sep 2025 10:03:21 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 08/23] ublk: handle UBLK_U_IO_PREP_IO_CMDS
Date: Mon,  1 Sep 2025 18:02:25 +0800
Message-ID: <20250901100242.3231000-9-ming.lei@redhat.com>
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

This commit implements the handling of the UBLK_U_IO_PREP_IO_CMDS command,
which allows userspace to prepare a batch of I/O requests.

The core of this change is the `ublk_walk_cmd_buf` function, which iterates
over the elements in the uring_cmd fixed buffer. For each element, it parses
the I/O details, finds the corresponding `ublk_io` structure, and prepares it
for future dispatch.

Add per-io lock for protecting concurrent delivery and committing.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 191 +++++++++++++++++++++++++++++++++-
 include/uapi/linux/ublk_cmd.h |   5 +
 2 files changed, 195 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4da0dbbd7e16..a4bae3d1562a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -116,6 +116,10 @@ struct ublk_uring_cmd_pdu {
 struct ublk_batch_io_data {
 	struct ublk_queue *ubq;
 	struct io_uring_cmd *cmd;
+	unsigned int issue_flags;
+
+	/* set when walking the element buffer */
+	const struct ublk_elem_header *elem;
 };
 
 /*
@@ -200,6 +204,7 @@ struct ublk_io {
 	unsigned task_registered_buffers;
 
 	void *buf_ctx_handle;
+	spinlock_t lock;
 } ____cacheline_aligned_in_smp;
 
 struct ublk_queue {
@@ -276,6 +281,16 @@ static inline bool ublk_support_batch_io(const struct ublk_queue *ubq)
 	return false;
 }
 
+static inline void ublk_io_lock(struct ublk_io *io)
+{
+	spin_lock(&io->lock);
+}
+
+static inline void ublk_io_unlock(struct ublk_io *io)
+{
+	spin_unlock(&io->lock);
+}
+
 static inline struct ublksrv_io_desc *
 ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
 {
@@ -2538,6 +2553,171 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	return ublk_ch_uring_cmd_local(cmd, issue_flags);
 }
 
+static inline __u64 ublk_batch_buf_addr(const struct ublk_batch_io *uc,
+					const struct ublk_elem_header *elem)
+{
+	const void *buf = (const void *)elem;
+
+	if (uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR)
+		return *(__u64 *)(buf + sizeof(*elem));
+	return -1;
+}
+
+static struct ublk_auto_buf_reg
+ublk_batch_auto_buf_reg(const struct ublk_batch_io *uc,
+			const struct ublk_elem_header *elem)
+{
+	struct ublk_auto_buf_reg reg = {
+		.index = elem->buf_index,
+		.flags = (uc->flags & UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK) ?
+			UBLK_AUTO_BUF_REG_FALLBACK : 0,
+	};
+
+	return reg;
+}
+
+/* 48 can cover any type of buffer element(8, 16 and 24 bytes) */
+#define UBLK_CMD_BATCH_TMP_BUF_SZ  (48 * 10)
+struct ublk_batch_io_iter {
+	/* copy to this buffer from iterator first */
+	unsigned char buf[UBLK_CMD_BATCH_TMP_BUF_SZ];
+	struct iov_iter iter;
+	unsigned done, total;
+	unsigned char elem_bytes;
+};
+
+static int __ublk_walk_cmd_buf(struct ublk_batch_io_iter *iter,
+				struct ublk_batch_io_data *data,
+				unsigned bytes,
+				int (*cb)(struct ublk_io *io,
+					const struct ublk_batch_io_data *data))
+{
+	int i, ret = 0;
+
+	for (i = 0; i < bytes; i += iter->elem_bytes) {
+		const struct ublk_elem_header *elem =
+			(const struct ublk_elem_header *)&iter->buf[i];
+		struct ublk_io *io;
+
+		if (unlikely(elem->tag >= data->ubq->q_depth)) {
+			ret = -EINVAL;
+			break;
+		}
+
+		io = &data->ubq->ios[elem->tag];
+		data->elem = elem;
+		ret = cb(io, data);
+		if (unlikely(ret))
+			break;
+	}
+	iter->done += i;
+	return ret;
+}
+
+static int ublk_walk_cmd_buf(struct ublk_batch_io_iter *iter,
+			     struct ublk_batch_io_data *data,
+			     int (*cb)(struct ublk_io *io,
+				     const struct ublk_batch_io_data *data))
+{
+	int ret = 0;
+
+	while (iter->done < iter->total) {
+		unsigned int len = min(sizeof(iter->buf), iter->total - iter->done);
+
+		ret = copy_from_iter(iter->buf, len, &iter->iter);
+		if (ret != len) {
+			pr_warn("ublk%d: read batch cmd buffer failed %u/%u\n",
+					data->ubq->dev->dev_info.dev_id, ret, len);
+			ret = -EINVAL;
+			break;
+		}
+
+		ret = __ublk_walk_cmd_buf(iter, data, len, cb);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+static int ublk_batch_unprep_io(struct ublk_io *io,
+				const struct ublk_batch_io_data *data)
+{
+	if (ublk_queue_ready(data->ubq))
+		data->ubq->dev->nr_queues_ready--;
+
+	ublk_io_lock(io);
+	io->flags = 0;
+	ublk_io_unlock(io);
+	data->ubq->nr_io_ready--;
+	return 0;
+}
+
+static void ublk_batch_revert_prep_cmd(struct ublk_batch_io_iter *iter,
+				       struct ublk_batch_io_data *data)
+{
+	int ret;
+
+	if (!iter->done)
+		return;
+
+	iov_iter_revert(&iter->iter, iter->done);
+	iter->total = iter->done;
+	iter->done = 0;
+
+	ret = ublk_walk_cmd_buf(iter, data, ublk_batch_unprep_io);
+	WARN_ON_ONCE(ret);
+}
+
+static int ublk_batch_prep_io(struct ublk_io *io,
+			      const struct ublk_batch_io_data *data)
+{
+	const struct ublk_batch_io *uc = io_uring_sqe_cmd(data->cmd->sqe);
+	union ublk_io_buf buf = { 0 };
+	int ret;
+
+	if (ublk_support_auto_buf_reg(data->ubq))
+		buf.auto_reg = ublk_batch_auto_buf_reg(uc, data->elem);
+	else if (ublk_need_map_io(data->ubq)) {
+		buf.addr = ublk_batch_buf_addr(uc, data->elem);
+
+		ret = ublk_check_fetch_buf(data->ubq, buf.addr);
+		if (ret)
+			return ret;
+	}
+
+	ublk_io_lock(io);
+	ret = __ublk_fetch(data->cmd, data->ubq, io);
+	if (!ret)
+		io->buf = buf;
+	ublk_io_unlock(io);
+
+	return ret;
+}
+
+static int ublk_handle_batch_prep_cmd(struct ublk_batch_io_data *data)
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
+	mutex_lock(&data->ubq->dev->mutex);
+	ret = ublk_walk_cmd_buf(&iter, data, ublk_batch_prep_io);
+
+	if (ret && iter.done)
+		ublk_batch_revert_prep_cmd(&iter, data);
+	mutex_unlock(&data->ubq->dev->mutex);
+	return ret;
+}
+
 static int ublk_check_batch_cmd_flags(const struct ublk_batch_io *uc)
 {
 	const unsigned short mask = UBLK_BATCH_F_HAS_BUF_ADDR |
@@ -2609,6 +2789,7 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
 	struct ublk_device *ub = cmd->file->private_data;
 	struct ublk_batch_io_data data = {
 		.cmd = cmd,
+		.issue_flags = issue_flags,
 	};
 	u32 cmd_op = cmd->cmd_op;
 	int ret = -EINVAL;
@@ -2619,6 +2800,11 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
 
 	switch (cmd_op) {
 	case UBLK_U_IO_PREP_IO_CMDS:
+		ret = ublk_check_batch_cmd(&data, uc);
+		if (ret)
+			goto out;
+		ret = ublk_handle_batch_prep_cmd(&data);
+		break;
 	case UBLK_U_IO_COMMIT_IO_CMDS:
 		ret = ublk_check_batch_cmd(&data, uc);
 		if (ret)
@@ -2780,7 +2966,7 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
 	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO;
 	void *ptr;
-	int size;
+	int size, i;
 
 	spin_lock_init(&ubq->cancel_lock);
 	ubq->flags = ub->dev_info.flags;
@@ -2792,6 +2978,9 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 	if (!ptr)
 		return -ENOMEM;
 
+	for (i = 0; i < ubq->q_depth; i++)
+		spin_lock_init(&ubq->ios[i].lock);
+
 	ubq->io_cmd_buf = ptr;
 	ubq->dev = ub;
 	return 0;
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 01d3af52cfb4..38c8cc10d694 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -102,6 +102,11 @@
 	_IOWR('u', 0x23, struct ublksrv_io_cmd)
 #define	UBLK_U_IO_UNREGISTER_IO_BUF	\
 	_IOWR('u', 0x24, struct ublksrv_io_cmd)
+
+/*
+ * return 0 if the command is run successfully, otherwise failure code
+ * is returned
+ */
 #define	UBLK_U_IO_PREP_IO_CMDS	\
 	_IOWR('u', 0x25, struct ublk_batch_io)
 #define	UBLK_U_IO_COMMIT_IO_CMDS	\
-- 
2.47.0

