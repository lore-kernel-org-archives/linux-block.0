Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617A0285CA7
	for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442322; cv=none; b=kkWH+ucuBsoklalPIWVTjXWMGCvIOCI62dFcAn1jt9Y6VYzgzj2Zz7yRGy+L4+HSXP3AOlHwl7nKNehIhkKFNEAvVt/4Y3bnGQKaIQkp+RdBSLyTCwTIZrI2u5938mGO2bnPVS7lpMpgEY6ngwG50iDRZyxG23EeCJIynL15OR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442322; c=relaxed/simple;
	bh=UtIyJnSbvTvujr7hfQMv9WFTy1RCXEc2g4Kaa8ITtno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZsDDMjVVNvFXrEpPqEN7nDjzQPUzCN3LX0OCcb9tFWc/694ya9/rOaf82chltB1nZVqCCuyxvlcqiBtTjYeOQP4j7oENTXJ8xmVEWBQ1QJJwKJ44TSKbgS6zT7rrwguhXfZJ3I2hlBAxGxiLuzoAUTw3SYLjg4HVcCzpdOxBmOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EszLwqzk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EszLwqzk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765442318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DmeVH7/DhuliDdruhn+MR/dhbCqY+wRKP4UaX7W54cg=;
	b=EszLwqzkNoTo2LMPuQIaYk32vzCETHc9txe/8zYDDyB7UrZN7919Fr8y/OR6SiyThIuANE
	9iJPyc+0OfC0EWLmRiaT3580AVhfAcor+VcUXVRchZAR5zj47oNlht162B0dXvrP6K0tLs
	B3OGfGV1SknGBVMO4/C3JARbN3gB16w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-2rDJ1sC-NtOhsrUaH4keEw-1; Thu,
 11 Dec 2025 03:38:32 -0500
X-MC-Unique: 2rDJ1sC-NtOhsrUaH4keEw-1
X-Mimecast-MFC-AGG-ID: 2rDJ1sC-NtOhsrUaH4keEw_1765442311
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10BD019560A5;
	Thu, 11 Dec 2025 08:38:31 +0000 (UTC)
Received: from localhost (unknown [10.72.116.129])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0CE2230001A7;
	Thu, 11 Dec 2025 08:38:29 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] ublk: fix deadlock when reading partition table
Date: Thu, 11 Dec 2025 16:38:24 +0800
Message-ID: <20251211083824.349210-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
 drivers/block/ublk_drv.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2c715df63f23..f69da449727f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1086,6 +1086,7 @@ static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
 {
 	unsigned int unmapped_bytes;
 	blk_status_t res = BLK_STS_OK;
+	bool requeue;
 
 	/* failed read IO if nothing is read */
 	if (!io->res && req_op(req) == REQ_OP_READ)
@@ -1117,14 +1118,28 @@ static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
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
+	local_bh_disable();
 	blk_mq_end_request(req, res);
+	local_bh_enable();
 }
 
 static struct io_uring_cmd *__ublk_prep_compl_io_cmd(struct ublk_io *io,
-- 
2.47.1

