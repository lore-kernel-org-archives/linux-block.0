Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781ADC04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CCA20878
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SYUpn0F6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25CCA20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeLDXie (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:38:34 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41499 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbeLDXie (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 18:38:34 -0500
Received: by mail-pg1-f195.google.com with SMTP id 70so8091939pgh.8
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 15:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9MIabrCZv2wQyfgdQ8RjyDsWgH6dv0dOreMfkqGsOyU=;
        b=SYUpn0F6F2xIg6+oEOxYeimcMQpJrCuWHHqNB09/67z9XQfJLyrFDUZWJYKVMeIk9J
         ZK/r0pb32AvtT858O1DLXFz6aU7c+8T+QoLsV6PSUjRqVS/ol6J7dgH8dCTR07kxik6R
         9K8AD1eyysXWEoUAVntTdzxvczk+nZ/u+eUpIvh4FquV4NuHCeMYP9HNfPvrz+iUO4Bn
         E8Ii8BOF7zH5b9Fzblh0gMz1e7OAtZq167YVAxcpes45khck8ZNxgRhsz3OZtwuLyafW
         W/rtufdAGWRESfCcYJ6P0Rwl+4A+NJBevg3npAbDZilru58lrFqSRrsrih/2kDtht1Qw
         XIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9MIabrCZv2wQyfgdQ8RjyDsWgH6dv0dOreMfkqGsOyU=;
        b=c/AXAyoI7ya1f9NYV/lzsBVJS/Li+KJYU+ctsgHyFIOZKIcc7dLQDeUG5QyoJNmt9H
         crVcKb698mjsJMVp72hh8vcSMiMzh9CCC/3/WFjLGvzmrTeh9E8Fj4i7Aepv5PGFePcR
         W6CNWo14Rxmo83/RUYQer+j4H3rsARvAuC6+yfP6+nRktWqZMJpqmdhCtIdt9/Gmher5
         ne86Tpp+3l2m0HJC2lFcZFcDBe6uzxNPSSPDg9O2PIP8XECBeWLZLeNxmZTYaQr2wJOn
         iYsi8dH/tcmxuPX43AZFwREZKqw99hj4E3eh7sbn6KNHY0mqrWu/vw8MJK/0hjrngk7S
         n/MQ==
X-Gm-Message-State: AA+aEWaUvIAMEoAkSBvZT+FV9vx7r4y4oU13m8cpvadOD9zP2+onOLrY
        MpuSAGYyOEF7sGPxEIoJsskKoPqGX+U=
X-Google-Smtp-Source: AFSGD/VPN2sBwHhLQtqTzW3GRQvgKl9K5bnxX1tIc+70GAh0HMCK8xhsalnq6N7/Juc/eQLVQVwoig==
X-Received: by 2002:a62:6385:: with SMTP id x127mr22379960pfb.15.1543966711993;
        Tue, 04 Dec 2018 15:38:31 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t13sm22527635pgr.42.2018.12.04.15.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 15:38:31 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 24/26] aio: add support for pre-mapped user IO buffers
Date:   Tue,  4 Dec 2018 16:37:27 -0700
Message-Id: <20181204233729.26776-25-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204233729.26776-1-axboe@kernel.dk>
References: <20181204233729.26776-1-axboe@kernel.dk>
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

See the fio change for how to utilize this feature:

http://git.kernel.dk/cgit/fio/commit/?id=2041bd343da1c1e955253f62374588718c64f0f3

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c                     | 193 ++++++++++++++++++++++++++++++++---
 include/uapi/linux/aio_abi.h |   1 +
 2 files changed, 177 insertions(+), 17 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 1735ec556089..1c8a8bb631a9 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -42,6 +42,7 @@
 #include <linux/ramfs.h>
 #include <linux/percpu-refcount.h>
 #include <linux/mount.h>
+#include <linux/sizes.h>
 
 #include <asm/kmap_types.h>
 #include <linux/uaccess.h>
@@ -97,6 +98,11 @@ struct aio_mapped_range {
 	long nr_pages;
 };
 
+struct aio_mapped_ubuf {
+	struct bio_vec *bvec;
+	unsigned int nr_bvecs;
+};
+
 struct kioctx {
 	struct percpu_ref	users;
 	atomic_t		dead;
@@ -132,6 +138,8 @@ struct kioctx {
 	struct page		**ring_pages;
 	long			nr_pages;
 
+	struct aio_mapped_ubuf	*user_bufs;
+
 	struct aio_mapped_range	iocb_range;
 
 	struct rcu_work		free_rwork;	/* see free_ioctx() */
@@ -301,6 +309,7 @@ static const bool aio_use_state_req_list = false;
 
 static void aio_useriocb_unmap(struct kioctx *);
 static void aio_iopoll_reap_events(struct kioctx *);
+static void aio_iocb_buffer_unmap(struct kioctx *);
 
 static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
 {
@@ -662,6 +671,7 @@ static void free_ioctx(struct work_struct *work)
 					  free_rwork);
 	pr_debug("freeing %p\n", ctx);
 
+	aio_iocb_buffer_unmap(ctx);
 	aio_useriocb_unmap(ctx);
 	aio_free_ring(ctx);
 	free_percpu(ctx->cpu);
@@ -1672,6 +1682,122 @@ static int aio_useriocb_map(struct kioctx *ctx, struct iocb __user *iocbs)
 	return aio_map_range(&ctx->iocb_range, iocbs, size, 0);
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
+	struct iocb *iocb;
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
 SYSCALL_DEFINE6(io_setup2, u32, nr_events, u32, flags, struct iocb __user *,
 		iocbs, void __user *, user1, void __user *, user2,
 		aio_context_t __user *, ctxp)
@@ -1682,7 +1808,8 @@ SYSCALL_DEFINE6(io_setup2, u32, nr_events, u32, flags, struct iocb __user *,
 
 	if (user1 || user2)
 		return -EINVAL;
-	if (flags & ~(IOCTX_FLAG_USERIOCB | IOCTX_FLAG_IOPOLL))
+	if (flags & ~(IOCTX_FLAG_USERIOCB | IOCTX_FLAG_IOPOLL |
+		      IOCTX_FLAG_FIXEDBUFS))
 		return -EINVAL;
 
 	ret = get_user(ctx, ctxp);
@@ -1698,6 +1825,15 @@ SYSCALL_DEFINE6(io_setup2, u32, nr_events, u32, flags, struct iocb __user *,
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
@@ -1975,23 +2111,39 @@ static int aio_prep_rw(struct aio_kiocb *kiocb, const struct iocb *iocb,
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
+			long index = (long) kiocb->ki_user_iocb;
+			struct aio_mapped_ubuf *amu;
+
+			/* __io_submit_one() already validated the index */
+			amu = &kiocb->ki_ctx->user_bufs[index];
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
@@ -2064,7 +2216,7 @@ static void aio_iopoll_iocb_issued(struct aio_submit_state *state,
 
 static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
 			struct aio_submit_state *state, bool vectored,
-			bool compat)
+			bool compat, bool kaddr)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *req = &kiocb->rw;
@@ -2084,9 +2236,11 @@ static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
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
@@ -2099,7 +2253,7 @@ static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
 
 static ssize_t aio_write(struct aio_kiocb *kiocb, const struct iocb *iocb,
 			 struct aio_submit_state *state, bool vectored,
-			 bool compat)
+			 bool compat, bool kaddr)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *req = &kiocb->rw;
@@ -2119,7 +2273,8 @@ static ssize_t aio_write(struct aio_kiocb *kiocb, const struct iocb *iocb,
 	if (unlikely(!file->f_op->write_iter))
 		goto out_fput;
 
-	ret = aio_setup_rw(WRITE, iocb, &iovec, vectored, compat, &iter);
+	ret = aio_setup_rw(WRITE, kiocb, iocb, &iovec, vectored, compat, kaddr,
+				&iter);
 	if (ret)
 		goto out_fput;
 	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
@@ -2358,7 +2513,8 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 
 static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 			   struct iocb __user *user_iocb,
-			   struct aio_submit_state *state, bool compat)
+			   struct aio_submit_state *state, bool compat,
+			   bool kaddr)
 {
 	struct aio_kiocb *req;
 	ssize_t ret;
@@ -2418,16 +2574,16 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
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
@@ -2479,6 +2635,7 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 			 struct aio_submit_state *state, bool compat)
 {
 	struct iocb iocb, *iocbp;
+	bool kaddr;
 
 	if (ctx->flags & IOCTX_FLAG_USERIOCB) {
 		unsigned long iocb_index = (unsigned long) user_iocb;
@@ -2486,14 +2643,16 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 		if (iocb_index >= ctx->max_reqs)
 			return -EINVAL;
 
+		kaddr = (ctx->flags & IOCTX_FLAG_FIXEDBUFS) != 0;
 		iocbp = aio_iocb_from_index(ctx, iocb_index);
 	} else {
 		if (unlikely(copy_from_user(&iocb, user_iocb, sizeof(iocb))))
 			return -EFAULT;
+		kaddr = false;
 		iocbp = &iocb;
 	}
 
-	return __io_submit_one(ctx, iocbp, user_iocb, state, compat);
+	return __io_submit_one(ctx, iocbp, user_iocb, state, compat, kaddr);
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

