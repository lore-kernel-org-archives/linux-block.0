Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D468CC43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4045218A1
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="T3myOqhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbfAHQ45 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:56:57 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37054 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729061AbfAHQ4z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 11:56:55 -0500
Received: by mail-it1-f194.google.com with SMTP id b5so6943071iti.2
        for <linux-block@vger.kernel.org>; Tue, 08 Jan 2019 08:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AAKxls5Es8ExKqpwMiUOBUcGduRQU3BNIbRWpRo7VtQ=;
        b=T3myOqhCULnqrWDIXm17iGuFuIzj0qtgtYJE/uBroWZSemlwzSeF7iiys/43IItZrF
         UBh8xYILQiLpu7mrGYR8a+qbzi+moIR8Y8yfDBBoZY0PEjSshHq6yiP4OsPNWf7CbkPk
         a4/0eA+mjy0XvYGLSVAPPbnbxiTOuZrQ/feFzG+QNufW3djRPX8L1ZIHoeNxdVWuUNL5
         Sw12GO/WKRWIUah7YH3vkiwVWYTtxX7q29Ir4j5FFvLcdurLOuWerQQ/3FTaIjQAv0kx
         ycxyzcH+tg7Iy5ik+vtnrUsccTSodWxSjw7yHF9zYt8TuQwHteg3+3C1tudXqduK9hQw
         cKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AAKxls5Es8ExKqpwMiUOBUcGduRQU3BNIbRWpRo7VtQ=;
        b=QKXFLYY8PZ7kwVDT8SxFzRpBdWkk2w+9N9QQdHm0sQms1etvmqP9qMjsbWfg5OER+x
         L0XDB3XtQONdbhRiM0lU+y1bqCNvTsEsN0cEKXpElVk+mUQNzVNWDIbUvPRKAoG1yRju
         xmMdOZWllkQemIrfIFyeweGTIvBl6yqHyCx3Fs6YR3zXrTdWiWIYXojwpkvMCIPv/k2M
         5kO+sHVlp3A+NOTKjJamexkLzSLhNfBKCQd/SoxF7rrnGDR7tO91z23ehMv9HuxfwnsI
         W3JKGTlkSQ/nzqX9TmocPpwEC4E4mHszElP2thIuuuVwbZySoE0lyThQMlsaasJ8Xah8
         OUGQ==
X-Gm-Message-State: AJcUukevjHmZCtUa8mRL5gDGUMdLUDWEn8ANYQ3w+2NgvrS+al44xtGL
        u+6FDsLtVDX9NEW6X2n0Cmca4g==
X-Google-Smtp-Source: ALg8bN521+owdIqdRbFEYj2WTUvMaWHOADu+tRbAJudOWJwqOtCvwGqJdV08Q8SjzGSq4NCdd1VDLg==
X-Received: by 2002:a02:8244:: with SMTP id q4mr1610249jag.43.1546966614931;
        Tue, 08 Jan 2019 08:56:54 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m10sm17563442ioq.25.2019.01.08.08.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 08:56:53 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/16] fs: add an iopoll method to struct file_operations
Date:   Tue,  8 Jan 2019 09:56:30 -0700
Message-Id: <20190108165645.19311-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108165645.19311-1-axboe@kernel.dk>
References: <20190108165645.19311-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

This new methods is used to explicitly poll for I/O completion for an
iocb.  It must be called for any iocb submitted asynchronously (that
is with a non-null ki_complete) which has the IOCB_HIPRI flag set.

The method is assisted by a new ki_cookie field in struct iocb to store
the polling cookie.

TODO: we can probably union ki_cookie with the existing hint and I/O
priority fields to avoid struct kiocb growth.

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 Documentation/filesystems/vfs.txt | 3 +++
 include/linux/fs.h                | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index 8dc8e9c2913f..761c6fd24a53 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -857,6 +857,7 @@ struct file_operations {
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
 	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
+	int (*iopoll)(struct kiocb *kiocb, bool spin);
 	int (*iterate) (struct file *, struct dir_context *);
 	int (*iterate_shared) (struct file *, struct dir_context *);
 	__poll_t (*poll) (struct file *, struct poll_table_struct *);
@@ -902,6 +903,8 @@ otherwise noted.
 
   write_iter: possibly asynchronous write with iov_iter as source
 
+  iopoll: called when aio wants to poll for completions on HIPRI iocbs
+
   iterate: called when the VFS needs to read the directory contents
 
   iterate_shared: called when the VFS needs to read the directory contents
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 811c77743dad..ccb0b7a63aa5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -310,6 +310,7 @@ struct kiocb {
 	int			ki_flags;
 	u16			ki_hint;
 	u16			ki_ioprio; /* See linux/ioprio.h */
+	unsigned int		ki_cookie; /* for ->iopoll */
 } __randomize_layout;
 
 static inline bool is_sync_kiocb(struct kiocb *kiocb)
@@ -1786,6 +1787,7 @@ struct file_operations {
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
 	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
+	int (*iopoll)(struct kiocb *kiocb, bool spin);
 	int (*iterate) (struct file *, struct dir_context *);
 	int (*iterate_shared) (struct file *, struct dir_context *);
 	__poll_t (*poll) (struct file *, struct poll_table_struct *);
-- 
2.17.1

