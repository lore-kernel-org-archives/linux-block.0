Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CBBC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD852146D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bsrjDYFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD852146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeLAEH3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:07:29 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40794 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeLAEH3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:07:29 -0500
Received: by mail-io1-f65.google.com with SMTP id n9so5070639ioh.7
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aki/HEwtmsNooA8ZOaa31kgTTJLrCRRouznljeQ9dMg=;
        b=bsrjDYFIKU2SWAVc2l2m3UuvsJCuSEwR2UFYC1qI0DgsNh8PzYEYTjDCj8rE+ZUjzU
         o1XssgeB0YCt30agEtU6konJP/BK9g4FY+/UCRiauQcv0r9sgIwrdNZHFgCz2OzAHpI7
         2C/bzUWRhY4+Pu390nYlppjbFFp5Ik4eDjxsaZtfwJS/fmbgBPXFHnvC8RESJ6htKXK/
         6tXlWxFOmx53ZXOPtmJVn+j+GNr1+IuVK0268L2ewlIDGDoeN5nX8gq5DY3mNBkzPjsr
         PAIebloCaY3TEsWLyikGrLPJnGHOwkG72+rTLQf9PI0coZJvTlHnz/5JfVj92CafnnvU
         2udA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aki/HEwtmsNooA8ZOaa31kgTTJLrCRRouznljeQ9dMg=;
        b=ECRhCwnYey4omo7jxhKIspekln9MFblsTAr9oXjjjwjyW3iYOyaTws7EKxxvNv6k5u
         7/HG3vvXapIoz/B+kxdqtGZKVA8Y9qqY2HQ8U8vnl/J60WYsYS7Ian1HncnFmEPv1mUj
         WWrwjZyo1T35vvR+vd8cih+xXLnMpDQLpVhlQRnqFrX4cYxix/fIj9W/XmuBvKaHdQQ+
         v1fFWnOaVxO7R+mk6TmQniJggUNLH2NBY5OdXSFZo4jJILw2qzQcCL3C4IAUJYmN6i+5
         C0x16uxdnqxo6x2pB8TITJJwbd8onUTZN3GMCy+qvy1b7HujA4FroQi0xRrJc3olb5R0
         Grsw==
X-Gm-Message-State: AA+aEWZkZXuR/MpsAC97wcJSei5ma6EDzY6SMCMeXY8shnsfr4yElICo
        tE0fgWGoJFYM4YJO6K/Tt6OZ0vjedYs=
X-Google-Smtp-Source: AFSGD/VH7pwateZNZ9rs9Hbt56WICSICYtAcNRGraKhq8NTLYJjr4DYvXMXt5t2qAc8i9H8ZvaPDKw==
X-Received: by 2002:a6b:3e45:: with SMTP id l66mr4938182ioa.269.1543597052800;
        Fri, 30 Nov 2018 08:57:32 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:57:31 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 27/27] aio: add support for pre-mapped user IO buffers
Date:   Fri, 30 Nov 2018 09:56:46 -0700
Message-Id: <20181130165646.27341-28-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130165646.27341-1-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
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
and 4M seemed like it would definitely be big enough.

See the fio change for how to utilize this feature:

http://git.kernel.dk/cgit/fio/commit/?id=2041bd343da1c1e955253f62374588718c64f0f3

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c                     | 185 +++++++++++++++++++++++++++++++----
 include/uapi/linux/aio_abi.h |   1 +
 2 files changed, 169 insertions(+), 17 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 426939f1dae9..f735967488a5 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -42,6 +42,7 @@
 #include <linux/ramfs.h>
 #include <linux/percpu-refcount.h>
 #include <linux/mount.h>
+#include <linux/sizes.h>
 
 #include <asm/kmap_types.h>
 #include <linux/uaccess.h>
@@ -86,6 +87,11 @@ struct ctx_rq_wait {
 	atomic_t count;
 };
 
