Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9692FD7CA
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 12:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764678083; cv=none; b=ME41WFUjOnwI0ct6G7jnUDM5m5nenVetW+z8LMyJ6GbcZtkJuCn/zhxcEOUHWdZhkENec8UrAbg7gJmmJQ4lTbzdZ5dbIrTXREJVv254wOwyjUHWXGzP/UGRtsN00WpHRdEnxyRrX5nm+2TxsqLSC012tINj9VXUOFZt32e6gm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764678083; c=relaxed/simple;
	bh=yGYVlMNopwPlxgg8gInpHYuu+s52BA+1z+Pad4ACDU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUZtmoLLsauKEyTlpzkKIlEqEjjzZQzGQtEAmRAJy4dcYFNV4t/7wuwM0/kZjxgnFHWMyTwsdkKYaUBf9xLTip4SllxTFporNdzq8kD9E+E9W+eLNKa1vhgAyR0iIk+oxkdKwZzf7IXWZds8pYqgENbBUPWhTkWV/A/EGFCrtNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nflyv1HF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nflyv1HF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764678081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n76+0k7FCqYtu2uE3Wq8X3OGhPq1xGnbSrjW+cyEm3Y=;
	b=Nflyv1HFpgZ3nW9EQqJLwhx/0bo91u3C5eySckwvyekjsdhlToPfC+n/8CV7SbyQ8N1LAG
	k0sEivvWdHZoWDC031T3QtG6q/zkjFdHjMOQLVXKrd0eQ7Sf3I+tVHD7+AKuuRchokyWS7
	l+JKMIUR+dgVDqFx3c70wfSWlHrEqGE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-hvJei8TBMa2Yiv37FdUUaA-1; Tue,
 02 Dec 2025 07:21:17 -0500
X-MC-Unique: hvJei8TBMa2Yiv37FdUUaA-1
X-Mimecast-MFC-AGG-ID: hvJei8TBMa2Yiv37FdUUaA_1764678077
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3EB919560B2;
	Tue,  2 Dec 2025 12:21:16 +0000 (UTC)
Received: from localhost (unknown [10.72.116.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F09E330001A4;
	Tue,  2 Dec 2025 12:21:14 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 12/21] ublk: implement batch request completion via blk_mq_end_request_batch()
Date: Tue,  2 Dec 2025 20:19:06 +0800
Message-ID: <20251202121917.1412280-13-ming.lei@redhat.com>
In-Reply-To: <20251202121917.1412280-1-ming.lei@redhat.com>
References: <20251202121917.1412280-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
index 034420e8df55..0168ee885b2d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -130,6 +130,7 @@ struct ublk_batch_io_data {
 	struct io_uring_cmd *cmd;
 	struct ublk_batch_io header;
 	unsigned int issue_flags;
+	struct io_comp_batch *iob;
 };
 
 /*
@@ -647,7 +648,7 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 #endif
 
 static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
-				      bool need_map);
+				      bool need_map, struct io_comp_batch *iob);
 
 static dev_t ublk_chr_devt;
 static const struct class ublk_chr_class = {
@@ -917,7 +918,7 @@ static inline void ublk_put_req_ref(struct ublk_io *io, struct request *req)
 		return;
 
 	/* ublk_need_map_io() and ublk_need_req_ref() are mutually exclusive */
-	__ublk_complete_rq(req, io, false);
+	__ublk_complete_rq(req, io, false, NULL);
 }
 
 static inline bool ublk_sub_req_ref(struct ublk_io *io)
@@ -1256,7 +1257,7 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
 
 /* todo: handle partial completion */
 static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
-				      bool need_map)
+				      bool need_map, struct io_comp_batch *iob)
 {
 	unsigned int unmapped_bytes;
 	blk_status_t res = BLK_STS_OK;
@@ -1293,8 +1294,11 @@ static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
 
 	if (blk_update_request(req, BLK_STS_OK, io->res))
 		blk_mq_requeue_request(req, true);
-	else if (likely(!blk_should_fake_timeout(req->q)))
+	else if (likely(!blk_should_fake_timeout(req->q))) {
+		if (blk_mq_add_to_batch(req, iob, false, blk_mq_end_request_batch))
+			return;
 		__blk_mq_end_request(req, BLK_STS_OK);
+	}
 
 	return;
 exit:
@@ -2273,7 +2277,7 @@ static void __ublk_fail_req(struct ublk_device *ub, struct ublk_io *io,
 		blk_mq_requeue_request(req, false);
 	else {
 		io->res = -EIO;
-		__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub));
+		__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub), NULL);
 	}
 }
 
@@ -3008,7 +3012,7 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		if (req_op(req) == REQ_OP_ZONE_APPEND)
 			req->__sector = addr;
 		if (compl)
-			__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub));
+			__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub), NULL);
 
 		if (ret)
 			goto out;
@@ -3329,11 +3333,11 @@ static int ublk_batch_commit_io(struct ublk_queue *ubq,
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
@@ -3342,10 +3346,15 @@ static int ublk_handle_batch_commit_cmd(const struct ublk_batch_io_data *data)
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

