Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC90331A52
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573242; cv=none; b=MiiPS5JTEEJfNSwE/elY6gzKaWHw1YwMLjX/lpPYZQ6v//gU80f/wIP1NTFGxUM7Z2Xb+RYpLOoeGaFRebeWyhRNYlvAVesy3/NWvJe+nEHSez1HTID+5N/IN9HPfz3Fqmi3z1CdO1e7QejlVLnToa5v/Q/Q2s8aBu1J7cUse8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573242; c=relaxed/simple;
	bh=FnJ9PID8abbMapJUVZ8m4GwHTNSCCk+t11h9GO1tmnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvyCtVtx39QWfAnOs1/ZJ0F95NcKu2K6S1xfvInRZIhELgKx7QQ95xZF5Ji5O710Dw94FlgO7HSxxxUACjnfjJ6gBJtkZkUg8hDfINSD6muRwtSgo53lGe2o7vtrBONjPZjbv6hbOCbTIHpwypOpRNU7smdlHBdr/EbN814lfl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6knCn22; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6knCn22"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768573238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vXLMj0CvvBzflkwpA4K0fwEGo7nmcdWjePH1Jj9Cwd4=;
	b=d6knCn22N9ByOGnbN4dxGlktV/taGomivtgwtCvhjKbiZWtfB34v7fxwZfdfCVnY05B6ME
	HobIwuIodcKNCapgFRhEm0lwT+xwdfIhjqsAPc/Zrm2eHAYrk2BrJO694h02PldbmQvaa3
	EiA23xJ9PZLeenRqdOJKJjEkXGHAueo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-EUIvpLfmP3aXiKxxlIcPkw-1; Fri,
 16 Jan 2026 09:20:29 -0500
X-MC-Unique: EUIvpLfmP3aXiKxxlIcPkw-1
X-Mimecast-MFC-AGG-ID: EUIvpLfmP3aXiKxxlIcPkw_1768573228
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 57F431956060;
	Fri, 16 Jan 2026 14:20:28 +0000 (UTC)
Received: from localhost (unknown [10.72.116.198])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 44B6A1955F22;
	Fri, 16 Jan 2026 14:20:26 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 17/24] selftests: ublk: add ublk_io_buf_idx() for returning io buffer index
Date: Fri, 16 Jan 2026 22:18:50 +0800
Message-ID: <20260116141859.719929-18-ming.lei@redhat.com>
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

Since UBLK_F_PER_IO_DAEMON is added, io buffer index may depend on current
thread because the common way is to use per-pthread io_ring_ctx for issuing
ublk uring_cmd.

Add one helper for returning io buffer index, so we can hide the buffer
index implementation details for target code.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/file_backed.c |  9 +++++----
 tools/testing/selftests/ublk/kublk.c       |  9 +++++----
 tools/testing/selftests/ublk/kublk.h       | 10 +++++++++-
 tools/testing/selftests/ublk/null.c        | 18 ++++++++++--------
 tools/testing/selftests/ublk/stripe.c      |  7 ++++---
 5 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index 889047bd8fa3..228af2580ac6 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -39,6 +39,7 @@ static int loop_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 	__u32 len = iod->nr_sectors << 9;
 	struct io_uring_sqe *sqe[3];
 	void *addr = io->buf_addr;
+	unsigned short buf_index = ublk_io_buf_idx(t, q, tag);
 
 	if (iod->op_flags & UBLK_IO_F_INTEGRITY) {
 		ublk_io_alloc_sqes(t, sqe, 1);
@@ -62,7 +63,7 @@ static int loop_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 				len,
 				offset);
 		if (auto_zc)
-			sqe[0]->buf_index = tag;
+			sqe[0]->buf_index = buf_index;
 		io_uring_sqe_set_flags(sqe[0], IOSQE_FIXED_FILE);
 		/* bit63 marks us as tgt io */
 		sqe[0]->user_data = build_user_data(tag, ublk_op, 0, q->q_id, 1);
@@ -71,7 +72,7 @@ static int loop_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 
 	ublk_io_alloc_sqes(t, sqe, 3);
 
