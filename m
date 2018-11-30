Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8D0C64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A881B2145D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="d0tJD0Wy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A881B2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbeLAEHM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:07:12 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:56310 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbeLAEHL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:07:11 -0500
Received: by mail-it1-f193.google.com with SMTP id o19so10088973itg.5
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oKKQgmcCq/9Ah7syrea645E2X6XDYJJKTHIbZiVUtQA=;
        b=d0tJD0Wy9ZqANIAHGeCLauIvT1VK7FS8IK8QoCAOQXsuEJ7/RYSep1DMCbjukV2xit
         8IN81K9MwjMNC0trD1xv50CEJzyhORoc0CDg4G0MV1WgDMJvxbL3H03rNtcpEq65NqVA
         lKELC/VGnU7DasbLyGho8vxDQ48aXQbL/LkZ8nmQQBrIfA7dp+PgD5/bXph7HVLP12E3
         exI4DhxNeeIZQigdrz7YQGEpI22R2M3jwOT9UfUv833rWUfDudVVDr45BIK94UzDpKtd
         cp7dFFYc+ty1caW3bf01/jmmL7fjKcRK1Ji5WFehV0obKLWPk5KIQjq/3X/5l0XENa3m
         6TOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oKKQgmcCq/9Ah7syrea645E2X6XDYJJKTHIbZiVUtQA=;
        b=nvsKhz606QMcL7J1bGYBhKVzUB+2vfMbLEWjTbXiYu85x0KTIha1uMLGoAiGQYjIBL
         912aMZNXxtQ8301Q9NZp1d55+ZLGzEJiSN+lgmxiRyGZCrIFsh+sG4o6G4aa9r3pwaWG
         7uFxEBCAwsKXDZ6oY8lAIs052OE2quUk5s9XEL658DP4wsiOc1jydmnsUXmHPNGMbGOG
         3hy4RFPp7W/AYfDrUqVm3hERQ6fjqy822zq61ba/zHYg0cYA+DgsWOiOQI/YGx7KPx85
         cqVSukhBJIdJJh3MfQukhOoN+K3UG/HN5R1oFulaTnxiFQYMXUVv89t8j6xY3GNyiX/R
         e2pQ==
X-Gm-Message-State: AA+aEWa3SQayR2U7o6k6RZnT2QF8cU1d+qajrrQN9IlAXSb7cFQURS+y
        2i4i2QGe0wstr7f4sAgTIonc8f2FMUw=
X-Google-Smtp-Source: AFSGD/VKuFulIgf3VgS6jKp58AG2QjXP9zPiQs34oa5nM39AyaEQN/SUENA7iC1X/xIfVgA60BlOIA==
X-Received: by 2002:a24:750f:: with SMTP id y15mr5507249itc.177.1543597035467;
        Fri, 30 Nov 2018 08:57:15 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:57:14 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 16/27] aio: add support for having user mapped iocbs
Date:   Fri, 30 Nov 2018 09:56:35 -0700
Message-Id: <20181130165646.27341-17-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130165646.27341-1-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For io_submit(), we have to first copy each pointer to an iocb, then
copy the iocb. The latter is 64 bytes in size, and that's a lot of
copying for a single IO.

Add support for setting IOCTX_FLAG_USERIOCB through the new io_setup2()
system call, which allows the iocbs to reside in userspace. If this flag
is used, then io_submit() doesn't take pointers to iocbs anymore, it
takes an index value into the array of iocbs instead. Similary, for
io_getevents(), the iocb ->obj will be the index, not the pointer to the
iocb.

See the change made to fio to support this feature, it's pretty
trivialy to adapt to. For applications, like fio, that previously
embedded the iocb inside a application private structure, some sort
of lookup table/structure is needed to find the private IO structure
from the index at io_getevents() time.

