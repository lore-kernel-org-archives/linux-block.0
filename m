Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BBEC04EB8
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF282086D
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oZWkgk3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF282086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbeLKAQc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:16:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42184 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729353AbeLKAQb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 19:16:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so6022751plp.9
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 16:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=14kCfLiACV93AenWhL1xKvUDPabDTnEKBX7DXRr/kpI=;
        b=oZWkgk3Y+ExS5+zTvoHMpbASGdK6Gd7piR4YSunNeYBTOuWZROV63qTK3VKq9j+rhK
         d4+M8o4ZRdEPgbR4P9x8xBiY3FYVLMDH3PThZWUtTfDTCSd20S1s7pY2oKPVMDY1ciVW
         WrrDeZWcB1s964sy7gqBgxwLxociegWn/OtgeDMR6dm3brpaMIxVDEVC2Hlm7N/DUibY
         tc+7Xdc3dVTOhSPgTBB+so9cPk0d+biMamrmV0QPxwKXyq38HPMyrhaRxXbGhTOYb31z
         U/y1B5dQKIOCT3eCoAmVixNCQnlJ7CvL+QLiNqIxPQsi1M4BspGNrqguKKg/z91Fw0W2
         +lIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=14kCfLiACV93AenWhL1xKvUDPabDTnEKBX7DXRr/kpI=;
        b=gwccAEqei2SmXdpMSPJPFaWyTf58o4cYMYD9mcX31VttcINSU+uj6S8NdJDUmyAD4o
         LqcMmmUn2AQDRi7StA5KQFJF93pirhM5Swuz/SEbKBLxJLXVMnLkCG5YGKmHWIP6cJWP
         6/kjA70218PPsyQwhtRmmnNpRdVWL0lpMmqUVw1Y9uIBuTOVEzT6PSwZL0xgFiIFc92z
         JYu9IAFkTnzBc46FyVIaKhFrbu/oRW3F7ixc0gtOS14YrYCyOV6Ycr6QLHVWSl6t4V8S
         RwXfUNjKZQO5dgpUg6XZP5qaQSr3xbI9rYWvTMG43R2+TLvPIbwKQs8BEAbd5ro4PS2+
         TKXA==
X-Gm-Message-State: AA+aEWb46mAZbtNrAQR1qkWjG94Fmr8niXntmXoHuBiSC+Hco8TugJ3/
        wbj+QnY4gXtEovXrU9pu9J9HE71ZhCwQSQ==
X-Google-Smtp-Source: AFSGD/WU09tsOuYv5f8br+tZn7vAt04Z7JG4xLDzM4E8HVV3HEmSMMrS84LbqN/ANd97Dm/zoZ6wZw==
X-Received: by 2002:a17:902:15a8:: with SMTP id m37mr14248027pla.129.1544487390737;
        Mon, 10 Dec 2018 16:16:30 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm16872856pfl.16.2018.12.10.16.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:16:29 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 17/27] fs: add fget_many() and fput_many()
Date:   Mon, 10 Dec 2018 17:15:39 -0700
Message-Id: <20181211001549.30085-18-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211001549.30085-1-axboe@kernel.dk>
References: <20181211001549.30085-1-axboe@kernel.dk>
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

