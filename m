Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBA8CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 22:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CE821D81
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 22:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RR3dDfZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfJYWW0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 18:22:26 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34535 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfJYWW0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 18:22:26 -0400
Received: by mail-io1-f68.google.com with SMTP id q1so4166194ion.1
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 15:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=7E+LHAWKbEFLelJceGQtgpxEZxCKg7EGUQ07MlhbbDk=;
        b=RR3dDfZ/ozdxfC+dtovVOP8bnFQk0KfJ7/Jhuhwub1UgWZk+vqLvMBxWcWKS4XrktI
         TD2ZYPlvxr9ezk1WzbHDFTdQBXfNWIl6tLQNFg3dVI9mP4ZmtBYv8gMOUrsKC+2dDFmE
         XGNUM4HB7bmeMqanq+551k9R6s8nL0hJMm3v66w/LcfbQRedMaIzprD5NgEvBG6xIGRL
         Zfuqn6rWvZNC/2W3rO7cCnatc3mmvhmi6UgbSbjTrFcWs3c+PdWLspPKozDdAQZ8/oSK
         TJHD7JyTkp94QsLlTC9eYSKR2cgmeuYEZryB+x53VMqfqSWDCVA7GZSVLSLdOxvg0ZLI
         vdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=7E+LHAWKbEFLelJceGQtgpxEZxCKg7EGUQ07MlhbbDk=;
        b=lvaaOY4Fitgac3C1l2miZ7SHyBScxTyZ+3g7h4DdyTS0qYENwt8cspCVnD7//yphHt
         hDjN6RpPE1KTNI1/E7FdngBwf2GgkVNioiH6DtAmtf1gCK2v7WdiuuExXR8+wTfI4l/d
         WWOrrKPF7k/HjZiGUAtnkybObM+dAmoXIWMtfr1bAivUd9SR1KmhgsW66rT6Pwme9vA2
         T7Um82QXdDMbehgwSZ0C9+534vHjRNUyI7ZVIK6w9y8D9kNGFsCYBu/3hfost39A0FPj
         ZN32oCU9aOWUSetqUBL9C1MHUHF2LmYLapmjSHr6WhMnQulDBazBHLi1jWef2kRpJFef
         nuMw==
X-Gm-Message-State: APjAAAUMb/+csDPu/j4PAp1WxKbXtl8lnA2eFQH0MK2W7UvLtswU6Nct
        bo0IH8MbkLM/ygJtw7Kvle/x0KKPoznuew==
X-Google-Smtp-Source: APXvYqxcsbQNfbKLrN4HgYmJl0b0G1PeiOP7ScbMDdn+qRNLH/+2WBhcGLJncvYauyRuk5DaLXEeOw==
X-Received: by 2002:a5e:9b04:: with SMTP id j4mr6456193iok.45.1572042144405;
        Fri, 25 Oct 2019 15:22:24 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a4sm522486ila.30.2019.10.25.15.22.22
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 15:22:23 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: support for larger fixed file sets
Message-ID: <59f5cab7-4bc4-84cb-b9b0-48f2743eafef@kernel.dk>
Date:   Fri, 25 Oct 2019 16:22:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There's been a few requests for supporting more fixed files than 1024.
This isn't really tricky to do, we just need to split up the file table
into multiple tables and index appropriately.

This patch adds support for up to 64K files, which should be enough for
everyone.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Complete with updated test case in liburing, test/file-register now has
a test case that registers 8K files (sparse), then does a file set
update of a random file late in the set and performs some IO to it to
ensure it works.

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 4402485f0879..2df92134e939 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -80,7 +80,11 @@
 
 #define IORING_MAX_ENTRIES	32768
 #define IORING_MAX_CQ_ENTRIES	(2 * IORING_MAX_ENTRIES)
