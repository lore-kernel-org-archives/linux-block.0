Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A8D27FD72
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 02:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690422; cv=none; b=e21tkcHrIlNG/pj9cgv3fy/JHi4zZVSTZR7JR+gLR+evvehIOb4OW94NRTVHuGgx/aXx20kvqGYiqRQL5V/oAdHmSAxXyru2ym1p/3rATYJQ4mcD8v5GTNxWKEtVnxW1DX+mKgQEzCMUvpsq6cIwLEBMlweBobwDTVewMosAEBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690422; c=relaxed/simple;
	bh=lZFQkkcIQFUAUsfrreKNnoPIzb8RfsdfF4lwfsW1fR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3Ju847CxfJb9BPSTBrQTOCdnPgShsfFWohj/vIt8avLAPu2+DVkuu+/bUiv1cZb30jz7IzFlnELuGAwozJV+c/CDvXt6Oh/dan4wzI2StLxgRk79UKTw/zWksoPhgQxb0t0aOmOoODlcwiVd0jsrMzs4Av0zPLDVOdgOZOEISs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=clWg0s/T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="clWg0s/T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763690420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lYUBO2QVHXZ0L0CaVikfzhTp2/fJbjkXi40POyUJvkA=;
	b=clWg0s/Tdgx7+YIGwEyb4OZf/K7OpwoMNOXSANvSKpNb3oULPQe2eu9YEd/xa4znWTbSnT
	+XeWmZztDblLkh9PNzPdVuu85iUTkkeWe5RH2IHx9y8FuZVBvttF/zeBm+k0WDu7zFg9Lc
	3isQ0G+z8J4NyrEd1CyxEur/EC5Apog=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-s7UGkC_MMXKZVHrmbcZyQw-1; Thu,
 20 Nov 2025 21:00:18 -0500
X-MC-Unique: s7UGkC_MMXKZVHrmbcZyQw-1
X-Mimecast-MFC-AGG-ID: s7UGkC_MMXKZVHrmbcZyQw_1763690417
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF583180047F;
	Fri, 21 Nov 2025 02:00:16 +0000 (UTC)
Received: from localhost (unknown [10.72.116.211])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0733D1956045;
	Fri, 21 Nov 2025 02:00:15 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 18/27] ublk: implement batch request completion via blk_mq_end_request_batch()
Date: Fri, 21 Nov 2025 09:58:40 +0800
Message-ID: <20251121015851.3672073-19-ming.lei@redhat.com>
In-Reply-To: <20251121015851.3672073-1-ming.lei@redhat.com>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 90cd1863bc83..a5606c7111a4 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -130,6 +130,7 @@ struct ublk_batch_io_data {
 	struct io_uring_cmd *cmd;
 	struct ublk_batch_io header;
 	unsigned int issue_flags;
+	struct io_comp_batch *iob;
 };
 
 /*
@@ -642,7 +643,12 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 #endif
 
 static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
-				      bool need_map);
+				      bool need_map, struct io_comp_batch *iob);
+
+static void ublk_complete_batch(struct io_comp_batch *iob)
+{
+	blk_mq_end_request_batch(iob);
+}
 
 static dev_t ublk_chr_devt;
 static const struct class ublk_chr_class = {
@@ -912,7 +918,7 @@ static inline void ublk_put_req_ref(struct ublk_io *io, struct request *req)
 		return;
 
 	/* ublk_need_map_io() and ublk_need_req_ref() are mutually exclusive */
-	__ublk_complete_rq(req, io, false);
+	__ublk_complete_rq(req, io, false, NULL);
 }
 
 static inline bool ublk_sub_req_ref(struct ublk_io *io)
@@ -1251,7 +1257,7 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
 
 /* todo: handle partial completion */
 static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
-				      bool need_map)
+				      bool need_map, struct io_comp_batch *iob)
 {
 	unsigned int unmapped_bytes;
 	blk_status_t res = BLK_STS_OK;
@@ -1288,8 +1294,11 @@ static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
 
 	if (blk_update_request(req, BLK_STS_OK, io->res))
 		blk_mq_requeue_request(req, true);
-	else if (likely(!blk_should_fake_timeout(req->q)))
+	else if (likely(!blk_should_fake_timeout(req->q))) {
+		if (blk_mq_add_to_batch(req, iob, false, ublk_complete_batch))
+			return;
 		__blk_mq_end_request(req, BLK_STS_OK);
+	}
 
 	return;
 exit:
@@ -2249,7 +2258,7 @@ static void __ublk_fail_req(struct ublk_device *ub, struct ublk_io *io,
 		blk_mq_requeue_request(req, false);
 	else {
 		io->res = -EIO;
-		__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub));
+		__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub), NULL);
 	}
 }
 
@@ -2986,7 +2995,7 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		if (req_op(req) == REQ_OP_ZONE_APPEND)
 			req->__sector = addr;
 		if (compl)
-			__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub));
+			__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub), NULL);
 
 		if (ret)
 			goto out;
@@ -3321,11 +3330,11 @@ static int ublk_batch_commit_io(struct ublk_queue *ubq,
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
@@ -3334,10 +3343,15 @@ static int ublk_handle_batch_commit_cmd(const struct ublk_batch_io_data *data)
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

