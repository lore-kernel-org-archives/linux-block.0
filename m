Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5617FC43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B0920862
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gwo+yj4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B0920862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbeK0Dk5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:40:57 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34302 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbeK0Dk5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:40:57 -0500
Received: by mail-io1-f66.google.com with SMTP id f6so14483620iob.1
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zVtp4FzAAmfv0AO0psddh6PYN7Ojhn91p4dzu/5A1xE=;
        b=gwo+yj4oRA4/npssvRBvLgGVaYZMjXSSthalnvqzG/2EdhQrW18+E8b6Vr+qXT8DHH
         xXKeMis/livLC0TdG8WpkKSX7BJeoCCBF7t9W7lT3jFoX+C1l9jB+fcZsq3e5v6FepnI
         WoNXdpglvfzLGBNmzUEN5AZwuYn+9GmRO4jK88xFYVaW5J9N+voN6Qb7sAypb5cSzXqe
         Oum4tIdJ/2UcABbag2Opzy0aoAiDNqFeaG5t4Rtnjox5wBOuVly3tcX8guT/8XWPfd7+
         kf7XBFSf4PvLNBzvuOPUsgEsp5dZP3J00bBGWpC2BwUFX9i3l+Ck5aTrP8xvIw8bYhpT
         b82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zVtp4FzAAmfv0AO0psddh6PYN7Ojhn91p4dzu/5A1xE=;
        b=e7u0mxvsksSzvWmpLdRz6n1Vhs9cgmxHzENhynkO4O9qGNDRNkt6fIP+XgoOGskrMc
         ZQT/0ARYxOjP1n3BI+rXmAJfn5vz5LEscr53XCHng2PiJRlqq3+n31VBCGZPDBTtSdal
         +Rr8XUZkSVhWYVEO2ED2RNfBWdZERRl0UUG7DrGVWOvi1hbFUhNd7xV9pcwGDmo6u02n
         UdtoQDf/Zw6IFBLfiuj9K90Dl0ZEmM8TR/HiljiUQRxZAb2+Piaiql8jQI4RTvvQUnrD
         T8Zn5UXoMFeLieXZKyQcfs/woVBKjMaK0+dkd+8uLlL4Px+IryOOV4b2p53zLQFrI3dR
         ntQw==
X-Gm-Message-State: AA+aEWYDnkmPv0N/NqsVdao/e5v/ajjNPUsEr45BwnzMzPbuh3qGDAT4
        8wqHcoky2oScOXd5LvzJeweols9jVrE=
X-Google-Smtp-Source: AFSGD/Xu0ULtfsLuGjSY3jj4ieITl4hs9xB406H1ZsosDyilpKAhI9MSsDxZB598aXESOiZxUTwDVQ==
X-Received: by 2002:a6b:8f8d:: with SMTP id r135mr21697089iod.5.1543250777143;
        Mon, 26 Nov 2018 08:46:17 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t65-v6sm486801ita.9.2018.11.26.08.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:46:16 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/20] aio: add io_setup2() system call
Date:   Mon, 26 Nov 2018 09:45:39 -0700
Message-Id: <20181126164544.5699-16-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181126164544.5699-1-axboe@kernel.dk>
References: <20181126164544.5699-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is just like io_setup(), except add a flags argument to let the
caller control/define some of the io_context behavior. Outside of that,
we pass in an iocb array for future use.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 fs/aio.c                               | 70 ++++++++++++++++----------
 include/linux/syscalls.h               |  2 +
 include/uapi/asm-generic/unistd.h      |  4 +-
 kernel/sys_ni.c                        |  1 +
 5 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f0b1709a5ffb..67c357225fb0 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -343,6 +343,7 @@
 332	common	statx			__x64_sys_statx
 333	common	io_pgetevents		__x64_sys_io_pgetevents
 334	common	rseq			__x64_sys_rseq
