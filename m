Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068D520CCFF
	for <linux-block@vger.kernel.org>; Thu, 27 Mar 2025 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743069137; cv=none; b=tEOx2CwaU1B+6Ljlx84IfpWfQrN+ywVk2g+TTQle+jUTuMcSQEP2z4xyoTvmHo2WW2CwAmETT+nDx2fuox9mM7gcECPAqlUa0BvaQWmJYwNL6rKnGStN9SwAEzYg8vWvkeEisPpEpl00Dq8/sGwlmu996dBPlJGLea+qFW0dQtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743069137; c=relaxed/simple;
	bh=M57+G++9aPAV0MfuBvNtPaFCs9cZe1ZCv+N77GHf4LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0o81zUpoALNnDKiDhOzuhLEbQy0q7v6EE4a85Vou7nNLyPretjfik10oU2QNpjTv4uNFQ56ELJ9U9Asji/jb0S+QAAOE77n/89VhvxRBICtjWH+ivUYRnjz28yHkVEynCZhl1lFif1yd0+AuP0zK8wM4Kvs4bn6zR+94/R4iC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BbjUza6B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BbjUza6B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743069134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0XL1Vw4t+Qhwtonanfet32takR9CSaXm2me/mz8jjPc=;
	b=BbjUza6B+d+YOGFh/strnPitje42aHkrPaC38/FCAW0MZPfj2dG6jSdF+4uERkdEVC3hbW
	hsToVIBq6iaTusIjlaSL6fnygNjk6KUE+90sCnP9H2KF6xOJFdGxOTW1xWLosAkSP6wjQq
	uvFDjVUie29bW7M0CGAZ5kJcPtXVKbk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-V111h_U4Nai6SwlKfldbiA-1; Thu,
 27 Mar 2025 05:52:13 -0400
X-MC-Unique: V111h_U4Nai6SwlKfldbiA-1
X-Mimecast-MFC-AGG-ID: V111h_U4Nai6SwlKfldbiA_1743069132
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4320B180025A;
	Thu, 27 Mar 2025 09:52:12 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E2FB6180B487;
	Thu, 27 Mar 2025 09:52:10 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 08/11] ublk: implement ->queue_rqs()
Date: Thu, 27 Mar 2025 17:51:17 +0800
Message-ID: <20250327095123.179113-9-ming.lei@redhat.com>
In-Reply-To: <20250327095123.179113-1-ming.lei@redhat.com>
References: <20250327095123.179113-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Implement ->queue_rqs() for improving perf in case of MQ.

In this way, we just need to call io_uring_cmd_complete_in_task() once for
whole IO batch, then both io_uring and ublk server can get exact batch from
ublk frontend.

Follows IOPS improvement:

- tests

	tools/testing/selftests/ublk/kublk add -t null -q 2 [-z]

	fio/t/io_uring -p0 /dev/ublkb0

- results:

	more than 10% IOPS boost observed

Pass all ublk selftests, especially the io dispatch order test.

Cc: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 131 +++++++++++++++++++++++++++++++++------
 1 file changed, 111 insertions(+), 20 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index a5bcf3aa9d8c..f97919460515 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -81,6 +81,20 @@ struct ublk_rq_data {
 };
 
 struct ublk_uring_cmd_pdu {
+	/*
+	 * Store requests in same batch temporarily for queuing them to
+	 * daemon context.
+	 *
+	 * It should have been stored to request payload, but we do want
+	 * to avoid extra pre-allocation, and uring_cmd payload is always
+	 * free for us
+	 */
+	struct request *req_list;
+
+	/*
+	 * The following two are valid in this cmd whole lifetime, and
+	 * setup in ublk uring_cmd handler
+	 */
 	struct ublk_queue *ubq;
 	u16 tag;
 };
@@ -1170,14 +1184,12 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 		blk_mq_end_request(rq, BLK_STS_IOERR);
 }
 