http://git.kernel.dk/cgit/fio/commit/?id=3c3168e91329c83880c91e5abc28b9d6b940fd95

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c                     | 111 +++++++++++++++++++++++++++++++----
 include/uapi/linux/aio_abi.h |   2 +
 2 files changed, 101 insertions(+), 12 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 74831ce2185e..380e6fe8c429 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -121,6 +121,9 @@ struct kioctx {
 	struct page		**ring_pages;
 	long			nr_pages;
 
+	struct page		**iocb_pages;
+	long			iocb_nr_pages;
+
 	struct rcu_work		free_rwork;	/* see free_ioctx() */
 
 	/*
@@ -216,6 +219,11 @@ static struct vfsmount *aio_mnt;
 static const struct file_operations aio_ring_fops;
 static const struct address_space_operations aio_ctx_aops;
 
+static const unsigned int iocb_page_shift =
+				ilog2(PAGE_SIZE / sizeof(struct iocb));
+
+static void aio_useriocb_free(struct kioctx *);
+
 static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
 {
 	struct file *file;
@@ -572,6 +580,7 @@ static void free_ioctx(struct work_struct *work)
 					  free_rwork);
 	pr_debug("freeing %p\n", ctx);
 
+	aio_useriocb_free(ctx);
 	aio_free_ring(ctx);
 	free_percpu(ctx->cpu);
 	percpu_ref_exit(&ctx->reqs);
@@ -1281,6 +1290,61 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
 	return ret;
 }
 
+static struct iocb *aio_iocb_from_index(struct kioctx *ctx, int index)
+{
+	unsigned int page_index;
+	struct iocb *iocb;
+
+	page_index = index >> iocb_page_shift;
+	index &= ((1 << iocb_page_shift) - 1);
+	iocb = page_address(ctx->iocb_pages[page_index]);
+
+	return iocb + index;
+}
+
+static void aio_useriocb_free(struct kioctx *ctx)
+{
+	int i;
+
+	if (!ctx->iocb_nr_pages)
+		return;
+
+	for (i = 0; i < ctx->iocb_nr_pages; i++)
+		put_page(ctx->iocb_pages[i]);
+
+	kfree(ctx->iocb_pages);
+	ctx->iocb_pages = NULL;
+	ctx->iocb_nr_pages = 0;
+}
+
+static int aio_useriocb_map(struct kioctx *ctx, struct iocb __user *iocbs)
+{
+	int nr_pages, ret;
+
+	if ((unsigned long) iocbs & ~PAGE_MASK)
+		return -EINVAL;
+
+	nr_pages = sizeof(struct iocb) * ctx->max_reqs;
+	nr_pages = (nr_pages + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+	ctx->iocb_pages = kzalloc(nr_pages * sizeof(struct page *), GFP_KERNEL);
+	if (!ctx->iocb_pages)
+		return -ENOMEM;
+
+	down_write(&current->mm->mmap_sem);
+	ret = get_user_pages((unsigned long) iocbs, nr_pages, 0,
+				ctx->iocb_pages, NULL);
+	up_write(&current->mm->mmap_sem);
+
+	if (ret < nr_pages) {
+		kfree(ctx->iocb_pages);
+		return -ENOMEM;
+	}
+
+	ctx->iocb_nr_pages = nr_pages;
+	return 0;
+}
+
 SYSCALL_DEFINE4(io_setup2, u32, nr_events, u32, flags, struct iocb * __user,
 		iocbs, aio_context_t __user *, ctxp)
 {
@@ -1288,7 +1352,7 @@ SYSCALL_DEFINE4(io_setup2, u32, nr_events, u32, flags, struct iocb * __user,
 	unsigned long ctx;
 	long ret;
 
-	if (flags)
+	if (flags & ~IOCTX_FLAG_USERIOCB)
 		return -EINVAL;
 
 	ret = get_user(ctx, ctxp);
@@ -1300,9 +1364,17 @@ SYSCALL_DEFINE4(io_setup2, u32, nr_events, u32, flags, struct iocb * __user,
 	if (IS_ERR(ioctx))
 		goto out;
 
+	if (flags & IOCTX_FLAG_USERIOCB) {
+		ret = aio_useriocb_map(ioctx, iocbs);
+		if (ret)
+			goto err;
+	}
+
 	ret = put_user(ioctx->user_id, ctxp);
-	if (ret)
+	if (ret) {
+err:
 		kill_ioctx(current->mm, ioctx, NULL);
+	}
 	percpu_ref_put(&ioctx->users);
 out:
 	return ret;
@@ -1851,10 +1923,13 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 		}
 	}
 
-	ret = put_user(KIOCB_KEY, &user_iocb->aio_key);
-	if (unlikely(ret)) {
-		pr_debug("EFAULT: aio_key\n");
-		goto out_put_req;
+	/* Don't support cancel on user mapped iocbs */
+	if (!(ctx->flags & IOCTX_FLAG_USERIOCB)) {
+		ret = put_user(KIOCB_KEY, &user_iocb->aio_key);
+		if (unlikely(ret)) {
+			pr_debug("EFAULT: aio_key\n");
+			goto out_put_req;
+		}
 	}
 
 	req->ki_user_iocb = user_iocb;
@@ -1908,12 +1983,22 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 			 bool compat)
 {
-	struct iocb iocb;
+	struct iocb iocb, *iocbp;
 
-	if (unlikely(copy_from_user(&iocb, user_iocb, sizeof(iocb))))
-		return -EFAULT;
+	if (ctx->flags & IOCTX_FLAG_USERIOCB) {
+		unsigned long iocb_index = (unsigned long) user_iocb;
+
+		if (iocb_index >= ctx->max_reqs)
+			return -EINVAL;
+
+		iocbp = aio_iocb_from_index(ctx, iocb_index);
+	} else {
+		if (unlikely(copy_from_user(&iocb, user_iocb, sizeof(iocb))))
+			return -EFAULT;
+		iocbp = &iocb;
+	}
 
-	return __io_submit_one(ctx, &iocb, user_iocb, compat);
+	return __io_submit_one(ctx, iocbp, user_iocb, compat);
 }
 
 /*
@@ -2063,6 +2148,9 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 	if (unlikely(!ctx))
 		return -EINVAL;
 
+	if (ctx->flags & IOCTX_FLAG_USERIOCB)
+		goto err;
+
 	spin_lock_irq(&ctx->ctx_lock);
 	kiocb = lookup_kiocb(ctx, iocb);
 	if (kiocb) {
@@ -2079,9 +2167,8 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 		 */
 		ret = -EINPROGRESS;
 	}
-
+err:
 	percpu_ref_put(&ctx->users);
-
 	return ret;
 }
 
diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
index 8387e0af0f76..814e6606c413 100644
--- a/include/uapi/linux/aio_abi.h
+++ b/include/uapi/linux/aio_abi.h
@@ -106,6 +106,8 @@ struct iocb {
 	__u32	aio_resfd;
 }; /* 64 bytes */
 
+#define IOCTX_FLAG_USERIOCB	(1 << 0)	/* iocbs are user mapped */
+
 #undef IFBIG
 #undef IFLITTLE
 
-- 
2.17.1

