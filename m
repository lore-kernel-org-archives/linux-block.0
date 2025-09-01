Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E17818E25
	for <linux-block@vger.kernel.org>; Mon,  1 Sep 2025 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721006; cv=none; b=n2N+wCfSWv1Epf/XlkZSk2ETuVLjvXwy6UQXrDsytFf/qR+q5OxpwIUNy088d6vHVxHSaHeBr3w8OAChqCXUGuHjIt6DTZfDBy1JNQ5/OaVjTWmmgDc4wPsDEPP3GbNe8HVjy7+eUYSCWW8Xp0m0ALz2KLi3tbYBAcXsQp8jhc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721006; c=relaxed/simple;
	bh=q2BSMfAXULqPpq0A0UxcOOVxeJk/zUOhuP2LNtSm0/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwHd0HrSRgAiA4V2rQJQ6SMwJUqHsNs08rhQdqZVESkLniqh8qYeUehSY16zF9cd897uISdwtvkWY95qkeiypG62F5hlxphTiTY0OxFdJVcAikOgsrxT6NxFgqZp3SgO9X/sQBy5Rn0AOWeJ5piwezQzlrCiCmqhxsd2v1zTfkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gGR/fdeB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGR/fdeB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756721003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+lhmhTQviYDvQjU0tHpTYDEVB1/qzwxs16FZlUCmPI=;
	b=gGR/fdeBUeMaxhTv+Acddf1tk0C8BaKlY/ZU1q9HQeC5i4oP8tcbUUx0vMSdqEoayKueYR
	pRlXJaCXfq2O44Vgjc6Hh3O01dLoGGpPT/xn/1IVSYgzysFE6MGDlvSstjAbbJ/GhRuZ83
	FS7dUh/C99pEhmCJIka4MBikFr1HILw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-5XZIH4j1PRqm8d5apKIf5w-1; Mon,
 01 Sep 2025 06:03:20 -0400
X-MC-Unique: 5XZIH4j1PRqm8d5apKIf5w-1
X-Mimecast-MFC-AGG-ID: 5XZIH4j1PRqm8d5apKIf5w_1756720999
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B9F11800446;
	Mon,  1 Sep 2025 10:03:19 +0000 (UTC)
Received: from localhost (unknown [10.72.116.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 80C961955EA4;
	Mon,  1 Sep 2025 10:03:17 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 07/23] ublk: add new batch command UBLK_U_IO_PREP_IO_CMDS & UBLK_U_IO_COMMIT_IO_CMDS
Date: Mon,  1 Sep 2025 18:02:24 +0800
Message-ID: <20250901100242.3231000-8-ming.lei@redhat.com>
In-Reply-To: <20250901100242.3231000-1-ming.lei@redhat.com>
References: <20250901100242.3231000-1-ming.lei@redhat.com>
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

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 102 +++++++++++++++++++++++++++++++++-
 include/uapi/linux/ublk_cmd.h |  49 ++++++++++++++++
 2 files changed, 149 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 46be5b656f22..4da0dbbd7e16 100644
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
@@ -108,6 +113,11 @@ struct ublk_uring_cmd_pdu {
 	u16 tag;
 };
 
+struct ublk_batch_io_data {
+	struct ublk_queue *ubq;
+	struct io_uring_cmd *cmd;
+};
+
 /*
  * io command is active: sqe cmd is received, and its cqe isn't done
  *
@@ -277,7 +287,7 @@ static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
 	return ub->dev_info.flags & UBLK_F_ZONED;
 }
 
-static inline bool ublk_queue_is_zoned(struct ublk_queue *ubq)
+static inline bool ublk_queue_is_zoned(const struct ublk_queue *ubq)
 {
 	return ubq->flags & UBLK_F_ZONED;
 }
@@ -2528,10 +2538,98 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	return ublk_ch_uring_cmd_local(cmd, issue_flags);
 }
 
+static int ublk_check_batch_cmd_flags(const struct ublk_batch_io *uc)
+{
+	const unsigned short mask = UBLK_BATCH_F_HAS_BUF_ADDR |
+		UBLK_BATCH_F_HAS_ZONE_LBA;
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
+		if (uc->elem_bytes != 8)
+			return -EINVAL;
+		break;
+	case UBLK_BATCH_F_HAS_ZONE_LBA:
+	case UBLK_BATCH_F_HAS_BUF_ADDR:
+		if (uc->elem_bytes != 8 + 8)
+			return -EINVAL;
+		break;
+	case UBLK_BATCH_F_HAS_ZONE_LBA | UBLK_BATCH_F_HAS_BUF_ADDR:
+		if (uc->elem_bytes != 8 + 8 + 8)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ublk_check_batch_cmd(const struct ublk_batch_io_data *data,
+				const struct ublk_batch_io *uc)
+{
+	if (!(data->cmd->flags & IORING_URING_CMD_FIXED))
+		return -EINVAL;
+
+	if (uc->nr_elem * uc->elem_bytes > data->cmd->sqe->len)
+		return -E2BIG;
+
+	if (uc->nr_elem > data->ubq->q_depth)
+		return -E2BIG;
+
+	if ((uc->flags & UBLK_BATCH_F_HAS_ZONE_LBA) &&
+			!ublk_queue_is_zoned(data->ubq))
+		return -EINVAL;
+
+	if ((uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR) &&
+			!ublk_need_map_io(data->ubq))
+		return -EINVAL;
+
+	if ((uc->flags & UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK) &&
+			!ublk_support_auto_buf_reg(data->ubq))
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
+		.cmd = cmd,
+	};
+	u32 cmd_op = cmd->cmd_op;
+	int ret = -EINVAL;
+
+	if (uc->q_id >= ub->dev_info.nr_hw_queues)
+		goto out;
+	data.ubq = ublk_get_queue(ub, uc->q_id);
+
+	switch (cmd_op) {
+	case UBLK_U_IO_PREP_IO_CMDS:
+	case UBLK_U_IO_COMMIT_IO_CMDS:
+		ret = ublk_check_batch_cmd(&data, uc);
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
index ec77dabba45b..01d3af52cfb4 100644
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
+	__u32 result;	/* I/O completion result (commit only) */
+};
+
+/*
+ * uring_cmd buffer structure
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

