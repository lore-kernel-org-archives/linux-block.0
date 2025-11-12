Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCBC2FDC41
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940324; cv=none; b=tBBnWnMEpHC8re3qvHNp3Qm7m5e27Esafu8NEEsGCrlvkc6wtLpsYvxaoYTtJ46CE9jUeWDBYwkNDNOpkFo03LWSFv8XZlNx6cvfjJekr+FZT6TqPy2FTM/CMig+M+SltHQavXNFp/F2SFUybMKyr9pODx3MKuK40mDXzFVpz64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940324; c=relaxed/simple;
	bh=bTepRVlUnh5zmgP2mbLkSTFzKTwdQ5Nbz+v0A4Zh6Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uX9f8Y1n4OZbBBpDaEbIa09+o9EswisbSEi7D1TId9e0/TbsKRnnX/HXyT2InDbS1a4TFoK+jMF6BS/4s3q2bsweZkuL3PPDeFIWdFYLTHoljOVTtU6AtNy4QAh9r9U84IrYZ6BX7uxQJHyyJVI3EkmXqGJUQWvrAcoh3ZD5q+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XD1S8WNx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XD1S8WNx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762940321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ukTf8SMpn9XlUYt2gwe5inrS0HBBtFrJ8LHwKh+e4hU=;
	b=XD1S8WNxMG8VK0r4IKv42nPJb7VG4zeb3QJcAjuSW1XcI+ahxnU/vj43oF1ARMqHvJrUei
	vUQjMuYIxKkdyoXjQu9+ebmks3xgZbhJZ5beV7GzIQrK86IBkJZLQzZJGZlpoExaz4oFD9
	2v4j23dOfpwLF2RPLoh72O6lHeJbe+4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-orPHNdZ2O1Wn9A5-nPzcNA-1; Wed,
 12 Nov 2025 04:38:40 -0500
X-MC-Unique: orPHNdZ2O1Wn9A5-nPzcNA-1
X-Mimecast-MFC-AGG-ID: orPHNdZ2O1Wn9A5-nPzcNA_1762940319
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 279021955DD9;
	Wed, 12 Nov 2025 09:38:39 +0000 (UTC)
Received: from localhost (unknown [10.72.116.179])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D24E30044E6;
	Wed, 12 Nov 2025 09:38:37 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 02/27] ublk: add parameter `struct io_uring_cmd *` to ublk_prep_auto_buf_reg()
Date: Wed, 12 Nov 2025 17:37:40 +0800
Message-ID: <20251112093808.2134129-3-ming.lei@redhat.com>
In-Reply-To: <20251112093808.2134129-1-ming.lei@redhat.com>
References: <20251112093808.2134129-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add parameter `struct io_uring_cmd *` to ublk_prep_auto_buf_reg() and
prepare for reusing this helper for the coming UBLK_BATCH_IO feature,
which can fetch & commit one batch of io commands via single uring_cmd.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 75f210523e52..2884e0687e31 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1176,11 +1176,12 @@ ublk_auto_buf_reg_fallback(const struct ublk_queue *ubq, struct ublk_io *io)
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
@@ -1192,18 +1193,19 @@ static bool ublk_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
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
@@ -1278,7 +1280,7 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
 	if (!ublk_start_io(ubq, req, io))
 		return;
 
-	if (ublk_prep_auto_buf_reg(ubq, req, io, issue_flags))
+	if (ublk_prep_auto_buf_reg(ubq, req, io, io->cmd, issue_flags))
 		ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags);
 }
 
-- 
2.47.0

