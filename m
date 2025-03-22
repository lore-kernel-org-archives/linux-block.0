Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F841C84D6
	for <linux-block@vger.kernel.org>; Sat, 22 Mar 2025 09:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742635988; cv=none; b=q0L3KZfo0xcka56KcAsy5fSZYjYLmxQY2nsdsU084URRNCsJ7AzqV9KZ5uO6cAzGbQwpKT4LrSEDBYI/mkTxUw0E0cdpYmPG/STykgo7JPpQ1GG3AyCzgDKYAE/lVyqxPV30hY4TY2GKjITkcQSMkGA4uPpsY9LGxigNbSQqV70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742635988; c=relaxed/simple;
	bh=Z0mNdp9Wv2MdNmEV+sGCPGJX8evlGPoXheyYhz0mteo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bLxI0/myocA4acTSw0oZf8morcon/LUnMtrozYx92WS4ohDMx0hSAKIYvYOEXpk6nqDRLEhkhLDpufceQzM65bcDaEkcSXKXx+hdzpa1C+giWeL0D4Tnq+EzMsYyFFDMuyQTjx3HAlUrGFl4eN5wxogXwp/iNw6bQBggPgMKVTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b+kDESTf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+kDESTf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742635985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzWwYJKnIjGe1VNWseywif21T0YvkPYSkeYfKKU5n0A=;
	b=b+kDESTfpFQtGbFH7ywXer1FzdUkD+rx6KpknuFEhOR/7NgKW9d3yDLuu3RYnEUgZzSY1Y
	3oqUTlmIrDe6ZYlPQBbaezLIisBzySX7yGGQ0VmN4QEzCU5nPFPfESHtn8Xju3VqFCTim2
	/QOlfRZcrBU6pGsmxociElornB8oDR8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-D5SitKkUPJiSEJXPd0bomg-1; Sat,
 22 Mar 2025 05:33:03 -0400
X-MC-Unique: D5SitKkUPJiSEJXPd0bomg-1
X-Mimecast-MFC-AGG-ID: D5SitKkUPJiSEJXPd0bomg_1742635983
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE88E196D2CF;
	Sat, 22 Mar 2025 09:33:02 +0000 (UTC)
Received: from localhost (unknown [10.72.120.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC600180B48B;
	Sat, 22 Mar 2025 09:33:01 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 7/8] selftests: ublk: simplify loop io completion
Date: Sat, 22 Mar 2025 17:32:15 +0800
Message-ID: <20250322093218.431419-8-ming.lei@redhat.com>
In-Reply-To: <20250322093218.431419-1-ming.lei@redhat.com>
References: <20250322093218.431419-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Use the added target io handling helpers for simplifying loop io
completion.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/file_backed.c | 91 +++++++++++-----------
 tools/testing/selftests/ublk/kublk.h       |  4 -
 2 files changed, 47 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index e2287eedaac8..6f34eabfae97 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -13,8 +13,22 @@ static enum io_uring_op ublk_to_uring_op(const struct ublksrv_io_desc *iod, int
 	assert(0);
 }
 
+static int loop_queue_flush_io(struct ublk_queue *q, const struct ublksrv_io_desc *iod, int tag)
+{
+	unsigned ublk_op = ublksrv_get_op(iod);
+	struct io_uring_sqe *sqe[1];
+
+	ublk_queue_alloc_sqes(q, sqe, 1);
+	io_uring_prep_fsync(sqe[0], 1 /*fds[1]*/, IORING_FSYNC_DATASYNC);
+	io_uring_sqe_set_flags(sqe[0], IOSQE_FIXED_FILE);
+	/* bit63 marks us as tgt io */
+	sqe[0]->user_data = build_user_data(tag, ublk_op, 0, 1);
+	return 1;
+}
+
 static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_desc *iod, int tag)
 {
+	unsigned ublk_op = ublksrv_get_op(iod);
 	int zc = ublk_queue_use_zc(q);
 	enum io_uring_op op = ublk_to_uring_op(iod, zc);
 	struct io_uring_sqe *sqe[3];
@@ -29,98 +43,87 @@ static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_de
 				iod->nr_sectors << 9,
 				iod->start_sector << 9);
 		io_uring_sqe_set_flags(sqe[0], IOSQE_FIXED_FILE);
-		q->io_inflight++;
 		/* bit63 marks us as tgt io */
-		sqe[0]->user_data = build_user_data(tag, op, UBLK_IO_TGT_NORMAL, 1);
-		return 0;
+		sqe[0]->user_data = build_user_data(tag, ublk_op, 0, 1);
+		return 1;
 	}
 
 	ublk_queue_alloc_sqes(q, sqe, 3);
 
 	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
-	sqe[0]->user_data = build_user_data(tag, 0xfe, 1, 1);
-	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS;
-	sqe[0]->flags |= IOSQE_IO_LINK;
+	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
+	sqe[0]->user_data = build_user_data(tag,
+			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, 1);
 
 	io_uring_prep_rw(op, sqe[1], 1 /*fds[1]*/, 0,
 		iod->nr_sectors << 9,
 		iod->start_sector << 9);
 	sqe[1]->buf_index = tag;
