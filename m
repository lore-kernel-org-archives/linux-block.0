Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA44D2D3EF1
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233583; cv=none; b=sQ9Iwb7u/HQg+HjFUFabCr4/+Ofldg5UPt8/z98MZhgKXW6CC6imx4biY0WJKQvEB45yR2nbHiMpTk19Z2dfYvtQchzr6vFan1Ii2vb3KwoFNAWtPmlPCDgC1h9uo0VfxEnumMmaGMUGFTAChCcEp0yBLYRHDfybVEzc1eBuUDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233583; c=relaxed/simple;
	bh=Oe/NtJMmPXZxo36g7J82n2i7h9Lud6+VjH8fWiLzp4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjCrJcraCEugJSjJZuot/lt4EbQGUPu+SzshbUUs8DXO3kXz/BByxTZxfVXlVtOenlYLrNIgkg8wP7XYCNBlNvGrquKFqyjRa1Ps1arO2hPXLOYJPj5EdkqH9dRRwI4NAq4id74mGZpbkVYhFOf4YJ25WOU/O+uG+3zwZADQURc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B8l0uhCX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8l0uhCX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761233580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zx/LV4chcX45NrHw5D6Jca3PUBQj7mbd/wgkhn0FAVI=;
	b=B8l0uhCXwjceaXBaUQgHWn1E7I3ECH2L3pSgNcSWm1BYuHdl3J5Wly5cVxVRskHnnqZkbb
	Du7fz943Epd32lhxtP/Q4Iw7wW0qamr7fVLQe+SspISmMojQngZdWx5/AyEC4iVBnF80h7
	Nx+rbyWBETlriYGGwCF4olYB6GAaV6o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-S7Ht-qs8Mx2mvaKnctC1lg-1; Thu,
 23 Oct 2025 11:32:56 -0400
X-MC-Unique: S7Ht-qs8Mx2mvaKnctC1lg-1
X-Mimecast-MFC-AGG-ID: S7Ht-qs8Mx2mvaKnctC1lg_1761233575
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86C951800365;
	Thu, 23 Oct 2025 15:32:55 +0000 (UTC)
Received: from localhost (unknown [10.72.120.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A40B19560B8;
	Thu, 23 Oct 2025 15:32:53 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 02/25] ublk: add `union ublk_io_buf` with improved naming
Date: Thu, 23 Oct 2025 23:32:07 +0800
Message-ID: <20251023153234.2548062-3-ming.lei@redhat.com>
In-Reply-To: <20251023153234.2548062-1-ming.lei@redhat.com>
References: <20251023153234.2548062-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add `union ublk_io_buf` for naming the anonymous union of struct ublk_io's
addr and buf fields, meantime apply it to `struct ublk_io` for storing either
ublk auto buffer register data or ublk server io buffer address.

The union uses clear field names:
- `addr`: for regular ublk server io buffer addresses
- `auto_reg`: for ublk auto buffer registration data

This eliminates confusing access patterns and improves code readability.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f92717ef3ede..b89acfee46c3 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -155,12 +155,13 @@ struct ublk_uring_cmd_pdu {
  */
 #define UBLK_REFCOUNT_INIT (REFCOUNT_MAX / 2)
 
+union ublk_io_buf {
+	__u64	addr;
+	struct ublk_auto_buf_reg auto_reg;
+};
+
 struct ublk_io {
-	/* userspace buffer address from io cmd */
-	union {
-		__u64	addr;
-		struct ublk_auto_buf_reg buf;
-	};
+	union ublk_io_buf buf;
 	unsigned int flags;
 	int res;
 
@@ -499,7 +500,7 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 	iod->op_flags = ublk_op | ublk_req_build_flags(req);
 	iod->nr_sectors = blk_rq_sectors(req);
 	iod->start_sector = blk_rq_pos(req);
-	iod->addr = io->addr;
+	iod->addr = io->buf.addr;
 
 	return BLK_STS_OK;
 }
@@ -1047,7 +1048,7 @@ static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
 		struct iov_iter iter;
 		const int dir = ITER_DEST;
 
-		import_ubuf(dir, u64_to_user_ptr(io->addr), rq_bytes, &iter);
+		import_ubuf(dir, u64_to_user_ptr(io->buf.addr), rq_bytes, &iter);
 		return ublk_copy_user_pages(req, 0, &iter, dir);
 	}
 	return rq_bytes;
@@ -1068,7 +1069,7 @@ static int ublk_unmap_io(bool need_map,
 
 		WARN_ON_ONCE(io->res > rq_bytes);
 
-		import_ubuf(dir, u64_to_user_ptr(io->addr), io->res, &iter);
+		import_ubuf(dir, u64_to_user_ptr(io->buf.addr), io->res, &iter);
 		return ublk_copy_user_pages(req, 0, &iter, dir);
 	}
 	return rq_bytes;
@@ -1134,7 +1135,7 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 	iod->op_flags = ublk_op | ublk_req_build_flags(req);
 	iod->nr_sectors = blk_rq_sectors(req);
 	iod->start_sector = blk_rq_pos(req);
-	iod->addr = io->addr;
+	iod->addr = io->buf.addr;
 
 	return BLK_STS_OK;
 }
