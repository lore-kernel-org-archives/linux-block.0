Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AA8C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9D020659
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="w/SNo+dM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9D020659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbeK0Dke (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:40:34 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:34672 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbeK0Dkd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:40:33 -0500
Received: by mail-it1-f193.google.com with SMTP id x124so24405315itd.1
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2auvEeZY6eQcIorX3a41A16F0lYlc9wyO+6UPHFanyg=;
        b=w/SNo+dMYxjWJHZ1zwoKIzE2g4TUUNz4RIMN31QgV0av0LR6idhPATbySxGRI/GCdF
         UNLMDXYVwfE6CgFjORlV7kmVtSBaWChfo2yD5cfsoyqCFgDX7iuuVSz2B+yx4WkhtxSX
         n04FQszoOxo9m1Wqh8TFuFauIu3gkykriE2QkqC7BaMQvd7RZg8v/8ZEZQjXXjNeJjVj
         3C8OdrZePp96fzLBtbbMKZti9ybCWUm9jpXFLmAm8PtD4hB2BB4L6U6wSvxoXk5SXer5
         +3ncmVBsi9eWx4ZQFBbxZP2pg0ZyNMbDDo7HjQSBew2yjPJROGDLRX2fcXFaoGpYrn2b
         ouBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2auvEeZY6eQcIorX3a41A16F0lYlc9wyO+6UPHFanyg=;
        b=jSEdb5hcOc2JdmatEHcrK99nVQaO5DR55o/GkwtBpDtiN/d24kj5wyj4iWzlCGMIFR
         Vpebs3RRnL+QLdIyyeFCJYbVEP+7MJ9WEWx9hirSfGst5WQlMaOfTg6NFJIwuYmJacNF
         /n1MooOO9Wtkq5slJpisXAZ4mRW/Zo4AcGhIi8R9gvp8AOLeiSJlogL+dedhxlEaeF9s
         bUSmnwDm5eiNnhD3bPNPY0KRfb6QlEwiuh6wqMeEQ9vKa+F/+Kfo01GUFq1SbgNuLjxn
         63fe1yO+sGYCO2z8Ed99VK73Wlpqlwgxg5VG68CYs99vlsl6LzAt0un8MUAlPbO18DYI
         y7GA==
X-Gm-Message-State: AA+aEWYmIQ3hKnvxjvRj5cb3tQZb595qnzmmhtfkUnqQ5jXFS3QBxNK5
        I7AwBe1MeYPzUfodoIAphI+EWwD85g8=
X-Google-Smtp-Source: AFSGD/U8icyOsqlt7qbnnKpgZLt1jeRy1Nmfvp72LILDfeBOCPEH8yjdod0uOLxbL5XwZLep/qTtqg==
X-Received: by 2002:a24:c40b:: with SMTP id v11mr1249763itf.73.1543250754148;
        Mon, 26 Nov 2018 08:45:54 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t65-v6sm486801ita.9.2018.11.26.08.45.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:45:53 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/20] fs: add an iopoll method to struct file_operations
Date:   Mon, 26 Nov 2018 09:45:27 -0700
Message-Id: <20181126164544.5699-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181126164544.5699-1-axboe@kernel.dk>
References: <20181126164544.5699-1-axboe@kernel.dk>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 Documentation/filesystems/vfs.txt | 3 +++
 include/linux/fs.h                | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index 5f71a252e2e0..d9dc5e4d82b9 100644
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
index a1ab233e6469..6a5f71f8ae06 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -310,6 +310,7 @@ struct kiocb {
 	int			ki_flags;
 	u16			ki_hint;
 	u16			ki_ioprio; /* See linux/ioprio.h */
+	unsigned int		ki_cookie; /* for ->iopoll */
 } __randomize_layout;
 
 static inline bool is_sync_kiocb(struct kiocb *kiocb)
@@ -1781,6 +1782,7 @@ struct file_operations {
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
 	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
+	int (*iopoll)(struct kiocb *kiocb, bool spin);
 	int (*iterate) (struct file *, struct dir_context *);
 	int (*iterate_shared) (struct file *, struct dir_context *);
 	__poll_t (*poll) (struct file *, struct poll_table_struct *);
-- 
2.17.1

