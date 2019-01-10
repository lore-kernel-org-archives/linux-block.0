Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9ADC43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 02:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F70421738
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 02:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="b2edNnYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfAJCoO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:44:14 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38325 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfAJCoO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 21:44:14 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so4498155plb.5
        for <linux-block@vger.kernel.org>; Wed, 09 Jan 2019 18:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AAKxls5Es8ExKqpwMiUOBUcGduRQU3BNIbRWpRo7VtQ=;
        b=b2edNnYjlsl680gPOpfYlqo5XIXIzCSlwmNZvS2LaXhvk6ac1CNQ8r19rGH+QpvvDk
         Z9usX5NTK5zGcBOfgAAf/VMzFMJo333xkEAefAF2FcYEiwF1vkn3IIB2vAn1CgOreXNu
         2pZbji+PceITVqfHGktvPayBrTxUN8ByxDY+xXW3w/TVzQpvbE5/qLYoyC2mV+5kW2U/
         WKnckaYo/42y080vdTaD98xCJ7OrRPynaj9DEGjWea0nsLBCOKyrt3a3Cc0F++OfgQ46
         n8+9VGRGSQhRQEKeDXo7WZRepse+Q+mlDqqIQU7rnP2w+kK/2dpSrsDox4zjqHn9dkFp
         HxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AAKxls5Es8ExKqpwMiUOBUcGduRQU3BNIbRWpRo7VtQ=;
        b=krm1p/4fYicxMCO1YmK7o1YBAT2X8A9F1QPRpkydhH6HmYL1kAN4Iddgs7d6c3H5XF
         YsSGzSJyVhVXKXpqaIGB0Ebh+MvLI5gSz2QDBcVwQJeSrx7qOHbN6JiE5mEKrt7S1uXv
         tJDxSGP7Bn7iBQRgBIKtrA8Px4Yc83Emyfhah15Bo1QGxv2YEyCjg0e8VpOZVlZ5btni
         EIqQQF/9F9HAwdjGywLrfwYLz7SuGHQk+M33fCTo4tyyyniDPvHqflkcW8OhQ+xIcGQk
         lbXNKgbJRuP/P/6EF7HUNoQM//eEGwdz6nvEFAqTIVgqN+1wCk4MMx8gjzoEYRITRfSE
         IHUQ==
X-Gm-Message-State: AJcUukcqEl/rh9uB09jYyZGP7t5nsbLWSHYZZdHn+kjuhJw9k3mUQtLx
        hRNwKn3YrigAx8epX3s34DW5Eg==
X-Google-Smtp-Source: ALg8bN4hUWfOgmHd5yUtDTNs8hS/nuSP6iEcpd3u5gxOt0w7gNkNXBC4jyR3zql4Idj+B0DS0vZ7ww==
X-Received: by 2002:a17:902:7201:: with SMTP id ba1mr8546211plb.105.1547088253525;
        Wed, 09 Jan 2019 18:44:13 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v15sm105799631pfn.94.2019.01.09.18.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 18:44:12 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/15] fs: add an iopoll method to struct file_operations
Date:   Wed,  9 Jan 2019 19:43:50 -0700
Message-Id: <20190110024404.25372-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110024404.25372-1-axboe@kernel.dk>
References: <20190110024404.25372-1-axboe@kernel.dk>
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

