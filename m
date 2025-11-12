Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AE41E25F9
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940369; cv=none; b=HpiCJu9uVBLMM2Avj72YIudjlL3bhvT4dxCNobKqwgxCxyvPJT44QrA/NFIo1Ps03aSPaYdWUss1p3r5EDhqO2X/35qu57dx9N/FJiQQFDCZgSwkFJWf8f/0r76//L2ab8Zbe2kDlrS8CHnc2fSN6cIGAUjCEoOCb7g4qCIEBV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940369; c=relaxed/simple;
	bh=MyXMr1sdoe1DImwtQvwrcd40uCI+YgpRXPwnu6EDlHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjoVzMek+F9xznprXBltvWO7m/cqi5uurbNlqgm3CKiI5s42Uv3sIHBuHzjSPsnZAwG45Nky7ooW+P3aJdZo+1T+J2bVeAGhDMx9wb2fooXY7nwUoyBfgQ2E4xO2crO+psoTJDWT3tsN/qH2DFDUK6J6s+DfgiS+DIVpwvPzneY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xp+J6580; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xp+J6580"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762940366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxeRgXyOlhhhhCbeLuODK/DQeLS37T7uorTIQ3ORuTg=;
	b=Xp+J6580DF4B9hxHIyqLZ+/94hGl5dW3kj5HkeBwcIlZAZNuXvPJV+fK/RIB4nIaV7PPk0
	0/rPgBqu4Z1uUQTU+3OeHDaEsQx8bVIFPtg8CZ/4/m7kSJVf5AbS39qRyUo7nEnH3SiG5F
	m0lxoTp0d7QCChfPTASHZRCK97JVs0M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-DnYI4qTfMAmre8KGEFdhjA-1; Wed,
 12 Nov 2025 04:39:24 -0500
X-MC-Unique: DnYI4qTfMAmre8KGEFdhjA-1
X-Mimecast-MFC-AGG-ID: DnYI4qTfMAmre8KGEFdhjA_1762940363
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4E041956050;
	Wed, 12 Nov 2025 09:39:23 +0000 (UTC)
Received: from localhost (unknown [10.72.116.179])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B195A1800576;
	Wed, 12 Nov 2025 09:39:22 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 13/27] ublk: add batch I/O dispatch infrastructure
Date: Wed, 12 Nov 2025 17:37:51 +0800
Message-ID: <20251112093808.2134129-14-ming.lei@redhat.com>
In-Reply-To: <20251112093808.2134129-1-ming.lei@redhat.com>
References: <20251112093808.2134129-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add infrastructure for delivering I/O commands to ublk server in batches,
preparing for the upcoming UBLK_U_IO_FETCH_IO_CMDS feature.

Key components:

- struct ublk_batch_fcmd: Represents a batch fetch uring_cmd that will
  receive multiple I/O tags in a single operation, using io_uring's
  multishot command for efficient ublk IO delivery.

- ublk_batch_dispatch(): Batch version of ublk_dispatch_req() that:
  * Pulls multiple request tags from the events FIFO (lock-free reader)
  * Prepares each I/O for delivery (including auto buffer registration)
  * Delivers tags to userspace via single uring_cmd notification
  * Handles partial failures by restoring undelivered tags to FIFO

The batch approach significantly reduces notification overhead by aggregating
multiple I/O completions into single uring_cmd, while maintaining the same
I/O processing semantics as individual operations.

Error handling ensures system consistency: if buffer selection or CQE
posting fails, undelivered tags are restored to the FIFO for retry.

This runs in task work context, scheduled via io_uring_cmd_complete_in_task()
or called directly from ->uring_cmd(), enabling efficient batch processing
without blocking the I/O submission path.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 126 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/ublk_cmd.h |   6 ++
 2 files changed, 132 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 840d6a16bd4b..c9183ba99792 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -91,6 +91,12 @@
 	 UBLK_BATCH_F_HAS_BUF_ADDR | \
 	 UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK)
 
