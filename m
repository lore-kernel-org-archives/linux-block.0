Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCCF12E5D
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 02:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747796130; cv=none; b=HO/XrAnqVHIHSojalHgI+JpMIFe8REkxVddvKnGN9akbZQOTpEgnH4PqJqkfUplB+9Gjw90iEbr2481wakaAUWfVTjB8AqGbmy3TQBHfDOTZXwtNaQnJrXO5doIjTC66A7Ssnl7b/ZEvou3N/Hj78oWZly5bgZDEesIlVwL+r4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747796130; c=relaxed/simple;
	bh=U7gCS/y0XkROB4d9jtELrAqH/KhXZlhnk4lrZXwyF9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCoQRgoD2MO6sldQyIRXSk93VX79YtueakqPTRN73TETlB0D+IEbeUs6m9+3rBwUTddD9ddM556NBKdcvevSkg0gfnKg6zFBhmPZkxF9oDaiC5l8FGBCqbqKNWSAYH41Ev3zSvDoEGKnlOjZM8u1VIkRwtvsPSdigUFOD7m9N+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CfsinqWJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CfsinqWJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747796127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wdbP6doy6736iUgJz1vkRO7STWqM8tDzc9uq52zHAHI=;
	b=CfsinqWJDmrnFaVs1zuPzOfov5CPOBEsx67OQjSoU8UCY0PzI8uUubjUDEFkCwG1Pjfis5
	KAyioikSp20EeMv5/reBl0BQHh0mSKrU/wcWMfZl11TNWIfH9cb8JA030RLFE5DTAk03Ll
	hCpdA9A+rzlzBB/hwX7sUwZ/zjJouwU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-gIrA3b_OPdyLCGMF2jTbfw-1; Tue,
 20 May 2025 22:55:24 -0400
X-MC-Unique: gIrA3b_OPdyLCGMF2jTbfw-1
X-Mimecast-MFC-AGG-ID: gIrA3b_OPdyLCGMF2jTbfw_1747796121
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E15418003FC;
	Wed, 21 May 2025 02:55:21 +0000 (UTC)
Received: from localhost (unknown [10.72.116.109])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1668318004A7;
	Wed, 21 May 2025 02:55:19 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] ublk: run auto buf unregisgering in same io_ring_ctx with register
Date: Wed, 21 May 2025 10:55:00 +0800
Message-ID: <20250521025502.71041-3-ming.lei@redhat.com>
In-Reply-To: <20250521025502.71041-1-ming.lei@redhat.com>
References: <20250521025502.71041-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

UBLK_F_AUTO_BUF_REG requires that the buffer registered automatically
is unregistered in same `io_ring_ctx`, so check it explicitly.

Meantime return the failure code if io_buffer_unregister_bvec() fails,
then ublk server can handle the failure in consistent way.

Also force to clear UBLK_IO_FLAG_AUTO_BUF_REG in ublk_io_release()
because ublk_io_release() may be triggered not from handling
UBLK_IO_COMMIT_AND_FETCH_REQ, and from releasing the `io_ring_ctx`
for registering the buffer.

Fixes: 99c1e4eb6a3f ("ublk: register buffer to local io_uring with provided buf index via UBLK_F_AUTO_BUF_REG")
Reported-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 35 +++++++++++++++++++++++++++++++----
 include/uapi/linux/ublk_cmd.h |  3 ++-
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index fcf568b89370..2af6422d6a89 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -84,6 +84,7 @@ struct ublk_rq_data {
 
 	/* for auto-unregister buffer in case of UBLK_F_AUTO_BUF_REG */
 	u16 buf_index;
+	unsigned long buf_ctx_id;
 };
 
 struct ublk_uring_cmd_pdu {
@@ -1192,6 +1193,11 @@ static void ublk_auto_buf_reg_fallback(struct request *req, struct ublk_io *io)
 	refcount_set(&data->ref, 1);
 }
 
+static unsigned long ublk_uring_cmd_ctx_id(struct io_uring_cmd *cmd)
+{
+	return (unsigned long)(cmd_to_io_kiocb(cmd)->ctx);
+}
+
 static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
 			      unsigned int issue_flags)
 {
@@ -1211,6 +1217,8 @@ static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
 	}
 	/* one extra reference is dropped by ublk_io_release */
 	refcount_set(&data->ref, 2);
+
+	data->buf_ctx_id = ublk_uring_cmd_ctx_id(io->cmd);
 	/* store buffer index in request payload */
 	data->buf_index = pdu->buf.index;
 	io->flags |= UBLK_IO_FLAG_AUTO_BUF_REG;
@@ -1994,6 +2002,21 @@ static void ublk_io_release(void *priv)
 {
 	struct request *rq = priv;
 	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
+	struct ublk_io *io = &ubq->ios[rq->tag];
+
+	/*
+	 * In case of UBLK_F_AUTO_BUF_REG, the `io_uring_ctx` for registering
+	 * this buffer may be released, so we reach here not from handling
+	 * `UBLK_IO_COMMIT_AND_FETCH_REQ`.
+	 *
+	 * Force to clear UBLK_IO_FLAG_AUTO_BUF_REG, so that ublk server
+	 * still may complete this IO request by issuing uring_cmd from
+	 * another `io_uring_ctx` in case that the `io_ring_ctx` for
+	 * registering the buffer is gone
+	 */
+	if (ublk_support_auto_buf_reg(ubq) &&
+			(io->flags & UBLK_IO_FLAG_AUTO_BUF_REG))
+		io->flags &= ~UBLK_IO_FLAG_AUTO_BUF_REG;
 
 	ublk_put_req_ref(ubq, rq);
 }
@@ -2109,14 +2132,18 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 	}
 
 	if (ublk_support_auto_buf_reg(ubq)) {
+		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
 		int ret;
 
 		if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG) {
-			struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
 
-			WARN_ON_ONCE(io_buffer_unregister_bvec(cmd,
-						data->buf_index,
-						issue_flags));
+			if (data->buf_ctx_id != ublk_uring_cmd_ctx_id(cmd))
+				return -EBADF;
+
+			ret = io_buffer_unregister_bvec(cmd, data->buf_index,
+							issue_flags);
+			if (ret)
+				return ret;
 			io->flags &= ~UBLK_IO_FLAG_AUTO_BUF_REG;
 		}
 
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index c4b9942697fc..3db604a3045e 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -226,7 +226,8 @@
  *
  * For using this feature:
  *
- * - ublk server has to create sparse buffer table
+ * - ublk server has to create sparse buffer table on the same `io_ring_ctx`
+ *   for issuing `UBLK_IO_FETCH_REQ` and `UBLK_IO_COMMIT_AND_FETCH_REQ`
  *
  * - ublk server passes auto buf register data via uring_cmd's sqe->addr,
  *   `struct ublk_auto_buf_reg` is populated from sqe->addr, please see
-- 
2.47.0