+335	common	io_setup2		__x64_sys_io_setup2
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/aio.c b/fs/aio.c
index 12859ea1cb64..74831ce2185e 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -94,6 +94,8 @@ struct kioctx {
 
 	unsigned long		user_id;
 
+	unsigned int		flags;
+
 	struct __percpu kioctx_cpu *cpu;
 
 	/*
@@ -680,21 +682,24 @@ static void aio_nr_sub(unsigned nr)
 	spin_unlock(&aio_nr_lock);
 }
 
-/* ioctx_alloc
- *	Allocates and initializes an ioctx.  Returns an ERR_PTR if it failed.
- */
-static struct kioctx *ioctx_alloc(unsigned nr_events)
+static struct kioctx *io_setup_flags(unsigned long ctxid,
+				     unsigned int nr_events, unsigned int flags)
 {
 	struct mm_struct *mm = current->mm;
 	struct kioctx *ctx;
 	int err = -ENOMEM;
-
 	/*
 	 * Store the original nr_events -- what userspace passed to io_setup(),
 	 * for counting against the global limit -- before it changes.
 	 */
 	unsigned int max_reqs = nr_events;
 
+	if (unlikely(ctxid || nr_events == 0)) {
+		pr_debug("EINVAL: ctx %lu nr_events %u\n",
+		         ctxid, nr_events);
+		return ERR_PTR(-EINVAL);
+	}
+
 	/*
 	 * We keep track of the number of available ringbuffer slots, to prevent
 	 * overflow (reqs_available), and we also use percpu counters for this.
@@ -720,6 +725,7 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
+	ctx->flags = flags;
 	ctx->max_reqs = max_reqs;
 
 	spin_lock_init(&ctx->ctx_lock);
@@ -1275,6 +1281,33 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
 	return ret;
 }
 
+SYSCALL_DEFINE4(io_setup2, u32, nr_events, u32, flags, struct iocb * __user,
+		iocbs, aio_context_t __user *, ctxp)
+{
+	struct kioctx *ioctx;
+	unsigned long ctx;
+	long ret;
+
+	if (flags)
+		return -EINVAL;
+
+	ret = get_user(ctx, ctxp);
+	if (unlikely(ret))
+		goto out;
+
+	ioctx = io_setup_flags(ctx, nr_events, flags);
+	ret = PTR_ERR(ioctx);
+	if (IS_ERR(ioctx))
+		goto out;
+
+	ret = put_user(ioctx->user_id, ctxp);
+	if (ret)
+		kill_ioctx(current->mm, ioctx, NULL);
+	percpu_ref_put(&ioctx->users);
+out:
+	return ret;
+}
+
 /* sys_io_setup:
  *	Create an aio_context capable of receiving at least nr_events.
  *	ctxp must not point to an aio_context that already exists, and
@@ -1290,7 +1323,7 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
  */
 SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
 {
-	struct kioctx *ioctx = NULL;
+	struct kioctx *ioctx;
 	unsigned long ctx;
 	long ret;
 
@@ -1298,14 +1331,7 @@ SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
 	if (unlikely(ret))
 		goto out;
 
-	ret = -EINVAL;
-	if (unlikely(ctx || nr_events == 0)) {
-		pr_debug("EINVAL: ctx %lu nr_events %u\n",
-		         ctx, nr_events);
-		goto out;
-	}
-
-	ioctx = ioctx_alloc(nr_events);
+	ioctx = io_setup_flags(ctx, nr_events, 0);
 	ret = PTR_ERR(ioctx);
 	if (!IS_ERR(ioctx)) {
 		ret = put_user(ioctx->user_id, ctxp);
@@ -1313,7 +1339,6 @@ SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
 			kill_ioctx(current->mm, ioctx, NULL);
 		percpu_ref_put(&ioctx->users);
 	}
-
 out:
 	return ret;
 }
@@ -1321,7 +1346,7 @@ SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
 {
-	struct kioctx *ioctx = NULL;
+	struct kioctx *ioctx;
 	unsigned long ctx;
 	long ret;
 
@@ -1329,23 +1354,14 @@ COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
 	if (unlikely(ret))
 		goto out;
 
-	ret = -EINVAL;
-	if (unlikely(ctx || nr_events == 0)) {
-		pr_debug("EINVAL: ctx %lu nr_events %u\n",
-		         ctx, nr_events);
-		goto out;
-	}
-
-	ioctx = ioctx_alloc(nr_events);
+	ioctx = io_setup_flags(ctx, nr_events, 0);
 	ret = PTR_ERR(ioctx);
 	if (!IS_ERR(ioctx)) {
-		/* truncating is ok because it's a user address */
-		ret = put_user((u32)ioctx->user_id, ctx32p);
+		ret = put_user(ioctx->user_id, ctx32p);
 		if (ret)
 			kill_ioctx(current->mm, ioctx, NULL);
 		percpu_ref_put(&ioctx->users);
 	}
-
 out:
 	return ret;
 }
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 2ac3d13a915b..b661e78717e6 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -287,6 +287,8 @@ static inline void addr_limit_user_check(void)
  */
 #ifndef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
 asmlinkage long sys_io_setup(unsigned nr_reqs, aio_context_t __user *ctx);
+asmlinkage long sys_io_setup2(unsigned, unsigned, struct iocb __user *,
+				aio_context_t __user *);
 asmlinkage long sys_io_destroy(aio_context_t ctx);
 asmlinkage long sys_io_submit(aio_context_t, long,
 			struct iocb __user * __user *);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 538546edbfbd..b4527ed373b0 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -738,9 +738,11 @@ __SYSCALL(__NR_statx,     sys_statx)
 __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
 #define __NR_rseq 293
 __SYSCALL(__NR_rseq, sys_rseq)
+#define __NR_io_setup2 294
+__SYSCALL(__NR_io_setup2, sys_io_setup2)
 
 #undef __NR_syscalls
-#define __NR_syscalls 294
+#define __NR_syscalls 295
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index df556175be50..17c8b4393669 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -37,6 +37,7 @@ asmlinkage long sys_ni_syscall(void)
  */
 
 COND_SYSCALL(io_setup);
+COND_SYSCALL(io_setup2);
 COND_SYSCALL_COMPAT(io_setup);
 COND_SYSCALL(io_destroy);
 COND_SYSCALL(io_submit);
-- 
2.17.1

