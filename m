Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199BD15CE
	for <linux-block@vger.kernel.org>; Mon,  8 Apr 2024 01:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712538295; cv=none; b=QP8umf5KepLg4MrN9Pi4mXY4Zlkp5Y8Toy0Y1krahJnpZoMAOskRrcIQXh0NyJ540qGh8JP7VsL/CEp4l0AJXcLDINBDsqjZ8F01R00sBQoXl6B19zYSgPsJQ3VVR9Usr7o07NUyw8+K+8NfGt9QT9h4XrE6SkTlyiFA4xWaq3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712538295; c=relaxed/simple;
	bh=tbxDyxHAlcNFeQnBURwM1YgU/WULb6cwg6iZD7VQov0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMeHruvde5qoSqK5ORmDxcy65+tNJzRUqHrcVoJkWUAR/uTh7vA/qgvKRjVIX9x6xOZbMoey3pNBE1VM4JYzSjDSOuo1TRGMrMDBO95GtupNwzjfkGiq1ysb/TFAcLUJsoUjarhNLy5FXfMhcC4bkSwIj4GSTUrmeVWsaZ9wyl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I0d2KEAe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0d2KEAe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712538293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZqNAycV/VAYvzRE10L9enQpc5mGiIyBt3NJ38rT53g=;
	b=I0d2KEAernt0dsiHJ7qZkgODN+3bYCfb52vXIp7bR98OMP0qNZkfxNEE0x7SBc/8ybTJ1F
	RjKfW9dRWZAwMHoHVuVByI6mBatKTgwnqx3YyVGNm+HbcDtddQcDzSQUoLLiVK4Im9otfB
	Y2QA+WL0m+P6IoCtDBCXD5nixgL5mH0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-PsKzz67XNC-qlylK31yMjA-1; Sun,
 07 Apr 2024 21:04:48 -0400
X-MC-Unique: PsKzz67XNC-qlylK31yMjA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63ECE3800082;
	Mon,  8 Apr 2024 01:04:48 +0000 (UTC)
Received: from localhost (unknown [10.72.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7547B210FD1D;
	Mon,  8 Apr 2024 01:04:47 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 7/9] io_uring/uring_cmd: support provide group kernel buffer
Date: Mon,  8 Apr 2024 09:03:20 +0800
Message-ID: <20240408010322.4104395-8-ming.lei@redhat.com>
In-Reply-To: <20240408010322.4104395-1-ming.lei@redhat.com>
References: <20240408010322.4104395-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Allow uring command to be group leader for providing kernel buffer,
and this way can support generic device zero copy over device buffer.

The following patch will use the way to support zero copy for ublk.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/io_uring/cmd.h  |  9 +++++++++
 include/uapi/linux/io_uring.h |  7 ++++++-
 io_uring/uring_cmd.c          | 22 ++++++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 447fbfd32215..707660df1083 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -48,6 +48,9 @@ void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
 void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 		unsigned int issue_flags);
 
+int io_uring_cmd_provide_kbuf(struct io_uring_cmd *ioucmd,
+		const struct io_uring_kernel_buf *grp_kbuf,
+		io_uring_buf_giveback_t grp_kbuf_ack);
 #else
 static inline int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct iov_iter *iter, void *ioucmd)
@@ -67,6 +70,12 @@ static inline void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
 }
+static inline int io_uring_cmd_provide_kbuf(struct io_uring_cmd *ioucmd,
+		const struct io_uring_kernel_buf *grp_kbuf,
+		io_uring_buf_giveback_t grp_kbuf_ack)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 /*
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index c0d34f2a2c17..0060971721d0 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -281,9 +281,14 @@ enum io_uring_op {
  * bit23 ~ bit16		sqe ext flags
  * IORING_URING_CMD_FIXED	use registered buffer; pass this flag
  *				along with setting sqe->buf_index.
+ * IORING_PROVIDE_GROUP_KBUF	this command provides group kernel buffer
+ *				for member requests which can retrieve
+ *				any sub-buffer with offset(sqe->addr) and
+ *				len(sqe->len)
  */
 #define IORING_URING_CMD_FIXED	(1U << 0)
-#define IORING_URING_CMD_MASK	IORING_URING_CMD_FIXED
+#define IORING_PROVIDE_GROUP_KBUF	(1U << 1)
+#define IORING_URING_CMD_MASK	(IORING_URING_CMD_FIXED | IORING_PROVIDE_GROUP_KBUF)
 #define IORING_URING_CMD_EXT_MASK	0x00ff0000
 
 
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 43b71f29e7b3..ec03c9fe965c 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -14,6 +14,7 @@
 #include "alloc_cache.h"
 #include "rsrc.h"
 #include "uring_cmd.h"
+#include "kbuf.h"
 
 static struct uring_cache *io_uring_async_get(struct io_kiocb *req)
 {
@@ -174,6 +175,27 @@ void io_uring_cmd_done(struct io_uring_cmd *ioucmd, ssize_t ret, ssize_t res2,
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_done);
 
+/*
+ * Provide kernel buffer for sqe group members to consume, and the caller
+ * has to guarantee that the provided buffer and the callback are valid
+ * until the callback is called.
+ */
+int io_uring_cmd_provide_kbuf(struct io_uring_cmd *ioucmd,
+		const struct io_uring_kernel_buf *grp_kbuf,
+		io_uring_buf_giveback_t grp_kbuf_ack)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+
+	if (unlikely(!(ioucmd->flags & IORING_PROVIDE_GROUP_KBUF)))
+		return -EINVAL;
+
+	if (unlikely(!(req->flags & REQ_F_SQE_GROUP)))
+		return -EINVAL;
+
+	return io_provide_group_kbuf(req, grp_kbuf, grp_kbuf_ack);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_provide_kbuf);
+
 static int io_uring_cmd_prep_setup(struct io_kiocb *req,
 				   const struct io_uring_sqe *sqe)
 {
-- 
2.42.0

