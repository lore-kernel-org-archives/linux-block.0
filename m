Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21163280338
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 01:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690369; cv=none; b=TP5iit2szvHgAQLErkmE8af4p0brfnKlCqu5Ws5WA5TOuR4B50xBthHdpu+moQ52UPn1PkfEgCgECEW0oH1gENn4ewMNvVM+rCo+EPCEtLpkUPPLzHzrkyNUwDBbpDNm3P3Vjc0x3sXXUeMECwf+5wo8V4xDiKECThueNwbE02A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690369; c=relaxed/simple;
	bh=ID3VdaatVF2sSDoX38s0c3b1u8IK71WzWOR198pdGR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+Vc46z4m4Jgs4y2AMVPvtkDa9Mi1cLe6het0o3+tcth4S1hD/BdCmb07rEvyWPoLRJqbGYrfgKt751mtdwspw4JkrlhJ8//5KsiUoU9gRTAP1KkuIad924Z0khv5Lf4HxQLDyqqI47G6IHJjDzwEisiiaz9JElOdDEg0pAxw24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=De5352Ol; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="De5352Ol"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763690366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVoBVCrQUYZ9ilGjyioJ6sWCbx0PTCJ/7FPYB9TJGCc=;
	b=De5352OlTvgp0QNDwpn4hWB2wMgyYTIv3CuzdkH7/CKm3+cl3tCVEC/A206YA/XWSWjfxy
	ASMr+k7oKFNvW4FGWbkdk5xpSVb/VrTN+lZHp606Y1syUxOU7/6CN80zUwu+ulul9XyZOV
	wNRUZuzTCktwQUsggG3ZWBn8lDepTj0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-fP1sLXXWNf2FS94u3rdpjg-1; Thu,
 20 Nov 2025 20:59:19 -0500
X-MC-Unique: fP1sLXXWNf2FS94u3rdpjg-1
X-Mimecast-MFC-AGG-ID: fP1sLXXWNf2FS94u3rdpjg_1763690357
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF1B21956088;
	Fri, 21 Nov 2025 01:59:16 +0000 (UTC)
Received: from localhost (unknown [10.72.116.211])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E648830044DB;
	Fri, 21 Nov 2025 01:59:15 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 03/27] ublk: add `union ublk_io_buf` with improved naming
Date: Fri, 21 Nov 2025 09:58:25 +0800
Message-ID: <20251121015851.3672073-4-ming.lei@redhat.com>
In-Reply-To: <20251121015851.3672073-1-ming.lei@redhat.com>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
index 2884e0687e31..f1fa5ceacdf6 100644
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
 
@@ -498,7 +499,7 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 	iod->op_flags = ublk_op | ublk_req_build_flags(req);
 	iod->nr_sectors = blk_rq_sectors(req);
 	iod->start_sector = blk_rq_pos(req);
-	iod->addr = io->addr;
+	iod->addr = io->buf.addr;
 
 	return BLK_STS_OK;
 }
@@ -981,7 +982,7 @@ static unsigned int ublk_map_io(const struct ublk_queue *ubq,
 		struct iov_iter iter;
 		const int dir = ITER_DEST;
 
-		import_ubuf(dir, u64_to_user_ptr(io->addr), rq_bytes, &iter);
+		import_ubuf(dir, u64_to_user_ptr(io->buf.addr), rq_bytes, &iter);
 		return ublk_copy_user_pages(req, 0, &iter, dir);
 	}
 	return rq_bytes;
@@ -1002,7 +1003,7 @@ static unsigned int ublk_unmap_io(bool need_map,
 
 		WARN_ON_ONCE(io->res > rq_bytes);
 
-		import_ubuf(dir, u64_to_user_ptr(io->addr), io->res, &iter);
+		import_ubuf(dir, u64_to_user_ptr(io->buf.addr), io->res, &iter);
 		return ublk_copy_user_pages(req, 0, &iter, dir);
 	}
 	return rq_bytes;
@@ -1068,7 +1069,7 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 	iod->op_flags = ublk_op | ublk_req_build_flags(req);
 	iod->nr_sectors = blk_rq_sectors(req);
 	iod->start_sector = blk_rq_pos(req);
-	iod->addr = io->addr;
+	iod->addr = io->buf.addr;
 
 	return BLK_STS_OK;
 }
@@ -1182,9 +1183,9 @@ static bool ublk_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
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
@@ -1473,7 +1474,7 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 		 */
 		io->flags &= UBLK_IO_FLAG_CANCELED;
 		io->cmd = NULL;
-		io->addr = 0;
+		io->buf.addr = 0;
 
 		/*
 		 * old task is PF_EXITING, put it now
@@ -2034,13 +2035,16 @@ static inline int ublk_check_cmd_op(u32 cmd_op)
 
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
 
@@ -2062,7 +2066,7 @@ static int ublk_handle_auto_buf_reg(struct ublk_io *io,
 		 * this ublk request gets stuck.
 		 */
 		if (io->buf_ctx_handle == io_uring_cmd_ctx_handle(cmd))
-			*buf_idx = io->buf.index;
+			*buf_idx = io->buf.auto_reg.index;
 	}
 
 	return ublk_set_auto_buf_reg(io, cmd);
@@ -2090,7 +2094,7 @@ ublk_config_io_buf(const struct ublk_device *ub, struct ublk_io *io,
 	if (ublk_dev_support_auto_buf_reg(ub))
 		return ublk_handle_auto_buf_reg(io, cmd, buf_idx);
 
-	io->addr = buf_addr;
+	io->buf.addr = buf_addr;
 	return 0;
 }
 
@@ -2287,7 +2291,7 @@ static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io,
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

