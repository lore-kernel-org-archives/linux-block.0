Return-Path: <SRS0=tXSx=YT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF41CA9EB9
	for <linux-block@archiver.kernel.org>; Sat, 26 Oct 2019 13:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1A321871
	for <linux-block@archiver.kernel.org>; Sat, 26 Oct 2019 13:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jiFTx+rw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfJZN4E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:56:04 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:43832 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfJZN4E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Oct 2019 09:56:04 -0400
Received: by mail-pg1-f174.google.com with SMTP id l24so3504652pgh.10
        for <linux-block@vger.kernel.org>; Sat, 26 Oct 2019 06:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=b5SxBHI5nCMGiHrTvkKi2CQRtqjh36u6kwiumqbskpI=;
        b=jiFTx+rwTqfDA1PWJOoBCGG2mRo1QUB9pCLyg/8hEmNAilYBMz6Lhy/cfnrx0iphIH
         0QRm0Z1ajje5dPTp2uvmp7nJCgs5JgAo2DoMR1UAiAsYYh+vrcIlnE/Wqyp+d4kH+uQp
         UANQTkuYEGZHtOfCp36k475/Sc6Ru8W0u39xB3OtIwz6X2RkyWreXftyqSQvv0LxvXbF
         VxfVVGDYoSlTY7AKyqNefhph4wAKX7Mh8eCGod6qpJKlhoGJk8sgPJpJkVoAnOU8DJZc
         tEv/lGdFtZdMzD5Mv+Bd+rccqtmYDJe0s361bIHCJvWpdtDGxkXhfXQwWSgqkbCx+JzU
         yU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=b5SxBHI5nCMGiHrTvkKi2CQRtqjh36u6kwiumqbskpI=;
        b=lHkqmbI36qtkpKOB1W/BBvm99hR8tMibSEJXeMykRs62/ZHl5JAZjJUKOyV7Hs8MUm
         K8kiitn2BDIWaGclRAlURpGcnwsWL95ZU9y1jUr8gqb+hbFIdUGpNL1YACe4yTLjrjQO
         Iy2bbSBj+fWrddVulLwwLQvjQQRR14W+1Z7xnZPgref98tuew/t8GhT9A9o8QoYyhWir
         0HmtjhVaYrcOeVIwkkK+HoDDpL+agPQ9MSeg+gsz4AMpw9l5XnTTS8msTzBzhgSZOJZW
         r3BhYEcRelmVKSBMkADW32eaa8TBRXBmypy7UCL3+rzUB88anoo4HrNrVYtnI7GHqZZu
         bNEQ==
X-Gm-Message-State: APjAAAVIfAE5Bk8HxMRWrCx6/habzlB83D6FOwW+d4fZaYuHQubZuE6K
        bl7fn4sEoItNhiEdBOvEJOYFZz82DSQnnQ==
X-Google-Smtp-Source: APXvYqyYfyFX//sTsn3bdkO8MWUlnbCBxIBlWH3H+qhb4Jldvy3gkPVdDhbaX2KRhhXwcyQQaTNwpw==
X-Received: by 2002:a63:1209:: with SMTP id h9mr10419801pgl.394.1572098162774;
        Sat, 26 Oct 2019 06:56:02 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id y9sm4967633pgq.11.2019.10.26.06.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Oct 2019 06:56:01 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Jann Horn <jannh@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] io_uring: support for larger fixed file sets
Message-ID: <0d06d4e0-7a6d-4e91-6499-b0bf8a327d7a@kernel.dk>
Date:   Sat, 26 Oct 2019 07:56:00 -0600
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
into multiple tables and index appropriately. As we do so, reduce the
max single file table to 512. This enables us to do single page allocs
always for the tables, which is an improvement over the situation prior.

This patch adds support for up to 64K files, which should be enough for
everyone.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Changes since v1:
- Change table size to 512 entries so we always get single page
  allocs
- Rebase on top of the nospec patch
- Fix nr_files missing decrement (Jann)
- Use DIV_ROUND_UP() instead of doing it manually
- Cleanup the code some more

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 769a8c7eee37..a3bef89544a0 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -80,7 +80,14 @@
 
 #define IORING_MAX_ENTRIES	32768
 #define IORING_MAX_CQ_ENTRIES	(2 * IORING_MAX_ENTRIES)
