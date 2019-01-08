Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA15EC43444
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48EF218AD
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jiT717Dv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbfAHQ5T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:57:19 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39985 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbfAHQ5S (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 11:57:18 -0500
Received: by mail-io1-f67.google.com with SMTP id k2so3660911iog.7
        for <linux-block@vger.kernel.org>; Tue, 08 Jan 2019 08:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FT9RER6+VMvxBXmLoLoheD2emU6/BVeQLCNJ27f3fko=;
        b=jiT717Dvw2CY3OUi23jaXcNGO3hJ+1UnFJM0ovDpDK1o/9BQTaV6tO7tmaQ/GuM9iu
         Z6/tnOkCbkRghXFgl2TNde5ccN6l6qdnwn8RvIHsoApgo383uR72LaKA2MjOElaOUNrn
         yxi2UQJb5sfAhpxPl7pLc8ufGeMsqY575Mtd4bfQopFg3U56zcNK1L/qYF4Iu0hvyHT+
         JirGTmgbdEfqtYpxcSAjY2GSn/2JcIAMh1a9qMd7zfxHArVtK8KuGHUyqCeEUC5VHPt6
         wIbNlh6qGPflnXkibifFXXeM7okVs6u5P7LHVUb4PTTHTbj/2thVjxtpOueyWk0HA/5J
         M2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FT9RER6+VMvxBXmLoLoheD2emU6/BVeQLCNJ27f3fko=;
        b=H832qgyrumQCPNa5f3iL8XD73uqkOj5BnCnjaaN/+/rhM/QtFj2m1tNzi00FiBzaXq
         1rfPPZDh//2paKTBamkd7y8NV2YM7XfX5FHMKSn/wjxc9KF7luMa6c4D/izK9lzusJJ2
         HFQr7ljkrIu+KWZ6TMfgzLGy3DeD/UscWK/QQhUgE45x0dwY+yA8erNy42gRMnSZN0Vo
         qrvoWMscyDQeryaAqIg0E1xT2OGl1kZ7JKB0T2Hoo/DeVWbvvyPAvfKH5jdxUPNF3gue
         Hyh1WowUc/zjkMG5IkqEia9p8LuI7k/P9p+qBEj8Oc0fk/B7O5xynb7FYAbxyL5K89mg
         cw2g==
X-Gm-Message-State: AJcUukdm4PdxHo0r+iTpQh2rYiYwJlrV6uU6iFc8DTBDEluG45iji3OS
        3wgyUkuM4SR7pOiKSt4CDSJFTg==
X-Google-Smtp-Source: ALg8bN7rn15oK/7ME5tKgFm/1iSH8HVuGXL3jwXpWf2A6VCKww0Q03T44VLLc1o3J6KOgar9mYNQyQ==
X-Received: by 2002:a5d:8ac6:: with SMTP id e6mr1410712iot.235.1546966636258;
        Tue, 08 Jan 2019 08:57:16 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m10sm17563442ioq.25.2019.01.08.08.57.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 08:57:15 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 13/16] io_uring: add support for pre-mapped user IO buffers
Date:   Tue,  8 Jan 2019 09:56:42 -0700
Message-Id: <20190108165645.19311-14-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108165645.19311-1-axboe@kernel.dk>
References: <20190108165645.19311-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we have fixed user buffers, we can map them into the kernel when we
setup the io_context. That avoids the need to do get_user_pages() for
each and every IO.

To utilize this feature, the application must set
IORING_SETUP_FIXEDBUFS and pass in an array of iovecs that contain the
desired buffer addresses and lengths. These buffers can then be mapped
into the kernel for the life time of the io_uring, as opposed to just
the duration of the each single IO. The application can then use the
IORING_OP_{READ,WRITE}_FIXED to perform IO to these fixed locations.

It's perfectly valid to setup a larger buffer, and then sometimes only
use parts of it for an IO. As long as the range is within the originally
mapped region, it will work just fine.

A limit of 4M is imposed as the largest buffer we currently support.
There's nothing preventing us from going larger, but we need some cap,
and 4M seemed like it would definitely be big enough. RLIMIT_MEMLOCK
is used to cap the total amount of memory pinned.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 212 +++++++++++++++++++++++++++++++---
 include/uapi/linux/io_uring.h |   3 +
 2 files changed, 201 insertions(+), 14 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 62778d7ffb8d..92129f867824 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -22,6 +22,8 @@
 #include <linux/workqueue.h>
 #include <linux/blkdev.h>
 #include <linux/anon_inodes.h>
