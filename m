Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0E7C5CFFE
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A072087F
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fkMUWoU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A072087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeLKAQ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:16:26 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44030 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbeLKAQ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 19:16:26 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so6021152plb.10
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 16:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+LP3w7x2B9MpQgqSbgcHQj0u8w6yOA4gvKXwxHoehoE=;
        b=fkMUWoU7YmQvU3Z68SMkc1UsLB4TTSNB4XnGOuYItETQ399I0eAB+L4q0UBp9nV6LT
         miEjzj9Ex0WHFBYd7UGlQoyHoF0C3rYvBAANqPe79X+dr/YC/6bDdzPdKCD6yHhRJFz+
         VBGWPt3j+fOxFW6CDUL6XCpTfYNR0IpwY0Dot2NFIKWL6x8bB/ZejcNARr68oWAMJP1y
         vFht6Wo+ipSA5X0Qt89rrU5OwpC6mvgyM20kHg/HU0dGSTiQilyetvDeax95M1ndtEWW
         NN0PrbYcnQJqBYLn4mVWFg9+D+WWt6ucKRUyM1Yc49CC0hAfAXE15ocAOAky+1oQg6kj
         YjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+LP3w7x2B9MpQgqSbgcHQj0u8w6yOA4gvKXwxHoehoE=;
        b=TnlQmx993Pd/gFq1oEXuqHAbXZpCeCvCXHDS8XqcioAdk6bOPdq33wLu3v2tJt7z9i
         kz61I27l0FCxiEeni7a2pgHgGJAp8g35BSfjGuCStXpZJN3zVPMxaW0HdS2ouhQMpS92
         a4NbRKLFPJdzt4KkBhH12zEEzCzniJBYM/pEA82uDLg13uEFSz/0KqNE1Vz58AGDPtJt
         kfueA6NP81+ytFzTP/aLUP55ygrtMevXPtcMDNw8VFDpHZNouyGhz0ywJh4nJiKK7vEu
         1mjsR/Ldi2P9YCa0H1cLfsznS8rPNoXLXP/UfoVCi4CQcOTJVt61UL/UkjzysrYoGm16
         oWFQ==
X-Gm-Message-State: AA+aEWbvbVH/urQZQWDgjTarUgntPRcPDDJNQAQU/ZwM3jbf1EENbEsX
        h2AHUcwJl7LW7eKH0/PRQCRKF4XB+7h0/Q==
X-Google-Smtp-Source: AFSGD/U4aoQlzm56RN2XfkQJrh4BAK+IW6H12hZz3FXJn5/JadFnpAv/Lkbvsegi8FJf6MCE+PO6nw==
X-Received: by 2002:a17:902:720c:: with SMTP id ba12mr14105170plb.79.1544487384828;
        Mon, 10 Dec 2018 16:16:24 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm16872856pfl.16.2018.12.10.16.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:16:23 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/27] aio: add support for having user mapped iocbs
Date:   Mon, 10 Dec 2018 17:15:36 -0700
Message-Id: <20181211001549.30085-15-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211001549.30085-1-axboe@kernel.dk>
References: <20181211001549.30085-1-axboe@kernel.dk>
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
index 0bad70eab553..4e8c471a2598 100644
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
 /* sys_io_setup2:
  *	Like sys_io_setup(), except that it takes a set of flags
  *	(IOCTX_FLAG_*), and some pointers to user structures:
@@ -1307,7 +1384,9 @@ SYSCALL_DEFINE6(io_setup2, u32, nr_events, u32, flags, struct iocb __user *,
 	unsigned long ctx;
 	long ret;
 
-	if (flags || user1 || user2)
+	if (user1 || user2)
+		return -EINVAL;
+	if (flags & ~IOCTX_FLAG_USERIOCB)
 		return -EINVAL;
 
 	ret = get_user(ctx, ctxp);
@@ -1319,9 +1398,17 @@ SYSCALL_DEFINE6(io_setup2, u32, nr_events, u32, flags, struct iocb __user *,
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
@@ -1871,10 +1958,13 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
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
@@ -1928,12 +2018,22 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
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
@@ -2077,6 +2177,9 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 	if (unlikely(!ctx))
 		return -EINVAL;
 
+	if (ctx->flags & IOCTX_FLAG_USERIOCB)
+		goto err;
+
 	spin_lock_irq(&ctx->ctx_lock);
 	kiocb = lookup_kiocb(ctx, iocb);
 	if (kiocb) {
@@ -2093,9 +2196,8 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
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