-	io_uring_prep_buf_register(sqe[0], q, tag, q->q_id, io->buf_index);
+	io_uring_prep_buf_register(sqe[0], q, tag, q->q_id, buf_index);
 	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
 	sqe[0]->user_data = build_user_data(tag,
 			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
@@ -79,11 +80,11 @@ static int loop_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 	io_uring_prep_rw(op, sqe[1], ublk_get_registered_fd(q, 1) /*fds[1]*/, 0,
 			len,
 			offset);
-	sqe[1]->buf_index = tag;
+	sqe[1]->buf_index = buf_index;
 	sqe[1]->flags |= IOSQE_FIXED_FILE | IOSQE_IO_HARDLINK;
 	sqe[1]->user_data = build_user_data(tag, ublk_op, 0, q->q_id, 1);
 
-	io_uring_prep_buf_unregister(sqe[2], q, tag, q->q_id, io->buf_index);
+	io_uring_prep_buf_unregister(sqe[2], q, tag, q->q_id, buf_index);
 	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, q->q_id, 1);
 
 	return !!(iod->op_flags & UBLK_IO_F_INTEGRITY) + 2;
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 08ba094df64d..51c4e20898a7 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -605,16 +605,17 @@ static void ublk_dev_unprep(struct ublk_dev *dev)
 	close(dev->fds[0]);
 }
 
