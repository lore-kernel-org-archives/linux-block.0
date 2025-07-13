Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ABD8836
	for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752417310; cv=none; b=QZB7VgZclwGsf6NPdXUd1nNJea+/SZhEYkdNl8Cas7JDMNRK/PSsTFl02Rbrv2472H9BNODRkpiWXglbNMVFlsdMDPnW83zct84Srf1pDxxR/yuePY7ynGT/NTfpf6EUSERqSRKLaFkFf9/T3suciMysLT0JEaDG5bwoG4iiEZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752417310; c=relaxed/simple;
	bh=pmz83P5HsoU8a2w3sSZZ9Z0jbfTN3CDFNuWooclRakM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/LNY2ocslW+u1kRZsXOljxdFsDd3DH0bDyCzVl1Xk9rgtFOk7lNhJj5Rvbg0Vq8kK+lYdetlZqcUoAMZMxjduFGVijLdxvZUOSV/bmtqSJf7HiaspuhiIoWy3fEPvMM+ZFSKy0qeeqgCjehBi2ivvCOn5pTcdiZgKl93xfkIa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T/sPjnDU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/sPjnDU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752417307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMpLj2zQ7MHv4DEYAixMS8FhTgnBE/7V1tSs0vQohyY=;
	b=T/sPjnDUDmd9X8Q9jjlk6OS1KMByRKmxf0AWLDRFp6rVfS2o9Zal93Y1Spnj0NHPrDqHGL
	l1ecXsI63xXiYiXoqiMfnzRD9YhumSf2uHXa9vOd959dLjkOa9CEbU2vYBcTdnaD7oL2Q3
	+apJTu42Ph3EGNluCVOHk5Rt49kiQvQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-raqXvh-0OWmohLdWfnEcrQ-1; Sun,
 13 Jul 2025 10:35:03 -0400
X-MC-Unique: raqXvh-0OWmohLdWfnEcrQ-1
X-Mimecast-MFC-AGG-ID: raqXvh-0OWmohLdWfnEcrQ_1752417302
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CFF319560B2;
	Sun, 13 Jul 2025 14:35:02 +0000 (UTC)
Received: from localhost (unknown [10.72.116.36])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 833AB180035E;
	Sun, 13 Jul 2025 14:34:59 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 07/17] ublk: store auto buffer register data into `struct ublk_io`
Date: Sun, 13 Jul 2025 22:34:02 +0800
Message-ID: <20250713143415.2857561-8-ming.lei@redhat.com>
In-Reply-To: <20250713143415.2857561-1-ming.lei@redhat.com>
References: <20250713143415.2857561-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

We can share space of `io->addr` for storing auto buffer register data
and user space buffer address.

So store auto buffer register data into `struct ublk_io`.

Prepare for supporting batch IO in which many ublk IOs share single
uring_cmd, so we can't store auto buffer register data into uring_cmd
pdu.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f70fab36fbc7..c69d4fafc6cc 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -105,8 +105,6 @@ struct ublk_uring_cmd_pdu {
 	 */
 	struct ublk_queue *ubq;
 
-	struct ublk_auto_buf_reg buf;
-
 	u16 tag;
 };
 
@@ -159,7 +157,10 @@ struct ublk_uring_cmd_pdu {
 
 struct ublk_io {
 	/* userspace buffer address from io cmd */
-	__u64	addr;
+	union {
+		__u64	addr;
+		struct ublk_auto_buf_reg buf;
+	};
 	unsigned int flags;
 	int res;
 
@@ -187,8 +188,6 @@ struct ublk_io {
 	/* Count of buffers registered on task and not yet unregistered */
 	unsigned task_registered_buffers;
 
-	/* auto-registered buffer, valid if UBLK_IO_FLAG_AUTO_BUF_REG is set */
-	u16 buf_index;
 	void *buf_ctx_handle;
 } ____cacheline_aligned_in_smp;
 
@@ -1217,13 +1216,12 @@ ublk_auto_buf_reg_fallback(const struct ublk_queue *ubq, struct ublk_io *io)
 static bool ublk_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
 			      struct ublk_io *io, unsigned int issue_flags)
 {
-	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(io->cmd);
 	int ret;
 
 	ret = io_buffer_register_bvec(io->cmd, req, ublk_io_release,
-				      pdu->buf.index, issue_flags);
+				      io->buf.index, issue_flags);
 	if (ret) {
-		if (pdu->buf.flags & UBLK_AUTO_BUF_REG_FALLBACK) {
+		if (io->buf.flags & UBLK_AUTO_BUF_REG_FALLBACK) {
 			ublk_auto_buf_reg_fallback(ubq, io);
 			return true;
 		}
@@ -1233,8 +1231,6 @@ static bool ublk_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
 
 	io->task_registered_buffers = 1;
 	io->buf_ctx_handle = io_uring_cmd_ctx_handle(io->cmd);
-	/* store buffer index in request payload */
-	io->buf_index = pdu->buf.index;
 	io->flags |= UBLK_IO_FLAG_AUTO_BUF_REG;
 	return true;
 }
@@ -2011,16 +2007,14 @@ static inline int ublk_check_cmd_op(u32 cmd_op)
 	return 0;
 }
 
-static inline int ublk_set_auto_buf_reg(struct io_uring_cmd *cmd)
+static inline int ublk_set_auto_buf_reg(struct ublk_io *io, struct io_uring_cmd *cmd)
 {
-	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
-
-	pdu->buf = ublk_sqe_addr_to_auto_buf_reg(READ_ONCE(cmd->sqe->addr));
+	io->buf = ublk_sqe_addr_to_auto_buf_reg(READ_ONCE(cmd->sqe->addr));
 
-	if (pdu->buf.reserved0 || pdu->buf.reserved1)
+	if (io->buf.reserved0 || io->buf.reserved1)
 		return -EINVAL;
 
-	if (pdu->buf.flags & ~UBLK_AUTO_BUF_REG_F_MASK)
+	if (io->buf.flags & ~UBLK_AUTO_BUF_REG_F_MASK)
 		return -EINVAL;
 	return 0;
 }
@@ -2043,10 +2037,10 @@ static int ublk_handle_auto_buf_reg(struct ublk_io *io,
 		 * this ublk request gets stuck.
 		 */
 		if (io->buf_ctx_handle == io_uring_cmd_ctx_handle(cmd))
-			*buf_idx = io->buf_index;
+			*buf_idx = io->buf.index;
 	}
 
-	return ublk_set_auto_buf_reg(cmd);
+	return ublk_set_auto_buf_reg(io, cmd);
 }
 
 /* Once we return, `io->req` can't be used any more */
-- 
2.47.0