@@ -1248,9 +1249,9 @@ static bool ublk_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
 	int ret;
 
 	ret = io_buffer_register_bvec(cmd, req, ublk_io_release,
-				      io->buf.index, issue_flags);
+				      io->buf.auto_reg.index, issue_flags);
 	if (ret) {
-		if (io->buf.flags & UBLK_AUTO_BUF_REG_FALLBACK) {
+		if (io->buf.auto_reg.flags & UBLK_AUTO_BUF_REG_FALLBACK) {
 			ublk_auto_buf_reg_fallback(ubq, io);
 			return true;
 		}
@@ -1539,7 +1540,7 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 		 */
 		io->flags &= UBLK_IO_FLAG_CANCELED;
 		io->cmd = NULL;
-		io->addr = 0;
+		io->buf.addr = 0;
 
 		/*
 		 * old task is PF_EXITING, put it now
@@ -2100,13 +2101,16 @@ static inline int ublk_check_cmd_op(u32 cmd_op)
 
 static inline int ublk_set_auto_buf_reg(struct ublk_io *io, struct io_uring_cmd *cmd)
 {
-	io->buf = ublk_sqe_addr_to_auto_buf_reg(READ_ONCE(cmd->sqe->addr));
+	struct ublk_auto_buf_reg buf;
+
+	buf = ublk_sqe_addr_to_auto_buf_reg(READ_ONCE(cmd->sqe->addr));
 
-	if (io->buf.reserved0 || io->buf.reserved1)
+	if (buf.reserved0 || buf.reserved1)
 		return -EINVAL;
 
-	if (io->buf.flags & ~UBLK_AUTO_BUF_REG_F_MASK)
+	if (buf.flags & ~UBLK_AUTO_BUF_REG_F_MASK)
 		return -EINVAL;
+	io->buf.auto_reg = buf;
 	return 0;
 }
 
@@ -2128,7 +2132,7 @@ static int ublk_handle_auto_buf_reg(struct ublk_io *io,
 		 * this ublk request gets stuck.
 		 */
 		if (io->buf_ctx_handle == io_uring_cmd_ctx_handle(cmd))
-			*buf_idx = io->buf.index;
+			*buf_idx = io->buf.auto_reg.index;
 	}
 
 	return ublk_set_auto_buf_reg(io, cmd);
@@ -2156,7 +2160,7 @@ ublk_config_io_buf(const struct ublk_device *ub, struct ublk_io *io,
 	if (ublk_dev_support_auto_buf_reg(ub))
 		return ublk_handle_auto_buf_reg(io, cmd, buf_idx);
 
-	io->addr = buf_addr;
+	io->buf.addr = buf_addr;
 	return 0;
 }
 
@@ -2353,7 +2357,7 @@ static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io,
 	 */
 	io->flags &= ~UBLK_IO_FLAG_NEED_GET_DATA;
 	/* update iod->addr because ublksrv may have passed a new io buffer */
-	ublk_get_iod(ubq, req->tag)->addr = io->addr;
+	ublk_get_iod(ubq, req->tag)->addr = io->buf.addr;
 	pr_devel("%s: update iod->addr: qid %d tag %d io_flags %x addr %llx\n",
 			__func__, ubq->q_id, req->tag, io->flags,
 			ublk_get_iod(ubq, req->tag)->addr);
-- 
2.47.0

