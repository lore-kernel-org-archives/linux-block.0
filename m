Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1921DF992
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896056; cv=none; b=C6oNExRRCGZmSEuSVFDOK5Cc8x2lvpeCck2gDBAA6b+kB5x7D9TbSktLGwOE/e34v9+qZ7FXVwNowRdg0cNclhGz/d/+7OoakHWOu/mh9b859iUx8PuSnsPjh4Xo8fBkc4PFEsLiHXIA8qaImXCoPgbbCcILa62mOTRkfwgr5Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896056; c=relaxed/simple;
	bh=lWy3gMaaLgVUMpofx8sCUJYhQg7wxEzpSW70O0prnh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OeMeA/jOddGbNmM8JQRyMnYsx1wOIl5uc8K8ie+y6oZYijsKErfxaL5ExFM/tmrmcuoNeofUiBe1pRAfPQH6TlErhVHA8ALbgvU10CGWjG1RV31s7+aLc9bYnTBzb3BZm4Ax0rFtOM8l3P0BQ/JgJeKNWvNjb3twRrBgaHhVxaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QfXKn/FR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfXKn/FR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJy5oiJoIue39dNqC8Dha4XLX5LUbQASeo3V+CBBROU=;
	b=QfXKn/FRBXrb+evhefAEov896BXRjBKLH7lpXTCe2ZpoM7fSzkVP3GWsyk6gkpzMQKHh+3
	4t6Ni/js4+Ef+Oh6oeR25tj4o2LYNKY/zANpi8I2ynrQ+bcEsQwfqVN5ALlFPkJWcKh2no
	VMda1v/RsBsbCmXXq0ZqgcYMPpRxYXw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-wyOfM9wFPz2dI-_hyGsBwQ-1; Wed,
 06 Nov 2024 07:27:30 -0500
X-MC-Unique: wyOfM9wFPz2dI-_hyGsBwQ-1
X-Mimecast-MFC-AGG-ID: wyOfM9wFPz2dI-_hyGsBwQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8CD41944ABF;
	Wed,  6 Nov 2024 12:27:28 +0000 (UTC)
Received: from localhost (unknown [10.72.116.107])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 870BB195607C;
	Wed,  6 Nov 2024 12:27:26 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Akilesh Kailash <akailash@google.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V9 4/7] io_uring: reuse io_mapped_buf for kernel buffer
Date: Wed,  6 Nov 2024 20:26:53 +0800
Message-ID: <20241106122659.730712-5-ming.lei@redhat.com>
In-Reply-To: <20241106122659.730712-1-ming.lei@redhat.com>
References: <20241106122659.730712-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Prepare for supporting kernel buffer in case of io group, in which group
leader leases kernel buffer to io_uring, and consumed by io_uring OPs.

So reuse io_mapped_buf for group kernel buffer, and unfortunately
io_import_fixed() can't be reused since userspace fixed buffer is
virt-contiguous, but it isn't true for kernel buffer.

Also kernel buffer lifetime is bound with group leader request, it isn't
necessary to use rsrc_node for tracking its lifetime, especially it needs
extra allocation of rsrc_node for each IO.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/io_uring_types.h | 23 +++++++++++++++++++++++
 io_uring/kbuf.c                | 34 ++++++++++++++++++++++++++++++++++
 io_uring/kbuf.h                |  3 +++
 io_uring/rsrc.c                |  1 +
 io_uring/rsrc.h                | 10 ----------
 5 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index bc883078c1ed..9af83cf214c2 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -2,6 +2,7 @@
 #define IO_URING_TYPES_H
 
 #include <linux/blkdev.h>
+#include <linux/bvec.h>
 #include <linux/hashtable.h>
 #include <linux/task_work.h>
 #include <linux/bitmap.h>
@@ -39,6 +40,28 @@ enum io_uring_cmd_flags {
 	IO_URING_F_COMPAT		= (1 << 12),
 };
 
