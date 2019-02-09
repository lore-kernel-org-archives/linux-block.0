Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0F6C282CB
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 21:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A85521934
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 21:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OCSV+rHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfBIVOI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 16:14:08 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46862 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfBIVOI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Feb 2019 16:14:08 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so3307345pfe.13
        for <linux-block@vger.kernel.org>; Sat, 09 Feb 2019 13:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=98aDYmP2NlaZN4eCHJfDt4iyzmD8E6C6eVhxrKQfagM=;
        b=OCSV+rHI6wUyaWWt1R3I4X9gVNRorSlD2PQtocig/fAgcNLrklvSeier0fUtZzA6WM
         YBN83N/uHEOGVSmbetWu2DChv6jwhBL3J+sFm+1ir1NnVQfNdJfZJzs7hb+wsz/E/7z9
         RZjCnpwIu3qlY1TKd4+08CMwPahEsDBFl6MQL1/hX5hkkkx9SxEXA8H3kdUEBfDOIQGH
         RRXAsoq+ETnOA73mshEcWPbNflOUmPS15fvDYbX2aMA9/4uhMufwrx3LQrQ13NdAeu+y
         DBGuCcq0Ymllq6pDeuxU6Oa9T1YEjk61NKoXmaLK5r2d4/1sJzEoCBmYXucYJCESf+Na
         ZDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=98aDYmP2NlaZN4eCHJfDt4iyzmD8E6C6eVhxrKQfagM=;
        b=SXHE8mnJQpHQ8YeINAZUPDCCZoSFGKPJaopSO1iYn/z7Z7Y3AUC+xM2uhReNEfDVwR
         aab0bjGHAlDe1WjQE96MlT7xFHnmZlttPOuEKT1h9DzT2UHaEv51XYDypW7dkYU5RJ1R
         egn/RoZx4MICxt8AKSlC3MvehvvSSItRXQkwE6R1RJd1B+8UfxaPIUwT2ug2mafiZOtR
         bsjoqZ4oQ7osF2TeEaClpTqifm6wMpNhoQYcwlQpwqT0xNGGRYyiNBhvKosDPucwoqox
         19x/h8g6udaviYx5BZJw3bHEfa7s1fJ3LG6JqnxFg1CnCH2q22UDi0ja62+BvbZ34xPh
         hcPQ==
X-Gm-Message-State: AHQUAuYwaIcVvRRYzA+vOjUvD0DQCLBdRGcXwJdzuUmimIqmYci0uFtB
        gGULPSgN/I8I2WKruutiVWKaE43KaITSkQ==
X-Google-Smtp-Source: AHgI3IY534TBjeW4ezGoWMlL9aGRsLn9Xkt03zoFiNHpvKao548ZYOz0TGWjj5ecyQFW0vpXxMc9Uw==
X-Received: by 2002:a63:1e17:: with SMTP id e23mr13196195pge.130.1549746847455;
        Sat, 09 Feb 2019 13:14:07 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a17sm7004942pgm.26.2019.02.09.13.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 13:14:06 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/19] fs: add fget_many() and fput_many()
Date:   Sat,  9 Feb 2019 14:13:35 -0700
Message-Id: <20190209211346.26060-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209211346.26060-1-axboe@kernel.dk>
References: <20190209211346.26060-1-axboe@kernel.dk>
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

Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/file.c            | 15 ++++++++++-----
 fs/file_table.c      |  9 +++++++--
 include/linux/file.h |  2 ++
 include/linux/fs.h   |  4 +++-
 4 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 3209ee271c41..97df385d6ab0 100644
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
+	return __fget(fd, FMODE_PATH, 1);
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
index 61aa210f0c2b..80e1b199a4b1 100644
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