-#define IORING_MAX_FIXED_FILES	1024
+
+#define IORING_FILE_TABLE_SHIFT	10
+#define IORING_MAX_FILES_TABLE	(1U << IORING_FILE_TABLE_SHIFT)
+#define IORING_FILE_TABLE_MASK	(IORING_MAX_FILES_TABLE - 1)
+#define IORING_MAX_FIXED_FILES	(64 * IORING_MAX_FILES_TABLE)
 
 struct io_uring {
 	u32 head ____cacheline_aligned_in_smp;
@@ -165,6 +169,10 @@ struct io_mapped_ubuf {
 	unsigned int	nr_bvecs;
 };
 
+struct fixed_file_table {
+	struct file		**files;
+};
+
 struct io_ring_ctx {
 	struct {
 		struct percpu_ref	refs;
@@ -225,7 +233,7 @@ struct io_ring_ctx {
 	 * readers must ensure that ->refs is alive as long as the file* is
 	 * used. Only updated through io_uring_register(2).
 	 */
-	struct file		**user_files;
+	struct fixed_file_table	*file_table;
 	unsigned		nr_user_files;
 
 	/* if used, fixed mapped user buffers */
@@ -2295,6 +2303,15 @@ static bool io_op_needs_file(const struct io_uring_sqe *sqe)
 	}
 }
 
+static inline struct file *io_file_from_index(struct io_ring_ctx *ctx,
+					      int index)
+{
+	struct fixed_file_table *table;
+
+	table = &ctx->file_table[index >> IORING_FILE_TABLE_SHIFT];
+	return table->files[index & IORING_FILE_TABLE_MASK];
+}
+
 static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 			   struct io_submit_state *state, struct io_kiocb *req)
 {
@@ -2317,12 +2334,15 @@ static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 		return 0;
 
 	if (flags & IOSQE_FIXED_FILE) {
-		if (unlikely(!ctx->user_files ||
+		struct file *file;
+
+		if (unlikely(!ctx->file_table ||
 		    (unsigned) fd >= ctx->nr_user_files))
 			return -EBADF;
-		if (!ctx->user_files[fd])
+		file = io_file_from_index(ctx, fd);
+		if (!file)
 			return -EBADF;
-		req->file = ctx->user_files[fd];
+		req->file = file;
 		req->flags |= REQ_F_FIXED_FILE;
 	} else {
 		if (s->needs_fixed_file)
@@ -2974,20 +2994,29 @@ static void __io_sqe_files_unregister(struct io_ring_ctx *ctx)
 #else
 	int i;
 
-	for (i = 0; i < ctx->nr_user_files; i++)
-		if (ctx->user_files[i])
-			fput(ctx->user_files[i]);
+	for (i = 0; i < ctx->nr_user_files; i++) {
+		struct file *file;
+
+		file = io_file_from_index(ctx, i);
+		if (file)
+			fput(file);
 #endif
 }
 
 static int io_sqe_files_unregister(struct io_ring_ctx *ctx)
 {
-	if (!ctx->user_files)
+	unsigned nr_tables, i;
+
+	if (!ctx->file_table)
 		return -ENXIO;
 
 	__io_sqe_files_unregister(ctx);
-	kfree(ctx->user_files);
-	ctx->user_files = NULL;
+	nr_tables = (ctx->nr_user_files + IORING_MAX_FILES_TABLE - 1) /
+			IORING_MAX_FILES_TABLE;
+	for (i = 0; i < nr_tables; i++)
+		kfree(ctx->file_table[i].files);
+	kfree(ctx->file_table);
+	ctx->file_table = NULL;
 	ctx->nr_user_files = 0;
 	return 0;
 }
@@ -3062,9 +3091,11 @@ static int __io_sqe_files_scm(struct io_ring_ctx *ctx, int nr, int offset)
 	nr_files = 0;
 	fpl->user = get_uid(ctx->user);
 	for (i = 0; i < nr; i++) {
-		if (!ctx->user_files[i + offset])
+		struct file *file = io_file_from_index(ctx, i + offset);
+
+		if (!file)
 			continue;
-		fpl->fp[nr_files] = get_file(ctx->user_files[i + offset]);
+		fpl->fp[nr_files] = get_file(file);
 		unix_inflight(fpl->user, fpl->fp[nr_files]);
 		nr_files++;
 	}
@@ -3113,8 +3144,10 @@ static int io_sqe_files_scm(struct io_ring_ctx *ctx)
 		return 0;
 
 	while (total < ctx->nr_user_files) {
-		if (ctx->user_files[total])
-			fput(ctx->user_files[total]);
+		struct file *file = io_file_from_index(ctx, total);
+
+		if (file)
+			fput(file);
 		total++;
 	}
 
@@ -3127,25 +3160,66 @@ static int io_sqe_files_scm(struct io_ring_ctx *ctx)
 }
 #endif
 
+static int io_sqe_alloc_file_tables(struct io_ring_ctx *ctx, unsigned nr_tables,
+				    unsigned nr_files)
+{
+	int i;
+
+	for (i = 0; i < nr_tables; i++) {
+		struct fixed_file_table *table = &ctx->file_table[i];
+		unsigned this_files;
+
+		this_files = nr_files;
+		if (this_files > IORING_MAX_FILES_TABLE)
+			this_files = IORING_MAX_FILES_TABLE;
+
+		table->files = kcalloc(this_files, sizeof(struct file *),
+					GFP_KERNEL);
+		if (!table->files)
+			break;
+	}
+
+	if (i == nr_tables)
+		return 0;
+
+	for (i = 0; i < nr_tables; i++) {
+		struct fixed_file_table *table = &ctx->file_table[i];
+		kfree(table->files);
+	}
+	return 1;
+}
+
 static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 				 unsigned nr_args)
 {
 	__s32 __user *fds = (__s32 __user *) arg;
+	unsigned nr_tables;
 	int fd, ret = 0;
 	unsigned i;
 
-	if (ctx->user_files)
+	if (ctx->file_table)
 		return -EBUSY;
 	if (!nr_args)
 		return -EINVAL;
 	if (nr_args > IORING_MAX_FIXED_FILES)
 		return -EMFILE;
 
-	ctx->user_files = kcalloc(nr_args, sizeof(struct file *), GFP_KERNEL);
-	if (!ctx->user_files)
+	nr_tables = (nr_args + IORING_MAX_FILES_TABLE - 1) /
+			IORING_MAX_FILES_TABLE;
+	ctx->file_table = kcalloc(nr_tables, sizeof(struct fixed_file_table),
+					GFP_KERNEL);
+	if (!ctx->file_table)
 		return -ENOMEM;
 
+	if (io_sqe_alloc_file_tables(ctx, nr_tables, nr_args)) {
+		kfree(ctx->file_table);
+		return -ENOMEM;
+	}
+
 	for (i = 0; i < nr_args; i++, ctx->nr_user_files++) {
+		struct fixed_file_table *table;
+		unsigned table_index;
+
 		ret = -EFAULT;
 		if (copy_from_user(&fd, &fds[i], sizeof(fd)))
 			break;
@@ -3155,10 +3229,12 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 			continue;
 		}
 
-		ctx->user_files[i] = fget(fd);
+		table = &ctx->file_table[i >> IORING_FILE_TABLE_SHIFT];
+		table_index = i & IORING_FILE_TABLE_MASK;
+		table->files[table_index] = fget(fd);
 
 		ret = -EBADF;
-		if (!ctx->user_files[i])
+		if (!table->files[table_index])
 			break;
 		/*
 		 * Don't allow io_uring instances to be registered. If UNIX
@@ -3167,20 +3243,28 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 		 * handle it just fine, but there's still no point in allowing
 		 * a ring fd as it doesn't support regular read/write anyway.
 		 */
-		if (ctx->user_files[i]->f_op == &io_uring_fops) {
-			fput(ctx->user_files[i]);
+		if (table->files[table_index]->f_op == &io_uring_fops) {
+			fput(table->files[table_index]);
 			break;
 		}
 		ret = 0;
 	}
 
 	if (ret) {
-		for (i = 0; i < ctx->nr_user_files; i++)
-			if (ctx->user_files[i])
-				fput(ctx->user_files[i]);
+		for (i = 0; i < ctx->nr_user_files; i++) {
+			struct fixed_file_table *table;
+			unsigned index;
+
+			table = &ctx->file_table[i >> IORING_FILE_TABLE_SHIFT];
+			index = i & IORING_FILE_TABLE_MASK;
+			if (table->files[index])
+				fput(table->files[index]);
+		}
+		for (i = 0; i < nr_tables; i++)
+			kfree(ctx->file_table[i].files);
 
-		kfree(ctx->user_files);
-		ctx->user_files = NULL;
+		kfree(ctx->file_table);
+		ctx->file_table = NULL;
 		ctx->nr_user_files = 0;
 		return ret;
 	}
@@ -3195,7 +3279,7 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 static void io_sqe_file_unregister(struct io_ring_ctx *ctx, int index)
 {
 #if defined(CONFIG_UNIX)
-	struct file *file = ctx->user_files[index];
+	struct file *file = io_file_from_index(ctx, index);
 	struct sock *sock = ctx->ring_sock->sk;
 	struct sk_buff_head list, *head = &sock->sk_receive_queue;
 	struct sk_buff *skb;
@@ -3251,7 +3335,7 @@ static void io_sqe_file_unregister(struct io_ring_ctx *ctx, int index)
 		spin_unlock_irq(&head->lock);
 	}
 #else
-	fput(ctx->user_files[index]);
+	fput(io_file_from_index(ctx, index));
 #endif
 }
 
@@ -3306,7 +3390,7 @@ static int io_sqe_files_update(struct io_ring_ctx *ctx, void __user *arg,
 	int fd, i, err;
 	__u32 done;
 
-	if (!ctx->user_files)
+	if (!ctx->file_table)
 		return -ENXIO;
 	if (!nr_args)
 		return -EINVAL;
@@ -3320,15 +3404,20 @@ static int io_sqe_files_update(struct io_ring_ctx *ctx, void __user *arg,
 	done = 0;
 	fds = (__s32 __user *) up.fds;
 	while (nr_args) {
+		struct fixed_file_table *table;
+		unsigned index;
+
 		err = 0;
 		if (copy_from_user(&fd, &fds[done], sizeof(fd))) {
 			err = -EFAULT;
 			break;
 		}
 		i = array_index_nospec(up.offset, ctx->nr_user_files);
-		if (ctx->user_files[i]) {
+		table = &ctx->file_table[i >> IORING_FILE_TABLE_SHIFT];
+		index = i & IORING_FILE_TABLE_MASK;
+		if (table->files[index]) {
 			io_sqe_file_unregister(ctx, i);
-			ctx->user_files[i] = NULL;
+			table->files[index] = NULL;
 		}
 		if (fd != -1) {
 			struct file *file;
@@ -3351,7 +3440,7 @@ static int io_sqe_files_update(struct io_ring_ctx *ctx, void __user *arg,
 				err = -EBADF;
 				break;
 			}
-			ctx->user_files[i] = file;
+			table->files[index] = file;
 			err = io_sqe_file_register(ctx, file, i);
 			if (err)
 				break;

-- 
Jens Axboe