+struct io_mapped_buf {
+	u64		start;
+	unsigned int	len;
+	unsigned int	nr_bvecs;
+
+	/* kbuf hasn't refs and accounting, its lifetime is bound with req */
+	union {
+		struct {
+			refcount_t	refs;
+			unsigned int	acct_pages;
+		};
+		/* pbvec is only for kbuf */
+		const struct bio_vec	*pbvec;
+	};
+	unsigned int	folio_shift:6;
+	unsigned int	dir:1;		/* ITER_DEST or ITER_SOURCE */
+	unsigned int	kbuf:1;		/* kernel buffer or not */
+	/* offset in the 1st bvec, for kbuf only */
+	unsigned int	offset;
+	struct bio_vec	bvec[] __counted_by(nr_bvecs);
+};
+
 struct io_wq_work_node {
 	struct io_wq_work_node *next;
 };
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index d407576ddfb7..c4a776860cb4 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -838,3 +838,37 @@ int io_pbuf_mmap(struct file *file, struct vm_area_struct *vma)
 	io_put_bl(ctx, bl);
 	return ret;
 }
+
+/*
+ * kernel buffer is built over generic bvec, and can't be always
+ * virt-contiguous, which is different with userspace fixed buffer,
+ * so we can't reuse io_import_fixed() here
+ *
+ * Also kernel buffer lifetime is bound with request, and we needn't
+ * to use rsrc_node to track its lifetime
+ */
+int io_import_kbuf(int ddir, struct iov_iter *iter,
+		    const struct io_mapped_buf *kbuf,
+		    u64 buf_off, size_t len)
+{
+	unsigned long offset = kbuf->offset;
+
+	WARN_ON_ONCE(!kbuf->kbuf);
+
+	if (ddir != kbuf->dir)
+		return -EINVAL;
+
+	if (unlikely(buf_off > kbuf->len))
+		return -EFAULT;
+
+	if (unlikely(len > kbuf->len - buf_off))
+		return -EFAULT;
+
+	offset += buf_off;
+	iov_iter_bvec(iter, ddir, kbuf->pbvec, kbuf->nr_bvecs, offset + len);
+
+	if (offset)
+		iov_iter_advance(iter, offset);
+
+	return 0;
+}
diff --git a/io_uring/kbuf.h b/io_uring/kbuf.h
index 36aadfe5ac00..04ccd52dd0ad 100644
--- a/io_uring/kbuf.h
+++ b/io_uring/kbuf.h
@@ -88,6 +88,9 @@ void io_put_bl(struct io_ring_ctx *ctx, struct io_buffer_list *bl);
 struct io_buffer_list *io_pbuf_get_bl(struct io_ring_ctx *ctx,
 				      unsigned long bgid);
 int io_pbuf_mmap(struct file *file, struct vm_area_struct *vma);
+int io_import_kbuf(int ddir, struct iov_iter *iter,
+		    const struct io_mapped_buf *kbuf,
+		    u64 buf_off, size_t len);
 
 static inline bool io_kbuf_recycle_ring(struct io_kiocb *req)
 {
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 16f5abe03d10..5f35641c55ab 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -771,6 +771,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 	imu->len = iov->iov_len;
 	imu->nr_bvecs = nr_pages;
 	imu->folio_shift = PAGE_SHIFT;
+	imu->kbuf = 0;
 	if (coalesced)
 		imu->folio_shift = data.folio_shift;
 	refcount_set(&imu->refs, 1);
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 255ec94ea172..d54a5f84b9ed 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -26,16 +26,6 @@ struct io_rsrc_node {
 	};
 };
 
-struct io_mapped_buf {
-	u64		start;
-	unsigned int	len;
-	unsigned int	nr_bvecs;
-	refcount_t	refs;
-	unsigned int	acct_pages;
-	unsigned int	folio_shift:6;
-	struct bio_vec	bvec[] __counted_by(nr_bvecs);
-};
-
 struct io_imu_folio_data {
 	/* Head folio can be partially included in the fixed buf */
 	unsigned int	nr_pages_head;
-- 
2.47.0

