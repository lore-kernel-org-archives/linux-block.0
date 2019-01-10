Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FFFC43444
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 02:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5F320665
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 02:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="m09SaBnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfAJCoe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:44:34 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44849 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbfAJCod (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 21:44:33 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so4161807pgr.11
        for <linux-block@vger.kernel.org>; Wed, 09 Jan 2019 18:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=scNBCeOhysecepgCupm97WAYtsMfIFMGuolJ4I0NyhI=;
        b=m09SaBnXPPXpKqlJalzUG+AWJI25+5/1GStXjtPIDayefmC2h4kRYImd+thX9wCm2Q
         bBDaCBq2ucv0KDXXbkLBo4lYXTt/CFHWNusBH1ahUKu/h50HKriF8/QBdzyYAS8pvBCO
         1fysW9LyFO76ffHO89qMamsH3E4yCQPsCKU+Fu4FUJagiutYNsMFGjZv12xH6c+tVHTv
         2z2iGC8NgsCVDMM5c+Ao7lRP5uR2fHcUSht9yOIIBAnqJlgiQZuBb6xXtxak89yjTZ7/
         CvEaUqA9fG+027wePc8xcFqbBtmNKJOIND26i1NtSxAAAmNvwU9Z1rsEwg0nsqHKGidD
         SPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=scNBCeOhysecepgCupm97WAYtsMfIFMGuolJ4I0NyhI=;
        b=bCMeoZDVppd9Lyw7IepTUMZiMa62UPfyn5A1qO63vxbO0JKU8wzJ07Ackd8I0Y+lZC
         JRALY4pVn4WnomN1lv3huNtYavW4Bb5xX94B3qaaYp8NHmeTNL8Q7sWaV2vfkjVca051
         KJt+uxUyujLj2xCmW/OQC/mpa80Av5tBg/S2/zc3SfGiNNsNhLiUDgXDbhTHhNRzQ8et
         i3cQAJn2Nn19S8NeUo6UE0EFdk7ryVuJ3ELowOReeYKJZlz0o6zbQ28WRI+vkMPgCSr6
         kZSMAn6UYaH9OSz1Ce51O0k+oMHh7QX4sn+OFh9NuBdrHZsUVgAv/48X5qR0pduDWn1T
         riIw==
X-Gm-Message-State: AJcUukcWcO1gevasns21Rx2SBqSTLeoEEIKCF0/Sk1Lc6ErNfP0oQktI
        y6qOCL2TPasXWEA5b6ELI0JTyQ==
X-Google-Smtp-Source: ALg8bN5r3cbfXjCv4VqGPoTzMLLihQnJPQtKE9SA+db6/ocBWCRoU7Bw1fcjsRstEQjNrcYkJZk7+w==
X-Received: by 2002:a63:f65:: with SMTP id 37mr7689063pgp.238.1547088272807;
        Wed, 09 Jan 2019 18:44:32 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v15sm105799631pfn.94.2019.01.09.18.44.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 18:44:31 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/15] fs: add fget_many() and fput_many()
Date:   Wed,  9 Jan 2019 19:43:57 -0700
Message-Id: <20190110024404.25372-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110024404.25372-1-axboe@kernel.dk>
References: <20190110024404.25372-1-axboe@kernel.dk>
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

