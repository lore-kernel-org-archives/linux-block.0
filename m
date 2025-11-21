Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477472BEC5F
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 02:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690402; cv=none; b=dyVGnlWrnsPvU2mi3Wo7h5JL4xtR46FDIocotCSg7Rr52T+uzbH2GxMArcUlJKYGSUPQTRux7ovQp4XNZ0xM59iDEAIRBvQVGh8fUS5dgP6XJ7bHHUU1U7Bks1w/OTU635wkt1lkTI7dHJhVPam/wJBid3XozaUcY20jXvQ3jtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690402; c=relaxed/simple;
	bh=AbFJ1DV82wHy9v2F+sPPlfbaAqosms/ezZTSgb3MceA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHjdCC1nlAvKV2pAqaxEIfssUBX1X29TCWCblMAztji3YOc3R4w4eSuMH2YEgMJeqGHC0ysNZSwaXajMOFFCYf9VnTJ7i7lycBCgVyNFDW7rikVaX92pJAdluHC92dBbqKNbCwV9vFQpSy5DUpJqkZ5IIapKKSc3p5atvkyVVHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NAlH3MUt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAlH3MUt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763690399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MwI8giRM7oA7xbL4F/ys7eykoL20MQlNafaZl3D58sA=;
	b=NAlH3MUttEKN0NWFApJ8MMFk/DYs4NsieHOZSVClPbvxOZMI1QnOliMtdne3PYMClYCCXb
	xSotmV2noYSuNlHo+2nsiP2242uNds71Lo9pODb0f/qhj0gujNqUIuQs4JCTbQ3wXwJFv4
	vZhx1TbNSmSkcTvyftFxjl3qPiiSQpE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-4UpknkH3N9aKno40MONbqw-1; Thu,
 20 Nov 2025 20:59:57 -0500
X-MC-Unique: 4UpknkH3N9aKno40MONbqw-1
X-Mimecast-MFC-AGG-ID: 4UpknkH3N9aKno40MONbqw_1763690396
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36F951800342;
	Fri, 21 Nov 2025 01:59:56 +0000 (UTC)
Received: from localhost (unknown [10.72.116.211])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5190E1800451;
	Fri, 21 Nov 2025 01:59:54 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 13/27] ublk: add batch I/O dispatch infrastructure
Date: Fri, 21 Nov 2025 09:58:35 +0800
Message-ID: <20251121015851.3672073-14-ming.lei@redhat.com>
In-Reply-To: <20251121015851.3672073-1-ming.lei@redhat.com>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
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
posting fails, undelivered tags are restored to the FIFO for retry,
meantime IO state has to be restored.

This runs in task work context, scheduled via io_uring_cmd_complete_in_task()
or called directly from ->uring_cmd(), enabling efficient batch processing
without blocking the I/O submission path.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 189 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6ff284243630..cc9c92d97349 100644
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
@@ -168,6 +174,9 @@ struct ublk_batch_io_data {
  */
 #define UBLK_REFCOUNT_INIT (REFCOUNT_MAX / 2)
 
+/* used for UBLK_F_BATCH_IO only */
+#define UBLK_BATCH_IO_UNUSED_TAG	((unsigned short)-1)
+
 union ublk_io_buf {
 	__u64	addr;
 	struct ublk_auto_buf_reg auto_reg;
@@ -616,6 +625,32 @@ static wait_queue_head_t ublk_idr_wq;	/* wait until one idr is freed */
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
@@ -1378,6 +1413,160 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
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
+	if (res == AUTO_BUF_REG_FAIL)
+		return false;
+
+	ublk_io_lock(io);
+	ublk_prep_auto_buf_reg_io(ubq, req, io, cmd, res);
+	ublk_io_unlock(io);
+
+	return true;
+}
+
+static bool ublk_batch_prep_dispatch(struct ublk_queue *ubq,
+				     const struct ublk_batch_io_data *data,
+				     unsigned short *tag_buf,
+				     unsigned int len)
+{
+	bool has_unused = false;
+	int i;
+
+	for (i = 0; i < len; i += 1) {
+		unsigned short tag = tag_buf[i];
+
+		if (!__ublk_batch_prep_dispatch(ubq, data, tag)) {
+			tag_buf[i] = UBLK_BATCH_IO_UNUSED_TAG;
+			has_unused = true;
+		}
+	}
+
+	return has_unused;
+}
+
+/*
+ * Filter out UBLK_BATCH_IO_UNUSED_TAG entries from tag_buf.
+ * Returns the new length after filtering.
+ */
+static unsigned int ublk_filter_unused_tags(unsigned short *tag_buf,
+					    unsigned int len)
+{
+	unsigned int i, j;
+
+	for (i = 0, j = 0; i < len; i++) {
+		if (tag_buf[i] != UBLK_BATCH_IO_UNUSED_TAG) {
+			if (i != j)
+				tag_buf[j] = tag_buf[i];
+			j++;
+		}
+	}
+
+	return j;
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
+	bool needs_filter;
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
+	needs_filter = ublk_batch_prep_dispatch(ubq, data, tag_buf, len);
+	/* Filter out unused tags before posting to userspace */
+	if (unlikely(needs_filter)) {
+		int new_len = ublk_filter_unused_tags(tag_buf, len);
+
+		if (!new_len)
+			return len;
+		len = new_len;
+	}
+
+	sel.val = ublk_batch_copy_io_tags(fcmd, sel.addr, tag_buf, len * 2);
+	ret = ublk_batch_fetch_post_cqe(fcmd, &sel, data->issue_flags);
+	if (unlikely(ret < 0)) {
+		int i, res;
+
+		/*
+		 * Undo prep state for all IOs since userspace never received them.
+		 * This restores IOs to pre-prepared state so they can be cleanly
+		 * re-prepared when tags are pulled from FIFO again.
+		 */
+		for (i = 0; i < len; i++) {
+			struct ublk_io *io = &ubq->ios[tag_buf[i]];
+			int index = -1;
+
+			ublk_io_lock(io);
+			if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG)
+				index = io->buf.auto_reg.index;
+			io->flags &= ~(UBLK_IO_FLAG_OWNED_BY_SRV | UBLK_IO_FLAG_AUTO_BUF_REG);
+			io->flags |= UBLK_IO_FLAG_ACTIVE;
+			ublk_io_unlock(io);
+
+			if (index != -1)
+				io_buffer_unregister_bvec(data->cmd, index,
+						data->issue_flags);
+		}
+
+		res = kfifo_in_spinlocked_noirqsave(&ubq->evts_fifo,
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
-- 
2.47.0

