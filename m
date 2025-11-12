Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A683A2FD692
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940355; cv=none; b=dvWqh2tvSzbK1vUHWIJieTVTjB2EoJwqrRq6Vq54NHOKdJdAlM07sHUcoBERSd4BfrzPXr9jOedrH3Ifli+CSwQ4+2yRjlrn6Fv5fFkHqzRnoOmUd8PefUDROTnA2cEXseQe41/ZvUjs2++DNESZPkdoT4xa09PJWEY89bv/Mvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940355; c=relaxed/simple;
	bh=GmlfPMdY+ZyMorr8omMEEva3Cu2dpecjTqaGVrCYzVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdV9myPOvqNPz4WuGJFlemJ52DOVrB7oD3nUDDJGdZWM2K7jbMrPQ1t8cyHbXJbeHd6tQaLarqOtZA12/X1odM/hzYm8NvahV8VI3STGyQ3GpfsRVISzIeqltaEBhztL0E4fIt/jgVnN9azAukWTx+RKYrtrwcyz6g1xBBzgcTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BwiiMkel; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwiiMkel"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762940352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCrdPuTkxT5D+7Dak0Ykx8y2+iVHyK/YFjApdJx+uV8=;
	b=BwiiMkel84Vk00t3qxc6oH60GAcNdWLvtW71XQ8xp18jhg3OJ5549G22LOtkbYYL0Q5gjI
	5kI9BFCGHfZSemUYXzYmdwL2Aduwjvbjq+O90y1P85mvkEVm/ZHqj60VISqyNd8bDXHkxg
	QXOYP7opYN2oQooj4qJmCn/ULDarLBg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-6CpsJ-2PNyiUiVnYaDtgeg-1; Wed,
 12 Nov 2025 04:39:09 -0500
X-MC-Unique: 6CpsJ-2PNyiUiVnYaDtgeg-1
X-Mimecast-MFC-AGG-ID: 6CpsJ-2PNyiUiVnYaDtgeg_1762940348
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19A121800250;
	Wed, 12 Nov 2025 09:39:08 +0000 (UTC)
Received: from localhost (unknown [10.72.116.179])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DCA461955F1A;
	Wed, 12 Nov 2025 09:39:06 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 09/27] ublk: add new batch command UBLK_U_IO_PREP_IO_CMDS & UBLK_U_IO_COMMIT_IO_CMDS
Date: Wed, 12 Nov 2025 17:37:47 +0800
Message-ID: <20251112093808.2134129-10-ming.lei@redhat.com>
In-Reply-To: <20251112093808.2134129-1-ming.lei@redhat.com>
References: <20251112093808.2134129-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add new command UBLK_U_IO_PREP_IO_CMDS, which is the batch version of
UBLK_IO_FETCH_REQ.

Add new command UBLK_U_IO_COMMIT_IO_CMDS, which is for committing io command
result only, still the batch version.

The new command header type is `struct ublk_batch_io`, and fixed buffer is
required for these two uring_cmd.

This patch doesn't actually implement these commands yet, just validates the
SQE fields.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 107 +++++++++++++++++++++++++++++++++-
 include/uapi/linux/ublk_cmd.h |  49 ++++++++++++++++
 2 files changed, 155 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c62b2f2057fe..5f9d7ec9daa4 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -85,6 +85,11 @@
 	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
 	 UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
 
+#define UBLK_BATCH_F_ALL  \
+	(UBLK_BATCH_F_HAS_ZONE_LBA | \
+	 UBLK_BATCH_F_HAS_BUF_ADDR | \
+	 UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK)
+
 struct ublk_uring_cmd_pdu {
 	/*
 	 * Store requests in same batch temporarily for queuing them to
@@ -108,6 +113,12 @@ struct ublk_uring_cmd_pdu {
 	u16 tag;
 };
 
+struct ublk_batch_io_data {
+	struct ublk_device *ub;
+	struct io_uring_cmd *cmd;
+	struct ublk_batch_io header;
+};
+
 /*
  * io command is active: sqe cmd is received, and its cqe isn't done
  *
@@ -2520,10 +2531,104 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	return ublk_ch_uring_cmd_local(cmd, issue_flags);
 }
 
+static int ublk_check_batch_cmd_flags(const struct ublk_batch_io *uc)
+{
+	const u16 mask = UBLK_BATCH_F_HAS_BUF_ADDR | UBLK_BATCH_F_HAS_ZONE_LBA;
+	const unsigned header_len = sizeof(struct ublk_elem_header);
+
+	if (uc->flags & ~UBLK_BATCH_F_ALL)
+		return -EINVAL;
+
+	/* UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK requires buffer index */
+	if ((uc->flags & UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK) &&
+			(uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR))
+		return -EINVAL;
+
+	switch (uc->flags & mask) {
+	case 0:
+		if (uc->elem_bytes != header_len)
+			return -EINVAL;
+		break;
+	case UBLK_BATCH_F_HAS_ZONE_LBA:
+	case UBLK_BATCH_F_HAS_BUF_ADDR:
+		if (uc->elem_bytes != header_len + sizeof(u64))
+			return -EINVAL;
+		break;
+	case UBLK_BATCH_F_HAS_ZONE_LBA | UBLK_BATCH_F_HAS_BUF_ADDR:
+		if (uc->elem_bytes != header_len + sizeof(u64) + sizeof(u64))
+			return -EINVAL;
+		break;
+	}
+
+	return 0;
+}
+
+static int ublk_check_batch_cmd(const struct ublk_batch_io_data *data)
+{
+
+	const struct ublk_batch_io *uc = &data->header;
+
+	if (!(data->cmd->flags & IORING_URING_CMD_FIXED))
+		return -EINVAL;
+
+	if (uc->nr_elem * uc->elem_bytes > data->cmd->sqe->len)
+		return -E2BIG;
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
+	if (uc->reserved || uc->reserved2)
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
index ec77dabba45b..2ce5a496b622 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -102,6 +102,10 @@
 	_IOWR('u', 0x23, struct ublksrv_io_cmd)
 #define	UBLK_U_IO_UNREGISTER_IO_BUF	\
 	_IOWR('u', 0x24, struct ublksrv_io_cmd)
+#define	UBLK_U_IO_PREP_IO_CMDS	\
+	_IOWR('u', 0x25, struct ublk_batch_io)
+#define	UBLK_U_IO_COMMIT_IO_CMDS	\
+	_IOWR('u', 0x26, struct ublk_batch_io)
 
 /* only ABORT means that no re-fetch */
 #define UBLK_IO_RES_OK			0
@@ -525,6 +529,51 @@ struct ublksrv_io_cmd {
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

