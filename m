Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBFA2D1F69
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940357; cv=none; b=QSpZxoXqe0s0L1zs7GdghO+Aw1UmcI6voEIRlIjRCr/C/GpCna8yYmgovVo8L/iJ6MpY8fo+OXSByHl6WH0nslJSAXJYDFDQmBnwl3+iBRiBkyV7FU0Lwk70IrPrFPWtscMyleB32RsNVLXSl3WoQt2GPjgYNKVu9UVHhomqX5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940357; c=relaxed/simple;
	bh=mXRJqBn6EZnnXB7U5u5lB+B/dFqP/c8+ThNUXMNWsz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXImdULSZK4IrhtBcb+QfCYIbLsu+elSmDhTMupjqMwad/PP9/GpnEFiuOzYSgHM3lnn7ORBtP5+T4czusfHX2fXLTmOX17Ew+AxD6rVDzyD1HoyhKK3+/tloH0ucJq8cZyrCdGR8PtD8SmBhbdiu4p6+LfQ/lhYWblCQzR/x/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GfAh3cYk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfAh3cYk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762940354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQKqMou8Tld5LzGLjhCEHbKSLlPeoXOD+f7+/DDep34=;
	b=GfAh3cYksy9COQmOfKe/xG63z4vay3P+xsE6q+JHL8Xz9t24Nx4xokRmtpKCa4+0tYVH0o
	pe6M0t4SAStAGSKcJW8r7/TVmywN3eMkYO63MWRovAMz2bWmq28Xcmsnvm2JoxcbrnU+/w
	NRY6yCWuWrhcgRY4y2W6V/VLoWWw1mc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-4wQIL3zBOF-XawdzqwO9DA-1; Wed,
 12 Nov 2025 04:39:13 -0500
X-MC-Unique: 4wQIL3zBOF-XawdzqwO9DA-1
X-Mimecast-MFC-AGG-ID: 4wQIL3zBOF-XawdzqwO9DA_1762940352
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30FA61800473;
	Wed, 12 Nov 2025 09:39:12 +0000 (UTC)
Received: from localhost (unknown [10.72.116.179])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1764E180047F;
	Wed, 12 Nov 2025 09:39:10 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 10/27] ublk: handle UBLK_U_IO_PREP_IO_CMDS
Date: Wed, 12 Nov 2025 17:37:48 +0800
Message-ID: <20251112093808.2134129-11-ming.lei@redhat.com>
In-Reply-To: <20251112093808.2134129-1-ming.lei@redhat.com>
References: <20251112093808.2134129-1-ming.lei@redhat.com>
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
 drivers/block/ublk_drv.c      | 205 +++++++++++++++++++++++++++++++++-
 include/uapi/linux/ublk_cmd.h |   5 +
 2 files changed, 209 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 5f9d7ec9daa4..84d838df18cb 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -117,6 +117,7 @@ struct ublk_batch_io_data {
 	struct ublk_device *ub;
 	struct io_uring_cmd *cmd;
 	struct ublk_batch_io header;
+	unsigned int issue_flags;
 };
 
 /*
@@ -201,6 +202,7 @@ struct ublk_io {
 	unsigned task_registered_buffers;
 
 	void *buf_ctx_handle;
+	spinlock_t lock;
 } ____cacheline_aligned_in_smp;
 
 struct ublk_queue {
@@ -270,6 +272,16 @@ static inline bool ublk_dev_support_batch_io(const struct ublk_device *ub)
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
@@ -2531,6 +2543,183 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	return ublk_ch_uring_cmd_local(cmd, issue_flags);
 }
 
+static inline __u64 ublk_batch_buf_addr(const struct ublk_batch_io *uc,
+					const struct ublk_elem_header *elem)
+{
+	const void *buf = elem;
+
+	if (uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR)
+		return *(__u64 *)(buf + sizeof(*elem));
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
+	/* copy to this buffer from iterator first */
+	unsigned char buf[UBLK_CMD_BATCH_TMP_BUF_SZ];
+	struct iov_iter iter;
+	unsigned done, total;
+	unsigned char elem_bytes;
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
+	int i, ret = 0;
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
+	/* revert unhandled bytes in case of failure */
+	if (ret)
+		iov_iter_revert(&iter->iter, bytes - i);
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
+		ret = copy_from_iter(iter->buf, len, &iter->iter);
+		if (ret != len) {
+			pr_warn("ublk%d: read batch cmd buffer failed %u/%u\n",
+					data->ub->dev_info.dev_id, ret, len);
+			ret = -EINVAL;
+			break;
+		}
+
+		ret = __ublk_walk_cmd_buf(ubq, iter, data, len, cb);
+		if (ret)
+			break;
+	}
+	return ret;
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
 	const u16 mask = UBLK_BATCH_F_HAS_BUF_ADDR | UBLK_BATCH_F_HAS_ZONE_LBA;
@@ -2609,6 +2798,7 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
 			.nr_elem = READ_ONCE(uc->nr_elem),
 			.elem_bytes = READ_ONCE(uc->elem_bytes),
 		},
+		.issue_flags = issue_flags,
 	};
 	u32 cmd_op = cmd->cmd_op;
 	int ret = -EINVAL;
@@ -2618,6 +2808,11 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
 
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
@@ -2792,7 +2987,7 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 	struct ublk_queue *ubq;
 	struct page *page;
 	int numa_node;
-	int size;
+	int size, i;
 
 	/* Determine NUMA node based on queue's CPU affinity */
 	numa_node = ublk_get_queue_numa_node(ub, q_id);
@@ -2817,6 +3012,9 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 	}
 	ubq->io_cmd_buf = page_address(page);
 
+	for (i = 0; i < ubq->q_depth; i++)
+		spin_lock_init(&ubq->ios[i].lock);
+
 	ub->queues[q_id] = ubq;
 	ubq->dev = ub;
 	return 0;
@@ -3043,6 +3241,11 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
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
index 2ce5a496b622..c96c299057c3 100644
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

