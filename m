Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117AA3242B1
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573175; cv=none; b=D3KwrKgzynr6b4kt6oMBNjOw49CocxOoOQQ1kdvqApW4eWTogseIzEnMb21I5WBEw2zrH+3Dq89Op/Of77RMQKh0AKLUfs/cCAPTJTsPGLXPbijt/ycPexxf7Na95hrHQZ3z9Il8pgnWouZReYm5ranDcR9urTYcMga06Pw8Vfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573175; c=relaxed/simple;
	bh=O1hKG8jc/ZoD5Wija9P4WERldruKxDzdEwQu6sfhVgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+qTB1VcU91AujQlPwxuf2wtaCfB5cNZ6TNqajnDL03J3X0arh0lPLkf8HwQleMqbfv7BS0Ffg45H5kkOQ9mffUfNZjaSmgAtj2dNgsn2kNvI8vVhS6NZwUaeeC/voee5kZN32Hy7IxCcfWiUcelbxKHOXp1DikoVxjuIc9NJG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NHUlV30z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHUlV30z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768573168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8c9+3aaQ3SPobYzImIPhSp1XjIzzNhUZ2HPazIA/M6E=;
	b=NHUlV30zha/nsow/DdJcLmLOLzyKOMhmtaBGm0L0e59KUEtyy725FhsV69J4pC6M67Or+v
	RDiRhsDMN/dT5a3piLQ4N8jkX648pS4Tna0yeSSvQiPxCAZopCEbBeCz4tNK0JlWX2b6z9
	yzHkrwIfuIa94crmVvzfsBK3CvaQTRM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-xmerTTyZN6ez-zk640B61g-1; Fri,
 16 Jan 2026 09:19:25 -0500
X-MC-Unique: xmerTTyZN6ez-zk640B61g-1
X-Mimecast-MFC-AGG-ID: xmerTTyZN6ez-zk640B61g_1768573164
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65C8C1955DD1;
	Fri, 16 Jan 2026 14:19:23 +0000 (UTC)
Received: from localhost (unknown [10.72.116.198])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 530E219560BA;
	Fri, 16 Jan 2026 14:19:21 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 03/24] ublk: add new batch command UBLK_U_IO_PREP_IO_CMDS & UBLK_U_IO_COMMIT_IO_CMDS
Date: Fri, 16 Jan 2026 22:18:36 +0800
Message-ID: <20260116141859.719929-4-ming.lei@redhat.com>
In-Reply-To: <20260116141859.719929-1-ming.lei@redhat.com>
References: <20260116141859.719929-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add new command UBLK_U_IO_PREP_IO_CMDS, which is the batch version of
UBLK_IO_FETCH_REQ.

Add new command UBLK_U_IO_COMMIT_IO_CMDS, which is for committing io command
result only, still the batch version.

The new command header type is `struct ublk_batch_io`.

This patch doesn't actually implement these commands yet, just validates the
SQE fields.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 87 ++++++++++++++++++++++++++++++++++-
 include/uapi/linux/ublk_cmd.h | 49 ++++++++++++++++++++
 2 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 8a0155f5e8f2..9fd81213b81b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -91,6 +91,11 @@
 	 UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT | \
 	 UBLK_PARAM_TYPE_INTEGRITY)
 
