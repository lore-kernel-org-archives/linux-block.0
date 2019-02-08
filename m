Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E727C169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 17:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BCA217D8
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 17:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iYiz1bQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfBHRef (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:34:35 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55021 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfBHRef (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 12:34:35 -0500
Received: by mail-it1-f193.google.com with SMTP id i145so10653763ita.4
        for <linux-block@vger.kernel.org>; Fri, 08 Feb 2019 09:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pB0024BHqxQbFqcC6bm8p7+6qjmI2rEZP9GcpS5QfRU=;
        b=iYiz1bQR07wqnjnyz3vfSH43HNU9ZABaxfYwqTG5lyJ5MqOjfRr3931RWMEnR6GV/y
         EyaPrwXODuc78oOLse2w2+8pXeF6wRnbz9P816bGzkDmxUM6r3RM0Ng4AAz6Zo/we3/Q
         QUjDoL5tPHFeOvr+6lXiH3LgQEHdnwcsiGA6UsLjQxsG6AubepUV4dldqsooeW0GlQa+
         kMvQI+6HhgSXfpGR7FwotfhtQ059D/h0IvyQvhK3vuT5DBbQNTAYGuA4AOka5hfJqEiJ
         LRi9Gynx2aDFsRi7oleQ4xSKua/t81VK1RoKqgR9X0Z2Ma9PFJ5c6EMuvO5Ibq1ckndb
         WEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pB0024BHqxQbFqcC6bm8p7+6qjmI2rEZP9GcpS5QfRU=;
        b=U6yL4GQ0EdhAKbUDX3O9waJesv6GGlIzIraSyQm5o6sev2mKaSwMm45nwKQNnTiwb5
         IJY5+d+9lx0xPGtR3JmE3FOKQenXMH097ygbSnngO4tYyDnDlNZ/puiHX5FN9CSsKKnm
         IpUlraUnTYu53QDl6Pop6pors2s+EPJF7EFPldjkBImRg09TU4jK6jcwzWUkf+U/cZgG
         wykLxjCsnY3Bld+kUUZ5mbuSz4LC74kyJuILexAxDtiUKYTdnu0C5T2OR5/eLrCpfNNQ
         XhM5GBtE5rH+AcLA12kX2KBr5Ec3yQJjnjKAS0dkSj6fJsEBE8Ncd2fzP7KIgjaP5wsG
         5aZA==
X-Gm-Message-State: AHQUAuYPC6cVTlRJwBUee+wooIG0bU1RC4igTKli+Uebc/uSmwzizinY
        RlZ5EVymDT3kipooVtVN2vlnAw==
X-Google-Smtp-Source: AHgI3IYlOYebmGR61bbl3Xb6VuLFn2tvs7ZB1VVaBVMa2tuHuqu04lb3Ob55JET1boWz36p9W3BX1g==
X-Received: by 2002:a24:6f51:: with SMTP id x78mr6717997itb.121.1549647274209;
        Fri, 08 Feb 2019 09:34:34 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f142sm1522627itc.15.2019.02.08.09.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:34:31 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/19] fs: add an iopoll method to struct file_operations
Date:   Fri,  8 Feb 2019 10:34:05 -0700
Message-Id: <20190208173423.27014-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190208173423.27014-1-axboe@kernel.dk>
References: <20190208173423.27014-1-axboe@kernel.dk>
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

