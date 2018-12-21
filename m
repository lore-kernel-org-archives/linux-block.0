Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A84C43387
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046E021929
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TN7m8vgj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391662AbeLUTWy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:22:54 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39949 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391654AbeLUTWw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Dec 2018 14:22:52 -0500
Received: by mail-io1-f67.google.com with SMTP id a11so1966402ioq.7
        for <linux-block@vger.kernel.org>; Fri, 21 Dec 2018 11:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cP01O8S4M8Pk79YHUMOcTMlJ2ny7YrlssbKXi8nIgEc=;
        b=TN7m8vgj7qlDfqFODwRqgHubkiEE7T8XNem8o2jLNUd64r9gXP9UweICoQ5P7NP5D6
         qC2kkU/jMi8Xxvzqk2QzRG5HthWIJiEQ3afCtSWV9GcWFV6eZFVxdpJp6a5bSUaGudJ2
         rLVAreZUyTaFc5WqpvuCJ6ESDoVjoPdIBAVJoHLWFk83URblrHeSZ0kYhHcKsgXXm4gJ
         AJ1fESTENsY+EaMKhy84R0S5++s0/T2ovYQKVZH8SXjkaN4EZcTC0mljgxXuewFW5Lbd
         OywbOhHtIzYhXk5DXASz2d4WAIr8jQXtaALuy61mPIRhs2sqthrFQ4+e31tzcboLE48g
         OzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cP01O8S4M8Pk79YHUMOcTMlJ2ny7YrlssbKXi8nIgEc=;
        b=uT+fKERfNwpVyfkifcWD6j+tkS7/XrZwXkHmidNGSg//90kIajYJfandDxaQ2NxBXG
         p98jw4FeHu/spA1h51Sj8U/Xky43ZNepnTQdfBAC+PRiybG++Z7d1ly7j880pe3NXbOq
         ZZuK7b9eambh/VODagN1HGjXvD6YupaO5NohiVFotJ4/Pc+BaPUtxYxrCD5T22XGC5Ru
         CXzEhEk+QLKgkaep3z3QoguNdaHCuty0Cj7HaEhO5o0whSp6SvGQ+Oc8M5rt9C1nzjvc
         BZqJX28W8Qyb5nXWWULX/8h7/UCiqRjhT096lIOYpNvSoYD2OsKL4AzreNm0w32b03av
         LSog==
X-Gm-Message-State: AJcUukespPjTA7fMlJAO5eql4J9mKATorEJ+6f/X9zE8BS6aNPgGOD4N
        mcQ5z/MMtPijimVMkx/qAbm6Tg==
X-Google-Smtp-Source: ALg8bN4v0kTbRljJ/gCvCIbYZK8/hOoLu9y9Yaealhm4nmv60qwIqJHVWif3NCpL6lVCnXKzgnWuwA==
X-Received: by 2002:a6b:1d8:: with SMTP id 207mr2593107iob.62.1545420170921;
        Fri, 21 Dec 2018 11:22:50 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t1sm12456290iol.85.2018.12.21.11.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:22:49 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/22] aio: add io_setup2() system call
Date:   Fri, 21 Dec 2018 12:22:21 -0700
Message-Id: <20181221192236.12866-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221192236.12866-1-axboe@kernel.dk>
References: <20181221192236.12866-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is just like io_setup(), except add a flags argument to let the
caller control/define some of the io_context behavior.

Outside of the flags, we add two user pointers for future use.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 Documentation/sysctl/fs.txt            |  8 +--
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 fs/aio.c                               | 76 +++++++++++++++++---------
 include/linux/syscalls.h               |  2 +
 include/uapi/asm-generic/unistd.h      |  4 +-
 kernel/sys_ni.c                        |  1 +
 6 files changed, 62 insertions(+), 30 deletions(-)

diff --git a/Documentation/sysctl/fs.txt b/Documentation/sysctl/fs.txt
index 819caf8ca05f..5e484eb7a25f 100644
--- a/Documentation/sysctl/fs.txt
+++ b/Documentation/sysctl/fs.txt
@@ -47,10 +47,10 @@ Currently, these files are in /proc/sys/fs:
 aio-nr & aio-max-nr:
 
 aio-nr is the running total of the number of events specified on the
-io_setup system call for all currently active aio contexts.  If aio-nr
-reaches aio-max-nr then io_setup will fail with EAGAIN.  Note that
-raising aio-max-nr does not result in the pre-allocation or re-sizing
-of any kernel data structures.
+io_setup/io_setup2 system call for all currently active aio contexts.
+If aio-nr reaches aio-max-nr then io_setup will fail with EAGAIN.
+Note that raising aio-max-nr does not result in the pre-allocation or
+re-sizing of any kernel data structures.
 
 ==============================================================
 
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
index e2882334b48f..958f432a0e5b 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -101,6 +101,8 @@ struct kioctx {
 
 	unsigned long		user_id;
 
+	unsigned int		flags;
+
 	struct __percpu kioctx_cpu *cpu;
 
 	/*
@@ -687,10 +689,8 @@ static void aio_nr_sub(unsigned nr)
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
@@ -702,6 +702,12 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
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
@@ -727,6 +733,7 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
+	ctx->flags = flags;
 	ctx->max_reqs = max_reqs;
 
 	spin_lock_init(&ctx->ctx_lock);
@@ -1283,6 +1290,41 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
 	return ret;
 }
 
+/* sys_io_setup2:
+ *	Like sys_io_setup(), except that it takes a set of flags
+ *	(IOCTX_FLAG_*), and some pointers to user structures:
+ *
+ *	*user1 - reserved for future use
+ *
+ *	*user2 - reserved for future use.
+ */
+SYSCALL_DEFINE5(io_setup2, u32, nr_events, u32, flags, void __user *, user1,
+		void __user *, user2, aio_context_t __user *, ctxp)
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
@@ -1298,7 +1340,7 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
  */
 SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
 {
-	struct kioctx *ioctx = NULL;
+	struct kioctx *ioctx;
 	unsigned long ctx;
 	long ret;
 
@@ -1306,14 +1348,7 @@ SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
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
@@ -1329,7 +1364,7 @@ SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
 {
-	struct kioctx *ioctx = NULL;
+	struct kioctx *ioctx;
 	unsigned long ctx;
 	long ret;
 
@@ -1337,23 +1372,14 @@ COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
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
index 2ac3d13a915b..67b7f03aa9fc 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -287,6 +287,8 @@ static inline void addr_limit_user_check(void)
  */
 #ifndef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
 asmlinkage long sys_io_setup(unsigned nr_reqs, aio_context_t __user *ctx);
+asmlinkage long sys_io_setup2(unsigned, unsigned, void __user *, void __user *,
+				aio_context_t __user *);
 asmlinkage long sys_io_destroy(aio_context_t ctx);
 asmlinkage long sys_io_submit(aio_context_t, long,
 			struct iocb __user * __user *);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index c7f3321fbe43..1bbaa4c59f20 100644
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

