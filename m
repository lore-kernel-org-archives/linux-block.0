Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9FA8836
	for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752417337; cv=none; b=LKOThaMLZ/z3dqsxn/fe9Ad0rCwnYUg9tWFRpEvcmrAsZA8zmRd9/S60NarNX8Z76OIkWTscyH9uUdH5A1jnX/PSAKN6L4uKWDOn7lwkWmjPFF3n/5nYqe3/tMXy1tr9qYhRSu7EMYgs0PWJpaQSE2thqUjRHU9QrwiNuDRm654=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752417337; c=relaxed/simple;
	bh=0xnOJuqda7cPNycfeK6piOE4lj8B2/PWZjhE2f/j3Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9nAyYXEbS/GvD+2VmYEBeRRW+VlUHZcHrOA3X3Gu9wy9TV7N/iV9iiEU5tRzlvsGosQvT+iSpKTTdC6b7HDQyc/KhKoM28tOGwdmlBr01GJTCXKuWDhgu/Rm+WKxfUbz9EYUXPOyV7u+AWJRnOFxjK+F2dyJSTMrt/Sgzakx+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q7+rB2XF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7+rB2XF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752417335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4CJtTCY3I0VAs+W9hACNFAI+04BsW+QJkhTkHZNCHZ4=;
	b=Q7+rB2XF8g60Ny+/k5KAdiFkErbGwEiWXIe5v8u2T4fG8gL4jorSdk1AAp0KXY1Zq2H9Y2
	GC6qi5tyf5xAAoEH66tfIBSA2BfVwlpMN5MgxbrBpdNQvCHLnApuRsQs6liHFZN24UYIoP
	9PDhxm4oJ/uzQvbCBYNskLmaqQwg7tc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-pLquiUpENFWBiWlFrBxEYw-1; Sun,
 13 Jul 2025 10:35:32 -0400
X-MC-Unique: pLquiUpENFWBiWlFrBxEYw-1
X-Mimecast-MFC-AGG-ID: pLquiUpENFWBiWlFrBxEYw_1752417331
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3792180028B;
	Sun, 13 Jul 2025 14:35:31 +0000 (UTC)
Received: from localhost (unknown [10.72.116.36])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA1D019560A3;
	Sun, 13 Jul 2025 14:35:30 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 13/17] selftests: ublk: pass 'ublk_thread *' to more common helpers
Date: Sun, 13 Jul 2025 22:34:08 +0800
Message-ID: <20250713143415.2857561-14-ming.lei@redhat.com>
In-Reply-To: <20250713143415.2857561-1-ming.lei@redhat.com>
References: <20250713143415.2857561-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Pass 'ublk_thread *' to more common helpers, then we can avoid to store
this reference into 'struct ublk_io'.

Prepare for supporting to handle IO via different task context.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/fault_inject.c |  6 +++---
 tools/testing/selftests/ublk/file_backed.c  |  6 +++---
 tools/testing/selftests/ublk/kublk.c        | 11 ++++-------
 tools/testing/selftests/ublk/kublk.h        | 20 +++++++++++---------
 tools/testing/selftests/ublk/null.c         |  8 ++++----
 tools/testing/selftests/ublk/stripe.c       |  6 +++---
 6 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/ublk/fault_inject.c b/tools/testing/selftests/ublk/fault_inject.c
index b4e9355e0eab..b227bd78b252 100644
--- a/tools/testing/selftests/ublk/fault_inject.c
+++ b/tools/testing/selftests/ublk/fault_inject.c
@@ -51,7 +51,7 @@ static int ublk_fault_inject_queue_io(struct ublk_thread *t,
 	io_uring_prep_timeout(sqe, &ts, 1, 0);
 	sqe->user_data = build_user_data(tag, ublksrv_get_op(iod), 0, q->q_id, 1);
 
-	ublk_queued_tgt_io(q, tag, 1);
+	ublk_queued_tgt_io(t, q, tag, 1);
 
 	return 0;
 }
