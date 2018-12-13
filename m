Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91CAC65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A788720851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kCAvsZDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A788720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbeLMR5X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:57:23 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35992 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbeLMR5X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 12:57:23 -0500
Received: by mail-io1-f67.google.com with SMTP id m19so2327047ioh.3
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 09:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=14kCfLiACV93AenWhL1xKvUDPabDTnEKBX7DXRr/kpI=;
        b=kCAvsZDPjgA8nWizJe5CdZPrXZhm9dVcGBb+XzFkiLfavCYuDkfRL3scrEdc5fqvQn
         8GG2B8NtzOkjfBp2fdUGgZb/1Q/ldUFp419buyQmIwoILM/6QwIoWP/DGuF+Ykt6MrB0
         Z07xhvuPBXhQ7RxroqiKbZqdhl4Hq5afzd9pgErIlTaa8fSqYU03tAVGx740uDMmB7jB
         DeTfwr93rwXbG2iGakYl6h2cPOUIwHqqnp/W5wyEQlofqKtkpNh+TE69IhEudyBSIvEz
         +VR61tH9MkmySspgDVwceHqYZmw3LSCAUjlMQvhfGOOmKkZRNV8H0YzFP8eP8Tuzr8He
         cGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=14kCfLiACV93AenWhL1xKvUDPabDTnEKBX7DXRr/kpI=;
        b=O2Iiiix+HanIRu6Ut030m5PkPixUbQv+ajTvuxEinCuPrSh83/VaUrsbQf/7E+kJkf
         wz0+0UKR0M9oXQLHbkZOCuIfY/kns2KbgF0HblziHhBdqysqyOX3Uhmp8Tn3WyUvkvkj
         dy/d14w+/kwbZKIZThK/N8mRo9LZzMUAd3xOeeCGX3mKXsLc7+C9VBC3yHpcUDuG3QwG
         c2imGw6DL2h7OWYyBoQZ2cH0GmljXJLhk5Nrvtznq1zKki/VETQrR6v60xrW76vbXNuf
         2pjmadtQ8N/6T83lDzl680gJgcEm6SK3FPnyyWv8YHPVdZu36KFJpxdRrJulbuBm9WQS
         XYXg==
X-Gm-Message-State: AA+aEWYoarhoyhpy2v3tA3ZSBkW41w/kpw/jJspG4a40hV05pDAYgN34
        mE71oEoJm0FTAqR3D3lF3n3z0DsrpyS0tg==
X-Google-Smtp-Source: AFSGD/UmA4MjC6zNE6Zr2oPUWGaVzrg7t+X25vG/ychaU95FXatP0tsBJKWywwGtD0sjcwTIt3WwIw==
X-Received: by 2002:a6b:3f06:: with SMTP id m6mr20055155ioa.117.1544723841121;
        Thu, 13 Dec 2018 09:57:21 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k6sm1022261ios.69.2018.12.13.09.57.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:57:19 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 16/26] fs: add fget_many() and fput_many()
Date:   Thu, 13 Dec 2018 10:56:35 -0700
Message-Id: <20181213175645.22181-17-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213175645.22181-1-axboe@kernel.dk>
References: <20181213175645.22181-1-axboe@kernel.dk>
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

