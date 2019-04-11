Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A37C10F13
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 15:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25A72173C
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 15:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kcNTcBDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDKPHJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:07:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45713 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfDKPHH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 11:07:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id bf11so3529380plb.12
        for <linux-block@vger.kernel.org>; Thu, 11 Apr 2019 08:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1GPpeKHWEA2m0dkYAegg4EerGsYnByjaw0MduNABJfc=;
        b=kcNTcBDQLCB4Jyc/VaX8pgU8T6HHJ+CnhHxk9gzPWwnQVGQswrAnzlLDT70jiBuVfY
         stgMDmTc72U06gFlmfwfbfnG95mW+dUMfHG5Pi0gmDf/JMx8XRV7YPHFDltU+WGYwmcj
         Z1sBTb4d0mncq4AYb9hboYsYLKYw7TojYn9q0cVLdlNE6sHBNJ0VF7pIrPJEfsYeloZD
         h8IWC8ibPCa2UvLi47qo6tmmtH/7AZz91VVI2cKxk46oHLYsRjmy7rf1c/3YdI937eQh
         kRa7cyQXgewpankpV7IVqxr+xKFddjxtOYD83esfNCSltsZhoKEIfbRc1Nr/ZbTyDs92
         5YbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1GPpeKHWEA2m0dkYAegg4EerGsYnByjaw0MduNABJfc=;
        b=qBaGpv6rvXJ+o51wwucga7Ff98rIV+duYXpLlpRJMt5MUqJYV79LI9Yz9jeTWZ071P
         uml1oSgbqxyshczLZcLtj6R6WyGf7YelV1EeHPxV6HGdYEm9aNIrFuwwb1rFyMfW7UKx
         33Jftro8NdC3mUyV/kHjN6JvEDI9nTO0k4tVT+RWXxrcamaKOUyR3biYbww5seR58uBa
         1DC9BjcxtyDW+99fQvjIXqYWCW4l3lj+MfN4PR9GHivZzcPDAQmMjiICEkR12oDxdA1G
         iVmH0EFtoPS++Hq5WQqm54z87zzt3C0ZWwEeUbAmoyNle9xsqUDqmeGrMp5KEDVPb3ee
         LQiw==
X-Gm-Message-State: APjAAAW/jOpsF3JMyYFilvL5f/GQnvLmAJdilJW1h22ERFbCeeQI7P1H
        Wj/SloYhvut33L4/mk/ykgi2Xg==
X-Google-Smtp-Source: APXvYqzIIgPXjggpCDmOerBOQ9LLgctGjsGwmEImXnqlwj0axahB886pp4z8CwQN6Z0SxfB530ewxA==
X-Received: by 2002:a17:902:5a2:: with SMTP id f31mr49033319plf.119.1554995226865;
        Thu, 11 Apr 2019 08:07:06 -0700 (PDT)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id s12sm62905062pgc.28.2019.04.11.08.07.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 08:07:05 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     hch@infradead.org, clm@fb.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] fs: add sync_file_range() helper
Date:   Thu, 11 Apr 2019 09:06:56 -0600
Message-Id: <20190411150657.18480-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411150657.18480-1-axboe@kernel.dk>
References: <20190411150657.18480-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This just pulls out the ksys_sync_file_range() code to work on a struct
file instead of an fd, so we can use it elsewhere.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/sync.c          | 135 ++++++++++++++++++++++++---------------------
 include/linux/fs.h |   3 +
 2 files changed, 74 insertions(+), 64 deletions(-)

diff --git a/fs/sync.c b/fs/sync.c
index b54e0541ad89..01e82170545a 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -234,58 +234,10 @@ SYSCALL_DEFINE1(fdatasync, unsigned int, fd)
 	return do_fsync(fd, 1);
 }
 