-#define IORING_MAX_FIXED_FILES	1024
+
+/*
+ * Shift of 9 is 512 entries, or exactly one page on 64-bit archs
+ */
+#define IORING_FILE_TABLE_SHIFT	9
+#define IORING_MAX_FILES_TABLE	(1U << IORING_FILE_TABLE_SHIFT)
+#define IORING_FILE_TABLE_MASK	(IORING_MAX_FILES_TABLE - 1)
+#define IORING_MAX_FIXED_FILES	(64 * IORING_MAX_FILES_TABLE)
 
 struct io_uring {
 	u32 head ____cacheline_aligned_in_smp;
@@ -165,6 +172,10 @@ struct io_mapped_ubuf {
 	unsigned int	nr_bvecs;
 };
 
+struct fixed_file_table {
+	struct file		**files;
+};
+
 struct io_ring_ctx {
 	struct {
 		struct percpu_ref	refs;
@@ -225,7 +236,7 @@ struct io_ring_ctx {
 	 * readers must ensure that ->refs is alive as long as the file* is
 	 * used. Only updated through io_uring_register(2).
 	 */
-	struct file		**user_files;
+	struct fixed_file_table	*file_table;
 	unsigned		nr_user_files;
 
 	/* if used, fixed mapped user buffers */
@@ -2295,6 +2306,15 @@ static bool io_op_needs_file(const struct io_uring_sqe *sqe)
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
@@ -2317,13 +2337,13 @@ static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 		return 0;
 
 	if (flags & IOSQE_FIXED_FILE) {
-		if (unlikely(!ctx->user_files ||
+		if (unlikely(!ctx->file_table ||
 		    (unsigned) fd >= ctx->nr_user_files))
 			return -EBADF;
 		fd = array_index_nospec(fd, ctx->nr_user_files);
-		if (!ctx->user_files[fd])
+		req->file = io_file_from_index(ctx, fd);
+		if (!req->file)
 			return -EBADF;
-		req->file = ctx->user_files[fd];
 		req->flags |= REQ_F_FIXED_FILE;
 	} else {
 		if (s->needs_fixed_file)
@@ -2975,20 +2995,28 @@ static void __io_sqe_files_unregister(struct io_ring_ctx *ctx)
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
+	nr_tables = DIV_ROUND_UP(ctx->nr_user_files, IORING_MAX_FILES_TABLE);
+	for (i = 0; i < nr_tables; i++)
+		kfree(ctx->file_table[i].files);
+	kfree(ctx->file_table);
+	ctx->file_table = NULL;
 	ctx->nr_user_files = 0;
 	return 0;
 }
@@ -3063,9 +3091,11 @@ static int __io_sqe_files_scm(struct io_ring_ctx *ctx, int nr, int offset)
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
@@ -3114,8 +3144,10 @@ static int io_sqe_files_scm(struct io_ring_ctx *ctx)
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
 
@@ -3128,25 +3160,63 @@ static int io_sqe_files_scm(struct io_ring_ctx *ctx)
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
+		this_files = min(nr_files, IORING_MAX_FILES_TABLE);
+		table->files = kcalloc(this_files, sizeof(struct file *),
+					GFP_KERNEL);
+		if (!table->files)
+			break;
+		nr_files -= this_files;
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
+	nr_tables = DIV_ROUND_UP(nr_args, IORING_MAX_FILES_TABLE);
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
+		unsigned index;
+
 		ret = -EFAULT;
 		if (copy_from_user(&fd, &fds[i], sizeof(fd)))
 			break;
@@ -3156,10 +3226,12 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 			continue;
 		}
 
-		ctx->user_files[i] = fget(fd);
+		table = &ctx->file_table[i >> IORING_FILE_TABLE_SHIFT];
+		index = i & IORING_FILE_TABLE_MASK;
+		table->files[index] = fget(fd);
 
 		ret = -EBADF;
-		if (!ctx->user_files[i])
+		if (!table->files[index])
 			break;
 		/*
 		 * Don't allow io_uring instances to be registered. If UNIX
@@ -3168,20 +3240,26 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 		 * handle it just fine, but there's still no point in allowing
 		 * a ring fd as it doesn't support regular read/write anyway.
 		 */
-		if (ctx->user_files[i]->f_op == &io_uring_fops) {
-			fput(ctx->user_files[i]);
+		if (table->files[index]->f_op == &io_uring_fops) {
+			fput(table->files[index]);
 			break;
 		}
 		ret = 0;
 	}
 
 	if (ret) {
-		for (i = 0; i < ctx->nr_user_files; i++)
-			if (ctx->user_files[i])
-				fput(ctx->user_files[i]);
+		for (i = 0; i < ctx->nr_user_files; i++) {
+			struct file *file;
 
-		kfree(ctx->user_files);
-		ctx->user_files = NULL;
+			file = io_file_from_index(ctx, i);
+			if (file)
+				fput(file);
+		}
+		for (i = 0; i < nr_tables; i++)
+			kfree(ctx->file_table[i].files);
+
+		kfree(ctx->file_table);
+		ctx->file_table = NULL;
 		ctx->nr_user_files = 0;
 		return ret;
 	}
@@ -3196,7 +3274,7 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 static void io_sqe_file_unregister(struct io_ring_ctx *ctx, int index)
 {
 #if defined(CONFIG_UNIX)
-	struct file *file = ctx->user_files[index];
+	struct file *file = io_file_from_index(ctx, index);
 	struct sock *sock = ctx->ring_sock->sk;
 	struct sk_buff_head list, *head = &sock->sk_receive_queue;
 	struct sk_buff *skb;
@@ -3252,7 +3330,7 @@ static void io_sqe_file_unregister(struct io_ring_ctx *ctx, int index)
 		spin_unlock_irq(&head->lock);
 	}
 #else
-	fput(ctx->user_files[index]);
+	fput(io_file_from_index(ctx, index));
 #endif
 }
 
@@ -3307,7 +3385,7 @@ static int io_sqe_files_update(struct io_ring_ctx *ctx, void __user *arg,
 	int fd, i, err;
 	__u32 done;
 
-	if (!ctx->user_files)
+	if (!ctx->file_table)
 		return -ENXIO;
 	if (!nr_args)
 		return -EINVAL;
@@ -3321,15 +3399,20 @@ static int io_sqe_files_update(struct io_ring_ctx *ctx, void __user *arg,
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
@@ -3352,7 +3435,7 @@ static int io_sqe_files_update(struct io_ring_ctx *ctx, void __user *arg,
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

