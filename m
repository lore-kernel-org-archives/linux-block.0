Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E46223DE7
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745400277; cv=none; b=JtsU9kdscsXi7CiLvmNlcJaD7a4urqLomSf5OwvgOIGThuSGxnU5lzi4c0iB6ldn1rOKpWcZCBd02hHz4QiXnIyKMPfwcBFaEX41Pw0/bFB4HqYaN/Hv4C6bDAEU4JAhkycDTYhdXltSLiY8OPi/GJJzbR8RcuwU8Z4oG4ARLUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745400277; c=relaxed/simple;
	bh=+7ywRTrpwjFMOE/Q9XXY1QGJyGr4/bJk2JIzbeGBIFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwYWxi1Syp4TM9hLSXDUNaExnrfmpRUNYiTFnijS7m2gvLjNAtPHI/s/p95taWD6N5GZsjLw4hoJTymCT8vlNjZKRUFC6Ah4KX1/xViWk5muiln7eUs78zQvb0qfYjDUV2pIBCPml6mPx1gbUUDeGb4808Bh2MrgFjtgvk3iwLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d+OqBBwV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+OqBBwV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745400270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FEmS3CzBkR/ayzBclqUzVIlyD/XqW08jakm+tcd35h4=;
	b=d+OqBBwVdz0yAlAUYod/3plmcAFBsEo370X9sk83u99Hp3xkHLkCCJlBMKMrkS+9GYGdXK
	6O9QNkwjslHJ0kKO6XQkUh8jsA/OfftWyo7QWSU0B0dGLjtAQ2J3rZX+5Jn7ugyxVy7Fg0
	eklp3p4+a8SAw2YIEQX2CXt6tImLO0Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-DI-gk5FgOYeOY8rrXhtSzA-1; Wed,
 23 Apr 2025 05:24:25 -0400
X-MC-Unique: DI-gk5FgOYeOY8rrXhtSzA-1
X-Mimecast-MFC-AGG-ID: DI-gk5FgOYeOY8rrXhtSzA_1745400264
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD9C5195608A;
	Wed, 23 Apr 2025 09:24:23 +0000 (UTC)
Received: from localhost (unknown [10.72.112.81])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C652118001D7;
	Wed, 23 Apr 2025 09:24:22 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Guy Eisenberg <geisenberg@nvidia.com>,
	Jared Holzman <jholzman@nvidia.com>,
	Yoav Cohen <yoav@nvidia.com>,
	Omri Levi <omril@nvidia.com>,
	Ofer Oshri <ofer@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] ublk: fix race between io_uring_cmd_complete_in_task and ublk_cancel_cmd
Date: Wed, 23 Apr 2025 17:24:03 +0800
Message-ID: <20250423092405.919195-3-ming.lei@redhat.com>
In-Reply-To: <20250423092405.919195-1-ming.lei@redhat.com>
References: <20250423092405.919195-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

ublk_cancel_cmd() calls io_uring_cmd_done() to complete uring_cmd, but
we may have scheduled task work via io_uring_cmd_complete_in_task() for
dispatching request, then kernel crash can be triggered.

Fix it by not trying to canceling the command if ublk block request is
coming to this slot.

Reported-by: Jared Holzman <jholzman@nvidia.com>
Closes: https://lore.kernel.org/linux-block/d2179120-171b-47ba-b664-23242981ef19@nvidia.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c4d4be4f6fbd..fbfb5b815c8d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1334,6 +1334,12 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (res != BLK_STS_OK)
 		return res;
 
+	/*
+	 * Order writing to rq->state in blk_mq_start_request() and
+	 * reading ubq->canceling, see comment in ublk_cancel_command()
+	 * wrt. the pair barrier.
+	 */
+	smp_mb();
 	/*
 	 * ->canceling has to be handled after ->force_abort and ->fail_io
 	 * is dealt with, otherwise this request may not be failed in case
@@ -1683,14 +1689,35 @@ static void ublk_start_cancel(struct ublk_queue *ubq)
 	ublk_put_disk(disk);
 }
 
-static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
+static void ublk_cancel_cmd(struct ublk_queue *ubq, unsigned tag,
 		unsigned int issue_flags)
 {
+	struct ublk_io *io = &ubq->ios[tag];
+	struct ublk_device *ub = ubq->dev;
+	struct request *req;
 	bool done;
 
 	if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
 		return;
 
+	/*
+	 * Don't try to cancel this command if the request is started for
+	 * avoiding race between io_uring_cmd_done() and
+	 * io_uring_cmd_complete_in_task().
+	 *
+	 * memory barrier is implied in ublk_start_cancel() for ordering to
+	 * WRITE ubq->canceling and READ request state from
+	 * blk_mq_request_started().
+	 *
+	 * If the request state is observed as not started, ublk_queue_rq()
+	 * should observe ubq->canceling, so request can be aborted and this
+	 * uring_cmd won't be used. Otherwise, this uring_cmd will be completed
+	 * from the dispatch code path finally.
+	 */
+	req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
+	if (req && blk_mq_request_started(req))
+		return;
+
 	spin_lock(&ubq->cancel_lock);
 	done = !!(io->flags & UBLK_IO_FLAG_CANCELED);
 	if (!done)
@@ -1722,7 +1749,6 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct ublk_queue *ubq = pdu->ubq;
 	struct task_struct *task;
-	struct ublk_io *io;
 
 	if (WARN_ON_ONCE(!ubq))
 		return;
@@ -1737,9 +1763,8 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	if (!ubq->canceling)
 		ublk_start_cancel(ubq);
 
-	io = &ubq->ios[pdu->tag];
-	WARN_ON_ONCE(io->cmd != cmd);
-	ublk_cancel_cmd(ubq, io, issue_flags);
+	WARN_ON_ONCE(ubq->ios[pdu->tag].cmd != cmd);
+	ublk_cancel_cmd(ubq, pdu->tag, issue_flags);
 }
 
 static inline bool ublk_queue_ready(struct ublk_queue *ubq)
@@ -1752,7 +1777,7 @@ static void ublk_cancel_queue(struct ublk_queue *ubq)
 	int i;
 
 	for (i = 0; i < ubq->q_depth; i++)
-		ublk_cancel_cmd(ubq, &ubq->ios[i], IO_URING_F_UNLOCKED);
+		ublk_cancel_cmd(ubq, i, IO_URING_F_UNLOCKED);
 }
 
 /* Cancel all pending commands, must be called after del_gendisk() returns */
-- 
2.47.0

