Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE8C327213
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573192; cv=none; b=b5cYaQYfTXMFDJnf4vN8WKAbl4U2G7l7tIX0sGS5ia6Rk6wZxYKpyYaPzw3s7Zv2GFj5ye10p6ccX7Vn80ghSHhRzAJe90/SGLy4izaMQn3KCitbyNEqrJ301cMX3kq+VEWxVKVjK+pEoB7wcl0/3bOI7KxZw6OmNnEg4O/y5tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573192; c=relaxed/simple;
	bh=pq3E6p9Q0zyRroHdVF7EsXJLgeeG4M3mv2L0BPbWtRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7OlUQPDIaG0YrtBVHAsyTnwl/gbXiEEbyUgLCTL/TW0PEts1KE3F3Fpc+qZT1MQGqSvlzASqEXpF/Wb0m1fi1QC8Z9Rx58OIVKLi28jTSYc3ItshLTMRHLQpFmpceOaXccY2e4RwVYNIeNNEm4dV2SI6nNytL4bC0+8uxn4V2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XsDUYiNC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XsDUYiNC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768573189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uYfk2wEraGXxLe6P3WDCY/3cJuH2tzESi2KegkrZUdk=;
	b=XsDUYiNCiPRFAXIBc8YhuiPAjpgb/jBe2tAJ575WMX4BBRKT1KAwpoEXTN/9bWmCm5fIYA
	GbU+7PmWIkWtCfNUtamKdtcelkEamO8BQ7469V+Lyb2DzXBG2UZHRAkwk25/lfBeswYb21
	C8l06O7rg5tAT/ruCuYPn4xVq2VqSQY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-QYW0QVhIPAWXNNJVTT1iww-1; Fri,
 16 Jan 2026 09:19:46 -0500
X-MC-Unique: QYW0QVhIPAWXNNJVTT1iww-1
X-Mimecast-MFC-AGG-ID: QYW0QVhIPAWXNNJVTT1iww_1768573184
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB5B21956054;
	Fri, 16 Jan 2026 14:19:43 +0000 (UTC)
Received: from localhost (unknown [10.72.116.198])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE0AD18007D2;
	Fri, 16 Jan 2026 14:19:42 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 07/24] ublk: add batch I/O dispatch infrastructure
Date: Fri, 16 Jan 2026 22:18:40 +0800
Message-ID: <20260116141859.719929-8-ming.lei@redhat.com>
In-Reply-To: <20260116141859.719929-1-ming.lei@redhat.com>
References: <20260116141859.719929-1-ming.lei@redhat.com>
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

- struct ublk_batch_fetch_cmd: Represents a batch fetch uring_cmd that will
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

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 195 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 195 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e5db5a552357..e7bd7e7b1731 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -97,6 +97,12 @@
 	 UBLK_BATCH_F_HAS_BUF_ADDR | \
 	 UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK)
 
+/* ublk batch fetch uring_cmd */
+struct ublk_batch_fetch_cmd {
+	struct io_uring_cmd *cmd;
+	unsigned short buf_group;
+};
+
 struct ublk_uring_cmd_pdu {
 	/*
 	 * Store requests in same batch temporarily for queuing them to
@@ -174,6 +180,9 @@ struct ublk_batch_io_data {
  */
 #define UBLK_REFCOUNT_INIT (REFCOUNT_MAX / 2)
 
+/* used for UBLK_F_BATCH_IO only */
+#define UBLK_BATCH_IO_UNUSED_TAG	((unsigned short)-1)
+
 union ublk_io_buf {
 	__u64	addr;
 	struct ublk_auto_buf_reg auto_reg;
@@ -656,6 +665,32 @@ static wait_queue_head_t ublk_idr_wq;	/* wait until one idr is freed */
 static DEFINE_MUTEX(ublk_ctl_mutex);
 
 
+static void ublk_batch_deinit_fetch_buf(const struct ublk_batch_io_data *data,
+					struct ublk_batch_fetch_cmd *fcmd,
+					int res)
+{
+	io_uring_cmd_done(fcmd->cmd, res, data->issue_flags);
+	fcmd->cmd = NULL;
+}
+
+static int ublk_batch_fetch_post_cqe(struct ublk_batch_fetch_cmd *fcmd,
+				     struct io_br_sel *sel,
+				     unsigned int issue_flags)
+{
+	if (io_uring_mshot_cmd_post_cqe(fcmd->cmd, sel, issue_flags))
+		return -ENOBUFS;
+	return 0;
+}
+
+static ssize_t ublk_batch_copy_io_tags(struct ublk_batch_fetch_cmd *fcmd,
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
@@ -1522,6 +1557,166 @@ static void ublk_dispatch_req(struct ublk_queue *ubq, struct request *req)
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
+	if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req)) {
+		res = __ublk_do_auto_buf_reg(ubq, req, io, cmd,
+				data->issue_flags);
+
+		if (res == AUTO_BUF_REG_FAIL)
+			return false;
+	}
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
+	unsigned int i;
+
+	for (i = 0; i < len; i++) {
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
+				 struct ublk_batch_fetch_cmd *fcmd)
+{
+	const unsigned int tag_sz = sizeof(unsigned short);
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
+	len = min(len, sizeof(tag_buf)) / tag_sz;
+	len = kfifo_out(&ubq->evts_fifo, tag_buf, len);
+
+	needs_filter = ublk_batch_prep_dispatch(ubq, data, tag_buf, len);
+	/* Filter out unused tags before posting to userspace */
+	if (unlikely(needs_filter)) {
+		int new_len = ublk_filter_unused_tags(tag_buf, len);
+
+		/* return actual length if all are failed or requeued */
+		if (!new_len) {
+			/* release the selected buffer */
+			sel.val = 0;
+			WARN_ON_ONCE(!io_uring_mshot_cmd_post_cqe(fcmd->cmd,
+						&sel, data->issue_flags));
+			return len;
+		}
+		len = new_len;
+	}
+
+	sel.val = ublk_batch_copy_io_tags(fcmd, sel.addr, tag_buf, len * tag_sz);
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
+		pr_warn_ratelimited("%s: copy tags or post CQE failure, move back "
+				"tags(%d %zu) ret %d\n", __func__, res, len,
+				ret);
+	}
+	return ret;
+}
+
+static __maybe_unused void
+ublk_batch_dispatch(struct ublk_queue *ubq,
+		    const struct ublk_batch_io_data *data,
+		    struct ublk_batch_fetch_cmd *fcmd)
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
+}
+
 static void ublk_cmd_tw_cb(struct io_tw_req tw_req, io_tw_token_t tw)
 {
 	struct io_uring_cmd *cmd = io_uring_cmd_from_tw(tw_req);
-- 
2.47.0

