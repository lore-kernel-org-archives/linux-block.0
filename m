Received: from out30-88.freemail.mail.aliyun.com (out30-88.freemail.mail.aliyun.com [115.124.30.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090BA399369;
	Mon, 20 Apr 2026 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776686527; cv=none; b=Doxo4miwtpZgYchecZ14CLVf4e/iR7so4VHholZsrKxtV26XuN6Ry8y9mq04IXH/jHuorCzmjdALulfT2OI4nujIpnzoDHg37yagqI29bWbc/ar2XwW7tMQKCv6EgOzvvJmy9xvXO75bN/pRJv05kZRYUSOpMtn5e02T9EpVngk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776686527; c=relaxed/simple;
	bh=u5zHwkkuroZpozLhYbtDF6ZdIvdiozMrMB/+y+CbERo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sfF82yGxJ+njqcSLZ/CVGmUcG4NJng3QEE4J2lBitgd0qmDis8SiZ+iD4s/T6NhZ8mlimISkzrcOwqA9eVXJULiejUq4QxaZScicAW4NlyA613Azp1ixJVD9w++MsXW9TimHYnmALfIPkv2GRJeVbiozyYJFe7gdsPI/RyppePM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=A3khxHSg; arc=none smtp.client-ip=115.124.30.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="A3khxHSg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1776686521; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Sg5weHTm8+7SZpuZznGV+ept8OBehbdx25ccgIZF/w4=;
	b=A3khxHSgFeF9TFannTxmhUcwIYIKgDNSh3R5dAORjeBX9ICToXmXNx/sn6ws8hVImg4lyfpGi94uHDeAikqojJ5s3Off83PKgxMQZGC1fnQYqd3IeZ1Vj+htAUiAydluw4NiHv/4OV6edVQbscC49auzrvuYqcCTuMnCXElGoKY=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06682798|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0343396-0.00329653-0.962364;FP=15056820203674600438|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=ruohanlan@aliyun.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---0X1M6EfD_1776686495;
Received: from China-team(mailfrom:ruohanlan@aliyun.com fp:SMTPD_---0X1M6EfD_1776686495 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Apr 2026 20:02:01 +0800
From: Ruohan Lan <ruohanlan@aliyun.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>,
	Ruohan Lan <ruohanlan@aliyun.com>
Subject: [PATCH 6.1.y] ublk: fix deadlock when reading partition table
Date: Mon, 20 Apr 2026 20:01:10 +0800
Message-ID: <20260420120110.864-1-ruohanlan@aliyun.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit c258f5c4502c9667bccf5d76fa731ab9c96687c1 ]

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
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
[axboe: rewrite comment in ublk]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ The fix omits the change in __ublk_do_auto_buf_reg() since this function
doesn't exist in 6.1. ]
Signed-off-by: Ruohan Lan <ruohanlan@aliyun.com>
---
 drivers/block/ublk_drv.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 121b62f8bb0a..00d29a3c3d28 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -603,12 +603,20 @@ static inline bool ubq_daemon_is_dying(struct ublk_queue *ubq)
 	return ubq->ubq_daemon->flags & PF_EXITING;
 }
 
+static void ublk_end_request(struct request *req, blk_status_t error)
+{
+	local_bh_disable();
+	blk_mq_end_request(req, error);
+	local_bh_enable();
+}
+
 /* todo: handle partial completion */
 static void ublk_complete_rq(struct request *req)
 {
 	struct ublk_queue *ubq = req->mq_hctx->driver_data;
 	struct ublk_io *io = &ubq->ios[req->tag];
 	unsigned int unmapped_bytes;
+	bool requeue;
 
 	/* failed read IO if nothing is read */
 	if (!io->res && req_op(req) == REQ_OP_READ)
@@ -641,7 +649,23 @@ static void ublk_complete_rq(struct request *req)
 	if (unlikely(unmapped_bytes < io->res))
 		io->res = unmapped_bytes;
 
-	if (blk_update_request(req, BLK_STS_OK, io->res))
+	/*
+	 * Run bio->bi_end_io() with softirqs disabled. If the final fput
+	 * happens off this path, then that will prevent ublk's blkdev_release()
+	 * from being called on current's task work, see fput() implementation.
+	 *
+	 * Otherwise, ublk server may not provide forward progress in case of
+	 * reading the partition table from bdev_open() with disk->open_mutex
+	 * held, and causes dead lock as we could already be holding
+	 * disk->open_mutex here.
+	 *
+	 * Preferably we would not be doing IO with a mutex held that is also
+	 * used for release, but this work-around will suffice for now.
+	 */
+	local_bh_disable();
+	requeue = blk_update_request(req, BLK_STS_OK, io->res);
+	local_bh_enable();
+	if (requeue)
 		blk_mq_requeue_request(req, true);
 	else
 		__blk_mq_end_request(req, BLK_STS_OK);
@@ -694,7 +718,7 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 	if (ublk_queue_can_use_recovery(ubq))
 		blk_mq_requeue_request(rq, false);
 	else
-		blk_mq_end_request(rq, BLK_STS_IOERR);
+		ublk_end_request(rq, BLK_STS_IOERR);
 
 	mod_delayed_work(system_wq, &ubq->dev->monitor_work, 0);
 }
-- 
2.43.0

