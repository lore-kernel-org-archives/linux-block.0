Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C4F289811
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765550080; cv=none; b=YA94MtmKXz5XS6h+lELZ9YJHNMgq0t3XBFrcLfSNQojXw38AO66lVFXL8ryCpcTTy5TDtZoHfIgnr/vd3Wgog+VKvGutLrUtxA7xi1sQHMTb3k4/n7dVaV1SoFIm4mTV4wr5uuULd7lDcMp3wx0MFYVsr/GErCzhIprWo6StV6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765550080; c=relaxed/simple;
	bh=sBRMeldnplFyo/gRjXaCmrntOrlgW0gTtzzmcavaYpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=riZ37WAWUll75bUs95fxQZSJLjg7vX5tsn4f/Tf213IhjzxxicwHulBfA8KJc5t+D05r0X0EwAiw8Jq3FjViTFA1YGKrf/0eiu1CmH5uvVuDd0j8C+BqwADgfHOphlBKiXHfPFbx2bfAL063Z9mnuqJCO4jTNY2dLCCVazfhsT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PUuL0j7z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUuL0j7z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765550077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RTtYEOy4bXyp0Np3uXXv7BfIcvy/yxd04dWuBTjTUvY=;
	b=PUuL0j7z13pTsmw34zJr+Q2A7wZuSVZPMP8RHJW7jAcO60odw6dERuN77vnmoFLNLw/LHI
	sREi6rgkTg9d/6u9vfdu2hlcAANLupBOmBI9cT+YEPZ2WJGcHFz6qF3Rn1ekJFNQWfBFmz
	K19GW80lfBDeDi5xL8qPMf9QgDXsvk4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-_IyhtjKvMc2GfVYVUQDSWg-1; Fri,
 12 Dec 2025 09:34:34 -0500
X-MC-Unique: _IyhtjKvMc2GfVYVUQDSWg-1
X-Mimecast-MFC-AGG-ID: _IyhtjKvMc2GfVYVUQDSWg_1765550073
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53C9B1956053;
	Fri, 12 Dec 2025 14:34:32 +0000 (UTC)
Received: from localhost (unknown [10.72.116.20])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3864819540DF;
	Fri, 12 Dec 2025 14:34:30 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2] ublk: fix deadlock when reading partition table
Date: Fri, 12 Dec 2025 22:34:15 +0800
Message-ID: <20251212143415.485359-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When one process(such as udev) opens ublk block device (e.g., to read
the partition table via bdev_open()), a deadlock[1] can occur:

1. bdev_open() grabs disk->open_mutex
2. The process issues read I/O to ublk backend to read partition table
3. In __ublk_complete_rq(), blk_update_request() or blk_mq_end_request()
   runs bio->bi_end_io() callbacks
4. If this triggers fput() on file descriptor of ublk block device, the
   work may be deferred to current task's task work (see fput() implementation)
5. This eventually calls blkdev_release() from the same context
6. blkdev_release() tries to grab disk->open_mutex again
7. Deadlock: same task waiting for a mutex it already holds

The fix is to run blk_update_request() and blk_mq_end_request() with bottom
halves disabled. This forces blkdev_release() to run in kernel work-queue
context instead of current task work context, and allows ublk server to make
forward progress, and avoids the deadlock.

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Link: https://github.com/ublk-org/ublksrv/issues/170 [1]
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- cover another two cases of ending request(Caleb Sander Mateos)

 drivers/block/ublk_drv.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index df9831783a13..38f138f248e6 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1080,12 +1080,20 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
 	return io_uring_cmd_to_pdu(ioucmd, struct ublk_uring_cmd_pdu);
 }
 
+static void ublk_end_request(struct request *req, blk_status_t error)
+{
+	local_bh_disable();
+	blk_mq_end_request(req, error);
+	local_bh_enable();
+}
+
 /* todo: handle partial completion */
 static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
 				      bool need_map)
 {
 	unsigned int unmapped_bytes;
 	blk_status_t res = BLK_STS_OK;
+	bool requeue;
 
 	/* failed read IO if nothing is read */
 	if (!io->res && req_op(req) == REQ_OP_READ)
@@ -1117,14 +1125,26 @@ static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
 	if (unlikely(unmapped_bytes < io->res))
 		io->res = unmapped_bytes;
 
-	if (blk_update_request(req, BLK_STS_OK, io->res))
+	/*
+	 * Run bio->bi_end_io() from softirq context for preventing this
+	 * ublk's blkdev_release() from being called on current's task
+	 * work, see fput() implementation.
+	 *
+	 * Otherwise, ublk server may not provide forward progress in
+	 * case of reading partition table from bdev_open() with
+	 * disk->open_mutex grabbed, and causes dead lock.
+	 */
+	local_bh_disable();
+	requeue = blk_update_request(req, BLK_STS_OK, io->res);
+	local_bh_enable();
+	if (requeue)
 		blk_mq_requeue_request(req, true);
 	else if (likely(!blk_should_fake_timeout(req->q)))
 		__blk_mq_end_request(req, BLK_STS_OK);
 
 	return;
 exit:
-	blk_mq_end_request(req, res);
+	ublk_end_request(req, res);
 }
 
 static struct io_uring_cmd *__ublk_prep_compl_io_cmd(struct ublk_io *io,
@@ -1164,7 +1184,7 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 	if (ublk_nosrv_dev_should_queue_io(ubq->dev))
 		blk_mq_requeue_request(rq, false);
 	else
-		blk_mq_end_request(rq, BLK_STS_IOERR);
+		ublk_end_request(rq, BLK_STS_IOERR);
 }
 
 static void
@@ -1209,7 +1229,7 @@ __ublk_do_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
 			ublk_auto_buf_reg_fallback(ubq, req->tag);
 			return AUTO_BUF_REG_FALLBACK;
 		}
-		blk_mq_end_request(req, BLK_STS_IOERR);
+		ublk_end_request(req, BLK_STS_IOERR);
 		return AUTO_BUF_REG_FAIL;
 	}
 
-- 
2.47.1

