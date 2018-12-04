Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69271C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F679206B6
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WM3qER6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F679206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbeLDXhl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:37:41 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42820 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbeLDXhk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 18:37:40 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so8091184pga.9
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 15:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uEeDBkOwPid70UEg8pUacK6i7pi0+OoFq4mtLStZsZw=;
        b=WM3qER6gZnamoCqOraZo0+l/uvpyWdqQYR1qkX5U0690qlTReyDJakw8A5TbrEFC91
         9/2ZTF4qa9uRzE++BvFLqq7CxV6N5n9pEj8Y3YOZwtF4D+xhTNHP1TzeyUR+Oi97HGeJ
         8zMWRhu+ulbnfqDvMO9dKy312MROBSOsbD7RxE+8hqBbCXMdScsupIThwZe2PLiRfTAy
         r6SShf0ONo/VuFRTWzy+nUxTFkzpaDEVOpTUb90Y0Lp2clvy2trniwPSaChQGfg8rykk
         McN29ee3Vv6rcZfx6h14HGJGbHwkQeydr0cFsrcZRDM1ZMiPxUwnSZhGFOuXSxXXqs3s
         IN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uEeDBkOwPid70UEg8pUacK6i7pi0+OoFq4mtLStZsZw=;
        b=F0A0pkx3Eov/tzMKn3R8jB4DjiaiBpJjdd5Rp7pdf17m2mi6bjhFQ2ma+sR0xEM7om
         vo5aAkDKeZ7CWS7Iez53W6m1kyK5RJBOf0F3B/K+XDxCdyvErdsu9bXp8vO+NUE7Ijbq
         31Q8GRqwwo8mvAqYQLBfrmC/ppkv/e6+eI/pj3EeXxJtXtzJ4hqsz9CBmaIrjRtNiuDl
         Liwac+YR1O4rGS6dYPwaVT210St92eR4/fnjknqj3MOi12jEwU8kvxM7Qbdool9LruGB
         a43Eze9kP/TVUlIm6BYSzKUVLNUaDYkfwwo/HUGgcsKL3VLXCPj1fYGtdtZbJF8tpI+C
         77zw==
X-Gm-Message-State: AA+aEWbM5iXu1X/GBulgyCe6AuLH9baLpVpgx/afyrm+FVsWCydvrgSK
        VvJuF3gWzYadMwoLHTUap3kRE0o7+B8=
X-Google-Smtp-Source: AFSGD/X9dy6/YWg2RzhNc3aa1H+mjufewC9ndul5KGodYelxHwnfEYTEkn1ww/+Q93mf2xedOtMbKw==
X-Received: by 2002:a62:a99:: with SMTP id 25mr21771482pfk.121.1543966659124;
        Tue, 04 Dec 2018 15:37:39 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t13sm22527635pgr.42.2018.12.04.15.37.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 15:37:38 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/26] fs: add an iopoll method to struct file_operations
Date:   Tue,  4 Dec 2018 16:37:04 -0700
Message-Id: <20181204233729.26776-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204233729.26776-1-axboe@kernel.dk>
References: <20181204233729.26776-1-axboe@kernel.dk>
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

