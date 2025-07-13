Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DA42798E2
	for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752417338; cv=none; b=WmuZ4sQ4r21ta/LApF+/aGchxfQM3pNwTJ5gB0u51RQEsATa+cyNEmSlqvYoHD/e+1yrb1nzowmqOY1dzG+eDrlrMOpE+6ENyf+qhgbmfY0p3iH2D6UckPOx106/BS7NWTqCtqZZPsOTMbzZz+i+/UXplQmPF8Kb0b/2NJM+b28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752417338; c=relaxed/simple;
	bh=wvZrhmnQPuYI6sCjekbY/IhovBz3LdLREKFiprK1JEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDHLLBd0NxdloYHjEgocBznng6DO0t9ubVgp2ad0ruPFI3akbfSIEsYWesUn0HQr6dDaQ2IfPrzq3WaBI3DJPxGXeb5RliOgtB28+GHEks275QjxXyrHwN19JZ7z8zRcQf6wzZRpaBN/Z6Q8lFUEeHJVN0uR0vg02LrcgFPR3tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BchhrTzB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BchhrTzB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752417336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jcj5QZB3VXoaOCU/A05ncv/3AZ5SaWAglwj16uusQHQ=;
	b=BchhrTzByb3nkoNncxj8pFmNkf6ntjmk4khhIuYFy4SpvCUtpZfqYS8Hk0ajJcV7L2ixc5
	rTNrp6lRT8UHsrmpf7rKNiu9+/dHWp8vFGrnIcWYe9/G+1Z6a+3RZceg6pW8Tc2C1eN/MW
	6094KPg/pxdb79R3VASBkp1PIyNM2uU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-7Z7wFRsCMQusV9GenDNocg-1; Sun,
 13 Jul 2025 10:35:29 -0400
X-MC-Unique: 7Z7wFRsCMQusV9GenDNocg-1
X-Mimecast-MFC-AGG-ID: 7Z7wFRsCMQusV9GenDNocg_1752417327
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8A3518011F9;
	Sun, 13 Jul 2025 14:35:27 +0000 (UTC)
Received: from localhost (unknown [10.72.116.36])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 90681180045C;
	Sun, 13 Jul 2025 14:35:26 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 12/17] selftests: ublk: pass 'ublk_thread *' to ->queue_io() and ->tgt_io_done()
Date: Sun, 13 Jul 2025 22:34:07 +0800
Message-ID: <20250713143415.2857561-13-ming.lei@redhat.com>
In-Reply-To: <20250713143415.2857561-1-ming.lei@redhat.com>
References: <20250713143415.2857561-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

'struct thread' is task local structure, and the related code will become
more readable if we pass it via parameter.

Meantime pass 'ublk_thread *' to ublk_io_alloc_sqes(), and this way is
natural since we use per-thread io_uring for handling IO.

More importantly it helps much for removing the current ubq_daemon or
per-io-task limit.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/fault_inject.c |  8 ++++---
 tools/testing/selftests/ublk/file_backed.c  | 25 +++++++++++---------
 tools/testing/selftests/ublk/kublk.c        | 13 ++++++-----
 tools/testing/selftests/ublk/kublk.h        |  9 +++----
 tools/testing/selftests/ublk/null.c         | 21 ++++++++++-------
 tools/testing/selftests/ublk/stripe.c       | 26 ++++++++++++---------
 6 files changed, 58 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/ublk/fault_inject.c b/tools/testing/selftests/ublk/fault_inject.c
index c980958ec045..b4e9355e0eab 100644
--- a/tools/testing/selftests/ublk/fault_inject.c
+++ b/tools/testing/selftests/ublk/fault_inject.c
@@ -38,7 +38,8 @@ static int ublk_fault_inject_tgt_init(const struct dev_ctx *ctx,
 	return 0;
 }
 
-static int ublk_fault_inject_queue_io(struct ublk_queue *q, int tag)
+static int ublk_fault_inject_queue_io(struct ublk_thread *t,
+				      struct ublk_queue *q, int tag)
 {
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
 	struct io_uring_sqe *sqe;
@@ -46,7 +47,7 @@ static int ublk_fault_inject_queue_io(struct ublk_queue *q, int tag)
 		.tv_nsec = (long long)q->dev->private_data,
 	};
 
