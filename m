Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A756BC43387
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB8C21929
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vzb57S2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391716AbeLUTXa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:23:30 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38647 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391658AbeLUTW5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Dec 2018 14:22:57 -0500
Received: by mail-it1-f193.google.com with SMTP id h65so8018808ith.3
        for <linux-block@vger.kernel.org>; Fri, 21 Dec 2018 11:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vn1H2PKRH+r2K/nzBAStOQAzrcfiBWWG76LFewR/io0=;
        b=vzb57S2ZmDfhFGP1J483vLS/Ny1PSITwmhybFwYj1F8swmh5sKKAXZLFxgcbg0HZ8B
         G0CGi8xrKeUpprNkOry9/Q3VGL4zV0yzxkTuYfCqmOPVB2by3b3oDuJSICTrUCGk+9wk
         BrPafFCNTZCOZrLr1ZeyuzKH9jvE68u6rWegYxJmjEKfq7JIR+13w9H3OcqSJ0l3l9S5
         1BEuJRWHPKZMpsDdgMciAzmmGLt2zDNdAR1JIpQjxg/E5ZImMpsHVux+J8Bap2CeGoY9
         CW6q4zE94VZLSYqzUWAgQlNCLcG3YCt7YXOo89LGrYqQ76A0fRAKRpV201LTUDHwfNMU
         PzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vn1H2PKRH+r2K/nzBAStOQAzrcfiBWWG76LFewR/io0=;
        b=YINyIlmsFN56nN9h2cRNAB9rGmcaoVh0DkSCl9REis8vqtVR5mP/BW0EUWx5HUB1Gc
         6u0aG0Y8bT/rem5n0Rap4Z0XuNPskzldhy4gL+1cMrCS8IoVNwQnJ2XRe9TzI5NxQhCi
         J/gloLKgQ3ERpOW1rKXwDi0+5wtx4FeVxwMXKD/ofqGHXsP0pNFwmY4WYe+Kx3xqgIfC
         z7RbDep8BI0lok6Fx0+z68Qt0qDsczZj+B0tAyphYdfFWEogBTn/jym/D4cbkrABHaQ1
         zRZEOowcEprGIDRlEgrdouqJz/EhzO0ExSL42kJrS/h2HCZMxFTA/VNK0X1x4pi9oDRb
         F6YQ==
X-Gm-Message-State: AA+aEWZ9joq0eREib5I0kLUB69wGkuZd77ILr8EdwTYpB+q0aCoD3VpJ
        HCPhb4Hr9l2pPcdB483nvBDaLw==
X-Google-Smtp-Source: AFSGD/VX3SuDbhQW2qknCyT0szW+E5Ww7t5ccHQUcWPO3c8Htb1zmqaYVejQUZF3DRt1NDMhXoSUHA==
X-Received: by 2002:a24:168f:: with SMTP id a137mr3103235ita.71.1545420176427;
        Fri, 21 Dec 2018 11:22:56 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t1sm12456290iol.85.2018.12.21.11.22.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:22:55 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/22] fs: add fget_many() and fput_many()
Date:   Fri, 21 Dec 2018 12:22:24 -0700
Message-Id: <20181221192236.12866-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221192236.12866-1-axboe@kernel.dk>
References: <20181221192236.12866-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some uses cases repeatedly get and put references to the same file, but
the only exposed interface is doing these one at the time. As each of
these entail an atomic inc or dec on a shared structure, that cost can
add up.

Add fget_many(), which works just like fget(), except it takes an
argument for how many references to get on the file. Ditto fput_many(),
which can drop an arbitrary number of references to a file.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/file.c            | 15 ++++++++++-----
 fs/file_table.c      |  9 +++++++--
 include/linux/file.h |  2 ++
 include/linux/fs.h   |  4 +++-
 4 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 7ffd6e9d103d..ad9870edfd51 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -676,7 +676,7 @@ void do_close_on_exec(struct files_struct *files)
 	spin_unlock(&files->file_lock);
 }
 