+#include <linux/sizes.h>
+#include <linux/nospec.h>
 
 #include <linux/uaccess.h>
 #include <linux/nospec.h>
@@ -65,6 +67,13 @@ struct io_event_ring {
 	unsigned		ring_mask;
 };
 
+struct io_mapped_ubuf {
+	u64		ubuf;
+	size_t		len;
+	struct		bio_vec *bvec;
+	unsigned int	nr_bvecs;
+};
+
 struct io_ring_ctx {
 	struct percpu_ref	refs;
 
@@ -74,6 +83,9 @@ struct io_ring_ctx {
 	struct io_iocb_ring	sq_ring;
 	struct io_event_ring	cq_ring;
 
+	/* if used, fixed mapped user buffers */
+	struct io_mapped_ubuf	*user_bufs;
+
 	struct work_struct	work;
 
 	/* iopoll submission state */
@@ -581,13 +593,45 @@ static int io_prep_rw(struct io_kiocb *kiocb, const struct io_uring_iocb *iocb,
 	return ret;
 }
 
-static int io_setup_rw(int rw, const struct io_uring_iocb *iocb,
-		       struct iovec **iovec, struct iov_iter *iter)
+static int io_setup_rw(int rw, struct io_kiocb *kiocb,
+		       const struct io_uring_iocb *iocb, struct iovec **iovec,
+		       struct iov_iter *iter, bool kaddr)
 {
 	void __user *buf = (void __user *)(uintptr_t)iocb->addr;
 	size_t ret;
 
-	ret = import_single_range(rw, buf, iocb->len, *iovec, iter);
+	if (!kaddr) {
+		ret = import_single_range(rw, buf, iocb->len, *iovec, iter);
+	} else {
+		struct io_ring_ctx *ctx = kiocb->ki_ctx;
+		struct io_mapped_ubuf *imu;
+		size_t len = iocb->len;
+		size_t offset;
+		int index;
+
+		/* __io_submit_one() already validated the index */
+		index = array_index_nospec(kiocb->ki_index,
+						ctx->max_reqs);
+		imu = &ctx->user_bufs[index];
+		if ((unsigned long) iocb->addr < imu->ubuf ||
+		    (unsigned long) iocb->addr + len > imu->ubuf + imu->len) {
+			ret = -EFAULT;
+			goto err;
+		}
+
+		/*
+		 * May not be a start of buffer, set size appropriately
+		 * and advance us to the beginning.
+		 */
+		offset = (unsigned long) iocb->addr - imu->ubuf;
+		iov_iter_bvec(iter, rw, imu->bvec, imu->nr_bvecs,
+				offset + len);
+		if (offset)
+			iov_iter_advance(iter, offset);
+		ret = 0;
+
+	}
+err:
 	*iovec = NULL;
 	return ret;
 }
@@ -672,7 +716,7 @@ static void io_iopoll_iocb_issued(struct io_submit_state *state,
 }
 
 static ssize_t io_read(struct io_kiocb *kiocb, const struct io_uring_iocb *iocb,
-		       struct io_submit_state *state)
+		       struct io_submit_state *state, bool kaddr)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *req = &kiocb->rw;
@@ -692,7 +736,7 @@ static ssize_t io_read(struct io_kiocb *kiocb, const struct io_uring_iocb *iocb,
 	if (unlikely(!file->f_op->read_iter))
 		goto out_fput;
 
-	ret = io_setup_rw(READ, iocb, &iovec, &iter);
+	ret = io_setup_rw(READ, kiocb, iocb, &iovec, &iter, kaddr);
 	if (ret)
 		goto out_fput;
 
@@ -708,7 +752,7 @@ static ssize_t io_read(struct io_kiocb *kiocb, const struct io_uring_iocb *iocb,
 
 static ssize_t io_write(struct io_kiocb *kiocb,
 			const struct io_uring_iocb *iocb,
-			struct io_submit_state *state)
+			struct io_submit_state *state, bool kaddr)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *req = &kiocb->rw;
@@ -728,7 +772,7 @@ static ssize_t io_write(struct io_kiocb *kiocb,
 	if (unlikely(!file->f_op->write_iter))
 		goto out_fput;
 
-	ret = io_setup_rw(WRITE, iocb, &iovec, &iter);
+	ret = io_setup_rw(WRITE, kiocb, iocb, &iovec, &iter, kaddr);
 	if (ret)
 		goto out_fput;
 	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
@@ -810,10 +854,16 @@ static int __io_submit_one(struct io_ring_ctx *ctx,
 	ret = -EINVAL;
 	switch (iocb->opcode) {
 	case IORING_OP_READ:
-		ret = io_read(req, iocb, state);
+		ret = io_read(req, iocb, state, false);
+		break;
+	case IORING_OP_READ_FIXED:
+		ret = io_read(req, iocb, state, true);
 		break;
 	case IORING_OP_WRITE:
-		ret = io_write(req, iocb, state);
+		ret = io_write(req, iocb, state, false);
+		break;
+	case IORING_OP_WRITE_FIXED:
+		ret = io_write(req, iocb, state, true);
 		break;
 	case IORING_OP_FSYNC:
 		if (ctx->flags & IORING_SETUP_IOPOLL)
@@ -1021,6 +1071,127 @@ static int __io_uring_enter(struct io_ring_ctx *ctx, unsigned to_submit,
 	return ret;
 }
 
+static void io_iocb_buffer_unmap(struct io_ring_ctx *ctx)
+{
+	int i, j;
+
+	if (!ctx->user_bufs)
+		return;
+
+	for (i = 0; i < ctx->max_reqs; i++) {
+		struct io_mapped_ubuf *imu = &ctx->user_bufs[i];
+
+		for (j = 0; j < imu->nr_bvecs; j++)
+			put_page(imu->bvec[j].bv_page);
+
+		kfree(imu->bvec);
+		imu->nr_bvecs = 0;
+	}
+
+	kfree(ctx->user_bufs);
+	ctx->user_bufs = NULL;
+}
+
+static int io_iocb_buffer_map(struct io_ring_ctx *ctx,
+			      struct iovec __user *iovecs)
+{
+	unsigned long total_pages, page_limit;
+	struct page **pages = NULL;
+	int i, j, got_pages = 0;
+	int ret = -EINVAL;
+
+	ctx->user_bufs = kcalloc(ctx->max_reqs, sizeof(struct io_mapped_ubuf),
+					GFP_KERNEL);
+	if (!ctx->user_bufs)
+		return -ENOMEM;
+
+	/* Don't allow more pages than we can safely lock */
+	total_pages = 0;
+	page_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+
+	for (i = 0; i < ctx->max_reqs; i++) {
+		struct io_mapped_ubuf *imu = &ctx->user_bufs[i];
+		unsigned long off, start, end, ubuf;
+		int pret, nr_pages;
+		struct iovec iov;
+		size_t size;
+
+		ret = -EFAULT;
+		if (copy_from_user(&iov, &iovecs[i], sizeof(iov)))
+			goto err;
+
+		/*
+		 * Don't impose further limits on the size and buffer
+		 * constraints here, we'll -EINVAL later when IO is
+		 * submitted if they are wrong.
+		 */
+		ret = -EFAULT;
+		if (!iov.iov_base)
+			goto err;
+
+		/* arbitrary limit, but we need something */
+		if (iov.iov_len > SZ_4M)
+			goto err;
+
+		ubuf = (unsigned long) iov.iov_base;
+		end = (ubuf + iov.iov_len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+		start = ubuf >> PAGE_SHIFT;
+		nr_pages = end - start;
+
+		ret = -ENOMEM;
+		if (total_pages + nr_pages > page_limit)
+			goto err;
+
+		if (!pages || nr_pages > got_pages) {
+			kfree(pages);
+			pages = kmalloc(nr_pages * sizeof(struct page *),
+					GFP_KERNEL);
+			if (!pages)
+				goto err;
+			got_pages = nr_pages;
+		}
+
+		imu->bvec = kmalloc(nr_pages * sizeof(struct bio_vec),
+					GFP_KERNEL);
+		if (!imu->bvec)
+			goto err;
+
+		down_write(&current->mm->mmap_sem);
+		pret = get_user_pages(ubuf, nr_pages, 1, pages, NULL);
+		up_write(&current->mm->mmap_sem);
+
+		if (pret < nr_pages) {
+			if (pret < 0)
+				ret = pret;
+			goto err;
+		}
+
+		off = ubuf & ~PAGE_MASK;
+		size = iov.iov_len;
+		for (j = 0; j < nr_pages; j++) {
+			size_t vec_len;
+
+			vec_len = min_t(size_t, size, PAGE_SIZE - off);
+			imu->bvec[j].bv_page = pages[j];
+			imu->bvec[j].bv_len = vec_len;
+			imu->bvec[j].bv_offset = off;
+			off = 0;
+			size -= vec_len;
+		}
+		/* store original address for later verification */
+		imu->ubuf = ubuf;
+		imu->len = iov.iov_len;
+		imu->nr_bvecs = nr_pages;
+		total_pages += nr_pages;
+	}
+	kfree(pages);
+	return 0;
+err:
+	kfree(pages);
+	io_iocb_buffer_unmap(ctx);
+	return ret;
+}
+
 static void io_free_scq_urings(struct io_ring_ctx *ctx)
 {
 	if (ctx->sq_ring.ring) {
@@ -1043,6 +1214,7 @@ static void io_ring_ctx_free(struct work_struct *work)
 
 	io_iopoll_reap_events(ctx);
 	io_free_scq_urings(ctx);
+	io_iocb_buffer_unmap(ctx);
 	percpu_ref_exit(&ctx->refs);
 	kmem_cache_free(ioctx_cachep, ctx);
 }
@@ -1191,11 +1363,19 @@ static void io_fill_offsets(struct io_uring_params *p)
 	p->cq_off.events = offsetof(struct io_cq_ring, events);
 }
 
-static int io_uring_create(unsigned entries, struct io_uring_params *p)
+static int io_uring_create(unsigned entries, struct io_uring_params *p,
+			   struct iovec __user *iovecs)
 {
 	struct io_ring_ctx *ctx;
 	int ret;
 
+	/*
+	 * We don't use the iovecs without fixed buffers being asked for.
+	 * Error out if they don't match.
+	 */
+	if (!(p->flags & IORING_SETUP_FIXEDBUFS) && iovecs)
+		return -EINVAL;
+
 	/*
 	 * Use twice as many entries for the CQ ring. It's possible for the
 	 * application to drive a higher depth than the size of the SQ ring,
@@ -1213,6 +1393,12 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
 	if (ret)
 		goto err;
 
+	if (p->flags & IORING_SETUP_FIXEDBUFS) {
+		ret = io_iocb_buffer_map(ctx, iovecs);
+		if (ret)
+			goto err;
+	}
+
 	ret = anon_inode_getfd("[io_uring]", &io_scqring_fops, ctx,
 				O_RDWR | O_CLOEXEC);
 	if (ret < 0)
@@ -1245,12 +1431,10 @@ SYSCALL_DEFINE3(io_uring_setup, u32, entries, struct iovec __user *, iovecs,
 			return -EINVAL;
 	}
 
-	if (p.flags & ~IORING_SETUP_IOPOLL)
-		return -EINVAL;
-	if (iovecs)
+	if (p.flags & ~(IORING_SETUP_IOPOLL | IORING_SETUP_FIXEDBUFS))
 		return -EINVAL;
 
-	ret = io_uring_create(entries, &p);
+	ret = io_uring_create(entries, &p, iovecs);
 	if (ret < 0)
 		return ret;
 
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index f7ba30747816..925fd6ca3f38 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -35,11 +35,14 @@ struct io_uring_iocb {
  * io_uring_setup() flags
  */
 #define IORING_SETUP_IOPOLL	(1 << 0)	/* io_context is polled */
+#define IORING_SETUP_FIXEDBUFS	(1 << 1)	/* IO buffers are fixed */
 
 #define IORING_OP_READ		1
 #define IORING_OP_WRITE		2
 #define IORING_OP_FSYNC		3
 #define IORING_OP_FDSYNC	4
+#define IORING_OP_READ_FIXED	5
+#define IORING_OP_WRITE_FIXED	6
 
 /*
  * IO completion data structure
-- 
2.17.1

