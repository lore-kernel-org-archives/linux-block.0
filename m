Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84087C43387
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468B421929
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1fMN18W+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391689AbeLUTXY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:23:24 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38678 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391688AbeLUTXK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Dec 2018 14:23:10 -0500
Received: by mail-it1-f196.google.com with SMTP id h65so8019719ith.3
        for <linux-block@vger.kernel.org>; Fri, 21 Dec 2018 11:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iCpQJPnY6XrF+XNAbmONE2yu31D4Ge1VoiIuSibfIME=;
        b=1fMN18W+RnX3A9n2EXha47HpZxQIvCZzErnp37ouUfm4c3fBcQc0XBABg65cxDeF4+
         TVzw4uEJWMk+e9YGSzn8mgZBYQ5/YmgGR26SVxq/t7W4xrWWFJcWrrnOjWgCrQXOtuEr
         Q6CRiJpWJSeYkUIWIrdBgXINSmWXIa9x4sujU/YTx7cOvpbhLhGNC/UOjVg/Es2seBPQ
         h/Wi5VkNpDGdBYsVRz9KCHGylTHqATBXg1woKcqp0TmsLLPM/cpY4MwCmCQGtFWRcBbU
         /ctGDZvz95Mwy9KgsgCsIv+I9uKHsTJvHAe2LoSNXSXSsb3TAj8589nrf0lpfTVeNw1J
         lN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iCpQJPnY6XrF+XNAbmONE2yu31D4Ge1VoiIuSibfIME=;
        b=HU7X+u0NXXO2SaQygoTeP2fFxRFcirkxAUULBTNsbGsdbzW+qkdt3ryqofHFq1b+v5
         hH/7wFBnCEmMGS4myJ/TEqstkXCZ/Nxa7eeie7YzlbTiIMXFGb3zuZarfDcd2Zza2zE3
         gNpARg9R3TviQ6IlEgf5otI+t+ggwmMYZLXOFOpC2gnvQ0OtqSSznpGbcf3SpCJSw0BB
         wLAYXugfDrVNdQLdhqLPTrQFRfs5h1DvnVmBgqOr3ku2aFkOd2/1NKek18K7zSpS9esc
         4wvqfb8S5mklMFKJ5mHZV3cOI6JwKJBqd/zn9LblHluPRSXSn3QWcJvozBpv/rYSOOcE
         QdlA==
X-Gm-Message-State: AA+aEWYzmJTkdJxrLFn6veKGhuL8SwEG4rcevFHUn3lyXh+end57C7j1
        m5PTdxYf6XxdhTOpYx14sKNFQw==
X-Google-Smtp-Source: AFSGD/VJJqaNbrgDP8i71LoMu6ceiL5Cdpda+qtrkLmABFU79UYGlmKlnrh05NZpTS+Ri/dJ6hmlDA==
X-Received: by 2002:a24:4e55:: with SMTP id r82mr3088409ita.128.1545420189206;
        Fri, 21 Dec 2018 11:23:09 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t1sm12456290iol.85.2018.12.21.11.23.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:23:08 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 18/22] aio: add support for pre-mapped user IO buffers
Date:   Fri, 21 Dec 2018 12:22:32 -0700
Message-Id: <20181221192236.12866-19-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221192236.12866-1-axboe@kernel.dk>
References: <20181221192236.12866-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we have fixed user buffers, we can map them into the kernel when we
setup the io_context. That avoids the need to do get_user_pages() for
each and every IO.

To utilize this feature, the application must use the SCQRING interface,
and additionally set IOCTX_FLAG_FIXEDBUFS when creating the IO context.
The latter tells aio that the iocbs in the SQ ring already contain valid
destination and sizes. These buffers can then be mapped into the kernel
for the life time of the io_context, as opposed to just the duration of
the each single IO.

It's perfectly valid to setup a larger buffer, and then sometimes only
use parts of it for an IO. As long as the range is within the originally
mapped region, it will work just fine.

Only works with non-vectored read/write commands for now, not with
PREADV/PWRITEV.

A limit of 4M is imposed as the largest buffer we currently support.
There's nothing preventing us from going larger, but we need some cap,
and 4M seemed like it would definitely be big enough. RLIMIT_MEMLOCK
is used to cap the total amount of memory pinned.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c                     | 219 ++++++++++++++++++++++++++++++++---
 include/uapi/linux/aio_abi.h |   1 +
 2 files changed, 202 insertions(+), 18 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index a49109e69334..c424aa2ed336 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -42,6 +42,8 @@
 #include <linux/ramfs.h>
 #include <linux/percpu-refcount.h>
 #include <linux/mount.h>
