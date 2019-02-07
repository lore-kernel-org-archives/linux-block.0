Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011BCC282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B0A21872
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SdLVDThf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfBGT4B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:56:01 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35962 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfBGT4B (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 14:56:01 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so2967336itj.1
        for <linux-block@vger.kernel.org>; Thu, 07 Feb 2019 11:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pB0024BHqxQbFqcC6bm8p7+6qjmI2rEZP9GcpS5QfRU=;
        b=SdLVDThfQNGGBvSdx2ieObxXUNxV541kXy7C0CKM0Rn+mwquJwHo+7gPZhNqgdgfhz
         mMjsRgcrqrMGitpc7N0Yt/Pcc4l2jtxQwdsW85Q+xcilRZJjip9LEpVO8b3hg+rhaMWp
         oLZmNfLIhl9FYvzAFjmFBT4cq4qmNacpd3uLzdeNzOAou6pTnrLT47Y9xC3UK/yMvudJ
         u8VZERigj5XAUy1wutp9LoBeoMuyZo3jzSdG+QTITcqbRi3xhQ0B5CIl7omlucUuAys7
         JiwiUWfR71TYjLFm1uKYjOxQSQfkYWOyqpsTtZC7IUxQJuAlRxEXkRinetKcu8d5bkwr
         huAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pB0024BHqxQbFqcC6bm8p7+6qjmI2rEZP9GcpS5QfRU=;
        b=B/L+yPe2CPw8hYqL94dMLRFo4tCpO9I8i4eoQmhxN2RPIs8DHRwgV6ybs5H8gu7lLA
         KGdv8B6NrPWD6PNgdhmVHVhbxbzgG2MCGdDAeoDLqIzMCYyLyPTu0B5Fgjd5iuIVQr/r
         KL7fcSj4scCmE1AIo2tdoeGGWbUekhNyccHOd94fZa3cMfBBDzNxUIaObmUY2A4bNI4d
         G1qH5liz+FO5sjDJ9dZDNBgMOKHmJqtD2jP4LUKmKrIK3+tSrsxkVDnr7507yeA56Zbm
         fDEzBPRBVJdfEFEY/SuZ98liidmd+mHNBMohM6lAbgUh2QeeyRWj18gYiIpelzQtNtlg
         B8iQ==
X-Gm-Message-State: AHQUAubFmqtWtztLq1E9Ap+PM0zLqq7vNy/SAmpOWrW2Rq5+r5pJa9aI
        B1V3x+bgihe7SpesPARUBlqCWA==
X-Google-Smtp-Source: AHgI3IZZSQU6u2qINr0s2sauHZQdvYQMMdS3/lnt0YCN4YBBAZgcgcRWg9XPNRgw8QA8qOeovGxfFw==
X-Received: by 2002:a24:68d0:: with SMTP id v199mr1628018itb.73.1549569360177;
        Thu, 07 Feb 2019 11:56:00 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y26sm5092782iob.16.2019.02.07.11.55.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 11:55:59 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/18] fs: add an iopoll method to struct file_operations
Date:   Thu,  7 Feb 2019 12:55:35 -0700
Message-Id: <20190207195552.22770-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190207195552.22770-1-axboe@kernel.dk>
References: <20190207195552.22770-1-axboe@kernel.dk>
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
index 29d8e2cfed0e..dedcc2e9265c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -310,6 +310,7 @@ struct kiocb {
 	int			ki_flags;
 	u16			ki_hint;
 	u16			ki_ioprio; /* See linux/ioprio.h */
+	unsigned int		ki_cookie; /* for ->iopoll */
 } __randomize_layout;
 
 static inline bool is_sync_kiocb(struct kiocb *kiocb)
@@ -1787,6 +1788,7 @@ struct file_operations {
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
 	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
+	int (*iopoll)(struct kiocb *kiocb, bool spin);
 	int (*iterate) (struct file *, struct dir_context *);
 	int (*iterate_shared) (struct file *, struct dir_context *);
 	__poll_t (*poll) (struct file *, struct poll_table_struct *);
-- 
2.17.1

