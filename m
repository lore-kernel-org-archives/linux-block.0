Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912ADC5CFFE
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3542086D
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="F9nlvPXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3542086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbeLKAQY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:16:24 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44029 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbeLKAQY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 19:16:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so6021126plb.10
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 16:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2VwCYOeUGu7l/Lze6URcp7snxlphdCvYVYhOjWANYnU=;
        b=F9nlvPXXhlHrNd6o85cJH2/Ml/NeAwJJ8T8WB+GrR7KcUi5CjYAYOHIXZHJ37Kx89v
         Os415k0VQ1So8ApFMyO1QzVVyeUdAIlfAvgIJ5FWReocfpzHzm4GR/y2OMbwsimDfX7s
         XvkcWPETR1Fmh51LPseyyj1gtAxNAUcmXGSLVFIZkj/VQuUf5J8TvArLNIcwc+2PN63y
         Qthg13fvxe6VLxUX4xwLMqSz8T5u/+TP3X/Luc4IcOaO/LnvOZTOPxeSeHH4DKw99FaU
         /i/i8v0y4AGe8o/JhX6wLvFETCcFckLoM/k8oIr/iOUTkaj7Yd9WjVYufEDGhnViZ+GG
         x3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2VwCYOeUGu7l/Lze6URcp7snxlphdCvYVYhOjWANYnU=;
        b=q4Do3S8dSoOWlifnAeIgTGodAUe6AKW4CDV8ksFdtejuGRURAoVbCVFc6w0LPtu2vK
         xXbicidLfeqzfrum0AnVm0uJ8f9J1XhGFR7p71EmLoRxCgwXIRg+dvQn0z2HsgwCoE2/
         KZERss/q9aSAZPgwCFzaqd+yrIGxTBHuBLooaQ+TX9jmCRj/Ay8FvN9he6VUVpOfyAyK
         p1eis2rLZgUM6TtuZkwhvVD3xojMnRHsfvEBjm7ZNY1EjTIHKIEDPSP1CVb6qYCw5EtJ
         9ZwcIsFeJbB+hQT/gEcvveC+qm/UC96rx/kcFNxJIn+rIPGsvB1WarTLHziL93/5yJej
         S0fQ==
X-Gm-Message-State: AA+aEWaDFRhCYxr81ZRyxEwWG/H5BWbJjmjuMK+EuY79c7tj4Nkiy6fc
        ukXZDKEPU9grsAQiA54JWDjxEA+BH0IMTA==
X-Google-Smtp-Source: AFSGD/WBZLUiMmZH02QLdJXp1E0IcmOr7+t1UVjvME+HULOeu6z4/d0GcPqqkP543sQfKkvPEkOSCQ==
X-Received: by 2002:a17:902:9a9:: with SMTP id 38mr13816843pln.204.1544487382810;
        Mon, 10 Dec 2018 16:16:22 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm16872856pfl.16.2018.12.10.16.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:16:21 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 13/27] aio: add io_setup2() system call
Date:   Mon, 10 Dec 2018 17:15:35 -0700
Message-Id: <20181211001549.30085-14-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211001549.30085-1-axboe@kernel.dk>
References: <20181211001549.30085-1-axboe@kernel.dk>
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
 fs/aio.c                               | 80 ++++++++++++++++++--------
 include/linux/syscalls.h               |  3 +
 include/uapi/asm-generic/unistd.h      |  4 +-
 kernel/sys_ni.c                        |  1 +
 6 files changed, 67 insertions(+), 30 deletions(-)

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
index 173f1f79dc8f..0bad70eab553 100644
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
@@ -1281,6 +1288,45 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
 	return ret;
 }
 
+/* sys_io_setup2:
+ *	Like sys_io_setup(), except that it takes a set of flags
+ *	(IOCTX_FLAG_*), and some pointers to user structures:
+ *
+ *	*iocbs - pointer to array of struct iocb, for when
+ *	IOCTX_FLAG_USERIOCB is set in flags.
+ *
+ *	*user1 - reserved for future use
+ *
+ *	*user2 - reserved for future use.
+ */
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
@@ -1296,7 +1342,7 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
  */
 SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
 {
-	struct kioctx *ioctx = NULL;
+	struct kioctx *ioctx;
 	unsigned long ctx;
 	long ret;
 
@@ -1304,14 +1350,7 @@ SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
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
@@ -1327,7 +1366,7 @@ SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
 {
-	struct kioctx *ioctx = NULL;
+	struct kioctx *ioctx;
 	unsigned long ctx;
 	long ret;
 
@@ -1335,23 +1374,14 @@ COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
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

