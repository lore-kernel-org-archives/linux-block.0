Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6611C84D6
	for <linux-block@vger.kernel.org>; Sat, 22 Mar 2025 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742635966; cv=none; b=NmUp1sLT7Sm7VdGyla5TIAChf+UpD/OgDxQmyMlgrT3r6fw+1wSSChqep5XK+7UAhqsu3bMPCpAZq0rhU8myutctH8t7uRCtQwlraSE3J1sAZ7hjvAbk7p2vz+R4hU2IB8kcCWQ0xZPlVR0InWMlo8cvEaRUexpWMGsdDiHZ6RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742635966; c=relaxed/simple;
	bh=BFGac4n0UU4R91VKsy5/ZL6NLPMSEvGxTy9AE+9XB9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HImn8tLxj6oQiAn1UNb/VYHoKmMBqLAWdjVUzMveyiuc7SbTtBGxTD0eddnWHTWu3Wv5WtAR9GNLLqeWPfS+861qf+z0c4+sANb+SgRimNJ3D8bmuZYpX1KaEcSg0CqcH3j0jWrt/YDEz/BQoZZe6i6+4YVUIk7hdA8L+viVpqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W1tKv8lZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1tKv8lZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742635963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SJRWcL6mtPOjMRd4vlh7un2qBlIOQPEB1/AeR08oMlM=;
	b=W1tKv8lZV/QUVTAPsBsy1aIBJ+CwlImuUjDp+iZBH+Hr2zFS6ni3id6pzg7DZL6iMIQMQ/
	puSidFliS1mt41SMv9CAI8xN4PJzt/rKu1fr2fWrA+McJVYJ+7BaA5fKgbAMezjRlFABfz
	WGGI5j4KVkwcFIk/4vSwyRjx20qmwEc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-S_yQtNrCNY6y_ynjBnoZqQ-1; Sat,
 22 Mar 2025 05:32:39 -0400
X-MC-Unique: S_yQtNrCNY6y_ynjBnoZqQ-1
X-Mimecast-MFC-AGG-ID: S_yQtNrCNY6y_ynjBnoZqQ_1742635959
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E285019560AA;
	Sat, 22 Mar 2025 09:32:38 +0000 (UTC)
Received: from localhost (unknown [10.72.120.5])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CFAF7180175F;
	Sat, 22 Mar 2025 09:32:37 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/8] selftests: ublk: add single sqe allocator helper