+#define UBLK_BATCH_F_ALL  \
+	(UBLK_BATCH_F_HAS_ZONE_LBA | \
+	 UBLK_BATCH_F_HAS_BUF_ADDR | \
+	 UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK)
+
 struct ublk_uring_cmd_pdu {
 	/*
 	 * Store requests in same batch temporarily for queuing them to
@@ -114,6 +119,13 @@ struct ublk_uring_cmd_pdu {
 	u16 tag;
 };
 
+struct ublk_batch_io_data {
+	struct ublk_device *ub;
+	struct io_uring_cmd *cmd;
+	struct ublk_batch_io header;
+	unsigned int issue_flags;
+};
+
 /*
  * io command is active: sqe cmd is received, and its cqe isn't done
  *
@@ -2687,10 +2699,83 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	return ublk_ch_uring_cmd_local(cmd, issue_flags);
 }
 
+static int ublk_check_batch_cmd_flags(const struct ublk_batch_io *uc)
+{
+	unsigned elem_bytes = sizeof(struct ublk_elem_header);
+
+	if (uc->flags & ~UBLK_BATCH_F_ALL)
+		return -EINVAL;
+
+	/* UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK requires buffer index */
+	if ((uc->flags & UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK) &&
+			(uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR))
+		return -EINVAL;
+
+	elem_bytes += (uc->flags & UBLK_BATCH_F_HAS_ZONE_LBA ? sizeof(u64) : 0) +
+		(uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR ? sizeof(u64) : 0);
+	if (uc->elem_bytes != elem_bytes)
+		return -EINVAL;
+	return 0;
+}
+
+static int ublk_check_batch_cmd(const struct ublk_batch_io_data *data)
+{
+
+	const struct ublk_batch_io *uc = &data->header;
+
+	if (uc->nr_elem > data->ub->dev_info.queue_depth)
+		return -E2BIG;
+
+	if ((uc->flags & UBLK_BATCH_F_HAS_ZONE_LBA) &&
+			!ublk_dev_is_zoned(data->ub))
+		return -EINVAL;
+
+	if ((uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR) &&
+			!ublk_dev_need_map_io(data->ub))
+		return -EINVAL;
+
+	if ((uc->flags & UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK) &&
+			!ublk_dev_support_auto_buf_reg(data->ub))
+		return -EINVAL;
+
+	return ublk_check_batch_cmd_flags(uc);
+}
+
 static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
 				       unsigned int issue_flags)
 {
-	return -EOPNOTSUPP;
+	const struct ublk_batch_io *uc = io_uring_sqe_cmd(cmd->sqe);
+	struct ublk_device *ub = cmd->file->private_data;
+	struct ublk_batch_io_data data = {
+		.ub  = ub,
+		.cmd = cmd,
+		.header = (struct ublk_batch_io) {
+			.q_id = READ_ONCE(uc->q_id),
+			.flags = READ_ONCE(uc->flags),
+			.nr_elem = READ_ONCE(uc->nr_elem),
+			.elem_bytes = READ_ONCE(uc->elem_bytes),
+		},
+		.issue_flags = issue_flags,
+	};
+	u32 cmd_op = cmd->cmd_op;
+	int ret = -EINVAL;
+
+	if (data.header.q_id >= ub->dev_info.nr_hw_queues)
+		goto out;
+
+	switch (cmd_op) {
+	case UBLK_U_IO_PREP_IO_CMDS:
+	case UBLK_U_IO_COMMIT_IO_CMDS:
+		ret = ublk_check_batch_cmd(&data);
+		if (ret)
+			goto out;
+		ret = -EOPNOTSUPP;
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+	}
+out:
+	return ret;
 }
 
 static inline bool ublk_check_ubuf_dir(const struct request *req,
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 90f47da4f435..0cc58e19d401 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -103,6 +103,10 @@
 	_IOWR('u', 0x23, struct ublksrv_io_cmd)
 #define	UBLK_U_IO_UNREGISTER_IO_BUF	\
 	_IOWR('u', 0x24, struct ublksrv_io_cmd)
+#define	UBLK_U_IO_PREP_IO_CMDS	\
+	_IOWR('u', 0x25, struct ublk_batch_io)
+#define	UBLK_U_IO_COMMIT_IO_CMDS	\
+	_IOWR('u', 0x26, struct ublk_batch_io)
 
 /* only ABORT means that no re-fetch */
 #define UBLK_IO_RES_OK			0
@@ -544,6 +548,51 @@ struct ublksrv_io_cmd {
 	};
 };
 
+struct ublk_elem_header {
+	__u16 tag;	/* IO tag */
+
+	/*
+	 * Buffer index for incoming io command, only valid iff
+	 * UBLK_F_AUTO_BUF_REG is set
+	 */
+	__u16 buf_index;
+	__s32 result;	/* I/O completion result (commit only) */
+};
+
+/*
+ * uring_cmd buffer structure for batch commands
+ *
+ * buffer includes multiple elements, which number is specified by
+ * `nr_elem`. Each element buffer is organized in the following order:
+ *
+ * struct ublk_elem_buffer {
+ * 	// Mandatory fields (8 bytes)
+ * 	struct ublk_elem_header header;
+ *
+ * 	// Optional fields (8 bytes each, included based on flags)
+ *
+ * 	// Buffer address (if UBLK_BATCH_F_HAS_BUF_ADDR) for copying data
+ * 	// between ublk request and ublk server buffer
+ * 	__u64 buf_addr;
+ *
+ * 	// returned Zone append LBA (if UBLK_BATCH_F_HAS_ZONE_LBA)
+ * 	__u64 zone_lba;
+ * }
+ *
+ * Used for `UBLK_U_IO_PREP_IO_CMDS` and `UBLK_U_IO_COMMIT_IO_CMDS`
+ */
+struct ublk_batch_io {
+	__u16  q_id;
+#define UBLK_BATCH_F_HAS_ZONE_LBA	(1 << 0)
+#define UBLK_BATCH_F_HAS_BUF_ADDR 	(1 << 1)
+#define UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK	(1 << 2)
+	__u16	flags;
+	__u16	nr_elem;
+	__u8	elem_bytes;
+	__u8	reserved;
+	__u64   reserved2;
+};
+
 struct ublk_param_basic {
 #define UBLK_ATTR_READ_ONLY            (1 << 0)
 #define UBLK_ATTR_ROTATIONAL           (1 << 1)
-- 
2.47.0

