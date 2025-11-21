Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D9E283682
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 01:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690371; cv=none; b=t5a4UuIspkgm/rAvyZsUJxhpXAvg8z/7ifLogF8VPFJNrSHqvT+1lQuSIjQk3sF17bqpYGLKjGPOO2CdE2Fd/CkUs5rERi8uokLDEMvA9x2kCw+fTuusBUa3aAMkMaZRas4oyp0amUlrETFPBrMQGvIocwUboPZTMqPq/aDC/Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690371; c=relaxed/simple;
	bh=2sEs+ptW36m+FbqKF4ySBIhs1E5oCnMNQ3hLz1W9yQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uexCCyIOnj/7zutL0zzRt1wBQf/C0fGDmxr2dDtZ9uOZN75zmS1x00YDh0ceLy/k1nPIjpnOzXMHLKtXtqywQOkjrH5HGY/eXN2+PtZjpgyREbLHQ5Ou1iRM72As+jEJws2v1n8/Lqa2G2REMM/qJV7sSydGlHnri37L/t+CtnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PNUC0mis; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNUC0mis"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763690368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzFM7RscsZAkx5obOZIu/ddnHKngMYodVSIc+DQ/QEg=;
	b=PNUC0misRW4tKL/R/+4eq3/T1AMbIVHPRGOKQNfkN/qHDigdxKuzbogQ7i3xSRhPh4PL8y
	cAbLpAji5AdW/8ZmSJ1FbvvVu7nktZLstwfqpMDWZC2M1/hz1lWw0Zrb2ouMwYC8ywgOSq
	QRWJNg1vBNqV9XThimGMGzDTl2jHWtk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-8CSPvGiLNzedJsKOTZQ5Xg-1; Thu,
 20 Nov 2025 20:59:23 -0500
X-MC-Unique: 8CSPvGiLNzedJsKOTZQ5Xg-1
X-Mimecast-MFC-AGG-ID: 8CSPvGiLNzedJsKOTZQ5Xg_1763690362
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50EDA195609F;
	Fri, 21 Nov 2025 01:59:21 +0000 (UTC)
Received: from localhost (unknown [10.72.116.211])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D33D1956045;
	Fri, 21 Nov 2025 01:59:19 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 04/27] ublk: refactor auto buffer register in ublk_dispatch_req()
Date: Fri, 21 Nov 2025 09:58:26 +0800
Message-ID: <20251121015851.3672073-5-ming.lei@redhat.com>
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

Refactor auto buffer register code and prepare for supporting batch IO
feature, and the main motivation is to put 'ublk_io' operation code
together, so that per-io lock can be applied for the code block.

The key changes are:
- Rename ublk_auto_buf_reg() as ublk_do_auto_buf_reg()
- Introduce an enum `auto_buf_reg_res` to represent the result of
  the buffer registration attempt (FAIL, FALLBACK, OK).
- Split the existing `ublk_do_auto_buf_reg` function into two:
  - `__ublk_do_auto_buf_reg`: Performs the actual buffer registration
    and returns the `auto_buf_reg_res` status.
  - `ublk_do_auto_buf_reg`: A wrapper that calls the internal function
    and handles the I/O preparation based on the result.
- Introduce `ublk_prep_auto_buf_reg_io` to encapsulate the logic for
  preparing the I/O for completion after buffer registration.
- Pass the `tag` directly to `ublk_auto_buf_reg_fallback` to avoid
  recalculating it.

This refactoring makes the control flow clearer and isolates the different
stages of the auto buffer registration process.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 64 +++++++++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 21 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f1fa5ceacdf6..b36cd55eceb0 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1168,17 +1168,37 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 }
 
 static void
-ublk_auto_buf_reg_fallback(const struct ublk_queue *ubq, struct ublk_io *io)
+ublk_auto_buf_reg_fallback(const struct ublk_queue *ubq, unsigned tag)
 {
-	unsigned tag = io - ubq->ios;
 	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, tag);
 
 	iod->op_flags |= UBLK_IO_F_NEED_REG_BUF;
 }
 
-static bool ublk_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
-			      struct ublk_io *io, struct io_uring_cmd *cmd,
-			      unsigned int issue_flags)
+enum auto_buf_reg_res {
+	AUTO_BUF_REG_FAIL,
+	AUTO_BUF_REG_FALLBACK,
+	AUTO_BUF_REG_OK,
+};
+
+static void ublk_prep_auto_buf_reg_io(const struct ublk_queue *ubq,
+				      struct request *req, struct ublk_io *io,
+				      struct io_uring_cmd *cmd,
+				      enum auto_buf_reg_res res)
+{
+	if (res == AUTO_BUF_REG_OK) {
+		io->task_registered_buffers = 1;
+		io->buf_ctx_handle = io_uring_cmd_ctx_handle(cmd);
+		io->flags |= UBLK_IO_FLAG_AUTO_BUF_REG;
+	}
+	ublk_init_req_ref(ubq, io);
+	__ublk_prep_compl_io_cmd(io, req);
+}
+
+static enum auto_buf_reg_res
+__ublk_do_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
+		       struct ublk_io *io, struct io_uring_cmd *cmd,
+		       unsigned int issue_flags)
 {
 	int ret;
 
@@ -1186,29 +1206,27 @@ static bool ublk_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
 				      io->buf.auto_reg.index, issue_flags);
 	if (ret) {
 		if (io->buf.auto_reg.flags & UBLK_AUTO_BUF_REG_FALLBACK) {
-			ublk_auto_buf_reg_fallback(ubq, io);
-			return true;
+			ublk_auto_buf_reg_fallback(ubq, req->tag);
+			return AUTO_BUF_REG_FALLBACK;
 		}
 		blk_mq_end_request(req, BLK_STS_IOERR);
-		return false;
+		return AUTO_BUF_REG_FAIL;
 	}
 
-	io->task_registered_buffers = 1;
-	io->buf_ctx_handle = io_uring_cmd_ctx_handle(cmd);
-	io->flags |= UBLK_IO_FLAG_AUTO_BUF_REG;
-	return true;
+	return AUTO_BUF_REG_OK;
 }
 
-static bool ublk_prep_auto_buf_reg(struct ublk_queue *ubq,
-				   struct request *req, struct ublk_io *io,
-				   struct io_uring_cmd *cmd,
-				   unsigned int issue_flags)
+static void ublk_do_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
+				 struct ublk_io *io, struct io_uring_cmd *cmd,
+				 unsigned int issue_flags)
 {
-	ublk_init_req_ref(ubq, io);
-	if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req))
-		return ublk_auto_buf_reg(ubq, req, io, cmd, issue_flags);
+	enum auto_buf_reg_res res = __ublk_do_auto_buf_reg(ubq, req, io, cmd,
+			issue_flags);
 
-	return true;
+	if (res != AUTO_BUF_REG_FAIL) {
+		ublk_prep_auto_buf_reg_io(ubq, req, io, cmd, res);
+		io_uring_cmd_done(cmd, UBLK_IO_RES_OK, issue_flags);
+	}
 }
 
 static bool ublk_start_io(const struct ublk_queue *ubq, struct request *req,
@@ -1281,8 +1299,12 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
 	if (!ublk_start_io(ubq, req, io))
 		return;
 
-	if (ublk_prep_auto_buf_reg(ubq, req, io, io->cmd, issue_flags))
+	if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req)) {
+		ublk_do_auto_buf_reg(ubq, req, io, io->cmd, issue_flags);
+	} else {
+		ublk_init_req_ref(ubq, io);
 		ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags);
+	}
 }
 
 static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
-- 
2.47.0

