Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6C8328B63
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573181; cv=none; b=k1b6LS0Nq8OUrkD+ajwWHLOaTtPE4mkhdWrb+15qWpG2FFF8IlHA9d0KJVUXoICS1AdPZm0thGuRAknqUc8u51xBEIUzGCcYCBCX5Ydeu1yQVOF4l25SKVcwb7DegIiVavFA4KYt3YGeyRvkNn1QbycaG9liGIsAFPMzkir8IZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573181; c=relaxed/simple;
	bh=fg1D+OK1stb4yGMMrupl06I7oQ+ay8UeFLHL0CFP/JI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCQOysT6y/1UrJaNvmGCM3DW46UapHG5Fsp4IMIf2oBrOc1ImhT2xFrvAKzNRnEfbVo8Qa2AdunhtXhMFFX/S/55+0Bm5N+5COMxSnAs1erk00+dZYIvjDTACBxqzMbh1GbGXkqZYMzBVIKIYh+K/bDBqs9KfyV79yFwXfS9S94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mv3LEOV1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mv3LEOV1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768573178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ofwym2MC9YSEdZpo0/V2We+Rwm7uaHs5lyQRKOj7Hto=;
	b=Mv3LEOV16gta6TmshS5+mPaVaIFQAkZ9uQbnBMTHpfvFae4xAqEmOPcZ/UFizhuTMc1TqT
	Y/YhUG3Ki4jQPYhbALvYsRmKzeI8NrfCqyyaccROWpjr/dJknL7nBBrLTSySqNE5pNJR0v
	/VGmI/ybD4nQ/vFOEd8aOZY9KkmCoB0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-XXXaHhKcPHKDRT5FrcqOvw-1; Fri,
 16 Jan 2026 09:19:32 -0500
X-MC-Unique: XXXaHhKcPHKDRT5FrcqOvw-1
X-Mimecast-MFC-AGG-ID: XXXaHhKcPHKDRT5FrcqOvw_1768573170
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C8A7195609F;
	Fri, 16 Jan 2026 14:19:28 +0000 (UTC)
Received: from localhost (unknown [10.72.116.198])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 62865195419F;
	Fri, 16 Jan 2026 14:19:26 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 04/24] ublk: handle UBLK_U_IO_PREP_IO_CMDS
Date: Fri, 16 Jan 2026 22:18:37 +0800
Message-ID: <20260116141859.719929-5-ming.lei@redhat.com>
In-Reply-To: <20260116141859.719929-1-ming.lei@redhat.com>
References: <20260116141859.719929-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This commit implements the handling of the UBLK_U_IO_PREP_IO_CMDS command,
which allows userspace to prepare a batch of I/O requests.

The core of this change is the `ublk_walk_cmd_buf` function, which iterates
over the elements in the uring_cmd fixed buffer. For each element, it parses
the I/O details, finds the corresponding `ublk_io` structure, and prepares it
for future dispatch.

Add per-io lock for protecting concurrent delivery and committing.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 191 +++++++++++++++++++++++++++++++++-
 include/uapi/linux/ublk_cmd.h |   5 +
 2 files changed, 195 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 9fd81213b81b..6aef1a856a80 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -208,6 +208,7 @@ struct ublk_io {
 	unsigned task_registered_buffers;
 
 	void *buf_ctx_handle;
+	spinlock_t lock;
 } ____cacheline_aligned_in_smp;
 
 struct ublk_queue {
@@ -280,6 +281,16 @@ static inline bool ublk_dev_support_batch_io(const struct ublk_device *ub)
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
@@ -2699,6 +2710,171 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	return ublk_ch_uring_cmd_local(cmd, issue_flags);
 }
 
