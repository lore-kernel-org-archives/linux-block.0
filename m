Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226EEC67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A7220851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qdDp1c23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A7220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbeLMR5i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:57:38 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33500 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbeLMR5i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 12:57:38 -0500
Received: by mail-io1-f67.google.com with SMTP id t24so2341774ioi.0
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 09:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nnsStoxMjXagyaQxrfF8MKczBgqcviWRVnTOz/hAPko=;
        b=qdDp1c230eTa990/GP4Ch43Wd1XdEQKuGOuCAkhXQ0ufvvXnXMAe3RZkQa3ixeSloT
         ibh+MvC9l6ezvem5amBkNTYhq57Bdr12oDtgXyl2eY4xg5o96Je/WbBhpAj7StRQCs9S
         tI/qjMCAjjsCfC1rx1NHh095VTgwvosJqxOFKL82UyB38GbGef4LtU//ZL9ZALwAXybE
         gjIpWOrsPXD248YwWKAjJK3zJr1Jwo62HVD+WBCR/SwmVhEsmle5ArxevyNrPSriOPRR
         qij5EF/GKlcTygDbKYw4aST0UMR49Cw31MjEtn/xyCv+qBzPxC5iVgkdLjX98zgSsCRa
         D2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nnsStoxMjXagyaQxrfF8MKczBgqcviWRVnTOz/hAPko=;
        b=S/+usCtRvBVoltYImfgJyEfAQdWEz+WE4GQ/kHdVO2QONJVTn6080ypzVlGhH4dJLq
         E9O5g7kuPg/WW08VVL+iimkP7hZjtI/V7Kx7gLyFg1FG3syrJcRrOCC1ZAI+C8BJFvye
         aZ7pRS2DwQ7b/7XChGToZ5CyW4TzbbhXwMvvEUttitcQOgibNFIp8o39tEvFGV2W07Um
         Ypv5RfgUB5D9/saFIWONK3+a9GVqoumn/9AXFZP+dTPdywmnnpyja7D8o9k+RBgtxODw
         sAuxURleLCuVZDlbDncqyOtORKHkmdqJw02G0kOeOvgdp5ClhTkHRAXMc+u2gr1ztssL
         64Yg==
X-Gm-Message-State: AA+aEWZrH4UCvZBE/YWs+Tx+4L505Dzt11tbwKhbxIIx7i3OUmuBTO/4
        c55vGw+iXSlf4Ym0u6n4gdDCwwt/k3SgeQ==
X-Google-Smtp-Source: AFSGD/WYu1yHk4SXd+GMlkFnoQ6e63b8mWO66poWcnYPcOSDRBNTb6GUMHuc8Qx1/gTHvovipj0etA==
X-Received: by 2002:a6b:fc03:: with SMTP id r3mr785971ioh.129.1544723856684;
        Thu, 13 Dec 2018 09:57:36 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k6sm1022261ios.69.2018.12.13.09.57.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:57:35 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 25/26] aio: add support for pre-mapped user IO buffers
Date:   Thu, 13 Dec 2018 10:56:44 -0700
Message-Id: <20181213175645.22181-26-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213175645.22181-1-axboe@kernel.dk>
References: <20181213175645.22181-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we have fixed user buffers, we can map them into the kernel when we
setup the io_context. That avoids the need to do get_user_pages() for
each and every IO.

To utilize this feature, the application must set both
IOCTX_FLAG_USERIOCB, to provide iocb's in userspace, and then
IOCTX_FLAG_FIXEDBUFS. The latter tells aio that the iocbs that are
mapped already contain valid destination and sizes. These buffers can
then be mapped into the kernel for the life time of the io_context, as
opposed to just the duration of the each single IO.

Only works with non-vectored read/write commands for now, not with
PREADV/PWRITEV.

A limit of 4M is imposed as the largest buffer we currently support.
There's nothing preventing us from going larger, but we need some cap,
and 4M seemed like it would definitely be big enough. RLIMIT_MEMLOCK
is used to cap the total amount of memory pinned.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c                     | 199 +++++++++++++++++++++++++++++++----
 include/uapi/linux/aio_abi.h |   1 +
 2 files changed, 182 insertions(+), 18 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index a5ec349670bc..66203fee6296 100644
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
@@ -104,6 +106,11 @@ struct aio_iocb_ring {
 	struct aio_mapped_range iocb_range;	/* maps user iocbs */
 };
 
