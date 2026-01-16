Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE1C32BF51
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573223; cv=none; b=WiKNTSdIvrRtPGF12adJC6fMORQG0VTfQU1JXUusdmlTAYpKNTxV/fc4XKQ8274lq/K1s3j4qR20bnL9gYtlmqstQCul1g54Z+DfvKFw32n16q+X0T9pa+32PCmK4+yqCbHgz4VswATMYCqH3rBe9FHO9/Xwnz36W5+LAhwFMS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573223; c=relaxed/simple;
	bh=L92/ImjpXwMrsYJfdKzLJqeujYX+xnx3PspaP4kW7us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7yq6+Bpwh/eGNnAfQiAtL4oMzifIqguqAu7sAR8soMEGDkZVmnwKZGz0qVyOwhuRkxmMzGaU1X1yobjJGVkJl/AORWqz8madU2D+LddiqsroGwVJ65N5kkRspihNavVWa3X6ncDlckNhDy5yTaueVbxi5CtbRDsoc/AWmmoCHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EiWxvmOv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EiWxvmOv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768573217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQB5W5FH3pR6W1G8zoMgE7xGbu8+zvpljpRTILIGylo=;
	b=EiWxvmOvAY4ye9gdy/+6MCrQsbpDBT7cR7FToE9ZmZFF4D50lCRAMv4xbXr8TqPEx/I7jv
	MBWHbebG7Rt9IUUhU8Qry4vuzGjTVLUB2L5A0Sz99y4TlG894ZtYh6mtXeoPdmA1sQmCxx
	WamqjjyHQ/Aasz7ZnUJs8yt/p8KtQhQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-hzKsOZ-HN36bRAWI8jHnyQ-1; Fri,
 16 Jan 2026 09:20:13 -0500
X-MC-Unique: hzKsOZ-HN36bRAWI8jHnyQ-1
X-Mimecast-MFC-AGG-ID: hzKsOZ-HN36bRAWI8jHnyQ_1768573212
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E80551956050;
	Fri, 16 Jan 2026 14:20:11 +0000 (UTC)
Received: from localhost (unknown [10.72.116.198])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D5CE21955F22;
	Fri, 16 Jan 2026 14:20:10 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 13/24] ublk: implement batch request completion via blk_mq_end_request_batch()
Date: Fri, 16 Jan 2026 22:18:46 +0800
Message-ID: <20260116141859.719929-14-ming.lei@redhat.com>
In-Reply-To: <20260116141859.719929-1-ming.lei@redhat.com>
References: <20260116141859.719929-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Reduce overhead when completing multiple requests in batch I/O mode by
accumulating them in an io_comp_batch structure and completing them
together via blk_mq_end_request_batch(). This minimizes per-request
completion overhead and improves performance for high IOPS workloads.

The implementation adds an io_comp_batch pointer to struct ublk_io and
initializes it in __ublk_fetch(). For batch I/O, the pointer is set to
the batch structure in ublk_batch_commit_io(). The __ublk_complete_rq()
function uses io->iob to call blk_mq_add_to_batch() for batch mode.
After processing all batch I/Os, the completion callback is invoked in
ublk_handle_batch_commit_cmd() to complete all accumulated requests
efficiently.

So far just covers direct completion. For deferred completion(zero copy,
auto buffer reg), ublk_io_release() is often delayed in freeing buffer
consumer io_uring request's code path, so this patch often doesn't work,
also it is hard to pass the per-task 'struct io_comp_batch' for deferred
completion.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2783af67ed10..e6e746cd369e 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -136,6 +136,7 @@ struct ublk_batch_io_data {
 	struct io_uring_cmd *cmd;
 	struct ublk_batch_io header;
 	unsigned int issue_flags;
+	struct io_comp_batch *iob;
 };
 
 /*
@@ -691,7 +692,7 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 #endif
 
 static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
-				      bool need_map);
+				      bool need_map, struct io_comp_batch *iob);
 
 static dev_t ublk_chr_devt;
 static const struct class ublk_chr_class = {
@@ -1001,7 +1002,7 @@ static inline void ublk_put_req_ref(struct ublk_io *io, struct request *req)
 		return;
 
 	/* ublk_need_map_io() and ublk_need_req_ref() are mutually exclusive */
-	__ublk_complete_rq(req, io, false);
+	__ublk_complete_rq(req, io, false, NULL);
 }
 
 static inline bool ublk_sub_req_ref(struct ublk_io *io)
@@ -1388,7 +1389,7 @@ static void ublk_end_request(struct request *req, blk_status_t error)
 
 /* todo: handle partial completion */
 static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
-				      bool need_map)
+				      bool need_map, struct io_comp_batch *iob)
 {
 	unsigned int unmapped_bytes;
 	blk_status_t res = BLK_STS_OK;
@@ -1442,8 +1443,11 @@ static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
 	local_bh_enable();
 	if (requeue)
 		blk_mq_requeue_request(req, true);
-	else if (likely(!blk_should_fake_timeout(req->q)))
+	else if (likely(!blk_should_fake_timeout(req->q))) {
+		if (blk_mq_add_to_batch(req, iob, false, blk_mq_end_request_batch))
+			return;
 		__blk_mq_end_request(req, BLK_STS_OK);
+	}
 
 	return;
 exit:
@@ -2478,7 +2482,7 @@ static void __ublk_fail_req(struct ublk_device *ub, struct ublk_io *io,
 		blk_mq_requeue_request(req, false);
 	else {
 		io->res = -EIO;
-		__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub));
+		__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub), NULL);
 	}
 }
 
@@ -3214,7 +3218,7 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		if (req_op(req) == REQ_OP_ZONE_APPEND)
 			req->__sector = addr;
 		if (compl)
-			__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub));
+			__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub), NULL);
 
 		if (ret)
 			goto out;
@@ -3533,11 +3537,11 @@ static int ublk_batch_commit_io(struct ublk_queue *ubq,
 	if (req_op(req) == REQ_OP_ZONE_APPEND)
 		req->__sector = ublk_batch_zone_lba(uc, elem);
 	if (compl)
-		__ublk_complete_rq(req, io, ublk_dev_need_map_io(data->ub));
+		__ublk_complete_rq(req, io, ublk_dev_need_map_io(data->ub), data->iob);
 	return 0;
 }
 
-static int ublk_handle_batch_commit_cmd(const struct ublk_batch_io_data *data)
+static int ublk_handle_batch_commit_cmd(struct ublk_batch_io_data *data)
 {
 	const struct ublk_batch_io *uc = &data->header;
 	struct io_uring_cmd *cmd = data->cmd;
@@ -3546,10 +3550,15 @@ static int ublk_handle_batch_commit_cmd(const struct ublk_batch_io_data *data)
 		.total = uc->nr_elem * uc->elem_bytes,
 		.elem_bytes = uc->elem_bytes,
 	};
+	DEFINE_IO_COMP_BATCH(iob);
 	int ret;
 
+	data->iob = &iob;
 	ret = ublk_walk_cmd_buf(&iter, data, ublk_batch_commit_io);
 
+	if (iob.complete)
+		iob.complete(&iob);
+
 	return iter.done == 0 ? ret : iter.done;
 }
 
-- 
2.47.0