Date: Sat, 22 Mar 2025 17:32:10 +0800
Message-ID: <20250322093218.431419-3-ming.lei@redhat.com>
In-Reply-To: <20250322093218.431419-1-ming.lei@redhat.com>
References: <20250322093218.431419-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Unify the sqe allocator helper, and we will use it for supporting
more cases, such as ublk stripe, in which variable sqe allocation
is required.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/file_backed.c | 50 +++++++++++-----------
 tools/testing/selftests/ublk/kublk.c       | 20 ++++-----
 tools/testing/selftests/ublk/kublk.h       | 26 +++++------
 3 files changed, 44 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index 570a5158b665..f58fa4ec9b51 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -69,44 +69,42 @@ static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_de
 {
 	int zc = ublk_queue_use_zc(q);
 	enum io_uring_op op = ublk_to_uring_op(iod, zc);
-	struct io_uring_sqe *reg;
-	struct io_uring_sqe *rw;
-	struct io_uring_sqe *ureg;
+	struct io_uring_sqe *sqe[3];
 
 	if (!zc) {
-		rw = ublk_queue_alloc_sqe(q);
-		if (!rw)
+		ublk_queue_alloc_sqes(q, sqe, 1);
+		if (!sqe[0])
 			return -ENOMEM;
 
-		io_uring_prep_rw(op, rw, 1 /*fds[1]*/,
+		io_uring_prep_rw(op, sqe[0], 1 /*fds[1]*/,
 				(void *)iod->addr,
 				iod->nr_sectors << 9,
 				iod->start_sector << 9);
-		io_uring_sqe_set_flags(rw, IOSQE_FIXED_FILE);
+		io_uring_sqe_set_flags(sqe[0], IOSQE_FIXED_FILE);
 		q->io_inflight++;
 		/* bit63 marks us as tgt io */
-		rw->user_data = build_user_data(tag, op, UBLK_IO_TGT_NORMAL, 1);
+		sqe[0]->user_data = build_user_data(tag, op, UBLK_IO_TGT_NORMAL, 1);
 		return 0;
 	}
 
-	ublk_queue_alloc_sqe3(q, &reg, &rw, &ureg);
+	ublk_queue_alloc_sqes(q, sqe, 3);
 
-	io_uring_prep_buf_register(reg, 0, tag, q->q_id, tag);
-	reg->user_data = build_user_data(tag, 0xfe, 1, 1);
-	reg->flags |= IOSQE_CQE_SKIP_SUCCESS;
-	reg->flags |= IOSQE_IO_LINK;
+	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
+	sqe[0]->user_data = build_user_data(tag, 0xfe, 1, 1);
+	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS;
+	sqe[0]->flags |= IOSQE_IO_LINK;
 
-	io_uring_prep_rw(op, rw, 1 /*fds[1]*/, 0,
+	io_uring_prep_rw(op, sqe[1], 1 /*fds[1]*/, 0,
 		iod->nr_sectors << 9,
 		iod->start_sector << 9);
-	rw->buf_index = tag;
-	rw->flags |= IOSQE_FIXED_FILE;
-	rw->flags |= IOSQE_IO_LINK;
-	rw->user_data = build_user_data(tag, op, UBLK_IO_TGT_ZC_OP, 1);
+	sqe[1]->buf_index = tag;
+	sqe[1]->flags |= IOSQE_FIXED_FILE;
+	sqe[1]->flags |= IOSQE_IO_LINK;
+	sqe[1]->user_data = build_user_data(tag, op, UBLK_IO_TGT_ZC_OP, 1);
 	q->io_inflight++;
 
-	io_uring_prep_buf_unregister(ureg, 0, tag, q->q_id, tag);
-	ureg->user_data = build_user_data(tag, 0xff, UBLK_IO_TGT_ZC_BUF, 1);
+	io_uring_prep_buf_unregister(sqe[2], 0, tag, q->q_id, tag);
+	sqe[2]->user_data = build_user_data(tag, 0xff, UBLK_IO_TGT_ZC_BUF, 1);
 	q->io_inflight++;
 
 	return 0;
@@ -116,17 +114,17 @@ static int loop_queue_tgt_io(struct ublk_queue *q, int tag)
 {
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
 	unsigned ublk_op = ublksrv_get_op(iod);
-	struct io_uring_sqe *sqe;
+	struct io_uring_sqe *sqe[1];
 
 	switch (ublk_op) {
 	case UBLK_IO_OP_FLUSH:
-		sqe = ublk_queue_alloc_sqe(q);
-		if (!sqe)
+		ublk_queue_alloc_sqes(q, sqe, 1);
+		if (!sqe[0])
 			return -ENOMEM;
-		io_uring_prep_fsync(sqe, 1 /*fds[1]*/, IORING_FSYNC_DATASYNC);
-		io_uring_sqe_set_flags(sqe, IOSQE_FIXED_FILE);
+		io_uring_prep_fsync(sqe[0], 1 /*fds[1]*/, IORING_FSYNC_DATASYNC);
+		io_uring_sqe_set_flags(sqe[0], IOSQE_FIXED_FILE);
 		q->io_inflight++;
-		sqe->user_data = build_user_data(tag, ublk_op, UBLK_IO_TGT_NORMAL, 1);
+		sqe[0]->user_data = build_user_data(tag, ublk_op, UBLK_IO_TGT_NORMAL, 1);
 		break;
 	case UBLK_IO_OP_WRITE_ZEROES:
 	case UBLK_IO_OP_DISCARD:
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 11005a87bcfa..0080cad1f3ae 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -420,7 +420,7 @@ static void ublk_dev_unprep(struct ublk_dev *dev)
 int ublk_queue_io_cmd(struct ublk_queue *q, struct ublk_io *io, unsigned tag)
 {
 	struct ublksrv_io_cmd *cmd;
-	struct io_uring_sqe *sqe;
+	struct io_uring_sqe *sqe[1];
 	unsigned int cmd_op = 0;
 	__u64 user_data;
 
@@ -441,24 +441,24 @@ int ublk_queue_io_cmd(struct ublk_queue *q, struct ublk_io *io, unsigned tag)
 	if (io_uring_sq_space_left(&q->ring) < 1)
 		io_uring_submit(&q->ring);
 
-	sqe = ublk_queue_alloc_sqe(q);
-	if (!sqe) {
+	ublk_queue_alloc_sqes(q, sqe, 1);
+	if (!sqe[0]) {
 		ublk_err("%s: run out of sqe %d, tag %d\n",
 				__func__, q->q_id, tag);
 		return -1;
 	}
 
-	cmd = (struct ublksrv_io_cmd *)ublk_get_sqe_cmd(sqe);
+	cmd = (struct ublksrv_io_cmd *)ublk_get_sqe_cmd(sqe[0]);
 
 	if (cmd_op == UBLK_U_IO_COMMIT_AND_FETCH_REQ)
 		cmd->result = io->result;
 
 	/* These fields should be written once, never change */
-	ublk_set_sqe_cmd_op(sqe, cmd_op);
-	sqe->fd		= 0;	/* dev->fds[0] */
-	sqe->opcode	= IORING_OP_URING_CMD;
-	sqe->flags	= IOSQE_FIXED_FILE;
-	sqe->rw_flags	= 0;
+	ublk_set_sqe_cmd_op(sqe[0], cmd_op);
+	sqe[0]->fd		= 0;	/* dev->fds[0] */
+	sqe[0]->opcode	= IORING_OP_URING_CMD;
+	sqe[0]->flags	= IOSQE_FIXED_FILE;
+	sqe[0]->rw_flags	= 0;
 	cmd->tag	= tag;
 	cmd->q_id	= q->q_id;
 	if (!(q->state & UBLKSRV_NO_BUF))
@@ -467,7 +467,7 @@ int ublk_queue_io_cmd(struct ublk_queue *q, struct ublk_io *io, unsigned tag)
 		cmd->addr	= 0;
 
 	user_data = build_user_data(tag, _IOC_NR(cmd_op), 0, 0);
-	io_uring_sqe_set_data64(sqe, user_data);
+	io_uring_sqe_set_data64(sqe[0], user_data);
 
 	io->flags = 0;
 
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 3ff9ac5104a7..9cd7ab62f258 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -221,28 +221,22 @@ static inline void ublk_dbg(int level, const char *fmt, ...)
 	}
 }
 
-static inline struct io_uring_sqe *ublk_queue_alloc_sqe(struct ublk_queue *q)
+static inline int ublk_queue_alloc_sqes(struct ublk_queue *q,
+		struct io_uring_sqe *sqes[], int nr_sqes)
 {
 	unsigned left = io_uring_sq_space_left(&q->ring);
+	int i;
 
-	if (left < 1)
+	if (left < nr_sqes)
 		io_uring_submit(&q->ring);
-	return io_uring_get_sqe(&q->ring);
-}
-
-static inline void ublk_queue_alloc_sqe3(struct ublk_queue *q,
-		struct io_uring_sqe **sqe1, struct io_uring_sqe **sqe2,
-		struct io_uring_sqe **sqe3)
-{
-	struct io_uring *r = &q->ring;
-	unsigned left = io_uring_sq_space_left(r);
 
-	if (left < 3)
-		io_uring_submit(r);
+	for (i = 0; i < nr_sqes; i++) {
+		sqes[i] = io_uring_get_sqe(&q->ring);
+		if (!sqes[i])
+			return i;
+	}
 
-	*sqe1 = io_uring_get_sqe(r);
-	*sqe2 = io_uring_get_sqe(r);
-	*sqe3 = io_uring_get_sqe(r);
+	return nr_sqes;
 }
 
 static inline void io_uring_prep_buf_register(struct io_uring_sqe *sqe,
-- 
2.47.0