@@ -66,8 +66,8 @@ static void ublk_fault_inject_tgt_io_done(struct ublk_thread *t,
 	if (cqe->res != -ETIME)
 		ublk_err("%s: unexpected cqe res %d\n", __func__, cqe->res);
 
-	if (ublk_completed_tgt_io(q, tag))
-		ublk_complete_io(q, tag, iod->nr_sectors << 9);
+	if (ublk_completed_tgt_io(t, q, tag))
+		ublk_complete_io(t, q, tag, iod->nr_sectors << 9);
 	else
 		ublk_err("%s: io not complete after 1 cqe\n", __func__);
 }
diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index eeac7af2230f..2d93ac860bd5 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -107,7 +107,7 @@ static int ublk_loop_queue_io(struct ublk_thread *t, struct ublk_queue *q,
 {
 	int queued = loop_queue_tgt_io(t, q, tag);
 
-	ublk_queued_tgt_io(q, tag, queued);
+	ublk_queued_tgt_io(t, q, tag, queued);
 	return 0;
 }
 
@@ -130,8 +130,8 @@ static void ublk_loop_io_done(struct ublk_thread *t, struct ublk_queue *q,
 	if (op == ublk_cmd_op_nr(UBLK_U_IO_REGISTER_IO_BUF))
 		io->tgt_ios += 1;
 
-	if (ublk_completed_tgt_io(q, tag))
-		ublk_complete_io(q, tag, io->result);
+	if (ublk_completed_tgt_io(t, q, tag))
+		ublk_complete_io(t, q, tag, io->result);
 }
 
 static int ublk_loop_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 180b6da08eab..944e0806ba05 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -589,9 +589,8 @@ static void ublk_set_auto_buf_reg(const struct ublk_queue *q,
 	sqe->addr = ublk_auto_buf_reg_to_sqe_addr(&buf);
 }
 
-int ublk_queue_io_cmd(struct ublk_io *io)
+int ublk_queue_io_cmd(struct ublk_thread *t, struct ublk_io *io)
 {
-	struct ublk_thread *t = io->t;
 	struct ublk_queue *q = ublk_io_to_queue(io);
 	struct ublksrv_io_cmd *cmd;
 	struct io_uring_sqe *sqe[1];
@@ -685,9 +684,8 @@ static void ublk_submit_fetch_commands(struct ublk_thread *t)
 			int tag = i % dinfo->queue_depth;
 			q = &t->dev->q[q_id];
 			io = &q->ios[tag];
-			io->t = t;
 			io->buf_index = j++;
-			ublk_queue_io_cmd(io);
+			ublk_queue_io_cmd(t, io);
 		}
 	} else {
 		/*
@@ -697,9 +695,8 @@ static void ublk_submit_fetch_commands(struct ublk_thread *t)
 		struct ublk_queue *q = &t->dev->q[t->idx];
 		for (i = 0; i < q->q_depth; i++) {
 			io = &q->ios[i];
-			io->t = t;
 			io->buf_index = i;
-			ublk_queue_io_cmd(io);
+			ublk_queue_io_cmd(t, io);
 		}
 	}
 }
@@ -770,7 +767,7 @@ static void ublk_handle_cqe(struct ublk_thread *t,
 			q->tgt_ops->queue_io(t, q, tag);
 	} else if (cqe->res == UBLK_IO_RES_NEED_GET_DATA) {
 		io->flags |= UBLKSRV_NEED_GET_DATA | UBLKSRV_IO_FREE;
-		ublk_queue_io_cmd(io);
+		ublk_queue_io_cmd(t, io);
 	} else {
 		/*
 		 * COMMIT_REQ will be completed immediately since no fetching
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 91e0286c5ca6..a4049984b055 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -136,7 +136,6 @@ struct ublk_io {
 	unsigned short buf_index;
 	unsigned short tgt_ios;
 	void *private_data;
-	struct ublk_thread *t;
 };
 
 struct ublk_tgt_ops {
@@ -232,7 +231,7 @@ struct ublk_dev {
 
 
 extern unsigned int ublk_dbg_mask;
-extern int ublk_queue_io_cmd(struct ublk_io *io);
+extern int ublk_queue_io_cmd(struct ublk_thread *t, struct ublk_io *io);
 
 
 static inline int ublk_io_auto_zc_fallback(const struct ublksrv_io_desc *iod)
@@ -402,33 +401,36 @@ static inline struct ublk_io *ublk_get_io(struct ublk_queue *q, unsigned tag)
 	return &q->ios[tag];
 }
 
-static inline int ublk_complete_io(struct ublk_queue *q, unsigned tag, int res)
+static inline int ublk_complete_io(struct ublk_thread *t, struct ublk_queue *q,
+				   unsigned tag, int res)
 {
 	struct ublk_io *io = &q->ios[tag];
 
 	ublk_mark_io_done(io, res);
 
-	return ublk_queue_io_cmd(io);
+	return ublk_queue_io_cmd(t, io);
 }
 
-static inline void ublk_queued_tgt_io(struct ublk_queue *q, unsigned tag, int queued)
+static inline void ublk_queued_tgt_io(struct ublk_thread *t, struct ublk_queue *q,
+				      unsigned tag, int queued)
 {
 	if (queued < 0)
-		ublk_complete_io(q, tag, queued);
+		ublk_complete_io(t, q, tag, queued);
 	else {
 		struct ublk_io *io = ublk_get_io(q, tag);
 
-		io->t->io_inflight += queued;
+		t->io_inflight += queued;
 		io->tgt_ios = queued;
 		io->result = 0;
 	}
 }
 
-static inline int ublk_completed_tgt_io(struct ublk_queue *q, unsigned tag)
+static inline int ublk_completed_tgt_io(struct ublk_thread *t,
+					struct ublk_queue *q, unsigned tag)
 {
 	struct ublk_io *io = ublk_get_io(q, tag);
 
-	io->t->io_inflight--;
+	t->io_inflight--;
 
 	return --io->tgt_ios == 0;
 }
diff --git a/tools/testing/selftests/ublk/null.c b/tools/testing/selftests/ublk/null.c
index e29a005fc1cc..452dcc369c8b 100644
--- a/tools/testing/selftests/ublk/null.c
+++ b/tools/testing/selftests/ublk/null.c
@@ -108,8 +108,8 @@ static void ublk_null_io_done(struct ublk_thread *t, struct ublk_queue *q,
 	if (op == ublk_cmd_op_nr(UBLK_U_IO_REGISTER_IO_BUF))
 		io->tgt_ios += 1;
 
-	if (ublk_completed_tgt_io(q, tag))
-		ublk_complete_io(q, tag, io->result);
+	if (ublk_completed_tgt_io(t, q, tag))
+		ublk_complete_io(t, q, tag, io->result);
 }
 
 static int ublk_null_queue_io(struct ublk_thread *t, struct ublk_queue *q,
@@ -125,10 +125,10 @@ static int ublk_null_queue_io(struct ublk_thread *t, struct ublk_queue *q,
 	else if (zc)
 		queued = null_queue_zc_io(t, q, tag);
 	else {
-		ublk_complete_io(q, tag, iod->nr_sectors << 9);
+		ublk_complete_io(t, q, tag, iod->nr_sectors << 9);
 		return 0;
 	}
-	ublk_queued_tgt_io(q, tag, queued);
+	ublk_queued_tgt_io(t, q, tag, queued);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selftests/ublk/stripe.c
index 462fab7492ce..1fb9b7cc281b 100644
--- a/tools/testing/selftests/ublk/stripe.c
+++ b/tools/testing/selftests/ublk/stripe.c
@@ -226,7 +226,7 @@ static int ublk_stripe_queue_io(struct ublk_thread *t, struct ublk_queue *q,
 {
 	int queued = stripe_queue_tgt_io(t, q, tag);
 
-	ublk_queued_tgt_io(q, tag, queued);
+	ublk_queued_tgt_io(t, q, tag, queued);
 	return 0;
 }
 
@@ -262,13 +262,13 @@ static void ublk_stripe_io_done(struct ublk_thread *t, struct ublk_queue *q,
 		}
 	}
 
-	if (ublk_completed_tgt_io(q, tag)) {
+	if (ublk_completed_tgt_io(t, q, tag)) {
 		int res = io->result;
 
 		if (!res)
 			res = iod->nr_sectors << 9;
 
-		ublk_complete_io(q, tag, res);
+		ublk_complete_io(t, q, tag, res);
 
 		free_stripe_array(io->private_data);
 		io->private_data = NULL;
-- 
2.47.0

