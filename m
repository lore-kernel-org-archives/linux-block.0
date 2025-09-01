Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC2525C83A
	for <linux-block@vger.kernel.org>; Mon,  1 Sep 2025 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720984; cv=none; b=XzK8TBCQnzMo80egLw5xvryOA8swjCF26NkDzReHgLvaHpOwC+/cnc7X+I9SZI3KfWKn8bZpS+D7SeL6euL4D9gfJ1ryy2xyFGvthgvcQb8hT/vekkVHsY3J2zLAmpVn7mYRuQrAI4ENdWyMdZfl/IrMUR7LU3WcIzavAv6jw3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720984; c=relaxed/simple;
	bh=bLEoMJjYtNHO0G5ez3RvC9vFIWTjDZCwg35Ny1+eRjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lku2ULAx4pOJqO+0Nl55lG1xTfGWQ1S3JAlDpnBVXH43H0gDQlG3kAfhECAOdhtLfypDHrROud/KAllY5D9Eme27aKWT6GY4psphKZ3jcFGaKKX5gJUDwPU+iktsYT3+T2Qmb6THgg+3RfPMF6g6Qt8dZ3khvA+52ecq5cnWHuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dv4ebHLn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dv4ebHLn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756720981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iw5meNpxym14v1gVWLlcv9sFJyFN1ypiAzAq+X2CQtM=;
	b=dv4ebHLnuRw1NKSrVikjKrzyR7RVNkw4uZRwpiIlgj4F6a+IQHT/RzkNxF1LScp8mHFQP7
	poZY4kYx5a3fWs/lvPPACMaHAk0NWzocqwKhVDSgq9ZCYdxrDJr/Bs+0Cc/wbCs4awSipe
	MuyYPWruMNFIZx0mwvdiIC5J1IkCrfk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-xz7eOHuwPG629E6H6EeMHg-1; Mon,
 01 Sep 2025 06:02:57 -0400
X-MC-Unique: xz7eOHuwPG629E6H6EeMHg-1
X-Mimecast-MFC-AGG-ID: xz7eOHuwPG629E6H6EeMHg_1756720976
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 374D51800366;
	Mon,  1 Sep 2025 10:02:56 +0000 (UTC)
Received: from localhost (unknown [10.72.116.17])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F03F1800447;
	Mon,  1 Sep 2025 10:02:54 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 01/23] ublk: add parameter `struct io_uring_cmd *` to ublk_prep_auto_buf_reg()
Date: Mon,  1 Sep 2025 18:02:18 +0800
Message-ID: <20250901100242.3231000-2-ming.lei@redhat.com>
In-Reply-To: <20250901100242.3231000-1-ming.lei@redhat.com>
References: <20250901100242.3231000-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add parameter `struct io_uring_cmd *` to ublk_prep_auto_buf_reg() and
prepare for reusing this helper for the coming UBLK_BATCH_IO feature,
which can fetch & commit one batch of io commands via single uring_cmd.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 99abd67b708b..040528ad5d30 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1213,11 +1213,12 @@ ublk_auto_buf_reg_fallback(const struct ublk_queue *ubq, struct ublk_io *io)
 }
 
 static bool ublk_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
-			      struct ublk_io *io, unsigned int issue_flags)
+			      struct ublk_io *io, struct io_uring_cmd *cmd,
+			      unsigned int issue_flags)
 {
 	int ret;
 
-	ret = io_buffer_register_bvec(io->cmd, req, ublk_io_release,
+	ret = io_buffer_register_bvec(cmd, req, ublk_io_release,
 				      io->buf.index, issue_flags);
 	if (ret) {
 		if (io->buf.flags & UBLK_AUTO_BUF_REG_FALLBACK) {
@@ -1229,18 +1230,19 @@ static bool ublk_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
 	}
 
 	io->task_registered_buffers = 1;
-	io->buf_ctx_handle = io_uring_cmd_ctx_handle(io->cmd);
+	io->buf_ctx_handle = io_uring_cmd_ctx_handle(cmd);
 	io->flags |= UBLK_IO_FLAG_AUTO_BUF_REG;
 	return true;
 }
 
 static bool ublk_prep_auto_buf_reg(struct ublk_queue *ubq,
 				   struct request *req, struct ublk_io *io,
+				   struct io_uring_cmd *cmd,
 				   unsigned int issue_flags)
 {
 	ublk_init_req_ref(ubq, io);
 	if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req))
-		return ublk_auto_buf_reg(ubq, req, io, issue_flags);
+		return ublk_auto_buf_reg(ubq, req, io, cmd, issue_flags);
 
 	return true;
 }
@@ -1315,7 +1317,7 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
 	if (!ublk_start_io(ubq, req, io))
 		return;
 
-	if (ublk_prep_auto_buf_reg(ubq, req, io, issue_flags))
+	if (ublk_prep_auto_buf_reg(ubq, req, io, io->cmd, issue_flags))
 		ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags);
 }
 
-- 
2.47.0

