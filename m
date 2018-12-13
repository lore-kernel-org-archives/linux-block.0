Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21579C67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F2020870
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="h2fYZcKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F2020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbeLMR5R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:57:17 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36031 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbeLMR5Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 12:57:16 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so5211907itj.1
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 09:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DVeHT+CTEar5aJxB4rOokI+f3iI3nErD0YUemufLYjE=;
        b=h2fYZcKv7t8SuboFEgwL0PXyNeUMWyEU2F/ffbNJZuW5j7mciUsmkMhNLXObDDsAS8
         +WwLNzmfeTNHU7EeixPg+rRlDZV92D1tO/QaF8YT81Dkfrqy1rMgp3zezfthYNu5ljTU
         GR1vp7bXEySZYEv4OHMZTPnjlAC8myJXkH0a5I9v4q+usdkabP7M1etGe8HqAbQZM2ev
         K9ZDisenanwzpoWezS/9XEE7S7GI/knfcsrThOKoxBDE2vdft3TYssRe3woOzCZtg2o+
         MktN1M/ZeuZdPYff19nmz2Xz68M+LNUcx6B7sc7g+d+GRCUXovJGehRKuNdkZOqj90Ob
         /W4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DVeHT+CTEar5aJxB4rOokI+f3iI3nErD0YUemufLYjE=;
        b=mrM062brizNpa4lo7YIN9xXO428Q1rSH5VBO8ZI9b0El2nNYrBiB64O86MrwLwt0z0
         wXvWUhA/g2MmpTq/F6XHBUefM+8HF30nXObW+m27FnhiSXJaaF+caT7BEwpL2F3HneDE
         m7xydfEfsWFLSvEHX41Wre2a0ZO4AP7VAq8O+1u9H9fcOTaYS/MJfgQQmfPg+Z7BDMSg
         Z0QF2xptjRDEv7yhsMYaFPCM4DfR6Fe0vRnXdRiUpK6MY3fi/aYiQtCE0SGGkByrakbO
         ITcUOyp7XMChD86fpytHZdpUjmSy9T8gvCe0Fb33TdQS93/pxBOq9kiEVn/Ts8zYdDMg
         94rg==
X-Gm-Message-State: AA+aEWbW5h1LBrsafqFG4g+aiWrGMrplMF+SEvnKTMIMs0vKdKFPvSRj
        DGT33P41pHJSZyHyyqrUMXjl0P7JGPSLiA==
X-Google-Smtp-Source: AFSGD/XyHEPFekXZ/VL8IxeSwXIJX2o2LwvWnEnMz7LDJQJ7aOiLZ4OBIGwIgQBkw2+36a+QrgovEg==
X-Received: by 2002:a24:1152:: with SMTP id 79mr275120itf.167.1544723835161;
        Thu, 13 Dec 2018 09:57:15 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k6sm1022261ios.69.2018.12.13.09.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:57:14 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 13/26] aio: add io_setup2() system call
Date:   Thu, 13 Dec 2018 10:56:32 -0700
Message-Id: <20181213175645.22181-14-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213175645.22181-1-axboe@kernel.dk>
References: <20181213175645.22181-1-axboe@kernel.dk>
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
index 173f1f79dc8f..20f907ba2890 100644
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
@@ -1281,6 +1288,41 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
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
@@ -1296,7 +1338,7 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
  */
 SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
 {
-	struct kioctx *ioctx = NULL;
+	struct kioctx *ioctx;
 	unsigned long ctx;
 	long ret;
 
@@ -1304,14 +1346,7 @@ SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
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
@@ -1327,7 +1362,7 @@ SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
 {
-	struct kioctx *ioctx = NULL;
+	struct kioctx *ioctx;
 	unsigned long ctx;
 	long ret;
 
@@ -1335,23 +1370,14 @@ COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
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