+struct aio_mapped_ubuf {
+	struct bio_vec *bvec;
+	unsigned int nr_bvecs;
+};
+
 struct kioctx {
 	struct percpu_ref	users;
 	atomic_t		dead;
@@ -139,6 +146,9 @@ struct kioctx {
 	struct page		**ring_pages;
 	long			nr_pages;
 
+	/* if used, fixed mapped user buffers */
+	struct aio_mapped_ubuf	*user_bufs;
+
 	/* if used, completion and submission rings */
 	struct aio_iocb_ring	sq_ring;
 	struct aio_mapped_range cq_ring;
@@ -313,8 +323,10 @@ static const bool aio_use_state_req_list = true;
 static const bool aio_use_state_req_list = false;
 #endif
 
+static void aio_iocb_buffer_unmap(struct kioctx *);
 static void aio_scqring_unmap(struct kioctx *);
 static void aio_iopoll_reap_events(struct kioctx *);
+static const struct iocb *aio_iocb_from_index(struct kioctx *ctx, unsigned idx);
 
 static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
 {
@@ -693,6 +705,7 @@ static void free_ioctx(struct work_struct *work)
 	pr_debug("freeing %p\n", ctx);
 
 	aio_scqring_unmap(ctx);
+	aio_iocb_buffer_unmap(ctx);
 	aio_free_ring(ctx);
 	free_percpu(ctx->cpu);
 	percpu_ref_exit(&ctx->reqs);
@@ -1830,6 +1843,122 @@ static int aio_scqring_map(struct kioctx *ctx,
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
+		pret = get_user_pages((unsigned long) iocb->aio_buf, nr_pages,
+					1, pages, NULL);
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
@@ -1847,7 +1976,8 @@ SYSCALL_DEFINE5(io_setup2, u32, nr_events, u32, flags,
 	unsigned long ctx;
 	long ret;
 
-	if (flags & ~(IOCTX_FLAG_IOPOLL | IOCTX_FLAG_SCQRING))
+	if (flags & ~(IOCTX_FLAG_IOPOLL | IOCTX_FLAG_SCQRING |
+		      IOCTX_FLAG_FIXEDBUFS))
 		return -EINVAL;
 
 	ret = get_user(ctx, ctxp);
@@ -1863,6 +1993,15 @@ SYSCALL_DEFINE5(io_setup2, u32, nr_events, u32, flags,
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
@@ -2142,23 +2281,42 @@ static int aio_prep_rw(struct aio_kiocb *kiocb, const struct iocb *iocb,
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
+			int index;
+
+			/* __io_submit_one() already validated the index */
+			index = array_index_nospec((long)kiocb->ki_user_iocb,
+							ctx->max_reqs);
+			amu = &ctx->user_bufs[index];
+			iov_iter_bvec(iter, rw, amu->bvec, amu->nr_bvecs, len);
+			ret = 0;
+
+		}
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
@@ -2231,7 +2389,7 @@ static void aio_iopoll_iocb_issued(struct aio_submit_state *state,
 
 static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
 			struct aio_submit_state *state, bool vectored,
-			bool compat)
+			bool compat, bool kaddr)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *req = &kiocb->rw;
@@ -2251,9 +2409,11 @@ static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
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
@@ -2266,7 +2426,7 @@ static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
 
 static ssize_t aio_write(struct aio_kiocb *kiocb, const struct iocb *iocb,
 			 struct aio_submit_state *state, bool vectored,
-			 bool compat)
+			 bool compat, bool kaddr)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *req = &kiocb->rw;
@@ -2286,7 +2446,8 @@ static ssize_t aio_write(struct aio_kiocb *kiocb, const struct iocb *iocb,
 	if (unlikely(!file->f_op->write_iter))
 		goto out_fput;
 
-	ret = aio_setup_rw(WRITE, iocb, &iovec, vectored, compat, &iter);
+	ret = aio_setup_rw(WRITE, kiocb, iocb, &iovec, vectored, compat, kaddr,
+				&iter);
 	if (ret)
 		goto out_fput;
 	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
@@ -2525,7 +2686,8 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 
 static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 			   struct iocb __user *user_iocb,
-			   struct aio_submit_state *state, bool compat)
+			   struct aio_submit_state *state, bool compat,
+			   bool kaddr)
 {
 	struct aio_kiocb *req;
 	ssize_t ret;
@@ -2583,16 +2745,16 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
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
@@ -2648,7 +2810,7 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 	if (unlikely(copy_from_user(&iocb, user_iocb, sizeof(iocb))))
 		return -EFAULT;
 
-	return __io_submit_one(ctx, &iocb, user_iocb, state, compat);
+	return __io_submit_one(ctx, &iocb, user_iocb, state, compat, false);
 }
 
 #ifdef CONFIG_BLOCK
@@ -2750,6 +2912,7 @@ static const struct iocb *aio_peek_sqring(struct kioctx *ctx, unsigned *nhead)
 
 static int aio_ring_submit(struct kioctx *ctx, unsigned int to_submit)
 {
+	bool kaddr = (ctx->flags & IOCTX_FLAG_FIXEDBUFS) != 0;
 	struct aio_submit_state state, *statep = NULL;
 	int i, ret = 0, submit = 0;
 
@@ -2766,7 +2929,7 @@ static int aio_ring_submit(struct kioctx *ctx, unsigned int to_submit)
 		if (!iocb)
 			break;
 
-		ret = __io_submit_one(ctx, iocb, NULL, statep, false);
+		ret = __io_submit_one(ctx, iocb, NULL, statep, false, kaddr);
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

