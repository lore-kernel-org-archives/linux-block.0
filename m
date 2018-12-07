Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEA9C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E031E20892
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="v3rCw0X0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E031E20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbeLGWUt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:20:49 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46052 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeLGWUs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 17:20:48 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so2556795pfd.12
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 14:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fcaGUab+hmUcXDyEXpGB51iaDLsNQ4/e2XEygehySfs=;
        b=v3rCw0X0fLOjGhHA/QIc2zQsIKhK3zJSS48+6ulBTNi46vIM6FYLXTErDTT5mAawKl
         0YlcGOqGInZ2I1i4MfgFoEink7w0pVWetgghaSYro6mx8afInSHqnhdXUyy1qDBWC7yo
         tUtYBm+w5FMqpXVO0BBbDr89FzEkJItH94OXHy+BFVwBnVoiK5YZQ+0wk5tTbFR2XvZm
         vzq/B+Lb3R3P05l+oS8xA8Y+1lYYX543jMymaKQJBZRjIJ2qqnkgnVHiZjzvv3tMvvKb
         p3Mron+10x+e+FuYJBYRliOek/yVc35NmwsqChfrMtD7DTWsTM3YkFwCZo7xUCXAPK30
         U3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fcaGUab+hmUcXDyEXpGB51iaDLsNQ4/e2XEygehySfs=;
        b=MOwXDdTHCHsEKlZDG+PJYAhVnriNhf3FXJ5eKHw/K2uMSF1JIf2z5eOj8x6DksdlEK
         ujBpiqYcOcrW4GfSBm3ewarUhqXuQ5F2j/obAV5OIqXG6z6KCcwxAq4PehkmwEVgECuo
         yOiQ3boK20DP6rqpqeg65rwvMIQFBwsHMwRheSxGvLPISKsYDPg+b8OW6NIok6q9sUSZ
         n1GbCPc+IwjqD05SQ7tIZJCNmBVqJp1AkrUuR5Q8WHSeBohwFhgSBj5kVLcSnNhtS0Pi
         0sxJOIUxmNIKIfIXqYjtHsWmLtsus8e/2ZCUAcsWD0/klZjvuvvRHCOSODuSck2Zvk9k
         wQEQ==
X-Gm-Message-State: AA+aEWY9MNilKUKczqECy/V4oXJSxB6ym5JgMwWr7zoPV+Rgj6+5wD7t
        ATnUi7u9bAdrPorexZo7LHDdfJKGbZU=
X-Google-Smtp-Source: AFSGD/VyKNwvEDwrlF6wHGtvkydSiihsEPBJ31GfUa7cVXyV2iurRk72pJdv94bStnHQJn+8oL7wmQ==
X-Received: by 2002:a62:2a4b:: with SMTP id q72mr3911041pfq.61.1544221247035;
        Fri, 07 Dec 2018 14:20:47 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e9sm5282511pff.5.2018.12.07.14.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 14:20:46 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 13/26] aio: add io_setup2() system call
Date:   Fri,  7 Dec 2018 15:20:03 -0700
Message-Id: <20181207222016.29387-14-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207222016.29387-1-axboe@kernel.dk>
References: <20181207222016.29387-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is just like io_setup(), except add a flags argument to let the
caller control/define some of the io_context behavior.

Outside of the flags, we add an iocb array and two user pointers for
future use.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 fs/aio.c                               | 69 ++++++++++++++++----------
 include/linux/syscalls.h               |  3 ++
 include/uapi/asm-generic/unistd.h      |  4 +-
 kernel/sys_ni.c                        |  1 +
 5 files changed, 52 insertions(+), 26 deletions(-)

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
index 173f1f79dc8f..26631d6872d2 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -100,6 +100,8 @@ struct kioctx {
 
 	unsigned long		user_id;
 
+	unsigned int		flags;
+
 	struct __percpu kioctx_cpu *cpu;
 
 	/*
@@ -686,10 +688,8 @@ static void aio_nr_sub(unsigned nr)
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
@@ -701,6 +701,12 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
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
@@ -726,6 +732,7 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
+	ctx->flags = flags;
 	ctx->max_reqs = max_reqs;
 
 	spin_lock_init(&ctx->ctx_lock);
@@ -1281,6 +1288,34 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
 	return ret;
 }
 
+SYSCALL_DEFINE6(io_setup2, u32, nr_events, u32, flags, struct iocb __user *,
+		iocbs, void __user *, user1, void __user *, user2,
+		aio_context_t __user *, ctxp)
+{
+	struct kioctx *ioctx;
+	unsigned long ctx;
+	long ret;
+
+	if (flags || user1 || user2)
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
@@ -1296,7 +1331,7 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
  */
 SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
 {
-	struct kioctx *ioctx = NULL;
+	struct kioctx *ioctx;
 	unsigned long ctx;
 	long ret;
 
@@ -1304,14 +1339,7 @@ SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
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
@@ -1327,7 +1355,7 @@ SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
 {
-	struct kioctx *ioctx = NULL;
+	struct kioctx *ioctx;
 	unsigned long ctx;
 	long ret;
 
@@ -1335,23 +1363,14 @@ COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
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
index 2ac3d13a915b..a20a663d583f 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -287,6 +287,9 @@ static inline void addr_limit_user_check(void)
  */
 #ifndef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
 asmlinkage long sys_io_setup(unsigned nr_reqs, aio_context_t __user *ctx);
+asmlinkage long sys_io_setup2(unsigned, unsigned, struct iocb __user *,
+				void __user *, void __user *,
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