-static void ublk_set_auto_buf_reg(const struct ublk_queue *q,
+static void ublk_set_auto_buf_reg(const struct ublk_thread *t,
+				  const struct ublk_queue *q,
 				  struct io_uring_sqe *sqe,
 				  unsigned short tag)
 {
 	struct ublk_auto_buf_reg buf = {};
 
 	if (q->tgt_ops->buf_index)
-		buf.index = q->tgt_ops->buf_index(q, tag);
+		buf.index = q->tgt_ops->buf_index(t, q, tag);
 	else
-		buf.index = q->ios[tag].buf_index;
+		buf.index = ublk_io_buf_idx(t, q, tag);
 
 	if (ublk_queue_auto_zc_fallback(q))
 		buf.flags = UBLK_AUTO_BUF_REG_FALLBACK;
@@ -730,7 +731,7 @@ int ublk_queue_io_cmd(struct ublk_thread *t, struct ublk_io *io)
 		cmd->addr	= 0;
 
 	if (ublk_queue_use_auto_zc(q))
-		ublk_set_auto_buf_reg(q, sqe[0], io->tag);
+		ublk_set_auto_buf_reg(t, q, sqe[0], io->tag);
 
 	user_data = build_user_data(io->tag, _IOC_NR(cmd_op), 0, q->q_id, 0);
 	io_uring_sqe_set_data64(sqe[0], user_data);
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 48634d29c084..311a75da9b21 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -150,7 +150,8 @@ struct ublk_tgt_ops {
 	void (*usage)(const struct ublk_tgt_ops *ops);
 
 	/* return buffer index for UBLK_F_AUTO_BUF_REG */
-	unsigned short (*buf_index)(const struct ublk_queue *, int tag);
+	unsigned short (*buf_index)(const struct ublk_thread *t,
+			const struct ublk_queue *, int tag);
 };
 
 struct ublk_tgt {
@@ -393,6 +394,13 @@ static inline void ublk_set_sqe_cmd_op(struct io_uring_sqe *sqe, __u32 cmd_op)
 	addr[1] = 0;
 }
 
+static inline unsigned short ublk_io_buf_idx(const struct ublk_thread *t,
+					     const struct ublk_queue *q,
+					     unsigned tag)
+{
+	return q->ios[tag].buf_index;
+}
+
 static inline struct ublk_io *ublk_get_io(struct ublk_queue *q, unsigned tag)
 {
 	return &q->ios[tag];
diff --git a/tools/testing/selftests/ublk/null.c b/tools/testing/selftests/ublk/null.c
index 3aa162f08476..7656888f4149 100644
--- a/tools/testing/selftests/ublk/null.c
+++ b/tools/testing/selftests/ublk/null.c
@@ -44,12 +44,12 @@ static int ublk_null_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 }
 
 static void __setup_nop_io(int tag, const struct ublksrv_io_desc *iod,
-		struct io_uring_sqe *sqe, int q_id)
+		struct io_uring_sqe *sqe, int q_id, unsigned buf_idx)
 {
 	unsigned ublk_op = ublksrv_get_op(iod);
 
 	io_uring_prep_nop(sqe);
-	sqe->buf_index = tag;
+	sqe->buf_index = buf_idx;
 	sqe->flags |= IOSQE_FIXED_FILE;
 	sqe->rw_flags = IORING_NOP_FIXED_BUFFER | IORING_NOP_INJECT_RESULT;
 	sqe->len = iod->nr_sectors << 9; 	/* injected result */
@@ -61,18 +61,19 @@ static int null_queue_zc_io(struct ublk_thread *t, struct ublk_queue *q,
 {
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
 	struct io_uring_sqe *sqe[3];
+	unsigned short buf_idx = ublk_io_buf_idx(t, q, tag);
 
 	ublk_io_alloc_sqes(t, sqe, 3);
 
-	io_uring_prep_buf_register(sqe[0], q, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
+	io_uring_prep_buf_register(sqe[0], q, tag, q->q_id, buf_idx);
 	sqe[0]->user_data = build_user_data(tag,
 			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
 	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
 
-	__setup_nop_io(tag, iod, sqe[1], q->q_id);
+	__setup_nop_io(tag, iod, sqe[1], q->q_id, buf_idx);
 	sqe[1]->flags |= IOSQE_IO_HARDLINK;
 
-	io_uring_prep_buf_unregister(sqe[2], q, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
+	io_uring_prep_buf_unregister(sqe[2], q, tag, q->q_id, buf_idx);
 	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, q->q_id, 1);
 
 	// buf register is marked as IOSQE_CQE_SKIP_SUCCESS
@@ -86,7 +87,7 @@ static int null_queue_auto_zc_io(struct ublk_thread *t, struct ublk_queue *q,
 	struct io_uring_sqe *sqe[1];
 
 	ublk_io_alloc_sqes(t, sqe, 1);
-	__setup_nop_io(tag, iod, sqe[0], q->q_id);
+	__setup_nop_io(tag, iod, sqe[0], q->q_id, ublk_io_buf_idx(t, q, tag));
 	return 1;
 }
 
@@ -137,11 +138,12 @@ static int ublk_null_queue_io(struct ublk_thread *t, struct ublk_queue *q,
  * return invalid buffer index for triggering auto buffer register failure,
  * then UBLK_IO_RES_NEED_REG_BUF handling is covered
  */
-static unsigned short ublk_null_buf_index(const struct ublk_queue *q, int tag)
+static unsigned short ublk_null_buf_index(const struct ublk_thread *t,
+		const struct ublk_queue *q, int tag)
 {
 	if (ublk_queue_auto_zc_fallback(q))
 		return (unsigned short)-1;
-	return q->ios[tag].buf_index;
+	return ublk_io_buf_idx(t, q, tag);
 }
 
 const struct ublk_tgt_ops null_tgt_ops = {
diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selftests/ublk/stripe.c
index b967447fe591..dca819f5366e 100644
--- a/tools/testing/selftests/ublk/stripe.c
+++ b/tools/testing/selftests/ublk/stripe.c
@@ -135,6 +135,7 @@ static int stripe_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 	struct ublk_io *io = ublk_get_io(q, tag);
 	int i, extra = zc ? 2 : 0;
 	void *base = io->buf_addr;
+	unsigned short buf_idx = ublk_io_buf_idx(t, q, tag);
 
 	io->private_data = s;
 	calculate_stripe_array(conf, iod, s, base);
@@ -142,7 +143,7 @@ static int stripe_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 	ublk_io_alloc_sqes(t, sqe, s->nr + extra);
 
 	if (zc) {
-		io_uring_prep_buf_register(sqe[0], q, tag, q->q_id, io->buf_index);
+		io_uring_prep_buf_register(sqe[0], q, tag, q->q_id, buf_idx);
 		sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
 		sqe[0]->user_data = build_user_data(tag,
 			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
@@ -158,7 +159,7 @@ static int stripe_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 				t->start << 9);
 		io_uring_sqe_set_flags(sqe[i], IOSQE_FIXED_FILE);
 		if (auto_zc || zc) {
-			sqe[i]->buf_index = tag;
+			sqe[i]->buf_index = buf_idx;
 			if (zc)
 				sqe[i]->flags |= IOSQE_IO_HARDLINK;
 		}
@@ -168,7 +169,7 @@ static int stripe_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 	if (zc) {
 		struct io_uring_sqe *unreg = sqe[s->nr + 1];
 
-		io_uring_prep_buf_unregister(unreg, q, tag, q->q_id, io->buf_index);
+		io_uring_prep_buf_unregister(unreg, q, tag, q->q_id, buf_idx);
 		unreg->user_data = build_user_data(
 			tag, ublk_cmd_op_nr(unreg->cmd_op), 0, q->q_id, 1);
 	}
-- 
2.47.0

