Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE186C4161D
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 17:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863EA208E4
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 17:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fWdTtJn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863EA208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbeKUDuX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:50:23 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35529 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730478AbeKUDuV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 22:50:21 -0500
Received: by mail-it1-f193.google.com with SMTP id v11so4745730itj.0
        for <linux-block@vger.kernel.org>; Tue, 20 Nov 2018 09:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F9di3IEVX4QrugPYKu6MpcNmw67MmPmAIxCBHyMeKH4=;
        b=fWdTtJn9f68RcjBTJ2S69pkRxiujrpt3MAumFVeM75vCQ+N21PPjcx2NH1UQCp2U/O
         KfuLCs5/7qgN/PFhZnjyiiZqM8ls/01Bz5u1d57cJufrOR3qKSI6F1/G3fqpMJ3AL+A5
         OEjiozGNyAlCkdcklmpbGDC5DhJ0gXFyp4CMUcUj9Uaeu1xWtKrEjMHiUXlKD3zde8Uv
         XLKKTDFYyqsOb6v7HqP6ekWcHf8AGOJXznzJbKuF6DofolAWBbTk53AJ2g9eHWj/KYR6
         uANgvsBxJFu7XLdYiJObX0IVac+npAAtOs0VdosS3yZogYgCnXkMvt+YMVbj4OI6AHci
         3UKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F9di3IEVX4QrugPYKu6MpcNmw67MmPmAIxCBHyMeKH4=;
        b=QDWzd9n6Nagf/0b9gZ7ZRa52YXORIPzMfHOW8SeVXG3kgCJpBnosJWe/3JR9SwycMx
         G0iqDokQGZD1/06MoQTfiDUj0n/npDXj5oOWbyC+1kknN7mjk9pGy+YWGdNCxzqmqIK5
         QCNNmvLT7QEuPfUHViwvnNH0gk0XG6e7nXE2FIJzTPFXSwBkcgAvylZGqpEjiF/+CkQf
         eyddpGKZaa10VJ8W/2JX3YcEkr2eQzfCfqWWMMZcKWvFIecb7OdeE8IX0BxG50EbHRkB
         aaKL1aXlarnLTV6DqPzPTLYD3c2IKRM6hLedFipfqOLdDRy5YNbcJ6Mlr2jweWTwBrir
         OT9Q==
X-Gm-Message-State: AGRZ1gJrYwyPV1pVkOtk0LtT1DVgD640Wm+3LTy9bTEN3L3hDkEa2WnG
        jXVhqho7oFPoZyKFB1qgJvIzpmPUNLo=
X-Google-Smtp-Source: AFSGD/WpeHvq5QEyZmvAX8EM49N7cpNrjq+7hd7nd259o6j2tWBLN2cG+ml3s5HLCrM1zzrESpyIGQ==
X-Received: by 2002:a24:648f:: with SMTP id t137mr2782863itc.95.1542734406920;
        Tue, 20 Nov 2018 09:20:06 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 186-v6sm15751530itf.11.2018.11.20.09.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 09:20:06 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/8] aio: add io_setup2() system call
Date:   Tue, 20 Nov 2018 10:19:51 -0700
Message-Id: <20181120171953.1258-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120171953.1258-1-axboe@kernel.dk>
References: <20181120171953.1258-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is just like io_setup(), except we get to pass in flags for what
kind of behavior we want.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 fs/aio.c                               | 67 +++++++++++++++++---------
 include/linux/syscalls.h               |  2 +
 include/uapi/asm-generic/unistd.h      |  4 +-
 kernel/sys_ni.c                        |  1 +
 5 files changed, 51 insertions(+), 24 deletions(-)

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
index 611e9824279d..8453bb849c32 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -683,7 +683,7 @@ static void aio_nr_sub(unsigned nr)
 /* ioctx_alloc
  *	Allocates and initializes an ioctx.  Returns an ERR_PTR if it failed.
  */
-static struct kioctx *ioctx_alloc(unsigned nr_events)
+static struct kioctx *ioctx_alloc(unsigned nr_events, unsigned int flags)
 {
 	struct mm_struct *mm = current->mm;
 	struct kioctx *ctx;
@@ -1269,6 +1269,44 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
 	return ret;
 }
 
+static struct kioctx *io_setup_flags(unsigned long ctx, unsigned int nr_events,
+				     unsigned int flags)
+{
+	if (unlikely(ctx || nr_events == 0)) {
+		pr_debug("EINVAL: ctx %lu nr_events %u\n",
+		         ctx, nr_events);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return ioctx_alloc(nr_events, flags);
+}
+
+SYSCALL_DEFINE3(io_setup2, u32, nr_events, u32, flags,
+		aio_context_t __user *, ctxp)
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
+	if (!IS_ERR(ioctx)) {
+		ret = put_user(ioctx->user_id, ctxp);
+		if (ret)
+			kill_ioctx(current->mm, ioctx, NULL);
+		percpu_ref_put(&ioctx->users);
+	}
+out:
+	return ret;
+}
+
 /* sys_io_setup:
  *	Create an aio_context capable of receiving at least nr_events.
  *	ctxp must not point to an aio_context that already exists, and
@@ -1284,7 +1322,7 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
  */
 SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
 {
-	struct kioctx *ioctx = NULL;
+	struct kioctx *ioctx;
 	unsigned long ctx;
 	long ret;
 
@@ -1292,14 +1330,7 @@ SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
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
@@ -1307,7 +1338,6 @@ SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
 			kill_ioctx(current->mm, ioctx, NULL);
 		percpu_ref_put(&ioctx->users);
 	}
-
 out:
 	return ret;
 }
@@ -1315,7 +1345,7 @@ SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
 {
-	struct kioctx *ioctx = NULL;
+	struct kioctx *ioctx;
 	unsigned long ctx;
 	long ret;
 
@@ -1323,23 +1353,14 @@ COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
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
index 2ac3d13a915b..455fabc5b0ac 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -287,6 +287,8 @@ static inline void addr_limit_user_check(void)
  */
 #ifndef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
 asmlinkage long sys_io_setup(unsigned nr_reqs, aio_context_t __user *ctx);
+asmlinkage long sys_io_setup2(unsigned nr_reqs, unsigned flags,
+				aio_context_t __user *ctx);
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