-static void ublk_rq_task_work_cb(struct io_uring_cmd *cmd,
-				 unsigned int issue_flags)
+static void ublk_dispatch_req(struct ublk_queue *ubq,
+			      struct io_uring_cmd *cmd,
+			      struct request *req,
+			      unsigned int issue_flags)
 {
-	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
-	struct ublk_queue *ubq = pdu->ubq;
-	int tag = pdu->tag;
-	struct request *req = blk_mq_tag_to_rq(
-		ubq->dev->tag_set.tags[ubq->q_id], tag);
+	int tag = req->tag;
 	struct ublk_io *io = &ubq->ios[tag];
 	unsigned int mapped_bytes;
 
@@ -1252,6 +1264,18 @@ static void ublk_rq_task_work_cb(struct io_uring_cmd *cmd,
 	ubq_complete_io_cmd(io, UBLK_IO_RES_OK, issue_flags);
 }
 
+static void ublk_rq_task_work_cb(struct io_uring_cmd *cmd,
+				 unsigned int issue_flags)
+{
+	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+	struct ublk_queue *ubq = pdu->ubq;
+	int tag = pdu->tag;
+	struct request *req = blk_mq_tag_to_rq(
+		ubq->dev->tag_set.tags[ubq->q_id], tag);
+
+	ublk_dispatch_req(ubq, cmd, req, issue_flags);
+}
+
 static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
 {
 	struct ublk_io *io = &ubq->ios[rq->tag];
@@ -1259,6 +1283,35 @@ static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
 	io_uring_cmd_complete_in_task(io->cmd, ublk_rq_task_work_cb);
 }
 
+static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
+		unsigned int issue_flags)
+{
+	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+	struct request *rq = pdu->req_list;
+	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
+	struct request *next;
+
+	while (rq) {
+		struct ublk_io *io = &ubq->ios[rq->tag];
+
+		next = rq->rq_next;
+		rq->rq_next = NULL;
+		ublk_dispatch_req(ubq, io->cmd, rq, issue_flags);
+		rq = next;
+	}
+}
+
+static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
+{
+	struct request *rq = rq_list_peek(l);
+	struct ublk_io *io = &ubq->ios[rq->tag];
+	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(io->cmd);
+
+	pdu->req_list = rq;
+	rq_list_init(l);
+	io_uring_cmd_complete_in_task(io->cmd, ublk_cmd_list_tw_cb);
+}
+
 static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 {
 	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
@@ -1297,21 +1350,12 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 	return BLK_EH_RESET_TIMER;
 }
 
-static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
-		const struct blk_mq_queue_data *bd)
+static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request *rq)
 {
-	struct ublk_queue *ubq = hctx->driver_data;
-	struct request *rq = bd->rq;
 	blk_status_t res;
 
-	if (unlikely(ubq->fail_io)) {
+	if (unlikely(ubq->fail_io))
 		return BLK_STS_TARGET;
-	}
-
-	/* fill iod to slot in io cmd buffer */
-	res = ublk_setup_iod(ubq, rq);
-	if (unlikely(res != BLK_STS_OK))
-		return BLK_STS_IOERR;
 
 	/* With recovery feature enabled, force_abort is set in
 	 * ublk_stop_dev() before calling del_gendisk(). We have to
@@ -1325,6 +1369,29 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ublk_nosrv_should_queue_io(ubq) && unlikely(ubq->force_abort))
 		return BLK_STS_IOERR;
 
+	if (unlikely(ubq->canceling))
+		return BLK_STS_IOERR;
+
+	/* fill iod to slot in io cmd buffer */
+	res = ublk_setup_iod(ubq, rq);
+	if (unlikely(res != BLK_STS_OK))
+		return BLK_STS_IOERR;
+
+	blk_mq_start_request(rq);
+	return BLK_STS_OK;
+}
+
+static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
+		const struct blk_mq_queue_data *bd)
+{
+	struct ublk_queue *ubq = hctx->driver_data;
+	struct request *rq = bd->rq;
+	blk_status_t res;
+
+	res = ublk_prep_req(ubq, rq);
+	if (res != BLK_STS_OK)
+		return res;
+
 	/*
 	 * ->canceling has to be handled after ->force_abort and ->fail_io
 	 * is dealt with, otherwise this request may not be failed in case
@@ -1335,12 +1402,35 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 		return BLK_STS_OK;
 	}
 
-	blk_mq_start_request(bd->rq);
 	ublk_queue_cmd(ubq, rq);
-
 	return BLK_STS_OK;
 }
 
+static void ublk_queue_rqs(struct rq_list *rqlist)
+{
+	struct rq_list requeue_list = { };
+	struct rq_list submit_list = { };
+	struct ublk_queue *ubq = NULL;
+	struct request *req;
+
+	while ((req = rq_list_pop(rqlist))) {
+		struct ublk_queue *this_q = req->mq_hctx->driver_data;
+
+		if (ubq && ubq != this_q && !rq_list_empty(&submit_list))
+			ublk_queue_cmd_list(ubq, &submit_list);
+		ubq = this_q;
+
+		if (ublk_prep_req(ubq, req) == BLK_STS_OK)
+			rq_list_add_tail(&submit_list, req);
+		else
+			rq_list_add_tail(&requeue_list, req);
+	}
+
+	if (ubq && !rq_list_empty(&submit_list))
+		ublk_queue_cmd_list(ubq, &submit_list);
+	*rqlist = requeue_list;
+}
+
 static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
 		unsigned int hctx_idx)
 {
@@ -1353,6 +1443,7 @@ static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
 
 static const struct blk_mq_ops ublk_mq_ops = {
 	.queue_rq       = ublk_queue_rq,
+	.queue_rqs      = ublk_queue_rqs,
 	.init_hctx	= ublk_init_hctx,
 	.timeout	= ublk_timeout,
 };
-- 
2.47.0

