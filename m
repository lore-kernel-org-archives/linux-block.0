Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2D8C43387
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E0C21929
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tySEbfnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391589AbeLUTWn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:22:43 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40749 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389636AbeLUTWm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Dec 2018 14:22:42 -0500
Received: by mail-it1-f194.google.com with SMTP id h193so8015214ita.5
        for <linux-block@vger.kernel.org>; Fri, 21 Dec 2018 11:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uEeDBkOwPid70UEg8pUacK6i7pi0+OoFq4mtLStZsZw=;
        b=tySEbfnxeDT4jme6deLJgvCeMaG1i9PJApHLbiEG4gGqOiXk3k0/XUsZgXEehDuIsj
         Ue/rNeN1mHnEfc0v84ggjwczB+wRqgbKsKxQ/SeKSPvIJpurSWXqUgNgTPN/Cs8CWri1
         N/7qE6WM8Ix37s/x4LG07rmiKKkJib57hqi680VSYgQETLw+nRd9qyudbm/JCDPjF3lo
         /d93g6SGI2U+BIwQ8+XWFL0OXD/7rgwO2zeFFKItm+qxJrBwByP0RVi6L8r1DVVmfPUJ
         mAjs5VceX/raYdh003WaTnt/W/cxvKRUfjGQmch0YvMf5MrCyYBjvfp43mjIyt7bW+l5
         Jicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uEeDBkOwPid70UEg8pUacK6i7pi0+OoFq4mtLStZsZw=;
        b=WGvA3Jpc3zbY5zCc/c2g1mEBFDH8vQ9TnMbrQpluQDjCVKy4xWudY30DtnXeXwrIPI
         dqI9cBLnHoKq/BS+KtupG+3yC8xubcCWobDakI5QN6V7bI+silzg/yLaCuY2RxXtHmoF
         gexlbR2PX9VxvZBnZZOjv0QuVaqLLAJWeuI5pWd0B7Nf7hYMD7qz5cTRedESNXn6Rlcc
         68rpDErX+PHGMFOdtC8ZzTIzYHPh60wEMOmCxPsjnbTPXbCpnZugs38mhwBM2Ht6s+LZ
         EFu5biPT5zEz2MicnUlDRkLAp8bmCEozlimkAWOLKyux9XrGpRLK9KdOgjkobJeSBEH/
         zHaw==
X-Gm-Message-State: AA+aEWayzWe/mAv10ureZ8y3xV1qTAGI3tDGT/J2iIuoi/t00lHUOdsW
        0YmU7IgyO3IGHtfXP+AgkDs7xA==
X-Google-Smtp-Source: AFSGD/Va0w7h33mplE28CDX3MwS7ZDvNothVRbUpzhHewDvjc2j6R4O6QrPbOF1mh5Exua/7V4THCw==
X-Received: by 2002:a02:9549:: with SMTP id y67mr2465234jah.4.1545420161456;
        Fri, 21 Dec 2018 11:22:41 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t1sm12456290iol.85.2018.12.21.11.22.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:22:40 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/22] fs: add an iopoll method to struct file_operations
Date:   Fri, 21 Dec 2018 12:22:15 -0700
Message-Id: <20181221192236.12866-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221192236.12866-1-axboe@kernel.dk>
References: <20181221192236.12866-1-axboe@kernel.dk>
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

