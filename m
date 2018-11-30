Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A24C65BAE
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E142145D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TiqPrLnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E142145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeLAEHQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:07:16 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38881 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbeLAEHQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:07:16 -0500
Received: by mail-it1-f195.google.com with SMTP id h65so10227413ith.3
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=14kCfLiACV93AenWhL1xKvUDPabDTnEKBX7DXRr/kpI=;
        b=TiqPrLnOkfC+Zz5Ju3GWBXlcq1tYFO2h82OmJ4SGdl3VfZ9GzV0OTQ/TQt1uf8la1x
         CpVciynTtXqo+HhAMdm1imVoG6es+G2xqmy0nsjkONh8SkD2nbDDGkCgbSKSU8d66F3y
         19sK++Ypfi7CpKiq69jkBQVzypv0+K6Tosuzw2EKqAyUyrO3E+nQvBRNGPX5lcwh6zXS
         LdfBYCKBOt1nBESVtMdXlcP+bmedgXCigUIoLeYkv8GWh/GyBruY7xkxwkoXpD9Akcg1
         hIxFsxGqV0JqLgQRfHLohN1wl+T36KSsyjpUYW6m8ispf6W0Qp2JHpgd8q1HZ1dm9Y8v
         A8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=14kCfLiACV93AenWhL1xKvUDPabDTnEKBX7DXRr/kpI=;
        b=lkOBqQwVQt8sUMZJ4H7u2VY6jHiO+HskOpBoj1GXlqOXz3JmU26n81f8ouRtq5O7bv
         505XV7L0ca+36PA6AdqPV1h3X2pbmVhmG2CyBdrcINJ+hHlicDqn5A9J69F2PxfRN+ZJ
         VqU2F0hQ69xMne1jsD9OzEoE/peCb57UAnwgwizE2DhrBZZ3/fOCMxnCA4RcfZpVKj5o
         edSLTnn/jMQ7bLmgfSj/Ee7WnTtscrB9eQ8ORwKWIS0FTu2EWive80UqCZfOzorNzwqY
         9kld//y2s4dWx95L0YfZIF8evIy1M5GrLiLomYWRfquXBbViGY9RV9B1XPkdtXJR6QAW
         1MNQ==
X-Gm-Message-State: AA+aEWZahcQqgRtw6BFiOa8Bp1IhN3dMo2mUkHtRbMruXSm6m3z8OT/H
        A6noIq5vX2J+0/DFgtdBEopqX8yQ3vA=
X-Google-Smtp-Source: AFSGD/UCWQhcPAOi9IxYkGGlOZkwbmyrVMJWWnfjL/JMdacEe+udH3jNy64/LUMyfmy7JJuLVa7p6Q==
X-Received: by 2002:a02:a990:: with SMTP id q16mr5882865jam.132.1543597040111;
        Fri, 30 Nov 2018 08:57:20 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:57:19 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 19/27] fs: add fget_many() and fput_many()
Date:   Fri, 30 Nov 2018 09:56:38 -0700
Message-Id: <20181130165646.27341-20-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130165646.27341-1-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
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
 fs/file_table.c      | 10 ++++++++--
 include/linux/file.h |  2 ++
 include/linux/fs.h   |  3 ++-
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
index e49af4caf15d..6a3964df33e4 100644
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
@@ -347,6 +347,12 @@ void fput(struct file *file)
 	}
 }
 
+void fput(struct file *file)
+{
+	fput_many(file, 1);
+}
+
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
index 6a5f71f8ae06..dc54a65c401a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -952,7 +952,8 @@ static inline struct file *get_file(struct file *f)
 	atomic_long_inc(&f->f_count);
 	return f;
 }
-#define get_file_rcu(x) atomic_long_inc_not_zero(&(x)->f_count)
+#define get_file_rcu_many(x, cnt) atomic_long_add_unless(&(x)->f_count, (cnt), 0)
+#define get_file_rcu(x) get_file_rcu_many((x), 1)
 #define fput_atomic(x)	atomic_long_add_unless(&(x)->f_count, -1, 1)
 #define file_count(x)	atomic_long_read(&(x)->f_count)
 
-- 
2.17.1

