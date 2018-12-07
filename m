Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3382AC07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8A12083D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QniSx9Ju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8A12083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbeLGWU4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:20:56 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46372 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbeLGWU4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 17:20:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so2552830pfe.13
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 14:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=14kCfLiACV93AenWhL1xKvUDPabDTnEKBX7DXRr/kpI=;
        b=QniSx9Juudp/AWQnI6Dek3QXL18XRZWqIwDObYPrY/SYNgHxpExBtqmp4O2t/Pcj61
         SqxPvtQ7Ur/2UULiAHwjJKzN1/9gbEO3VgsWsp6OEgFuB/WiiQFLAdR96dzbPkfBVquT
         2qQnkoWrQXHRQvk6r/uOW8ljhoU/i471c92fxT3QQcO3CI+U8pXuB7hlEWObLjQEWo0+
         8dxc9gnrS2tKH+c/mWYn9MV1VEvFwqdRfpS2ATzUqGeYKDxaT1T3ssAKyX/B6JYXNjGw
         0YkKHulaXiYKyIbphJ1i0UENuTr5WgX4mX2+xT/M9fSgu45o2BJg3QG3V+Ebhljf71CC
         n13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=14kCfLiACV93AenWhL1xKvUDPabDTnEKBX7DXRr/kpI=;
        b=Uz06eIuEeoygcQQUCIwswV/p5DjZlEP8c3CyiTzbFYgtq3s9vPsH6RVMLhUmRf/8Bz
         IJUXmP398oovBsOG9Sf5kMueOt/KlVRbbrBXC4Sqj3Vj5w8/sxVRPu9DoOO26n/aMFVf
         2EcNsEDsiNlY+uzzudB6e1hDCfVXBdXZPI0bnBNuqAaN6rq3HxWZRP7JjB0pkCweV9Wo
         dFG3r7WiYYo+McwjKH9B6PzGejA8pY6sB6m/mJIXn0uW/nb1LmvZayKL92vg/kWC+YGI
         hV03hbc/CPAjTLzh1j1gE5mY8Ep5kHV4KtZrT0b8l6FBHUNoDAB2a7H89Yt9GH6jgikw
         Ke+w==
X-Gm-Message-State: AA+aEWaEcDwUs9zADL7XRJXCxTb4I/QagPEPGTe+DsoXIQA6vxfDCkel
        TaDHcXnE0a6XY8AhZP7v8xlV4dKos1c=
X-Google-Smtp-Source: AFSGD/UEkx4Qcxfc4BhWKR4uYfM80KgpvBecNZtZ9VFlrwNzhEz34gA3n0x/Ntx4DwkMGYyg+CTyyg==
X-Received: by 2002:a63:1f1c:: with SMTP id f28mr3500068pgf.193.1544221255166;
        Fri, 07 Dec 2018 14:20:55 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e9sm5282511pff.5.2018.12.07.14.20.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 14:20:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 17/26] fs: add fget_many() and fput_many()
Date:   Fri,  7 Dec 2018 15:20:07 -0700
Message-Id: <20181207222016.29387-18-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207222016.29387-1-axboe@kernel.dk>
References: <20181207222016.29387-1-axboe@kernel.dk>
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

