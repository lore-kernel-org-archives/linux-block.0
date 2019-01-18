Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCFCC43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 16:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B5C20850
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 16:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="C9dElZo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfARQMh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:12:37 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33150 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfARQMg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 11:12:36 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so6279521pgu.0
        for <linux-block@vger.kernel.org>; Fri, 18 Jan 2019 08:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AAKxls5Es8ExKqpwMiUOBUcGduRQU3BNIbRWpRo7VtQ=;
        b=C9dElZo20Bxj0ZgMYG03l1rKb3R8/CuRHGH9nKq+ZlP0I6+4uXo5e/Uy7PYaL6Y7gR
         8TIL8HgENThSnskWojwhmf/m+6Zln+R3GypmKVeAPegPqk6+DyseZ99hEMynMKnH1Hat
         hIUHKHHmJ/92OeeqeHdGb4H0YQ+d2qJg3m6p8Fu6eGK8cFBFAAATEKbi9GlUNIZb+LSd
         vYdWLNeqo1r2tHOKy+DQxbvbdSuBXrbuPjvLMcSv9YVc2DY+I0KssPTzWFYtspEw2xZu
         9hJthWnPNfxyyV7KsTscqjsxeG8M03rnoJ+3ErP8dKKDDLMmxiI4TEZY6cLasMTg87n3
         hwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AAKxls5Es8ExKqpwMiUOBUcGduRQU3BNIbRWpRo7VtQ=;
        b=BfofQwv6ZL7DatFiU2Me5hQULY66JMkMrEE9tgh3+t+67uiFnu1GDNrHcz1RjYuDYc
         G9pOZ9aHCVspreKzKzRuotJpPprY2fbiuQ3fMNdBxYXNpM7mkXA5xuOeZZ0gfYyRkJ/X
         InryniL9Ge/TnIxaE255rCsdm+/W3dduC+nTahvF30MHSU3dJPibdc7feVWVKg2ZGSL1
         qYOf5Y81oYDB8PKu6oK2TUr5JdiBH88fxa0zkwq6TLbSNXCvXEgOFmV3kirkzCPAyuqW
         Bz6+hUD687b2mEp7amjGJBUQULbQXNDEE0/SEyxY2lhWfDm3MjQMAZNLSJrQsoWcGz2w
         yAxg==
X-Gm-Message-State: AJcUukeS+SVbt+A6mTNF2gPRdJOANzAKJwWqq0V1mZ6C5Y7iS1TmnALC
        m8ZEHknpfz2wUyWY70x5pTKdvg==
X-Google-Smtp-Source: ALg8bN4x0Onz1U8hCv8wS7z6Taa1bDSDrgvlHIwvmxWcJBQvsZ9Ne9kqKSuP+La7r81bsgy+D0N2qw==
X-Received: by 2002:a63:5ec6:: with SMTP id s189mr17525861pgb.357.1547827955403;
        Fri, 18 Jan 2019 08:12:35 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m20sm5317804pgv.93.2019.01.18.08.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 08:12:34 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/17] fs: add an iopoll method to struct file_operations
Date:   Fri, 18 Jan 2019 09:12:09 -0700
Message-Id: <20190118161225.4545-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190118161225.4545-1-axboe@kernel.dk>
References: <20190118161225.4545-1-axboe@kernel.dk>
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