-	sqe[1]->flags |= IOSQE_FIXED_FILE;
-	sqe[1]->flags |= IOSQE_IO_LINK;
-	sqe[1]->user_data = build_user_data(tag, op, UBLK_IO_TGT_ZC_OP, 1);
-	q->io_inflight++;
+	sqe[1]->flags |= IOSQE_FIXED_FILE | IOSQE_IO_HARDLINK;
+	sqe[1]->user_data = build_user_data(tag, ublk_op, 0, 1);
 
 	io_uring_prep_buf_unregister(sqe[2], 0, tag, q->q_id, tag);
-	sqe[2]->user_data = build_user_data(tag, 0xff, UBLK_IO_TGT_ZC_BUF, 1);
-	q->io_inflight++;
+	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, 1);
 
-	return 0;
+	return 2;
 }
 
 static int loop_queue_tgt_io(struct ublk_queue *q, int tag)
 {
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
 	unsigned ublk_op = ublksrv_get_op(iod);
-	struct io_uring_sqe *sqe[1];
+	int ret;
 
 	switch (ublk_op) {
 	case UBLK_IO_OP_FLUSH:
-		ublk_queue_alloc_sqes(q, sqe, 1);
-		if (!sqe[0])
-			return -ENOMEM;
-		io_uring_prep_fsync(sqe[0], 1 /*fds[1]*/, IORING_FSYNC_DATASYNC);
-		io_uring_sqe_set_flags(sqe[0], IOSQE_FIXED_FILE);
-		q->io_inflight++;
-		sqe[0]->user_data = build_user_data(tag, ublk_op, UBLK_IO_TGT_NORMAL, 1);
+		ret = loop_queue_flush_io(q, iod, tag);
 		break;
 	case UBLK_IO_OP_WRITE_ZEROES:
 	case UBLK_IO_OP_DISCARD:
-		return -ENOTSUP;
+		ret = -ENOTSUP;
+		break;
 	case UBLK_IO_OP_READ:
 	case UBLK_IO_OP_WRITE:
-		loop_queue_tgt_rw_io(q, iod, tag);
+		ret = loop_queue_tgt_rw_io(q, iod, tag);
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		break;
 	}
 
 	ublk_dbg(UBLK_DBG_IO, "%s: tag %d ublk io %x %llx %u\n", __func__, tag,
 			iod->op_flags, iod->start_sector, iod->nr_sectors << 9);
-	return 1;
+	return ret;
 }
 
 static int ublk_loop_queue_io(struct ublk_queue *q, int tag)
 {
 	int queued = loop_queue_tgt_io(q, tag);
 
-	if (queued < 0)
-		ublk_complete_io(q, tag, queued);
-
+	ublk_queued_tgt_io(q, tag, queued);
 	return 0;
 }
 
 static void ublk_loop_io_done(struct ublk_queue *q, int tag,
 		const struct io_uring_cqe *cqe)
 {
-	int cqe_tag = user_data_to_tag(cqe->user_data);
-	unsigned tgt_data = user_data_to_tgt_data(cqe->user_data);
-	int res = cqe->res;
+	unsigned op = user_data_to_op(cqe->user_data);
+	struct ublk_io *io = ublk_get_io(q, tag);
+
+	if (cqe->res < 0 || op != ublk_cmd_op_nr(UBLK_U_IO_UNREGISTER_IO_BUF)) {
+		if (!io->result)
+			io->result = cqe->res;
+		if (cqe->res < 0)
+			ublk_err("%s: io failed op %x user_data %lx\n",
+					__func__, op, cqe->user_data);
+	}
 
-	if (res < 0 || tgt_data == UBLK_IO_TGT_NORMAL)
-		goto complete;
+	/* buffer register op is IOSQE_CQE_SKIP_SUCCESS */
+	if (op == ublk_cmd_op_nr(UBLK_U_IO_REGISTER_IO_BUF))
+		io->tgt_ios += 1;
 
-	if (tgt_data == UBLK_IO_TGT_ZC_OP) {
-		ublk_set_io_res(q, tag, cqe->res);
-		goto exit;
-	}
-	assert(tgt_data == UBLK_IO_TGT_ZC_BUF);
-	res = ublk_get_io_res(q, tag);
-complete:
-	assert(tag == cqe_tag);
-	ublk_complete_io(q, tag, res);
-exit:
-	q->io_inflight--;
+	if (ublk_completed_tgt_io(q, tag))
+		ublk_complete_io(q, tag, io->result);
 }
 
 static int ublk_loop_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 48ca16055710..02f0bff7918c 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -44,10 +44,6 @@
 #define UBLK_MAX_QUEUES                 4
 #define UBLK_QUEUE_DEPTH                128
 
-#define UBLK_IO_TGT_NORMAL 		0
-#define UBLK_IO_TGT_ZC_BUF 		1
-#define UBLK_IO_TGT_ZC_OP 		2
-
 #define UBLK_DBG_DEV            (1U << 0)
 #define UBLK_DBG_QUEUE          (1U << 1)
 #define UBLK_DBG_IO_CMD         (1U << 2)
-- 
2.47.0