+#include <linux/sizes.h>
+#include <linux/nospec.h>
 
 #include <asm/kmap_types.h>
 #include <linux/uaccess.h>
@@ -107,6 +109,13 @@ struct aio_iocb_ring {
 	struct aio_mapped_range iocb_range;	/* maps user iocbs */
 };
 
+struct aio_mapped_ubuf {
+	u64 ubuf;
+	size_t len;
+	struct bio_vec *bvec;
+	unsigned int nr_bvecs;
+};
+
 struct kioctx {
 	struct percpu_ref	users;
 	atomic_t		dead;
@@ -142,6 +151,9 @@ struct kioctx {
 	struct page		**ring_pages;
 	long			nr_pages;
 
+	/* if used, fixed mapped user buffers */
+	struct aio_mapped_ubuf	*user_bufs;
+
 	/* if used, completion and submission rings */
 	struct aio_iocb_ring	sq_ring;
 	struct aio_mapped_range cq_ring;
@@ -309,8 +321,10 @@ static const unsigned int iocb_page_shift =
 static const unsigned int event_page_shift =
 				ilog2(PAGE_SIZE / sizeof(struct io_event));
 
+static void aio_iocb_buffer_unmap(struct kioctx *);
 static void aio_scqring_unmap(struct kioctx *);
 static void aio_iopoll_reap_events(struct kioctx *);
+static const struct iocb *aio_iocb_from_index(struct kioctx *ctx, unsigned idx);
 
 static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
 {
@@ -689,6 +703,7 @@ static void free_ioctx(struct work_struct *work)
 	pr_debug("freeing %p\n", ctx);
 
 	aio_scqring_unmap(ctx);
+	aio_iocb_buffer_unmap(ctx);
 	aio_free_ring(ctx);
 	free_percpu(ctx->cpu);
 	percpu_ref_exit(&ctx->reqs);
@@ -1827,6 +1842,124 @@ static int aio_scqring_map(struct kioctx *ctx,
 	return ret;
 }
 
+static void aio_iocb_buffer_unmap(struct kioctx *ctx)
+{
+	int i, j;
+
+	if (!ctx->user_bufs)
+		return;
+
+	for (i = 0; i < ctx->max_reqs; i++) {
+		struct aio_mapped_ubuf *amu = &ctx->user_bufs[i];
+
+		for (j = 0; j < amu->nr_bvecs; j++)
+			put_page(amu->bvec[j].bv_page);
+
+		kfree(amu->bvec);
+		amu->nr_bvecs = 0;
+	}
+
+	kfree(ctx->user_bufs);
+	ctx->user_bufs = NULL;
+}
+
+static int aio_iocb_buffer_map(struct kioctx *ctx)
+{
+	unsigned long total_pages, page_limit;
+	struct page **pages = NULL;
+	int i, j, got_pages = 0;
+	const struct iocb *iocb;
+	int ret = -EINVAL;
+
+	ctx->user_bufs = kzalloc(ctx->max_reqs * sizeof(struct aio_mapped_ubuf),
+					GFP_KERNEL);
+	if (!ctx->user_bufs)
+		return -ENOMEM;
+
+	/* Don't allow more pages than we can safely lock */
+	total_pages = 0;
+	page_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+
+	for (i = 0; i < ctx->max_reqs; i++) {
+		struct aio_mapped_ubuf *amu = &ctx->user_bufs[i];
+		unsigned long off, start, end, ubuf;
+		int pret, nr_pages;
+		size_t size;
+
+		iocb = aio_iocb_from_index(ctx, i);
+
+		/*
+		 * Don't impose further limits on the size and buffer
+		 * constraints here, we'll -EINVAL later when IO is
+		 * submitted if they are wrong.
+		 */
+		ret = -EFAULT;
+		if (!iocb->aio_buf)
+			goto err;
+
+		/* arbitrary limit, but we need something */
+		if (iocb->aio_nbytes > SZ_4M)
+			goto err;
+
+		ubuf = iocb->aio_buf;
+		end = (ubuf + iocb->aio_nbytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
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
+		amu->bvec = kmalloc(nr_pages * sizeof(struct bio_vec),
+					GFP_KERNEL);
+		if (!amu->bvec)
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
+		size = iocb->aio_nbytes;
+		for (j = 0; j < nr_pages; j++) {
+			size_t vec_len;
+
+			vec_len = min_t(size_t, size, PAGE_SIZE - off);
+			amu->bvec[j].bv_page = pages[j];
+			amu->bvec[j].bv_len = vec_len;
+			amu->bvec[j].bv_offset = off;
+			off = 0;
+			size -= vec_len;
+		}
+		/* store original address for later verification */
+		amu->ubuf = ubuf;
+		amu->len = iocb->aio_nbytes;
+		amu->nr_bvecs = nr_pages;
+		total_pages += nr_pages;
+	}
+	kfree(pages);
+	return 0;
+err:
+	kfree(pages);
+	aio_iocb_buffer_unmap(ctx);
+	return ret;
+}
+
 /* sys_io_setup2:
  *	Like sys_io_setup(), except that it takes a set of flags
  *	(IOCTX_FLAG_*), and some pointers to user structures:
@@ -1844,7 +1977,8 @@ SYSCALL_DEFINE5(io_setup2, u32, nr_events, u32, flags,
 	unsigned long ctx;
 	long ret;
 
-	if (flags & ~(IOCTX_FLAG_IOPOLL | IOCTX_FLAG_SCQRING))
+	if (flags & ~(IOCTX_FLAG_IOPOLL | IOCTX_FLAG_SCQRING |
+		      IOCTX_FLAG_FIXEDBUFS))
 		return -EINVAL;
 
 	ret = get_user(ctx, ctxp);
@@ -1860,6 +1994,15 @@ SYSCALL_DEFINE5(io_setup2, u32, nr_events, u32, flags,
 		ret = aio_scqring_map(ioctx, sq_ring, cq_ring);
 		if (ret)
 			goto err;
+		if (flags & IOCTX_FLAG_FIXEDBUFS) {
+			ret = aio_iocb_buffer_map(ioctx);
+			if (ret)
+				goto err;
+		}
+	} else if (flags & IOCTX_FLAG_FIXEDBUFS) {
+		/* can only support fixed bufs with SQ/CQ ring */
+		ret = -EINVAL;
+		goto err;
 	}
 
 	ret = put_user(ioctx->user_id, ctxp);
@@ -2135,23 +2278,58 @@ static int aio_prep_rw(struct aio_kiocb *kiocb, const struct iocb *iocb,
 	return ret;
 }
 
-static int aio_setup_rw(int rw, const struct iocb *iocb, struct iovec **iovec,
-		bool vectored, bool compat, struct iov_iter *iter)
+static int aio_setup_rw(int rw, struct aio_kiocb *kiocb,
+		const struct iocb *iocb, struct iovec **iovec, bool vectored,
+		bool compat, bool kaddr, struct iov_iter *iter)
 {
-	void __user *buf = (void __user *)(uintptr_t)iocb->aio_buf;
+	void __user *ubuf = (void __user *)(uintptr_t)iocb->aio_buf;
 	size_t len = iocb->aio_nbytes;
 
 	if (!vectored) {
-		ssize_t ret = import_single_range(rw, buf, len, *iovec, iter);
+		ssize_t ret;
+
+		if (!kaddr) {
+			ret = import_single_range(rw, ubuf, len, *iovec, iter);
+		} else {
+			struct kioctx *ctx = kiocb->ki_ctx;
+			struct aio_mapped_ubuf *amu;
+			size_t offset;
+			int index;
+
+			/* __io_submit_one() already validated the index */
+			index = array_index_nospec(kiocb->ki_index,
+							ctx->max_reqs);
+			amu = &ctx->user_bufs[index];
+			if (iocb->aio_buf < amu->ubuf ||
+			    iocb->aio_buf + len > amu->ubuf + amu->len) {
+				ret = -EFAULT;
+				goto err;
+			}
+
+			/*
+			 * May not be a start of buffer, set size appropriately
+			 * and advance us to the beginning.
+			 */
+			offset = iocb->aio_buf - amu->ubuf;
+			iov_iter_bvec(iter, rw, amu->bvec, amu->nr_bvecs,
+					offset + len);
+			if (offset)
+				iov_iter_advance(iter, offset);
+			ret = 0;
+
+		}
+err:
 		*iovec = NULL;
 		return ret;
 	}
+	if (kaddr)
+		return -EINVAL;
 #ifdef CONFIG_COMPAT
 	if (compat)
-		return compat_import_iovec(rw, buf, len, UIO_FASTIOV, iovec,
+		return compat_import_iovec(rw, ubuf, len, UIO_FASTIOV, iovec,
 				iter);
 #endif
-	return import_iovec(rw, buf, len, UIO_FASTIOV, iovec, iter);
+	return import_iovec(rw, ubuf, len, UIO_FASTIOV, iovec, iter);
 }
 
 static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
@@ -2233,7 +2411,7 @@ static void aio_iopoll_iocb_issued(struct aio_submit_state *state,
 
 static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
 			struct aio_submit_state *state, bool vectored,
-			bool compat)
+			bool compat, bool kaddr)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *req = &kiocb->rw;
@@ -2253,9 +2431,11 @@ static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
 	if (unlikely(!file->f_op->read_iter))
 		goto out_fput;
 
-	ret = aio_setup_rw(READ, iocb, &iovec, vectored, compat, &iter);
+	ret = aio_setup_rw(READ, kiocb, iocb, &iovec, vectored, compat, kaddr,
+				&iter);
 	if (ret)
 		goto out_fput;
+
 	ret = rw_verify_area(READ, file, &req->ki_pos, iov_iter_count(&iter));
 	if (!ret)
 		aio_rw_done(req, call_read_iter(file, req, &iter));
@@ -2268,7 +2448,7 @@ static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
 
 static ssize_t aio_write(struct aio_kiocb *kiocb, const struct iocb *iocb,
 			 struct aio_submit_state *state, bool vectored,
-			 bool compat)
+			 bool compat, bool kaddr)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *req = &kiocb->rw;
@@ -2288,7 +2468,8 @@ static ssize_t aio_write(struct aio_kiocb *kiocb, const struct iocb *iocb,
 	if (unlikely(!file->f_op->write_iter))
 		goto out_fput;
 
-	ret = aio_setup_rw(WRITE, iocb, &iovec, vectored, compat, &iter);
+	ret = aio_setup_rw(WRITE, kiocb, iocb, &iovec, vectored, compat, kaddr,
+				&iter);
 	if (ret)
 		goto out_fput;
 	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
@@ -2527,7 +2708,8 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 
 static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 			   unsigned long ki_index,
-			   struct aio_submit_state *state, bool compat)
+			   struct aio_submit_state *state, bool compat,
+			   bool kaddr)
 {
 	struct aio_kiocb *req;
 	ssize_t ret;
@@ -2588,16 +2770,16 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 	ret = -EINVAL;
 	switch (iocb->aio_lio_opcode) {
 	case IOCB_CMD_PREAD:
-		ret = aio_read(req, iocb, state, false, compat);
+		ret = aio_read(req, iocb, state, false, compat, kaddr);
 		break;
 	case IOCB_CMD_PWRITE:
-		ret = aio_write(req, iocb, state, false, compat);
+		ret = aio_write(req, iocb, state, false, compat, kaddr);
 		break;
 	case IOCB_CMD_PREADV:
-		ret = aio_read(req, iocb, state, true, compat);
+		ret = aio_read(req, iocb, state, true, compat, kaddr);
 		break;
 	case IOCB_CMD_PWRITEV:
-		ret = aio_write(req, iocb, state, true, compat);
+		ret = aio_write(req, iocb, state, true, compat, kaddr);
 		break;
 	case IOCB_CMD_FSYNC:
 		if (ctx->flags & IOCTX_FLAG_IOPOLL)
@@ -2654,7 +2836,7 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 	if (unlikely(copy_from_user(&iocb, user_iocb, sizeof(iocb))))
 		return -EFAULT;
 
-	return __io_submit_one(ctx, &iocb, ki_index, state, compat);
+	return __io_submit_one(ctx, &iocb, ki_index, state, compat, false);
 }
 
 #ifdef CONFIG_BLOCK
@@ -2757,6 +2939,7 @@ static const struct iocb *aio_peek_sqring(struct kioctx *ctx,
 
 static int aio_ring_submit(struct kioctx *ctx, unsigned int to_submit)
 {
+	bool kaddr = (ctx->flags & IOCTX_FLAG_FIXEDBUFS) != 0;
 	struct aio_submit_state state, *statep = NULL;
 	int i, ret = 0, submit = 0;
 
@@ -2773,7 +2956,7 @@ static int aio_ring_submit(struct kioctx *ctx, unsigned int to_submit)
 		if (!iocb)
 			break;
 
-		ret = __io_submit_one(ctx, iocb, iocb_index, statep, false);
+		ret = __io_submit_one(ctx, iocb, iocb_index, statep, false, kaddr);
 		if (ret)
 			break;
 
diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
index 5d3ada40ce15..39d783175872 100644
--- a/include/uapi/linux/aio_abi.h
+++ b/include/uapi/linux/aio_abi.h
@@ -110,6 +110,7 @@ struct iocb {
 
 #define IOCTX_FLAG_IOPOLL	(1 << 0)	/* io_context is polled */
 #define IOCTX_FLAG_SCQRING	(1 << 1)	/* Use SQ/CQ rings */
+#define IOCTX_FLAG_FIXEDBUFS	(1 << 2)	/* IO buffers are fixed */
 
 struct aio_sq_ring {
 	union {
-- 
2.17.1