+static inline __u64 ublk_batch_buf_addr(const struct ublk_batch_io *uc,
+					const struct ublk_elem_header *elem)
+{
+	const void *buf = elem;
+
+	if (uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR)
+		return *(const __u64 *)(buf + sizeof(*elem));
+	return 0;
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
+/*
+ * 48 can hold any type of buffer element(8, 16 and 24 bytes) because
+ * it is the least common multiple(LCM) of 8, 16 and 24
+ */
+#define UBLK_CMD_BATCH_TMP_BUF_SZ  (48 * 10)
+struct ublk_batch_io_iter {
+	void __user *uaddr;
+	unsigned done, total;
+	unsigned char elem_bytes;
+	/* copy to this buffer from user space */
+	unsigned char buf[UBLK_CMD_BATCH_TMP_BUF_SZ];
+};
+
+static inline int
+__ublk_walk_cmd_buf(struct ublk_queue *ubq,
+		    struct ublk_batch_io_iter *iter,
+		    const struct ublk_batch_io_data *data,
+		    unsigned bytes,
+		    int (*cb)(struct ublk_queue *q,
+			    const struct ublk_batch_io_data *data,
+			    const struct ublk_elem_header *elem))
+{
+	unsigned int i;
+	int ret = 0;
+
+	for (i = 0; i < bytes; i += iter->elem_bytes) {
+		const struct ublk_elem_header *elem =
+			(const struct ublk_elem_header *)&iter->buf[i];
+
+		if (unlikely(elem->tag >= data->ub->dev_info.queue_depth)) {
+			ret = -EINVAL;
+			break;
+		}
+
+		ret = cb(ubq, data, elem);
+		if (unlikely(ret))
+			break;
+	}
+
+	iter->done += i;
+	return ret;
+}
+
+static int ublk_walk_cmd_buf(struct ublk_batch_io_iter *iter,
+			     const struct ublk_batch_io_data *data,
+			     int (*cb)(struct ublk_queue *q,
+				     const struct ublk_batch_io_data *data,
+				     const struct ublk_elem_header *elem))
+{
+	struct ublk_queue *ubq = ublk_get_queue(data->ub, data->header.q_id);
+	int ret = 0;
+
+	while (iter->done < iter->total) {
+		unsigned int len = min(sizeof(iter->buf), iter->total - iter->done);
+
+		if (copy_from_user(iter->buf, iter->uaddr + iter->done, len)) {
+			pr_warn("ublk%d: read batch cmd buffer failed\n",
+					data->ub->dev_info.dev_id);
+			return -EFAULT;
+		}
+
+		ret = __ublk_walk_cmd_buf(ubq, iter, data, len, cb);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static int ublk_batch_unprep_io(struct ublk_queue *ubq,
+				const struct ublk_batch_io_data *data,
+				const struct ublk_elem_header *elem)
+{
+	struct ublk_io *io = &ubq->ios[elem->tag];
+
+	data->ub->nr_io_ready--;
+	ublk_io_lock(io);
+	io->flags = 0;
+	ublk_io_unlock(io);
+	return 0;
+}
+
+static void ublk_batch_revert_prep_cmd(struct ublk_batch_io_iter *iter,
+				       const struct ublk_batch_io_data *data)
+{
+	int ret;
+
+	/* Re-process only what we've already processed, starting from beginning */
+	iter->total = iter->done;
+	iter->done = 0;
+
+	ret = ublk_walk_cmd_buf(iter, data, ublk_batch_unprep_io);
+	WARN_ON_ONCE(ret);
+}
+
+static int ublk_batch_prep_io(struct ublk_queue *ubq,
+			      const struct ublk_batch_io_data *data,
+			      const struct ublk_elem_header *elem)
+{
+	struct ublk_io *io = &ubq->ios[elem->tag];
+	const struct ublk_batch_io *uc = &data->header;
+	union ublk_io_buf buf = { 0 };
+	int ret;
+
+	if (ublk_dev_support_auto_buf_reg(data->ub))
+		buf.auto_reg = ublk_batch_auto_buf_reg(uc, elem);
+	else if (ublk_dev_need_map_io(data->ub)) {
+		buf.addr = ublk_batch_buf_addr(uc, elem);
+
+		ret = ublk_check_fetch_buf(data->ub, buf.addr);
+		if (ret)
+			return ret;
+	}
+
+	ublk_io_lock(io);
+	ret = __ublk_fetch(data->cmd, data->ub, io);
+	if (!ret)
+		io->buf = buf;
+	ublk_io_unlock(io);
+
+	return ret;
+}
+
+static int ublk_handle_batch_prep_cmd(const struct ublk_batch_io_data *data)
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
+	mutex_lock(&data->ub->mutex);
+	ret = ublk_walk_cmd_buf(&iter, data, ublk_batch_prep_io);
+
+	if (ret && iter.done)
+		ublk_batch_revert_prep_cmd(&iter, data);
+	mutex_unlock(&data->ub->mutex);
+	return ret;
+}
+
 static int ublk_check_batch_cmd_flags(const struct ublk_batch_io *uc)
 {
 	unsigned elem_bytes = sizeof(struct ublk_elem_header);
@@ -2765,6 +2941,11 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
 
 	switch (cmd_op) {
 	case UBLK_U_IO_PREP_IO_CMDS:
+		ret = ublk_check_batch_cmd(&data);
+		if (ret)
+			goto out;
+		ret = ublk_handle_batch_prep_cmd(&data);
+		break;
 	case UBLK_U_IO_COMMIT_IO_CMDS:
 		ret = ublk_check_batch_cmd(&data);
 		if (ret)
@@ -2952,7 +3133,7 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 	struct ublk_queue *ubq;
 	struct page *page;
 	int numa_node;
-	int size;
+	int size, i;
 
 	/* Determine NUMA node based on queue's CPU affinity */
 	numa_node = ublk_get_queue_numa_node(ub, q_id);
@@ -2977,6 +3158,9 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 	}
 	ubq->io_cmd_buf = page_address(page);
 
+	for (i = 0; i < ubq->q_depth; i++)
+		spin_lock_init(&ubq->ios[i].lock);
+
 	ub->queues[q_id] = ubq;
 	ubq->dev = ub;
 	return 0;
@@ -3229,6 +3413,11 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 		return -EINVAL;
 
 	mutex_lock(&ub->mutex);
+	/* device may become not ready in case of F_BATCH */
+	if (!ublk_dev_ready(ub)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
 	if (ub->dev_info.state == UBLK_S_DEV_LIVE ||
 	    test_bit(UB_STATE_USED, &ub->state)) {
 		ret = -EEXIST;
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 0cc58e19d401..1a3d4d33c1d1 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -103,6 +103,11 @@
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

