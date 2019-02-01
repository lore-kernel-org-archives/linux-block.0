Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11529C282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 15:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41B0218AC
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 15:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="H5FHgDZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbfBAPYW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:24:22 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35166 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbfBAPYW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 10:24:22 -0500
Received: by mail-io1-f68.google.com with SMTP id f4so6001490ion.2
        for <linux-block@vger.kernel.org>; Fri, 01 Feb 2019 07:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FY7i8A/t+ar+CVDsIpMVwrTPPHLhDb6dZzvnPNdG5Kc=;
        b=H5FHgDZ/lXx2jL01XrD63+jcC4f9c+VkASLc/Frz7Wj0QUDM5rces0eE6RLf5oP1vJ
         eYVw3mUz6HzTQOnXpiW7XPBUimIpx+dEuDW++H+atlzXXaTI7TBna+PB9Wiq87CMqp75
         tgx957ZOsswR96qKGA7PhSRkD3rFaNwm1uKR68RqrpnCfnqautmVF7QqKb2xTAWFvzX2
         LGUMt1fBMvlw2gYk0r8b1rEmYlVN5qHfFPGue9Z6EldVVNoYzCC9TzNsx7WuNt0qG9Tf
         yL4gPS6AxjVzjPwU7YrYSGEsAVGvpH9GRqqwocdSf6FTL/X7HbaBCNJwKLX1BdMs5A72
         2mmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FY7i8A/t+ar+CVDsIpMVwrTPPHLhDb6dZzvnPNdG5Kc=;
        b=ieuVcrWmIqHq3iOS3FoeAnwvMYy3einEH06OOF+cpmMK/4uTgMMFWEHYgv8dWCSorD
         vZ3F5zMO20by9YlD8Ohnw2CAT5fgZxDugYjz213gyHiMebFq7jvrNfwj0x9aIoFl11Wy
         Nb6iR3DS1FJCyT4z0UTlYU45pWPzyDY9Gn0kgP9Cthig8eG5Zitnm7IYpqmSgMEMgTRB
         fKMDDcU5onTj9bwRV4ikf43Zn2N3lYyM9PqiwTkmufoymzRzLz3rUjTqLQEfGI+HqVgH
         d3J1+a7FCyiAw86hEph7dA7J6x65ZfQNd58qYbu56CxIMKmXiL+jzfnFfgtDroZKdg7O
         ncFQ==
X-Gm-Message-State: AHQUAuaygCBnzoJceESatMJcvEzX09a8HXjoPjqPKiBsd18NhzK4gm2r
        2+uzRdD2yimBx64kAzOPH7fDRV7FlTs=
X-Google-Smtp-Source: AHgI3IaQlXoSSulsajnGVKl10qQkalJpD1Qi8lIBHQbkb8vfhfKRDbAgR/lxz3AOyquYSJawk22Btg==
X-Received: by 2002:a5d:870b:: with SMTP id u11mr23187205iom.168.1549034660909;
        Fri, 01 Feb 2019 07:24:20 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t6sm3388898ioc.87.2019.02.01.07.24.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:24:19 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/18] fs: add an iopoll method to struct file_operations
Date:   Fri,  1 Feb 2019 08:23:57 -0700
Message-Id: <20190201152414.23296-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201152414.23296-1-axboe@kernel.dk>
References: <20190201152414.23296-1-axboe@kernel.dk>
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

