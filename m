Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBA61A5BAE
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 02:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750818373; cv=none; b=O8vMOeB5ryXM/cDDnILjmJe4NeMdIpX3NClNLhsaQDM+ZsWpfL2dHq8BbCvIENE/n/Bfp3NPIW5zL2FG7wYcBoA4BaOaMQJANpww2aN4tuEOOmi7+n17opOpMUkdbQ679wvUY/6W5EIJdElrv+e2Wn3sGNQql2J8qZ0KMdRETkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750818373; c=relaxed/simple;
	bh=XgZAm2YKn0RDLGM+IYhiB4mlE6GfDEhzTXxW8Lkr9oI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=euN/F31qH1KzXa+ic5JaU8y8X4Ak7n1SabiJBdQYy3RAq7tZVa9BZLiRwa6b/hXfWhoAne28D2nHAMFWhrPa6KdU78RtwYX9ZJT6nZ0C199fr6Og92pPvYrGypmorqpABFIObKINvSkeJTMnnjZfrV98DAU+kb1sTW66RSDSlV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QykVajoX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QykVajoX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750818368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bmeKsN/UJG3jIi3BNFXZOuIOXEMjf4u+/01VOVmcxYw=;
	b=QykVajoXpQF5w4cZie3dmVoA9VzS7O8ECWiMbzLsNKuZX79PwMpBUTuuyNPvi28ITqtWGi
	hNuhNWH58KiPKx38dKsA/fOGi4IEIRvk4k231YnI435KVH0br4OY5w7OQbBNb8eaybvf6X
	yPMj1MRpyfkCDIPKQYwqzYGKTHkEHrQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-h-iVgmQaOROsyNDtC3_2SQ-1; Tue,
 24 Jun 2025 22:26:04 -0400
X-MC-Unique: h-iVgmQaOROsyNDtC3_2SQ-1
X-Mimecast-MFC-AGG-ID: h-iVgmQaOROsyNDtC3_2SQ_1750818363
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C074195608B;
	Wed, 25 Jun 2025 02:26:03 +0000 (UTC)
Received: from localhost (unknown [10.72.116.109])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 069E4195608F;
	Wed, 25 Jun 2025 02:26:01 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2] ublk: build batch from IOs in same io_ring_ctx and io task
Date: Wed, 25 Jun 2025 10:25:54 +0800
Message-ID: <20250625022554.883571-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

ublk_queue_cmd_list() dispatches the whole batch list by scheduling task
work via the tail request's io_uring_cmd, this way is fine even though
more than one io_ring_ctx are involved for this batch since it is just
one running context.

However, the task work handler ublk_cmd_list_tw_cb() takes `issue_flags`
of tail uring_cmd's io_ring_ctx for completing all commands. This way is
wrong if any uring_cmd is issued from different io_ring_ctx.

Fixes it by always building batch IOs from same io_ring_ctx and io task
because ublk_dispatch_req() does validate task context, and IO needs to
be aborted in case of running from fallback task work context.

For typical per-queue or per-io daemon implementation, this way shouldn't
make difference from performance viewpoint, because single io_ring_ctx is
taken in each daemon for normal use case.

Fixes: d796cea7b9f3 ("ublk: implement ->queue_rqs()")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- build batch list from same io_uring_ctx and io task(Caleb Sander Mateos)

 drivers/block/ublk_drv.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3566d7c36b8d..d441d3259edb 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1423,6 +1423,14 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
+static inline bool ublk_belong_to_same_batch(const struct ublk_io *io,
+					     const struct ublk_io *io2)
+{
+	return (io_uring_cmd_ctx_handle(io->cmd) ==
+		io_uring_cmd_ctx_handle(io2->cmd)) &&
+		(io->task == io2->task);
+}
+
 static void ublk_queue_rqs(struct rq_list *rqlist)
 {
 	struct rq_list requeue_list = { };
@@ -1434,7 +1442,8 @@ static void ublk_queue_rqs(struct rq_list *rqlist)
 		struct ublk_queue *this_q = req->mq_hctx->driver_data;
 		struct ublk_io *this_io = &this_q->ios[req->tag];
 
-		if (io && io->task != this_io->task && !rq_list_empty(&submit_list))
+		if (io && !ublk_belong_to_same_batch(io, this_io) &&
+				!rq_list_empty(&submit_list))
 			ublk_queue_cmd_list(io, &submit_list);
 		io = this_io;
 
-- 
2.47.1

