Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C00CC04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5368C20850
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="d6miXTU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5368C20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeLDXiJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:38:09 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40372 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeLDXiJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 18:38:09 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so9002784pfo.7
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 15:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VIelYwIQhuJ5AQqTwtkFXKeN6WxDwL+cWQ8voRQ13S0=;
        b=d6miXTU9Z4A/cp8m95J4Xxd/U58htbpmyTwK8VyCNShZt47ee4m5i5Uj6P4G3tNM2p
         51XvXtcYGnQEJhRSIqeO5qfG4zZ9m6ePg1SLrUySY5aCnbLpIxgGf1GBY3hQu7CNaZHL
         Z5yHZM1xBEaQymEjPT1BCkOJAtvpAACQchLLdxdw3uyBgHgi34gkO+N6HGX2RldXDdzY
         ro/7MLVDSRCcmFTV7UMQmsN2PUth7fDOdUzq/sOlU8aU9a5mJo+MPql0pHW5adAa0Cau
         4PxTgufa5VU5vsZjA/yKJkqk7kkP82Q42de+BnsY7jWTq7zvpVNaURCzxTDmUMw/gkRF
         YhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VIelYwIQhuJ5AQqTwtkFXKeN6WxDwL+cWQ8voRQ13S0=;
        b=Fpv8fQzqM5670acGeogmBBpFZwfZO39ToHe+VjREAAaA8slFqXqatI6xEiIOh6GMcz
         /Sto6qx0JsHOEoQw2LAVZOB8NgB6oCr6zr/LgGMM/50T7hsFYgIJxCy2/XW88pYSmZcU
         5gC4aiF5FVwjEr3ss1tt+SwHob48MmJzZWKPrHVYv5jLa+rsMH5h3tCj/X1NU8Jo68Hh
         AC4c42uPL8qHh1/uf7uNzVFyPoVGKM/gVmPFzPGoUfMSKt0gfhhzG1Lpvpk46fy29zCP
         vG9EZhSdUik3lPEWrTVE5TNEOZfikkjd3/aETPtzp4WIWGSQ9EtexBtilpdyAIf5hcjd
         XZqQ==
X-Gm-Message-State: AA+aEWbzuGXTNP+xaZsLIwaS31gglCvan2rAd+eTMnwK/VbkVYg2A3Z4
        RzPxzbazwADfhSdnxPBRT8FaSoyvHeo=
X-Google-Smtp-Source: AFSGD/UBis7FX5ONJ6WpZJyGf5Gs4b305mrD7oG87jzrfFY2Bdkzrxavk3/BeFLpWzWMczuD5ndmYQ==
X-Received: by 2002:a63:9a09:: with SMTP id o9mr17796984pge.94.1543966687233;
        Tue, 04 Dec 2018 15:38:07 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t13sm22527635pgr.42.2018.12.04.15.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 15:38:06 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/26] aio: add support for having user mapped iocbs
Date:   Tue,  4 Dec 2018 16:37:17 -0700
Message-Id: <20181204233729.26776-15-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204233729.26776-1-axboe@kernel.dk>
References: <20181204233729.26776-1-axboe@kernel.dk>
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
 fs/aio.c                     | 126 +++++++++++++++++++++++++++++++----
 include/uapi/linux/aio_abi.h |   2 +
 2 files changed, 116 insertions(+), 12 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 26631d6872d2..bb6f07ca6940 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -92,6 +92,11 @@ struct ctx_rq_wait {
 	atomic_t count;
 };
 
