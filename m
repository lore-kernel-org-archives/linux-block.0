Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD3FC43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B0020862
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="usfYWlUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B0020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeK0Dk7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:40:59 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:56044 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbeK0Dk7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:40:59 -0500
Received: by mail-it1-f193.google.com with SMTP id o19so29265801itg.5
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zWP6coMWt07nFsQ2bCKPJsd0fyiDRI0lMmSnLaRva2o=;
        b=usfYWlUi2uqiKReQCULh3/c58WLx/7awhBs0tRsajj8S4ioh/nqGHzbpUH7hRqDvqU
         7b3/cZ09F2+uAFnK1Ywr2Ziv1oQcjlAnI0YbSxTZLjID82YwlpbhS/WTwIlnYWlyX51y
         0XwZ2/YECZICJmd0cfNhtLzcbOPZL9fyKgoqcvCEV7dHYFxqXA81GvG4DCSBoECwfBUl
         ysi4me5m47AdLZA6TVTGLStIxhEX3mH2yzbMXYdwNPonuh8CX54jos6hA1IJoaXU9t3O
         lAF76i1ku0GZLbZRYFlKlYxf9s5dAPzfZ18lPRd2fElh03EHSdXpNPLiMlieH5PQR/FR
         S31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zWP6coMWt07nFsQ2bCKPJsd0fyiDRI0lMmSnLaRva2o=;
        b=aD0AIHEhAX1Wwz/FOFfGnW/AcIH4z0HIbkznVfEJ7BJ5jNEEVhGXCWjC5lh5wcZElx
         nbfesDtrXUyQ8we2Wz2Nui7ifrQmahhGLvD9s9nRxBIdFUYl9zrwdLWPTZcD+os1bTkb
         MndWYy3pyDDOGeyj1x/E48vLzbXFS94pGg6AbdGR2RvEZKBavvjE3XxyZw2C8s5bN7gw
         uVgJuIoR9mkT0ea3LjqtoGdbK+yjvIWYCIilGLYZ2iT99V/CI3yDu2tGJCAW//G8vQ+l
         4XzY/RvexQJN4XpNLyJYVtCztwVJeuywVumfWb1a288wMdEEi4j1QhNT8XQQxZ6eK6UP
         MXnQ==
X-Gm-Message-State: AA+aEWbCLC3rZiaQEu7FMTGRUk+1ozH2vupCyVp0FMkwm5N6VKyspafe
        22Hp5frLP72K0k8bQnMGZ01kjvAejok=
X-Google-Smtp-Source: AFSGD/UIQ+qF9QnYQgfHW8Qu+jPteNhC11a5yA1vg3hjZUWhqYLVMmMH0Xfcv5jX9RFDhEGjT1GoEA==
X-Received: by 2002:a24:c40b:: with SMTP id v11mr1251131itf.73.1543250779133;
        Mon, 26 Nov 2018 08:46:19 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t65-v6sm486801ita.9.2018.11.26.08.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:46:17 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 16/20] aio: add support for having user mapped iocbs
Date:   Mon, 26 Nov 2018 09:45:40 -0700
Message-Id: <20181126164544.5699-17-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181126164544.5699-1-axboe@kernel.dk>
References: <20181126164544.5699-1-axboe@kernel.dk>
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
 fs/aio.c                     | 99 +++++++++++++++++++++++++++++++-----
 include/uapi/linux/aio_abi.h |  2 +
 2 files changed, 89 insertions(+), 12 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 74831ce2185e..e98121df92f6 100644
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
@@ -1281,6 +1290,45 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
 	return ret;
 }
 
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
+}
+
+static int aio_useriocb_map(struct kioctx *ctx, struct iocb __user *iocbs,
+			    unsigned int nr_events)
+{
+	int nr_pages, ret;
+
+	if ((unsigned long) iocbs & ~PAGE_MASK)
+		return -EINVAL;
+
+	nr_pages = sizeof(struct iocb) * nr_events;
+	nr_pages = (nr_pages + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+	ctx->iocb_pages = kzalloc(nr_pages * sizeof(struct page *), GFP_KERNEL);
+	if (!ctx->iocb_pages)
+		return -ENOMEM;
+
+	ret = get_user_pages_fast((unsigned long) iocbs, nr_pages, 0,
+					ctx->iocb_pages);
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
@@ -1288,7 +1336,7 @@ SYSCALL_DEFINE4(io_setup2, u32, nr_events, u32, flags, struct iocb * __user,
 	unsigned long ctx;
 	long ret;
 
-	if (flags)
+	if (flags & ~IOCTX_FLAG_USERIOCB)
 		return -EINVAL;
 
 	ret = get_user(ctx, ctxp);
@@ -1300,9 +1348,17 @@ SYSCALL_DEFINE4(io_setup2, u32, nr_events, u32, flags, struct iocb * __user,
 	if (IS_ERR(ioctx))
 		goto out;
 
+	if (flags & IOCTX_FLAG_USERIOCB) {
+		ret = aio_useriocb_map(ioctx, iocbs, nr_events);
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
@@ -1851,10 +1907,13 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
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
@@ -1908,12 +1967,26 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 			 bool compat)
 {
-	struct iocb iocb;
+	struct iocb iocb, *iocbp;
 
-	if (unlikely(copy_from_user(&iocb, user_iocb, sizeof(iocb))))
-		return -EFAULT;
+	if (ctx->flags & IOCTX_FLAG_USERIOCB) {
+		unsigned long iocb_index = (unsigned long) user_iocb;
+		unsigned int page_index;
 
-	return __io_submit_one(ctx, &iocb, user_iocb, compat);
+		if (iocb_index >= ctx->nr_events)
+			return -EINVAL;
+
+		page_index = iocb_index >> iocb_page_shift;
+		iocb_index &= ((1 << iocb_page_shift) - 1);
+		iocbp = page_address(ctx->iocb_pages[page_index]);
+		iocbp += iocb_index;
+	} else {
+		if (unlikely(copy_from_user(&iocb, user_iocb, sizeof(iocb))))
+			return -EFAULT;
+		iocbp = &iocb;
+	}
+
+	return __io_submit_one(ctx, iocbp, user_iocb, compat);
 }
 
 /*
@@ -2063,6 +2136,9 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 	if (unlikely(!ctx))
 		return -EINVAL;
 
+	if (ctx->flags & IOCTX_FLAG_USERIOCB)
+		goto err;
+
 	spin_lock_irq(&ctx->ctx_lock);
 	kiocb = lookup_kiocb(ctx, iocb);
 	if (kiocb) {
@@ -2079,9 +2155,8 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
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

