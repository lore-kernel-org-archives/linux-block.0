Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3261F20DD48
	for <linux-block@vger.kernel.org>; Mon,  1 Sep 2025 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720988; cv=none; b=COiuCRTWS6A4OCvKmEWzQHZUCOibOUrtVubBvV2+R10p2T1gBVwERi94rbccU/hbRxPG1Sw3AwR28i6npo/rb8BLvotvPdBfxt6rrfX69MYRoYHJ+ZUN2bVf33gAfPkv5tpW/aeh1IaNlPmxLYizHC74JbQ8IYMIjeHlac223GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720988; c=relaxed/simple;
	bh=6zOkSabBhgaxpN14tYdp0h4IpsWbtRNrJF+oqeVQaOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npHG25LZoRn5IkCzYR0RKaOMFJwzfz94WrJT5+RafnvYm12Oa+007NNjCLrd67rRnpw6OUuxUoAbxNsRd8OhRRLTtiN/2L6/Eit6t/ve2EP1WRfUZHH5e05GLcfSfY4H77+/n/age2hw/jFvmifql6osiKU3RbZGYfBqdLk+RFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rt+Lkl74; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rt+Lkl74"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756720986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FnegKdPQBM3bNtrMe6Ap0UU/n5ORLghkF8OBr0w9pCg=;
	b=Rt+Lkl74CrlVVFE5I5jUBy8hr91ucrh/R+dylwbRymQDmQenr9+BzyQT0fbOWnQlJuCRRh
	udCdHVw0XR6wRodu6eCzTchl9jLNzG7mnHTTseYHzAn2BPbUTw005gZoiPBQq/zFg3E4pv
	uU7OvNDG2pm2wS7pYZ4lltjgmkg0vqE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-2p6vdsg0O2WBFTRg9ttvXg-1; Mon,
 01 Sep 2025 06:03:05 -0400
X-MC-Unique: 2p6vdsg0O2WBFTRg9ttvXg-1
X-Mimecast-MFC-AGG-ID: 2p6vdsg0O2WBFTRg9ttvXg_1756720984
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 007D51956055;
	Mon,  1 Sep 2025 10:03:04 +0000 (UTC)
Received: from localhost (unknown [10.72.116.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE4591955EA4;
	Mon,  1 Sep 2025 10:03:02 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 03/23] ublk: refactor auto buffer register in ublk_dispatch_req()
Date: Mon,  1 Sep 2025 18:02:20 +0800
Message-ID: <20250901100242.3231000-4-ming.lei@redhat.com>
In-Reply-To: <20250901100242.3231000-1-ming.lei@redhat.com>
References: <20250901100242.3231000-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 65 +++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 21 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 9185978abeb7..e53f623b0efe 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1205,17 +1205,36 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
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
+				   struct request *req, struct ublk_io *io,
+				   struct io_uring_cmd *cmd, bool registered)
+{
+	if (registered) {
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
 
@@ -1223,29 +1242,27 @@ static bool ublk_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
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
+		ublk_prep_auto_buf_reg_io(ubq, req, io, cmd, res == AUTO_BUF_REG_OK);
+		io_uring_cmd_done(cmd, UBLK_IO_RES_OK, 0, issue_flags);
+	}
 }
 
 static bool ublk_start_io(const struct ublk_queue *ubq, struct request *req,
@@ -1318,8 +1335,14 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
 	if (!ublk_start_io(ubq, req, io))
 		return;
 
-	if (ublk_prep_auto_buf_reg(ubq, req, io, io->cmd, issue_flags))
+	if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req)) {
+		struct io_uring_cmd *cmd = io->cmd;
+
+		ublk_do_auto_buf_reg(ubq, req, io, cmd, issue_flags);
+	} else {
+		ublk_init_req_ref(ubq, io);
 		ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags);
+	}
 }
 
 static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
-- 
2.47.0

