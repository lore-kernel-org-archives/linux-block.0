Return-Path: <SRS0=tPwK=PU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72612C43387
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426D02086C
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TMRr4+hD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfALVai (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:30:38 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40047 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfALVah (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Jan 2019 16:30:37 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so8362213plq.7
        for <linux-block@vger.kernel.org>; Sat, 12 Jan 2019 13:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=scNBCeOhysecepgCupm97WAYtsMfIFMGuolJ4I0NyhI=;
        b=TMRr4+hDYOacDnkEaeA+/ucAU/kCy7rfVWmTZP9KlLHt29O+oYZJ0XtNnvLg/CUqEr
         IEOQSTgwy3TxyYwFKKfsXXdmGy+LFuzUY1pjyEp7n96RfN6s4rVJ3oyR6HU4gQCTA8zf
         YkcK7z5dsXFiiXxHDXj7QlRAsic8NAn8hPIr3J3iJDrYxB3SKwrvgt142MjLhWmdMIOT
         Hab1UuANTAnA+TkqxYNcbWNXs4/PQKlgRN5uIoH1Mcf40XQT5dHzU2GrGkPuU3v5St43
         VWc+lcayablnb7/j3nVPCrr6plLpLBXEAyzIDUf0PcQSH3JvKa5yw+dczhzSefRCy0QI
         8Z7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=scNBCeOhysecepgCupm97WAYtsMfIFMGuolJ4I0NyhI=;
        b=UnJ3GipHm2mSzm0n3FsHbCGHmZq7aVUgeDcPkIu2b8nq+zXol+VtffV9hRHIH1i8mP
         bbRq5y/ZsCHyopXtW9PkOhV2R93O/k9XBdI3aRIOho5nA78RIjUxQL/b+GOZehksnbgI
         HLuipZ3AnCowANapVxqSc3fad3XTjU15oj7ux3gV4VNdFMQSP2MUExrE6IT4extFI/YW
         Y/CkbwvGhg4lLsC/Mle3zDMVleY+xxqcWZA2NKEYEc9zU2+miuXnMLmpz5SfKR/aUgHk
         GHpiwco2ib3llc/G/+3wrst1qtPS6iH2xoel2nugSaWvQblsZb6Dly/4U+UZ7+lSvmI0
         JnOQ==
X-Gm-Message-State: AJcUukcdHgKkUEIPetcZH/yddS6eCqEtiI9riiHl+JRiseD1LuW19M/7
        CmYv1WfZI6ZCQFmolNeKyx8AvA==
X-Google-Smtp-Source: ALg8bN5UiO3mzJCLfvTWnHiKpY3iioSGQIM+v15yaqpDJ3WVSdowIN0BZ94jGPz0xgk4dr4VDXAR1g==
X-Received: by 2002:a17:902:ac1:: with SMTP id 59mr19624309plp.36.1547328636633;
        Sat, 12 Jan 2019 13:30:36 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y6sm151629818pfd.104.2019.01.12.13.30.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 13:30:35 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/16] fs: add fget_many() and fput_many()
Date:   Sat, 12 Jan 2019 14:30:04 -0700
Message-Id: <20190112213011.1439-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190112213011.1439-1-axboe@kernel.dk>
References: <20190112213011.1439-1-axboe@kernel.dk>
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
index 3209ee271c41..e0d7ce70e860 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -705,7 +705,7 @@ void do_close_on_exec(struct files_struct *files)
 	spin_unlock(&files->file_lock);
 }
 
-static struct file *__fget(unsigned int fd, fmode_t mask)
+static struct file *__fget(unsigned int fd, fmode_t mask, unsigned int refs)
 {
 	struct files_struct *files = current->files;
 	struct file *file;
@@ -720,7 +720,7 @@ static struct file *__fget(unsigned int fd, fmode_t mask)
 		 */
 		if (file->f_mode & mask)
 			file = NULL;
-		else if (!get_file_rcu(file))
+		else if (!get_file_rcu_many(file, refs))
 			goto loop;
 	}
 	rcu_read_unlock();
@@ -728,15 +728,20 @@ static struct file *__fget(unsigned int fd, fmode_t mask)
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
 
@@ -767,7 +772,7 @@ static unsigned long __fget_light(unsigned int fd, fmode_t mask)
 			return 0;
 		return (unsigned long)file;
 	} else {
-		file = __fget(fd, mask);
+		file = __fget(fd, mask, 1);
 		if (!file)
 			return 0;
 		return FDPUT_FPUT | (unsigned long)file;
diff --git a/fs/file_table.c b/fs/file_table.c
index 5679e7fcb6b0..155d7514a094 100644
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
index ccb0b7a63aa5..acaad78b6781 100644
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