-	ublk_io_alloc_sqes(ublk_get_io(q, tag), &sqe, 1);
+	ublk_io_alloc_sqes(t, &sqe, 1);
 	io_uring_prep_timeout(sqe, &ts, 1, 0);
 	sqe->user_data = build_user_data(tag, ublksrv_get_op(iod), 0, q->q_id, 1);
 
@@ -55,7 +56,8 @@ static int ublk_fault_inject_queue_io(struct ublk_queue *q, int tag)
 	return 0;
 }
 
-static void ublk_fault_inject_tgt_io_done(struct ublk_queue *q,
+static void ublk_fault_inject_tgt_io_done(struct ublk_thread *t,
+					  struct ublk_queue *q,
 					  const struct io_uring_cqe *cqe)
 {
 	unsigned tag = user_data_to_tag(cqe->user_data);
diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index 02fb8a411d3b..eeac7af2230f 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -13,12 +13,13 @@ static enum io_uring_op ublk_to_uring_op(const struct ublksrv_io_desc *iod, int
 	assert(0);
 }
 
-static int loop_queue_flush_io(struct ublk_queue *q, const struct ublksrv_io_desc *iod, int tag)
+static int loop_queue_flush_io(struct ublk_thread *t, struct ublk_queue *q,
+			       const struct ublksrv_io_desc *iod, int tag)
 {
 	unsigned ublk_op = ublksrv_get_op(iod);
 	struct io_uring_sqe *sqe[1];
 
-	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 1);
+	ublk_io_alloc_sqes(t, sqe, 1);
 	io_uring_prep_fsync(sqe[0], 1 /*fds[1]*/, IORING_FSYNC_DATASYNC);
 	io_uring_sqe_set_flags(sqe[0], IOSQE_FIXED_FILE);
 	/* bit63 marks us as tgt io */
@@ -26,7 +27,8 @@ static int loop_queue_flush_io(struct ublk_queue *q, const struct ublksrv_io_des
 	return 1;
 }
 
-static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_desc *iod, int tag)
+static int loop_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
+				const struct ublksrv_io_desc *iod, int tag)
 {
 	unsigned ublk_op = ublksrv_get_op(iod);
 	unsigned zc = ublk_queue_use_zc(q);
@@ -36,7 +38,7 @@ static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_de
 	void *addr = (zc | auto_zc) ? NULL : (void *)iod->addr;
 
 	if (!zc || auto_zc) {
-		ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 1);
+		ublk_io_alloc_sqes(t, sqe, 1);
 		if (!sqe[0])
 			return -ENOMEM;
 
@@ -52,7 +54,7 @@ static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_de
 		return 1;
 	}
 
-	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 3);
+	ublk_io_alloc_sqes(t, sqe, 3);
 
 	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
 	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
@@ -72,7 +74,7 @@ static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_de
 	return 2;
 }
 
