Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF99149C69
	for <linux-block@vger.kernel.org>; Sat, 12 Oct 2024 08:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728723252; cv=none; b=dGq5dyGEBu0ymiB2qn/yV1Lbu8l1JhKUJPsuKFFP384t5OEfIsSwz4mpVEICzLuObMsTlifsqeycObqkOf8E3ACfmAlf17R/9lnFLfWiosSWBTTD0tfT3dKS3tmaXmYenCKvF+b0DVfbwsWXSRzazDDS9I8Q1cTbK9r+yyAqN/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728723252; c=relaxed/simple;
	bh=swcQYvakEC8sJhGZZrRLNFVprgi+8FidVj9QWyWxFJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5pJuzicDyZk9TN/1I3KmP9nm74bNblq7CeslDQaSGgzYqes9VYl51CxYde4ee65sujKhuzxTgLCqpNr8vp945M+1n7Im5WVXAOGLH7AqTtB2Vk5jvxLExEzvBX8F9xB8LRkx6pMahQUx/x6wwTujWeLHEKmWsdPMiq1YBRGy4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lk9Tyk33; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lk9Tyk33"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728723250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rIv96hFCLG/tT39xHIqIXd8K8IN4JG06/rfpfhwt920=;
	b=Lk9Tyk33IO2tKuhiPUg3tX9ho3JimL8bnpP56vXMk4erzizq7qYBiHHCGorOUPzbh7Beo0
	b1KfdGI7VmrGIbE7Z3DGEVCeTsLW9kEp9DjrvGL48eNKarklcq5nykmEu/FGGMs0t63sH+
	x3vIyelHZwI1qZxPWnoIbg6oA94VU7c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-NkWDiq70NIiPgpHc6A2G1g-1; Sat,
 12 Oct 2024 04:54:04 -0400
X-MC-Unique: NkWDiq70NIiPgpHc6A2G1g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D80E1955F28;
	Sat, 12 Oct 2024 08:54:03 +0000 (UTC)
Received: from localhost (unknown [10.72.116.121])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5799319560A2;
	Sat, 12 Oct 2024 08:54:01 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V7 6/7] io_uring/uring_cmd: support leasing device kernel buffer to io_uring
Date: Sat, 12 Oct 2024 16:53:26 +0800
Message-ID: <20241012085330.2540955-7-ming.lei@redhat.com>
In-Reply-To: <20241012085330.2540955-1-ming.lei@redhat.com>
References: <20241012085330.2540955-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add API of io_uring_cmd_lease_kbuf() for driver to lease its kernel
buffer to io_uring.

The leased buffer can only be consumed by io_uring OPs in group wide,
and the uring_cmd has to be one group leader.

This way can support generic device zero copy over device buffer in
userspace:

- create one sqe group
- lease one device buffer to io_uring by the group leader of uring_cmd
- io_uring member OPs consume this kernel buffer by passing IOSQE_IO_DRAIN
  which isn't used for group member, and mapped to GROUP_KBUF.
- the kernel buffer is returned back after all member OPs are completed

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/io_uring/cmd.h |  7 +++++++
 io_uring/uring_cmd.c         | 13 +++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index c189d36ad55e..bdf7abfa0d8a 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -60,6 +60,8 @@ void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 /* Execute the request from a blocking context */
 void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd);
 
+int io_uring_cmd_lease_kbuf(struct io_uring_cmd *ioucmd,
+		const struct io_uring_kernel_buf *grp_kbuf);
 #else
 static inline int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct iov_iter *iter, void *ioucmd)
@@ -82,6 +84,11 @@ static inline void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 static inline void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd)
 {
 }
+static inline int io_uring_cmd_lease_kbuf(struct io_uring_cmd *ioucmd,
+		const struct io_uring_kernel_buf *grp_kbuf)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 /*
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 39c3c816ec78..cf9ab37cf8cc 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -15,6 +15,7 @@
 #include "alloc_cache.h"
 #include "rsrc.h"
 #include "uring_cmd.h"
+#include "kbuf.h"
 
 static struct uring_cache *io_uring_async_get(struct io_kiocb *req)
 {
@@ -175,6 +176,18 @@ void io_uring_cmd_done(struct io_uring_cmd *ioucmd, ssize_t ret, ssize_t res2,
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_done);
 
+int io_uring_cmd_lease_kbuf(struct io_uring_cmd *ioucmd,
+		const struct io_uring_kernel_buf *grp_kbuf)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+
+	if (unlikely(ioucmd->flags & IORING_URING_CMD_FIXED))
+		return -EINVAL;
+
+	return io_lease_group_kbuf(req, grp_kbuf);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_lease_kbuf);
+
 static int io_uring_cmd_prep_setup(struct io_kiocb *req,
 				   const struct io_uring_sqe *sqe)
 {
-- 
2.46.0

