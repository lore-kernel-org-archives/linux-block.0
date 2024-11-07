Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438451F471B
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977360; cv=none; b=UZo/sc0pqhg2p7zF0jxWFBFKkCyKGnX+oKJWWKvOcpMDgY3NB6mFTQBl8D1X5hPjQ0dUWayHNF6rHsGAP+aVZUVLN1KpxW/y5rtyPvhvbFNXeDM7bSvUSeKF/8xTzWxU6X532yc5H7g3HGEZT1tP2BuNcqkqu75aFwbUgogO/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977360; c=relaxed/simple;
	bh=tly5WzZ/x+5sr3uFZjmb1OElDgbLU/izgB/EE+LNdcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNMNPpIKHaSh3HwlDBWfVMhS8Y8B3ii3xHfNMLr1sFmN+dpafx2kGrF18ZCqMKROqk5LYXK/e53gIEinyVUMGwlXKmRzM2O9b9igcKsID62LuBS9f7+CIKLmc95tN1O57DLVJUXmoT3Ss8Xqq7vHdywOutXUyBvIRNJIIyNG6tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFILATLe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFILATLe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730977358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXhq6YRcO+Qv5hJmRM0rhu2PFbttro6G4So3Dp8+hAE=;
	b=PFILATLebfeCHydHtuT0FibpoUbvelHiaypj8PflbGKWZDbFA5qmuggSsQeEihwV38b2VD
	1mjyusJtnNbK6Xf4e8W58eHDP3d2saFP8hRNv2527vP2qGMbFanisnz0uo1HasxhQxJO3i
	4m7BY3bE36/VcvgGHSqTrOUa/54IaDU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-CXAvhZHPN5O82g83F8N1aA-1; Thu,
 07 Nov 2024 06:02:35 -0500
X-MC-Unique: CXAvhZHPN5O82g83F8N1aA-1
X-Mimecast-MFC-AGG-ID: CXAvhZHPN5O82g83F8N1aA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 201D51955F45;
	Thu,  7 Nov 2024 11:02:34 +0000 (UTC)
Received: from localhost (unknown [10.72.116.54])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E59F33003B78;
	Thu,  7 Nov 2024 11:02:32 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Akilesh Kailash <akailash@google.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V10 08/12] io_uring: reuse io_mapped_buf for kernel buffer
Date: Thu,  7 Nov 2024 19:01:41 +0800
Message-ID: <20241107110149.890530-9-ming.lei@redhat.com>
In-Reply-To: <20241107110149.890530-1-ming.lei@redhat.com>
References: <20241107110149.890530-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Prepare for supporting kernel buffer in case of io group, in which group
leader leases kernel buffer to io_uring, and consumed by io_uring OPs.

So reuse io_mapped_buf for group kernel buffer, and unfortunately
io_import_fixed() can't be reused since userspace fixed buffer is
virt-contiguous, but it isn't true for kernel buffer.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/io_uring_types.h | 19 +++++++++++++++++++
 io_uring/kbuf.c                | 34 ++++++++++++++++++++++++++++++++++
 io_uring/kbuf.h                |  3 +++
 io_uring/rsrc.c                |  1 +
 io_uring/rsrc.h                | 10 ----------
 5 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index d060ce5e6145..03abaeef4a67 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -2,6 +2,7 @@
 #define IO_URING_TYPES_H
 
 #include <linux/blkdev.h>
+#include <linux/bvec.h>
 #include <linux/hashtable.h>
 #include <linux/task_work.h>
 #include <linux/bitmap.h>
@@ -39,6 +40,24 @@ enum io_uring_cmd_flags {
 	IO_URING_F_COMPAT		= (1 << 12),
 };
 
+struct io_mapped_buf {
+	u64		addr;
+	unsigned int	len;
+	unsigned int	nr_bvecs;
+	refcount_t	refs;
+	union {
+		/* for userspace buffer only */
+		unsigned int	acct_pages;
+		/* offset in the 1st bvec, for kbuf only */
+		unsigned int	offset;
+	};
+	const struct bio_vec	*pbvec; /* pbvec is only for kbuf */
+	unsigned int	folio_shift:6;
+	unsigned int	dir:1;		/* ITER_DEST or ITER_SOURCE */
+	unsigned int	kbuf:1;		/* kernel buffer or not */
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
index 99ff2797e6ec..b0b60ae0456a 100644
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
index bf0824b4beb6..3bc3a484fbba 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -28,16 +28,6 @@ struct io_rsrc_node {
 	};
 };
 
-struct io_mapped_buf {
-	u64		addr;
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