-static struct file *__fget(unsigned int fd, fmode_t mask)
+static struct file *__fget(unsigned int fd, fmode_t mask, unsigned int refs)
 {
 	struct files_struct *files = current->files;
 	struct file *file;
@@ -691,7 +691,7 @@ static struct file *__fget(unsigned int fd, fmode_t mask)
 		 */
 		if (file->f_mode & mask)
 			file = NULL;
-		else if (!get_file_rcu(file))
+		else if (!get_file_rcu_many(file, refs))
 			goto loop;
 	}
 	rcu_read_unlock();
@@ -699,15 +699,20 @@ static struct file *__fget(unsigned int fd, fmode_t mask)
 	return file;
 }
 
+struct file *fget_many(unsigned int fd, unsigned int refs)
+{
+	return __fget(fd, FMODE_PATH, refs);
+}
+
 struct file *fget(unsigned int fd)
 {
-	return __fget(fd, FMODE_PATH);
+	return fget_many(fd, 1);
 }
 EXPORT_SYMBOL(fget);
 
 struct file *fget_raw(unsigned int fd)
 {
-	return __fget(fd, 0);
+	return __fget(fd, 0, 1);
 }
 EXPORT_SYMBOL(fget_raw);
 
@@ -738,7 +743,7 @@ static unsigned long __fget_light(unsigned int fd, fmode_t mask)
 			return 0;
 		return (unsigned long)file;
 	} else {
-		file = __fget(fd, mask);
+		file = __fget(fd, mask, 1);
 		if (!file)
 			return 0;
 		return FDPUT_FPUT | (unsigned long)file;
diff --git a/fs/file_table.c b/fs/file_table.c
index e49af4caf15d..6a715639728d 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -326,9 +326,9 @@ void flush_delayed_fput(void)
 
 static DECLARE_DELAYED_WORK(delayed_fput_work, delayed_fput);
 
-void fput(struct file *file)
+void fput_many(struct file *file, unsigned int refs)
 {
-	if (atomic_long_dec_and_test(&file->f_count)) {
+	if (atomic_long_sub_and_test(refs, &file->f_count)) {
 		struct task_struct *task = current;
 
 		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
@@ -347,6 +347,11 @@ void fput(struct file *file)
 	}
 }
 
+void fput(struct file *file)
+{
+	fput_many(file, 1);
+}
+
 /*
  * synchronous analog of fput(); for kernel threads that might be needed
  * in some umount() (and thus can't use flush_delayed_fput() without
diff --git a/include/linux/file.h b/include/linux/file.h
index 6b2fb032416c..3fcddff56bc4 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -13,6 +13,7 @@
 struct file;
 
 extern void fput(struct file *);
+extern void fput_many(struct file *, unsigned int);
 
 struct file_operations;
 struct vfsmount;
@@ -44,6 +45,7 @@ static inline void fdput(struct fd fd)
 }
 
 extern struct file *fget(unsigned int fd);
+extern struct file *fget_many(unsigned int fd, unsigned int refs);
 extern struct file *fget_raw(unsigned int fd);
 extern unsigned long __fdget(unsigned int fd);
 extern unsigned long __fdget_raw(unsigned int fd);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6a5f71f8ae06..e81d0a64d369 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -952,7 +952,9 @@ static inline struct file *get_file(struct file *f)
 	atomic_long_inc(&f->f_count);
 	return f;
 }
-#define get_file_rcu(x) atomic_long_inc_not_zero(&(x)->f_count)
+#define get_file_rcu_many(x, cnt)	\
+	atomic_long_add_unless(&(x)->f_count, (cnt), 0)
+#define get_file_rcu(x) get_file_rcu_many((x), 1)
 #define fput_atomic(x)	atomic_long_add_unless(&(x)->f_count, -1, 1)
 #define file_count(x)	atomic_long_read(&(x)->f_count)
 
-- 
2.17.1

