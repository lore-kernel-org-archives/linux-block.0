Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A4825F7A1
	for <linux-block@vger.kernel.org>; Mon, 24 Mar 2025 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824197; cv=none; b=NQP/3iEztpEwvstTL+GuLYNuoj9YnsgnEooQKMoAaEjs5odXn4YEfAPNikwhxt2OTZReP4vEaFWETHjwxKKf83gT+QdOV0tCxHDTGDLKWb5PTcxMbALdPqnNFeN98wPYNJTy1z19qGZ0cbwAAdLMjnF7ODDwtovWQIInIh6/dwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824197; c=relaxed/simple;
	bh=+MGKWzxbL2BS4VPQGqdNhise33g8maT1NPFXdHBg/8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDCOq4F0WU3gpXILVfXvp/rwd9IXYYLnAnTPLQolagtH3Zlxg4UJD2YJHtlwxEDVX0saIXxTTj6IOrf5/Lo3yawg+drnpiWfD+1V7QMGtN1rJrdpg35lkuu0deAfg+ZD2cTGHL48cDcVG3I3oNXT3yuLK4vzhyP1JIs1HsVMWYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G0Djxim8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0Djxim8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742824194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aaALj6WfpB7OZJhZK0pbXEuwwGsu12U+9EA165hm4jM=;
	b=G0Djxim84ARQPsBPeZiYrtGI9+ApPsqeH8g08rf3eqPfHSlR4cRCI4Ghr2aNb7jfjr+/1R
	EwgFhxqAsFrgsnOYe19eTXwZax1tsGKd4dWeHLBGba6iV7EyjWsVJqrndIhgo5Q6k/vwLi
	IDqU4d41dsuOZ1sUWpWmw5sne5+3xkE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-3QvlZIUzOH6jJmBuvFBPmg-1; Mon,
 24 Mar 2025 09:49:53 -0400
X-MC-Unique: 3QvlZIUzOH6jJmBuvFBPmg-1
X-Mimecast-MFC-AGG-ID: 3QvlZIUzOH6jJmBuvFBPmg_1742824192
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FA8F19560B1;
	Mon, 24 Mar 2025 13:49:52 +0000 (UTC)
Received: from localhost (unknown [10.72.120.24])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D0D35180B485;
	Mon, 24 Mar 2025 13:49:50 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 6/8] ublk: implement ->queue_rqs()
Date: Mon, 24 Mar 2025 21:49:01 +0800
Message-ID: <20250324134905.766777-7-ming.lei@redhat.com>
In-Reply-To: <20250324134905.766777-1-ming.lei@redhat.com>
References: <20250324134905.766777-1-ming.lei@redhat.com>
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
one batch, then both io_uring and ublk server can get exact batch from
client side.

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
 drivers/block/ublk_drv.c | 85 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 77 insertions(+), 8 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 53a463681a41..86621fde7fde 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -83,6 +83,7 @@ struct ublk_rq_data {
 struct ublk_uring_cmd_pdu {
 	struct ublk_queue *ubq;
 	u16 tag;
+	struct rq_list list;
 };
 
 /*
@@ -1258,6 +1259,32 @@ static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
 	io_uring_cmd_complete_in_task(io->cmd, ublk_rq_task_work_cb);
 }
 
+static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
+		unsigned int issue_flags)
+{
+	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+	struct ublk_queue *ubq = pdu->ubq;
+	struct request *rq;
+
+	while ((rq = rq_list_pop(&pdu->list))) {
+		struct ublk_io *io = &ubq->ios[rq->tag];
+
+		ublk_rq_task_work_cb(io->cmd, issue_flags);
+	}
+}
+
+static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
+{
+	struct request *rq = l->head;
+	struct ublk_io *io = &ubq->ios[rq->tag];
+	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(io->cmd);
+
+	pdu->ubq = ubq;
+	pdu->list = *l;
+	rq_list_init(l);
+	io_uring_cmd_complete_in_task(io->cmd, ublk_cmd_list_tw_cb);
+}
+
 static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 {
 	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
@@ -1296,16 +1323,13 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 	return BLK_EH_RESET_TIMER;
 }
 
-static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
-		const struct blk_mq_queue_data *bd)
+static blk_status_t ublk_prep_rq_batch(struct request *rq)
 {
-	struct ublk_queue *ubq = hctx->driver_data;
-	struct request *rq = bd->rq;
+	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
 	blk_status_t res;
 
-	if (unlikely(ubq->fail_io)) {
+	if (unlikely(ubq->fail_io))
 		return BLK_STS_TARGET;
-	}
 
 	/* fill iod to slot in io cmd buffer */
 	res = ublk_setup_iod(ubq, rq);
@@ -1324,17 +1348,58 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ublk_nosrv_should_queue_io(ubq) && unlikely(ubq->force_abort))
 		return BLK_STS_IOERR;
 
+	if (unlikely(ubq->canceling))
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
 	if (unlikely(ubq->canceling)) {
 		__ublk_abort_rq(ubq, rq);
 		return BLK_STS_OK;
 	}
 
-	blk_mq_start_request(bd->rq);
-	ublk_queue_cmd(ubq, rq);
+	res = ublk_prep_rq_batch(rq);
+	if (res != BLK_STS_OK)
+		return res;
 
+	ublk_queue_cmd(ubq, rq);
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
+		if (ublk_prep_rq_batch(req) == BLK_STS_OK)
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
@@ -1347,6 +1412,7 @@ static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
 
 static const struct blk_mq_ops ublk_mq_ops = {
 	.queue_rq       = ublk_queue_rq,
+	.queue_rqs      = ublk_queue_rqs,
 	.init_hctx	= ublk_init_hctx,
 	.timeout	= ublk_timeout,
 };
@@ -3147,6 +3213,9 @@ static int __init ublk_init(void)
 	BUILD_BUG_ON((u64)UBLKSRV_IO_BUF_OFFSET +
 			UBLKSRV_IO_BUF_TOTAL_SIZE < UBLKSRV_IO_BUF_OFFSET);
 
+	BUILD_BUG_ON(sizeof(struct ublk_uring_cmd_pdu) >
+			sizeof_field(struct io_uring_cmd, pdu));
+
 	init_waitqueue_head(&ublk_idr_wq);
 
 	ret = misc_register(&ublk_misc);
-- 
2.47.0

