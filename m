Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668963148C1
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233578; cv=none; b=Pru5mJagEC0DJi+A1PwQtt2kBxmGqejhUk3AoAa86yEeuXFxCDFgjYoIV1hRoNmIiRr4IxBlfkmKU1pbiSwz3w8ZcrX7BCBvfkd1KwpkqGF2wgPXSdZMbrXUN+4Iv7UPJdPkJI8WbS7wadC78y2AkTpBZtRle9pxZARwHFyDdTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233578; c=relaxed/simple;
	bh=/E6+zuxtc35At2utcmg2KvBCuJlg1v8We/YGtP8gA+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gY/+/xhnsl1iOD7/9UXxXxklemhNHF6UubcAmQc/7cQNYz/Hc/K/E8asrHjZsGHbioWGAzvjjtOibo5R9r9tI4q7kP+4u97kurgk6C656xB8jiDK9jAR4tvCvTBVawbcWPe70X/ZCwgi2AsNMzI2+uiheWcSD39l8BnJhTA6j6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/Qo1roF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/Qo1roF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761233575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZTq9MhaOZRyf1Y95pmOTulVDUR5LCtoVmxYvZikDK9o=;
	b=N/Qo1roFCs5vJ/quVCJiRBbff4AmPO69UUsl7UejAeXjCuNytxMsSo6g/fTa9QWZkm0Suo
	bmexkGLEFo8R3kSP8LqL07z/vDdKajYPBLotNYZITL4uF5U+9SBObTTgvGg0pf3UqAiG88
	AMRfItPLXxy9gIMOZ6knHGFhwcnEW7Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-iseAkjoqPpexmZxuO9QphQ-1; Thu,
 23 Oct 2025 11:32:52 -0400
X-MC-Unique: iseAkjoqPpexmZxuO9QphQ-1
X-Mimecast-MFC-AGG-ID: iseAkjoqPpexmZxuO9QphQ_1761233571
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 379A0180120B;
	Thu, 23 Oct 2025 15:32:51 +0000 (UTC)
Received: from localhost (unknown [10.72.120.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC252180035A;
	Thu, 23 Oct 2025 15:32:49 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 01/25] ublk: add parameter `struct io_uring_cmd *` to ublk_prep_auto_buf_reg()
Date: Thu, 23 Oct 2025 23:32:06 +0800
Message-ID: <20251023153234.2548062-2-ming.lei@redhat.com>
In-Reply-To: <20251023153234.2548062-1-ming.lei@redhat.com>
References: <20251023153234.2548062-1-ming.lei@redhat.com>
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

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 0c74a41a6753..f92717ef3ede 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1242,11 +1242,12 @@ ublk_auto_buf_reg_fallback(const struct ublk_queue *ubq, struct ublk_io *io)
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
@@ -1258,18 +1259,19 @@ static bool ublk_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
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
@@ -1344,7 +1346,7 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
 	if (!ublk_start_io(ubq, req, io))
 		return;
 
-	if (ublk_prep_auto_buf_reg(ubq, req, io, issue_flags))
+	if (ublk_prep_auto_buf_reg(ubq, req, io, io->cmd, issue_flags))
 		ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags);
 }
 
-- 
2.47.0