-static int loop_queue_tgt_io(struct ublk_queue *q, int tag)
+static int loop_queue_tgt_io(struct ublk_thread *t, struct ublk_queue *q, int tag)
 {
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
 	unsigned ublk_op = ublksrv_get_op(iod);
@@ -80,7 +82,7 @@ static int loop_queue_tgt_io(struct ublk_queue *q, int tag)
 
 	switch (ublk_op) {
 	case UBLK_IO_OP_FLUSH:
-		ret = loop_queue_flush_io(q, iod, tag);
+		ret = loop_queue_flush_io(t, q, iod, tag);
 		break;
 	case UBLK_IO_OP_WRITE_ZEROES:
 	case UBLK_IO_OP_DISCARD:
@@ -88,7 +90,7 @@ static int loop_queue_tgt_io(struct ublk_queue *q, int tag)
 		break;
 	case UBLK_IO_OP_READ:
 	case UBLK_IO_OP_WRITE:
-		ret = loop_queue_tgt_rw_io(q, iod, tag);
+		ret = loop_queue_tgt_rw_io(t, q, iod, tag);
 		break;
 	default:
 		ret = -EINVAL;
@@ -100,15 +102,16 @@ static int loop_queue_tgt_io(struct ublk_queue *q, int tag)
 	return ret;
 }
 
-static int ublk_loop_queue_io(struct ublk_queue *q, int tag)
+static int ublk_loop_queue_io(struct ublk_thread *t, struct ublk_queue *q,
+			      int tag)
 {
-	int queued = loop_queue_tgt_io(q, tag);
+	int queued = loop_queue_tgt_io(t, q, tag);
 
 	ublk_queued_tgt_io(q, tag, queued);
 	return 0;
 }
 
-static void ublk_loop_io_done(struct ublk_queue *q,
+static void ublk_loop_io_done(struct ublk_thread *t, struct ublk_queue *q,
 		const struct io_uring_cqe *cqe)
 {
 	unsigned tag = user_data_to_tag(cqe->user_data);
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index fba4e80e9bab..180b6da08eab 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -620,7 +620,7 @@ int ublk_queue_io_cmd(struct ublk_io *io)
 	if (io_uring_sq_space_left(&t->ring) < 1)
 		io_uring_submit(&t->ring);
 
-	ublk_io_alloc_sqes(io, sqe, 1);
+	ublk_io_alloc_sqes(t, sqe, 1);
 	if (!sqe[0]) {
 		ublk_err("%s: run out of sqe. thread %u, tag %d\n",
 				__func__, t->idx, io->tag);
@@ -714,8 +714,9 @@ static int ublk_thread_is_done(struct ublk_thread *t)
 	return (t->state & UBLKSRV_THREAD_STOPPING) && ublk_thread_is_idle(t);
 }
 
-static inline void ublksrv_handle_tgt_cqe(struct ublk_queue *q,
-		struct io_uring_cqe *cqe)
+static inline void ublksrv_handle_tgt_cqe(struct ublk_thread *t,
+					  struct ublk_queue *q,
+					  struct io_uring_cqe *cqe)
 {
 	if (cqe->res < 0 && cqe->res != -EAGAIN)
 		ublk_err("%s: failed tgt io: res %d qid %u tag %u, cmd_op %u\n",
@@ -724,7 +725,7 @@ static inline void ublksrv_handle_tgt_cqe(struct ublk_queue *q,
 			user_data_to_op(cqe->user_data));
 
 	if (q->tgt_ops->tgt_io_done)
-		q->tgt_ops->tgt_io_done(q, cqe);
+		q->tgt_ops->tgt_io_done(t, q, cqe);
 }
 
 static void ublk_handle_cqe(struct ublk_thread *t,
@@ -751,7 +752,7 @@ static void ublk_handle_cqe(struct ublk_thread *t,
 
 	/* Don't retrieve io in case of target io */
 	if (is_target_io(cqe->user_data)) {
-		ublksrv_handle_tgt_cqe(q, cqe);
+		ublksrv_handle_tgt_cqe(t, q, cqe);
 		return;
 	}
 
@@ -766,7 +767,7 @@ static void ublk_handle_cqe(struct ublk_thread *t,
 	if (cqe->res == UBLK_IO_RES_OK) {
 		assert(tag < q->q_depth);
 		if (q->tgt_ops->queue_io)
-			q->tgt_ops->queue_io(q, tag);
+			q->tgt_ops->queue_io(t, q, tag);
 	} else if (cqe->res == UBLK_IO_RES_NEED_GET_DATA) {
 		io->flags |= UBLKSRV_NEED_GET_DATA | UBLKSRV_IO_FREE;
 		ublk_queue_io_cmd(io);
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index d7b711e63822..91e0286c5ca6 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -144,8 +144,9 @@ struct ublk_tgt_ops {
 	int (*init_tgt)(const struct dev_ctx *ctx, struct ublk_dev *);
 	void (*deinit_tgt)(struct ublk_dev *);
 
-	int (*queue_io)(struct ublk_queue *, int tag);
-	void (*tgt_io_done)(struct ublk_queue *, const struct io_uring_cqe *);
+	int (*queue_io)(struct ublk_thread *, struct ublk_queue *, int tag);
+	void (*tgt_io_done)(struct ublk_thread *, struct ublk_queue *,
+			    const struct io_uring_cqe *);
 
 	/*
 	 * Target specific command line handling
@@ -313,10 +314,10 @@ static inline struct ublk_queue *ublk_io_to_queue(const struct ublk_io *io)
 	return container_of(io, struct ublk_queue, ios[io->tag]);
 }
 
-static inline int ublk_io_alloc_sqes(struct ublk_io *io,
+static inline int ublk_io_alloc_sqes(struct ublk_thread *t,
 		struct io_uring_sqe *sqes[], int nr_sqes)
 {
-	struct io_uring *ring = &io->t->ring;
+	struct io_uring *ring = &t->ring;
 	unsigned left = io_uring_sq_space_left(ring);
 	int i;
 
diff --git a/tools/testing/selftests/ublk/null.c b/tools/testing/selftests/ublk/null.c
index ea3da53437e9..e29a005fc1cc 100644
--- a/tools/testing/selftests/ublk/null.c
+++ b/tools/testing/selftests/ublk/null.c
@@ -55,12 +55,13 @@ static void __setup_nop_io(int tag, const struct ublksrv_io_desc *iod,
 	sqe->user_data = build_user_data(tag, ublk_op, 0, q_id, 1);
 }
 
-static int null_queue_zc_io(struct ublk_queue *q, int tag)
+static int null_queue_zc_io(struct ublk_thread *t, struct ublk_queue *q,
+			    int tag)
 {
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
 	struct io_uring_sqe *sqe[3];
 
-	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 3);
+	ublk_io_alloc_sqes(t, sqe, 3);
 
 	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
 	sqe[0]->user_data = build_user_data(tag,
@@ -77,18 +78,19 @@ static int null_queue_zc_io(struct ublk_queue *q, int tag)
 	return 2;
 }
 
-static int null_queue_auto_zc_io(struct ublk_queue *q, int tag)
+static int null_queue_auto_zc_io(struct ublk_thread *t, struct ublk_queue *q,
+				 int tag)
 {
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
 	struct io_uring_sqe *sqe[1];
 
-	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 1);
+	ublk_io_alloc_sqes(t, sqe, 1);
 	__setup_nop_io(tag, iod, sqe[0], q->q_id);
 	return 1;
 }
 
-static void ublk_null_io_done(struct ublk_queue *q,
-		const struct io_uring_cqe *cqe)
+static void ublk_null_io_done(struct ublk_thread *t, struct ublk_queue *q,
+			      const struct io_uring_cqe *cqe)
 {
 	unsigned tag = user_data_to_tag(cqe->user_data);
 	unsigned op = user_data_to_op(cqe->user_data);
@@ -110,7 +112,8 @@ static void ublk_null_io_done(struct ublk_queue *q,
 		ublk_complete_io(q, tag, io->result);
 }
 
-static int ublk_null_queue_io(struct ublk_queue *q, int tag)
+static int ublk_null_queue_io(struct ublk_thread *t, struct ublk_queue *q,
+			      int tag)
 {
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
 	unsigned auto_zc = ublk_queue_use_auto_zc(q);
@@ -118,9 +121,9 @@ static int ublk_null_queue_io(struct ublk_queue *q, int tag)
 	int queued;
 
 	if (auto_zc && !ublk_io_auto_zc_fallback(iod))
-		queued = null_queue_auto_zc_io(q, tag);
+		queued = null_queue_auto_zc_io(t, q, tag);
 	else if (zc)
-		queued = null_queue_zc_io(q, tag);
+		queued = null_queue_zc_io(t, q, tag);
 	else {
 		ublk_complete_io(q, tag, iod->nr_sectors << 9);
 		return 0;
diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selftests/ublk/stripe.c
index 53cefffaf32e..462fab7492ce 100644
--- a/tools/testing/selftests/ublk/stripe.c
+++ b/tools/testing/selftests/ublk/stripe.c
@@ -123,7 +123,8 @@ static inline enum io_uring_op stripe_to_uring_op(
 	assert(0);
 }
 
-static int stripe_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_desc *iod, int tag)
+static int stripe_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
+				  const struct ublksrv_io_desc *iod, int tag)
 {
 	const struct stripe_conf *conf = get_chunk_shift(q);
 	unsigned auto_zc = (ublk_queue_use_auto_zc(q) != 0);
@@ -138,7 +139,7 @@ static int stripe_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_
 	io->private_data = s;
 	calculate_stripe_array(conf, iod, s, base);
 
-	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, s->nr + extra);
+	ublk_io_alloc_sqes(t, sqe, s->nr + extra);
 
 	if (zc) {
 		io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, io->buf_index);
@@ -176,13 +177,14 @@ static int stripe_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_
 	return s->nr + zc;
 }
 
-static int handle_flush(struct ublk_queue *q, const struct ublksrv_io_desc *iod, int tag)
+static int handle_flush(struct ublk_thread *t, struct ublk_queue *q,
+			const struct ublksrv_io_desc *iod, int tag)
 {
 	const struct stripe_conf *conf = get_chunk_shift(q);
 	struct io_uring_sqe *sqe[NR_STRIPE];
 	int i;
 
-	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, conf->nr_files);
+	ublk_io_alloc_sqes(t, sqe, conf->nr_files);
 	for (i = 0; i < conf->nr_files; i++) {
 		io_uring_prep_fsync(sqe[i], i + 1, IORING_FSYNC_DATASYNC);
 		io_uring_sqe_set_flags(sqe[i], IOSQE_FIXED_FILE);
@@ -191,7 +193,8 @@ static int handle_flush(struct ublk_queue *q, const struct ublksrv_io_desc *iod,
 	return conf->nr_files;
 }
 
-static int stripe_queue_tgt_io(struct ublk_queue *q, int tag)
+static int stripe_queue_tgt_io(struct ublk_thread *t, struct ublk_queue *q,
+			       int tag)
 {
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
 	unsigned ublk_op = ublksrv_get_op(iod);
@@ -199,7 +202,7 @@ static int stripe_queue_tgt_io(struct ublk_queue *q, int tag)
 
 	switch (ublk_op) {
 	case UBLK_IO_OP_FLUSH:
-		ret = handle_flush(q, iod, tag);
+		ret = handle_flush(t, q, iod, tag);
 		break;
 	case UBLK_IO_OP_WRITE_ZEROES:
 	case UBLK_IO_OP_DISCARD:
@@ -207,7 +210,7 @@ static int stripe_queue_tgt_io(struct ublk_queue *q, int tag)
 		break;
 	case UBLK_IO_OP_READ:
 	case UBLK_IO_OP_WRITE:
-		ret = stripe_queue_tgt_rw_io(q, iod, tag);
+		ret = stripe_queue_tgt_rw_io(t, q, iod, tag);
 		break;
 	default:
 		ret = -EINVAL;
@@ -218,16 +221,17 @@ static int stripe_queue_tgt_io(struct ublk_queue *q, int tag)
 	return ret;
 }
 
-static int ublk_stripe_queue_io(struct ublk_queue *q, int tag)
+static int ublk_stripe_queue_io(struct ublk_thread *t, struct ublk_queue *q,
+				int tag)
 {
-	int queued = stripe_queue_tgt_io(q, tag);
+	int queued = stripe_queue_tgt_io(t, q, tag);
 
 	ublk_queued_tgt_io(q, tag, queued);
 	return 0;
 }
 
-static void ublk_stripe_io_done(struct ublk_queue *q,
-		const struct io_uring_cqe *cqe)
+static void ublk_stripe_io_done(struct ublk_thread *t, struct ublk_queue *q,
+				const struct io_uring_cqe *cqe)
 {
 	unsigned tag = user_data_to_tag(cqe->user_data);
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
-- 
2.47.0

