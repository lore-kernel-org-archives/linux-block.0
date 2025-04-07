Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C25D253F30
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031758; cv=none; b=d6vE+ULgsGrqEFD4UjGWcJMPqhcyCO7LuUUFHE4ibC528gEF66AWOSgKpSPunDCcPwM+M0kkHtCY6C+PgdPnvKKXQpJIq7yz51FEBU4tuoABzCk2phRkmig2J2en1p2CpdAQBvHH2MmGtWWGI6PQwgxlTjuIQDje6z4uOMlCZzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031758; c=relaxed/simple;
	bh=Ieluj13KN9IX3gvgona5k3jidMCRjIdN3NIF6dFAaX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+a2mgRa0jarkWGvb7AZd7o616qLZlsSnILtxLrK5odEnFxTAnoIfns+O4RYxjl/IAJVadts4w+SFSjvmcergbj/0l7X2g5bohCkgFQ0ObmAnlnLA4PzZ7R8TmX+iwk5vtY3sotlteQaeY/g9gG+9oXlBqY/Q8PKcX+4tENUjxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GrL+JPFb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrL+JPFb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744031756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mef04b3Clp5tca7zXspfwwlUO3Z3Fq+fgjt6B0Y/HgU=;
	b=GrL+JPFbZnbxo8YLZvfSAY4yee44e/MQCoLFS7mVoMFjgeSrEarw40uwHenod2ireL9f04
	4szQc4GBDFmsd6cmQH2Tio5gbfznQJP9T2EgiWT0JBUXZJxyphxvs/FQ56Na/fYkPUKAbQ
	5tU41Qh7Ha3fKqIUykDrS8xWV3NK3Yk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-pJAIRYJkNJqF1ZkPGTJ8EA-1; Mon,
 07 Apr 2025 09:15:50 -0400
X-MC-Unique: pJAIRYJkNJqF1ZkPGTJ8EA-1
X-Mimecast-MFC-AGG-ID: pJAIRYJkNJqF1ZkPGTJ8EA_1744031749
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13446180AF59;
	Mon,  7 Apr 2025 13:15:49 +0000 (UTC)
Received: from localhost (unknown [10.72.120.16])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EEF7419541A6;
	Mon,  7 Apr 2025 13:15:47 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 01/13] ublk: delay aborting zc request until io_uring returns the buffer
Date: Mon,  7 Apr 2025 21:15:12 +0800
Message-ID: <20250407131526.1927073-2-ming.lei@redhat.com>
In-Reply-To: <20250407131526.1927073-1-ming.lei@redhat.com>
References: <20250407131526.1927073-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

When one request buffer is leased to io_uring via
io_buffer_register_bvec(), io_uring guarantees that the buffer will
be returned. However ublk aborts request in case that io_uring context
is exiting, then ublk_io_release() may observe freed request, and
kernel panic is triggered.

Fix the issue by delaying to abort zc request until io_uring returns
the buffer back.

Cc: Keith Busch <kbusch@kernel.org>
Fixes: 1f6540e2aabb ("ublk: zc register/unregister bvec")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2fd05c1bd30b..76caec28e5ac 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -140,6 +140,17 @@ struct ublk_uring_cmd_pdu {
  */
 #define UBLK_IO_FLAG_NEED_GET_DATA 0x08
 
+
+/*
+ * Set when this request buffer is leased to ublk server, and cleared when
+ * the buffer is returned back.
+ *
+ * If this flag is set, this request can't be aborted until buffer is
+ * returned back from io_uring since io_uring is guaranteed to release the
+ * buffer.
+ */
+#define UBLK_IO_FLAG_BUF_LEASED   0x10
+
 /* atomic RW with ubq->cancel_lock */
 #define UBLK_IO_FLAG_CANCELED	0x80000000
 
@@ -1550,7 +1561,8 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 			rq = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], i);
 			if (rq && blk_mq_request_started(rq)) {
 				io->flags |= UBLK_IO_FLAG_ABORTED;
-				__ublk_fail_req(ubq, io, rq);
+				if (!(io->flags & UBLK_IO_FLAG_BUF_LEASED))
+					__ublk_fail_req(ubq, io, rq);
 			}
 		}
 	}
@@ -1874,8 +1886,18 @@ static void ublk_io_release(void *priv)
 {
 	struct request *rq = priv;
 	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
+	struct ublk_io *io = &ubq->ios[rq->tag];
 
-	ublk_put_req_ref(ubq, rq);
+	io->flags &= ~UBLK_IO_FLAG_BUF_LEASED;
+	/*
+	 * request has been aborted, and the queue context is exiting,
+	 * and ublk server can't be relied for completing this IO cmd,
+	 * so force to complete it
+	 */
+	if (unlikely(io->flags & UBLK_IO_FLAG_ABORTED))
+		__ublk_complete_rq(rq);
+	else
+		ublk_put_req_ref(ubq, rq);
 }
 
 static int ublk_register_io_buf(struct io_uring_cmd *cmd,
@@ -1958,7 +1980,10 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	ret = -EINVAL;
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_REGISTER_IO_BUF:
-		return ublk_register_io_buf(cmd, ubq, tag, ub_cmd->addr, issue_flags);
+		ret = ublk_register_io_buf(cmd, ubq, tag, ub_cmd->addr, issue_flags);
+		if (!ret)
+			io->flags |= UBLK_IO_FLAG_BUF_LEASED;
+		return ret;
 	case UBLK_IO_UNREGISTER_IO_BUF:
 		return ublk_unregister_io_buf(cmd, ub_cmd->addr, issue_flags);
 	case UBLK_IO_FETCH_REQ:
-- 
2.47.0

