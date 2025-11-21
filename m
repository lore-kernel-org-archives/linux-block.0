Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CFA25A64C
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 01:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690359; cv=none; b=ofpKOaeuAVBn1rf2g4EKgEIrq5iy/y6uOhwfxalZ8gIjmZumM6fjtibcD9HungnxIZR3M1UbALXgBgFGfUXGcZpwJmugW8OeTvkSh+6QxlnQVZlzS7dJsmAnnGovEjRF3cDDQPL3qXBiNkABQQ+wXjDRykDknaT5cfAicz5nF8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690359; c=relaxed/simple;
	bh=bTepRVlUnh5zmgP2mbLkSTFzKTwdQ5Nbz+v0A4Zh6Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8mPsz+38x+8rLGx9PQ1vOykoiVJANK4ryBoMDJIm6cNIgBl6t1kB+mRHFwoyyyQpZ1KdS0XWSypMOXizpYWVK6z7ETOYL4F3BFGOvSdR/hRVV0bBH1Zy9TUU1j+VivwKat7Zhy+s2zECDtzEzd92/nqACjNFdMAbENaJPmK6r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T5dFSj1E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5dFSj1E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763690356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ukTf8SMpn9XlUYt2gwe5inrS0HBBtFrJ8LHwKh+e4hU=;
	b=T5dFSj1EbhnCkeXuqGjPZcUwbESbYo6CExjzuaf7zrLdLfgyCOtIzHuq3KAeqy6uMA1p4W
	3DDWo3L7eaSBOUP50nxu9tvCaFzF64yHvqCgd4VprSr/+ZgC+pn/Y7610yP+sRqWiMYGAH
	njSvD9eMbXEwifqZde3wIH0S3bVOaHw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-8xBPPQPsMlWvfj3nQvXqVw-1; Thu,
 20 Nov 2025 20:59:14 -0500
X-MC-Unique: 8xBPPQPsMlWvfj3nQvXqVw-1
X-Mimecast-MFC-AGG-ID: 8xBPPQPsMlWvfj3nQvXqVw_1763690353
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E45311800250;
	Fri, 21 Nov 2025 01:59:12 +0000 (UTC)
Received: from localhost (unknown [10.72.116.211])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D3E71800984;
	Fri, 21 Nov 2025 01:59:10 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 02/27] ublk: add parameter `struct io_uring_cmd *` to ublk_prep_auto_buf_reg()
Date: Fri, 21 Nov 2025 09:58:24 +0800
Message-ID: <20251121015851.3672073-3-ming.lei@redhat.com>
In-Reply-To: <20251121015851.3672073-1-ming.lei@redhat.com>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