+struct aio_mapped_range {
+	struct page **pages;
+	long nr_pages;
+};
+
 struct kioctx {
 	struct percpu_ref	users;
 	atomic_t		dead;
@@ -127,6 +132,8 @@ struct kioctx {
 	struct page		**ring_pages;
 	long			nr_pages;
 
+	struct aio_mapped_range	iocb_range;
+
 	struct rcu_work		free_rwork;	/* see free_ioctx() */
 
 	/*
@@ -222,6 +229,11 @@ static struct vfsmount *aio_mnt;
 static const struct file_operations aio_ring_fops;
 static const struct address_space_operations aio_ctx_aops;
 
+static const unsigned int iocb_page_shift =
+				ilog2(PAGE_SIZE / sizeof(struct iocb));
+
+static void aio_useriocb_unmap(struct kioctx *);
+
 static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
 {
 	struct file *file;
@@ -578,6 +590,7 @@ static void free_ioctx(struct work_struct *work)
 					  free_rwork);
 	pr_debug("freeing %p\n", ctx);
 
+	aio_useriocb_unmap(ctx);
 	aio_free_ring(ctx);
 	free_percpu(ctx->cpu);
 	percpu_ref_exit(&ctx->reqs);
@@ -1288,6 +1301,70 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
 	return ret;
 }
 
+static struct iocb *aio_iocb_from_index(struct kioctx *ctx, int index)
+{
+	struct iocb *iocb;
+
+	iocb = page_address(ctx->iocb_range.pages[index >> iocb_page_shift]);
+	index &= ((1 << iocb_page_shift) - 1);
+	return iocb + index;
+}
+
+static void aio_unmap_range(struct aio_mapped_range *range)
+{
+	int i;
+
+	if (!range->nr_pages)
+		return;
+
+	for (i = 0; i < range->nr_pages; i++)
+		put_page(range->pages[i]);
+
+	kfree(range->pages);
+	range->pages = NULL;
+	range->nr_pages = 0;
+}
+
+static int aio_map_range(struct aio_mapped_range *range, void __user *uaddr,
+			 size_t size, int gup_flags)
+{
+	int nr_pages, ret;
+
+	if ((unsigned long) uaddr & ~PAGE_MASK)
+		return -EINVAL;
+
+	nr_pages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+	range->pages = kzalloc(nr_pages * sizeof(struct page *), GFP_KERNEL);
+	if (!range->pages)
+		return -ENOMEM;
+
+	down_write(&current->mm->mmap_sem);
+	ret = get_user_pages((unsigned long) uaddr, nr_pages, gup_flags,
+				range->pages, NULL);
+	up_write(&current->mm->mmap_sem);
+
+	if (ret < nr_pages) {
+		kfree(range->pages);
+		return -ENOMEM;
+	}
+
+	range->nr_pages = nr_pages;
+	return 0;
+}
+
+static void aio_useriocb_unmap(struct kioctx *ctx)
+{
+	aio_unmap_range(&ctx->iocb_range);
+}
+
+static int aio_useriocb_map(struct kioctx *ctx, struct iocb __user *iocbs)
+{
+	size_t size = sizeof(struct iocb) * ctx->max_reqs;
+
+	return aio_map_range(&ctx->iocb_range, iocbs, size, 0);
+}
+
 SYSCALL_DEFINE6(io_setup2, u32, nr_events, u32, flags, struct iocb __user *,
 		iocbs, void __user *, user1, void __user *, user2,
 		aio_context_t __user *, ctxp)
@@ -1296,7 +1373,9 @@ SYSCALL_DEFINE6(io_setup2, u32, nr_events, u32, flags, struct iocb __user *,
 	unsigned long ctx;
 	long ret;
 
-	if (flags || user1 || user2)
+	if (user1 || user2)
+		return -EINVAL;
+	if (flags & ~IOCTX_FLAG_USERIOCB)
 		return -EINVAL;
 
 	ret = get_user(ctx, ctxp);
@@ -1308,9 +1387,17 @@ SYSCALL_DEFINE6(io_setup2, u32, nr_events, u32, flags, struct iocb __user *,
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
@@ -1860,10 +1947,13 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
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
@@ -1917,12 +2007,22 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 			 bool compat)
 {
-	struct iocb iocb;
+	struct iocb iocb, *iocbp;
 
-	if (unlikely(copy_from_user(&iocb, user_iocb, sizeof(iocb))))
-		return -EFAULT;
+	if (ctx->flags & IOCTX_FLAG_USERIOCB) {
+		unsigned long iocb_index = (unsigned long) user_iocb;
 
-	return __io_submit_one(ctx, &iocb, user_iocb, compat);
+		if (iocb_index >= ctx->max_reqs)
+			return -EINVAL;
+
+		iocbp = aio_iocb_from_index(ctx, iocb_index);
+	} else {
+		if (unlikely(copy_from_user(&iocb, user_iocb, sizeof(iocb))))
+			return -EFAULT;
+		iocbp = &iocb;
+	}
+
+	return __io_submit_one(ctx, iocbp, user_iocb, compat);
 }
 
 /* sys_io_submit:
@@ -2066,6 +2166,9 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 	if (unlikely(!ctx))
 		return -EINVAL;
 
+	if (ctx->flags & IOCTX_FLAG_USERIOCB)
+		goto err;
+
 	spin_lock_irq(&ctx->ctx_lock);
 	kiocb = lookup_kiocb(ctx, iocb);
 	if (kiocb) {
@@ -2082,9 +2185,8 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
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