+struct aio_mapped_ubuf {
+	struct kvec *kvec;
+	unsigned int nr_kvecs;
+};
+
 struct kioctx {
 	struct percpu_ref	users;
 	atomic_t		dead;
@@ -124,6 +130,8 @@ struct kioctx {
 	struct page		**iocb_pages;
 	long			iocb_nr_pages;
 
+	struct aio_mapped_ubuf	*user_bufs;
+
 	struct rcu_work		free_rwork;	/* see free_ioctx() */
 
 	/*
@@ -290,6 +298,7 @@ static const bool aio_use_state_req_list = false;
 #endif
 
 static void aio_useriocb_free(struct kioctx *);
+static void aio_iocb_buffer_unmap(struct kioctx *);
 static void aio_iopoll_reap_events(struct kioctx *);
 
 static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
@@ -652,6 +661,7 @@ static void free_ioctx(struct work_struct *work)
 					  free_rwork);
 	pr_debug("freeing %p\n", ctx);
 
+	aio_iocb_buffer_unmap(ctx);
 	aio_useriocb_free(ctx);
 	aio_free_ring(ctx);
 	free_percpu(ctx->cpu);
@@ -1597,6 +1607,115 @@ static struct iocb *aio_iocb_from_index(struct kioctx *ctx, int index)
 	return iocb + index;
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
+		for (j = 0; j < amu->nr_kvecs; j++) {
+			struct page *page;
+
+			page = virt_to_page(amu->kvec[j].iov_base);
+			put_page(page);
+		}
+		kfree(amu->kvec);
+		amu->nr_kvecs = 0;
+	}
+
+	kfree(ctx->user_bufs);
+	ctx->user_bufs = NULL;
+}
+
+static int aio_iocb_buffer_map(struct kioctx *ctx)
+{
+	struct page **pages = NULL;
+	int i, j, got_pages = 0;
+	struct iocb *iocb;
+	int ret = -EINVAL;
+
+	ctx->user_bufs = kzalloc(ctx->max_reqs * sizeof(struct aio_mapped_ubuf),
+					GFP_KERNEL);
+	if (!ctx->user_bufs)
+		return -ENOMEM;
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
+		if (!pages || nr_pages > got_pages) {
+			kfree(pages);
+			pages = kmalloc(nr_pages * sizeof(struct page *),
+					GFP_KERNEL);
+			if (!pages) {
+				ret = -ENOMEM;
+				goto err;
+			}
+			got_pages = nr_pages;
+		}
+
+		amu->kvec = kmalloc(nr_pages * sizeof(struct kvec), GFP_KERNEL);
+		if (!amu->kvec)
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
+			amu->kvec[j].iov_base = page_address(pages[j]) + off;
+			amu->kvec[j].iov_len = vec_len;
+			off = 0;
+			size -= vec_len;
+		}
+		amu->nr_kvecs = nr_pages;
+	}
+	kfree(pages);
+	return 0;
+err:
+	kfree(pages);
+	aio_iocb_buffer_unmap(ctx);
+	return ret;
+}
+
 static void aio_useriocb_free(struct kioctx *ctx)
 {
 	int i;
@@ -1647,7 +1766,8 @@ SYSCALL_DEFINE4(io_setup2, u32, nr_events, u32, flags, struct iocb * __user,
 	unsigned long ctx;
 	long ret;
 
-	if (flags & ~(IOCTX_FLAG_USERIOCB | IOCTX_FLAG_IOPOLL))
+	if (flags & ~(IOCTX_FLAG_USERIOCB | IOCTX_FLAG_IOPOLL |
+		      IOCTX_FLAG_FIXEDBUFS))
 		return -EINVAL;
 
 	ret = get_user(ctx, ctxp);
@@ -1663,6 +1783,15 @@ SYSCALL_DEFINE4(io_setup2, u32, nr_events, u32, flags, struct iocb * __user,
 		ret = aio_useriocb_map(ioctx, iocbs);
 		if (ret)
 			goto err;
+		if (flags & IOCTX_FLAG_FIXEDBUFS) {
+			ret = aio_iocb_buffer_map(ioctx);
+			if (ret)
+				goto err;
+		}
+	} else if (flags & IOCTX_FLAG_FIXEDBUFS) {
+		/* can only support fixed bufs with user mapped iocbs */
+		ret = -EINVAL;
+		goto err;
 	}
 
 	ret = put_user(ioctx->user_id, ctxp);
@@ -1939,23 +2068,38 @@ static int aio_prep_rw(struct aio_kiocb *kiocb, const struct iocb *iocb,
 	return ret;
 }
 
-static int aio_setup_rw(int rw, const struct iocb *iocb, struct iovec **iovec,
-		bool vectored, bool compat, struct iov_iter *iter)
+static int aio_setup_rw(int rw, struct aio_kiocb *kiocb,
+		const struct iocb *iocb, struct iovec **iovec, bool vectored,
+		bool compat, bool kvecs, struct iov_iter *iter)
 {
-	void __user *buf = (void __user *)(uintptr_t)iocb->aio_buf;
+	void __user *ubuf = (void __user *)(uintptr_t)iocb->aio_buf;
 	size_t len = iocb->aio_nbytes;
 
 	if (!vectored) {
-		ssize_t ret = import_single_range(rw, buf, len, *iovec, iter);
+		ssize_t ret;
+
+		if (!kvecs) {
+			ret = import_single_range(rw, ubuf, len, *iovec, iter);
+		} else {
+			long index = (long) kiocb->ki_user_iocb;
+			struct aio_mapped_ubuf *amu;
+
+			/* __io_submit_one() already validated the index */
+			amu = &kiocb->ki_ctx->user_bufs[index];
+			ret = import_kvec(rw, amu->kvec, amu->nr_kvecs,
+						len, iter);
+		}
 		*iovec = NULL;
 		return ret;
 	}
+	if (kvecs)
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
@@ -2028,7 +2172,7 @@ static void aio_iopoll_iocb_issued(struct aio_submit_state *state,
 
 static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
 			struct aio_submit_state *state, bool vectored,
-			bool compat)
+			bool compat, bool kvecs)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *req = &kiocb->rw;
@@ -2048,9 +2192,11 @@ static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
 	if (unlikely(!file->f_op->read_iter))
 		goto out_fput;
 
-	ret = aio_setup_rw(READ, iocb, &iovec, vectored, compat, &iter);
+	ret = aio_setup_rw(READ, kiocb, iocb, &iovec, vectored, compat, kvecs,
+				&iter);
 	if (ret)
 		goto out_fput;
+
 	ret = rw_verify_area(READ, file, &req->ki_pos, iov_iter_count(&iter));
 	if (!ret)
 		aio_rw_done(req, call_read_iter(file, req, &iter));
@@ -2063,7 +2209,7 @@ static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
 
 static ssize_t aio_write(struct aio_kiocb *kiocb, const struct iocb *iocb,
 			 struct aio_submit_state *state, bool vectored,
-			 bool compat)
+			 bool compat, bool kvecs)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *req = &kiocb->rw;
@@ -2083,7 +2229,8 @@ static ssize_t aio_write(struct aio_kiocb *kiocb, const struct iocb *iocb,
 	if (unlikely(!file->f_op->write_iter))
 		goto out_fput;
 
-	ret = aio_setup_rw(WRITE, iocb, &iovec, vectored, compat, &iter);
+	ret = aio_setup_rw(WRITE, kiocb, iocb, &iovec, vectored, compat, kvecs,
+				&iter);
 	if (ret)
 		goto out_fput;
 	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
@@ -2322,7 +2469,8 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 
 static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 			   struct iocb __user *user_iocb,
-			   struct aio_submit_state *state, bool compat)
+			   struct aio_submit_state *state, bool compat,
+			   bool kvecs)
 {
 	struct aio_kiocb *req;
 	ssize_t ret;
@@ -2382,16 +2530,16 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 	ret = -EINVAL;
 	switch (iocb->aio_lio_opcode) {
 	case IOCB_CMD_PREAD:
-		ret = aio_read(req, iocb, state, false, compat);
+		ret = aio_read(req, iocb, state, false, compat, kvecs);
 		break;
 	case IOCB_CMD_PWRITE:
-		ret = aio_write(req, iocb, state, false, compat);
+		ret = aio_write(req, iocb, state, false, compat, kvecs);
 		break;
 	case IOCB_CMD_PREADV:
-		ret = aio_read(req, iocb, state, true, compat);
+		ret = aio_read(req, iocb, state, true, compat, kvecs);
 		break;
 	case IOCB_CMD_PWRITEV:
-		ret = aio_write(req, iocb, state, true, compat);
+		ret = aio_write(req, iocb, state, true, compat, kvecs);
 		break;
 	case IOCB_CMD_FSYNC:
 		if (ctx->flags & IOCTX_FLAG_IOPOLL)
@@ -2443,6 +2591,7 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 			 struct aio_submit_state *state, bool compat)
 {
 	struct iocb iocb, *iocbp;
+	bool kvecs;
 
 	if (ctx->flags & IOCTX_FLAG_USERIOCB) {
 		unsigned long iocb_index = (unsigned long) user_iocb;
@@ -2450,14 +2599,16 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 		if (iocb_index >= ctx->max_reqs)
 			return -EINVAL;
 
+		kvecs = (ctx->flags & IOCTX_FLAG_FIXEDBUFS) != 0;
 		iocbp = aio_iocb_from_index(ctx, iocb_index);
 	} else {
 		if (unlikely(copy_from_user(&iocb, user_iocb, sizeof(iocb))))
 			return -EFAULT;
+		kvecs = false;
 		iocbp = &iocb;
 	}
 
-	return __io_submit_one(ctx, iocbp, user_iocb, state, compat);
+	return __io_submit_one(ctx, iocbp, user_iocb, state, compat, kvecs);
 }
 
 #ifdef CONFIG_BLOCK
diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
index ea0b9a19f4df..05d72cf86bd3 100644
--- a/include/uapi/linux/aio_abi.h
+++ b/include/uapi/linux/aio_abi.h
@@ -110,6 +110,7 @@ struct iocb {
 
 #define IOCTX_FLAG_USERIOCB	(1 << 0)	/* iocbs are user mapped */
 #define IOCTX_FLAG_IOPOLL	(1 << 1)	/* io_context is polled */
+#define IOCTX_FLAG_FIXEDBUFS	(1 << 2)	/* IO buffers are fixed */
 
 #undef IFBIG
 #undef IFLITTLE
-- 
2.17.1