+/* ublk batch fetch uring_cmd */
+struct ublk_batch_fcmd {
+	struct io_uring_cmd *cmd;
+	unsigned short buf_group;
+};
+
 struct ublk_uring_cmd_pdu {
 	/*
 	 * Store requests in same batch temporarily for queuing them to
@@ -616,6 +622,32 @@ static wait_queue_head_t ublk_idr_wq;	/* wait until one idr is freed */
 static DEFINE_MUTEX(ublk_ctl_mutex);
 
 
+static void ublk_batch_deinit_fetch_buf(const struct ublk_batch_io_data *data,
+					struct ublk_batch_fcmd *fcmd,
+					int res)
+{
+	io_uring_cmd_done(fcmd->cmd, res, data->issue_flags);
+	fcmd->cmd = NULL;
+}
+
+static int ublk_batch_fetch_post_cqe(struct ublk_batch_fcmd *fcmd,
+				     struct io_br_sel *sel,
+				     unsigned int issue_flags)
+{
+	if (io_uring_mshot_cmd_post_cqe(fcmd->cmd, sel, issue_flags))
+		return -ENOBUFS;
+	return 0;
+}
+
+static ssize_t ublk_batch_copy_io_tags(struct ublk_batch_fcmd *fcmd,
+				       void __user *buf, const u16 *tag_buf,
+				       unsigned int len)
+{
+	if (copy_to_user(buf, tag_buf, len))
+		return -EFAULT;
+	return len;
+}
+
 #define UBLK_MAX_UBLKS UBLK_MINORS
 
 /*
@@ -1378,6 +1410,100 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
 	}
 }
 
+static bool __ublk_batch_prep_dispatch(struct ublk_queue *ubq,
+				       const struct ublk_batch_io_data *data,
+				       unsigned short tag)
+{
+	struct ublk_device *ub = data->ub;
+	struct ublk_io *io = &ubq->ios[tag];
+	struct request *req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
+	enum auto_buf_reg_res res = AUTO_BUF_REG_FALLBACK;
+	struct io_uring_cmd *cmd = data->cmd;
+
+	if (!ublk_start_io(ubq, req, io))
+		return false;
+
+	if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req))
+		res = __ublk_do_auto_buf_reg(ubq, req, io, cmd,
+				data->issue_flags);
+
+	ublk_io_lock(io);
+	ublk_prep_auto_buf_reg_io(ubq, req, io, cmd, res);
+	ublk_io_unlock(io);
+
+	return res != AUTO_BUF_REG_FAIL;
+}
+
+static void ublk_batch_prep_dispatch(struct ublk_queue *ubq,
+				     const struct ublk_batch_io_data *data,
+				     unsigned short *tag_buf,
+				     unsigned int len)
+{
+	int i;
+
+	for (i = 0; i < len; i += 1) {
+		unsigned short tag = tag_buf[i];
+
+		if (!__ublk_batch_prep_dispatch(ubq, data, tag))
+			tag_buf[i] = UBLK_BATCH_IO_UNUSED_TAG;
+	}
+}
+
+#define MAX_NR_TAG 128
+static int __ublk_batch_dispatch(struct ublk_queue *ubq,
+				 const struct ublk_batch_io_data *data,
+				 struct ublk_batch_fcmd *fcmd)
+{
+	unsigned short tag_buf[MAX_NR_TAG];
+	struct io_br_sel sel;
+	size_t len = 0;
+	int ret;
+
+	sel = io_uring_cmd_buffer_select(fcmd->cmd, fcmd->buf_group, &len,
+					 data->issue_flags);
+	if (sel.val < 0)
+		return sel.val;
+	if (!sel.addr)
+		return -ENOBUFS;
+
+	/* single reader needn't lock and sizeof(kfifo element) is 2 bytes */
+	len = min(len, sizeof(tag_buf)) / 2;
+	len = kfifo_out(&ubq->evts_fifo, tag_buf, len);
+
+	ublk_batch_prep_dispatch(ubq, data, tag_buf, len);
+
+	sel.val = ublk_batch_copy_io_tags(fcmd, sel.addr, tag_buf, len * 2);
+	ret = ublk_batch_fetch_post_cqe(fcmd, &sel, data->issue_flags);
+	if (unlikely(ret < 0)) {
+		int res = kfifo_in_spinlocked_noirqsave(&ubq->evts_fifo,
+			tag_buf, len, &ubq->evts_lock);
+
+		pr_warn("%s: copy tags or post CQE failure, move back "
+				"tags(%d %zu) ret %d\n", __func__, res, len,
+				ret);
+	}
+	return ret;
+}
+
+static __maybe_unused int
+ublk_batch_dispatch(struct ublk_queue *ubq,
+		    const struct ublk_batch_io_data *data,
+		    struct ublk_batch_fcmd *fcmd)
+{
+	int ret = 0;
+
+	while (!ublk_io_evts_empty(ubq)) {
+		ret = __ublk_batch_dispatch(ubq, data, fcmd);
+		if (ret <= 0)
+			break;
+	}
+
+	if (ret < 0)
+		ublk_batch_deinit_fetch_buf(data, fcmd, ret);
+
+	return ret;
+}
+
 static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
 			   unsigned int issue_flags)
 {
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 295ec8f34173..a56a50bbb00a 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -553,6 +553,12 @@ struct ublk_elem_header {
 	__s32 result;	/* I/O completion result (commit only) */
 };
 
+/*
+ * If this tag value is observed from buffer of `UBLK_U_IO_FETCH_IO_CMDS`
+ * ublk server can simply ignore it
+ */
+#define UBLK_BATCH_IO_UNUSED_TAG 	(__u16)(-1)
+
 /*
  * uring_cmd buffer structure for batch commands
  *
-- 
2.47.0