-/*
- * sys_sync_file_range() permits finely controlled syncing over a segment of
- * a file in the range offset .. (offset+nbytes-1) inclusive.  If nbytes is
- * zero then sys_sync_file_range() will operate from offset out to EOF.
- *
- * The flag bits are:
- *
- * SYNC_FILE_RANGE_WAIT_BEFORE: wait upon writeout of all pages in the range
- * before performing the write.
- *
- * SYNC_FILE_RANGE_WRITE: initiate writeout of all those dirty pages in the
- * range which are not presently under writeback. Note that this may block for
- * significant periods due to exhaustion of disk request structures.
- *
- * SYNC_FILE_RANGE_WAIT_AFTER: wait upon writeout of all pages in the range
- * after performing the write.
- *
- * Useful combinations of the flag bits are:
- *
- * SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE: ensures that all pages
- * in the range which were dirty on entry to sys_sync_file_range() are placed
- * under writeout.  This is a start-write-for-data-integrity operation.
- *
- * SYNC_FILE_RANGE_WRITE: start writeout of all dirty pages in the range which
- * are not presently under writeout.  This is an asynchronous flush-to-disk
- * operation.  Not suitable for data integrity operations.
- *
- * SYNC_FILE_RANGE_WAIT_BEFORE (or SYNC_FILE_RANGE_WAIT_AFTER): wait for
- * completion of writeout of all pages in the range.  This will be used after an
- * earlier SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE operation to wait
- * for that operation to complete and to return the result.
- *
- * SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE|SYNC_FILE_RANGE_WAIT_AFTER:
- * a traditional sync() operation.  This is a write-for-data-integrity operation
- * which will ensure that all pages in the range which were dirty on entry to
- * sys_sync_file_range() are committed to disk.
- *
- *
- * SYNC_FILE_RANGE_WAIT_BEFORE and SYNC_FILE_RANGE_WAIT_AFTER will detect any
- * I/O errors or ENOSPC conditions and will return those to the caller, after
- * clearing the EIO and ENOSPC flags in the address_space.
- *
- * It should be noted that none of these operations write out the file's
- * metadata.  So unless the application is strictly performing overwrites of
- * already-instantiated disk blocks, there are no guarantees here that the data
- * will be available after a crash.
- */
-int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
-			 unsigned int flags)
+int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
+		    unsigned int flags)
 {
 	int ret;
-	struct fd f;
 	struct address_space *mapping;
 	loff_t endbyte;			/* inclusive */
 	umode_t i_mode;
@@ -325,41 +277,96 @@ int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 	else
 		endbyte--;		/* inclusive */
 
-	ret = -EBADF;
-	f = fdget(fd);
-	if (!f.file)
-		goto out;
-
-	i_mode = file_inode(f.file)->i_mode;
+	i_mode = file_inode(file)->i_mode;
 	ret = -ESPIPE;
 	if (!S_ISREG(i_mode) && !S_ISBLK(i_mode) && !S_ISDIR(i_mode) &&
 			!S_ISLNK(i_mode))
-		goto out_put;
+		goto out;
 
-	mapping = f.file->f_mapping;
+	mapping = file->f_mapping;
 	ret = 0;
 	if (flags & SYNC_FILE_RANGE_WAIT_BEFORE) {
-		ret = file_fdatawait_range(f.file, offset, endbyte);
+		ret = file_fdatawait_range(file, offset, endbyte);
 		if (ret < 0)
-			goto out_put;
+			goto out;
 	}
 
 	if (flags & SYNC_FILE_RANGE_WRITE) {
 		ret = __filemap_fdatawrite_range(mapping, offset, endbyte,
 						 WB_SYNC_NONE);
 		if (ret < 0)
-			goto out_put;
+			goto out;
 	}
 
 	if (flags & SYNC_FILE_RANGE_WAIT_AFTER)
-		ret = file_fdatawait_range(f.file, offset, endbyte);
+		ret = file_fdatawait_range(file, offset, endbyte);
 
-out_put:
-	fdput(f);
 out:
 	return ret;
 }
 
+/*
+ * sys_sync_file_range() permits finely controlled syncing over a segment of
+ * a file in the range offset .. (offset+nbytes-1) inclusive.  If nbytes is
+ * zero then sys_sync_file_range() will operate from offset out to EOF.
+ *
+ * The flag bits are:
+ *
+ * SYNC_FILE_RANGE_WAIT_BEFORE: wait upon writeout of all pages in the range
+ * before performing the write.
+ *
+ * SYNC_FILE_RANGE_WRITE: initiate writeout of all those dirty pages in the
+ * range which are not presently under writeback. Note that this may block for
+ * significant periods due to exhaustion of disk request structures.
+ *
+ * SYNC_FILE_RANGE_WAIT_AFTER: wait upon writeout of all pages in the range
+ * after performing the write.
+ *
+ * Useful combinations of the flag bits are:
+ *
+ * SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE: ensures that all pages
+ * in the range which were dirty on entry to sys_sync_file_range() are placed
+ * under writeout.  This is a start-write-for-data-integrity operation.
+ *
+ * SYNC_FILE_RANGE_WRITE: start writeout of all dirty pages in the range which
+ * are not presently under writeout.  This is an asynchronous flush-to-disk
+ * operation.  Not suitable for data integrity operations.
+ *
+ * SYNC_FILE_RANGE_WAIT_BEFORE (or SYNC_FILE_RANGE_WAIT_AFTER): wait for
+ * completion of writeout of all pages in the range.  This will be used after an
+ * earlier SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE operation to wait
+ * for that operation to complete and to return the result.
+ *
+ * SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE|SYNC_FILE_RANGE_WAIT_AFTER:
+ * a traditional sync() operation.  This is a write-for-data-integrity operation
+ * which will ensure that all pages in the range which were dirty on entry to
+ * sys_sync_file_range() are committed to disk.
+ *
+ *
+ * SYNC_FILE_RANGE_WAIT_BEFORE and SYNC_FILE_RANGE_WAIT_AFTER will detect any
+ * I/O errors or ENOSPC conditions and will return those to the caller, after
+ * clearing the EIO and ENOSPC flags in the address_space.
+ *
+ * It should be noted that none of these operations write out the file's
+ * metadata.  So unless the application is strictly performing overwrites of
+ * already-instantiated disk blocks, there are no guarantees here that the data
+ * will be available after a crash.
+ */
+int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
+			 unsigned int flags)
+{
+	int ret;
+	struct fd f;
+
+	ret = -EBADF;
+	f = fdget(fd);
+	if (f.file)
+		ret = sync_file_range(f.file, offset, nbytes, flags);
+
+	fdput(f);
+	return ret;
+}
+
 SYSCALL_DEFINE4(sync_file_range, int, fd, loff_t, offset, loff_t, nbytes,
 				unsigned int, flags)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8b42df09b04c..84e2c45ff989 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2782,6 +2782,9 @@ extern int vfs_fsync_range(struct file *file, loff_t start, loff_t end,
 			   int datasync);
 extern int vfs_fsync(struct file *file, int datasync);
 
+extern int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
+				unsigned int flags);
+
 /*
  * Sync the bytes written if this was a synchronous write.  Expect ki_pos
  * to already be updated for the write, and will return either the amount
-- 
2.17.1

