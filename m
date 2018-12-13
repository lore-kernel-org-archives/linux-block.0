Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57568C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2670820851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="K29xAmUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2670820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbeLMR44 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:56:56 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40546 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729322AbeLMR4z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 12:56:55 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so5168084ita.5
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 09:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uEeDBkOwPid70UEg8pUacK6i7pi0+OoFq4mtLStZsZw=;
        b=K29xAmUeGIFAKrkzOvkZyXu6KCp4r3uo1oeRZsHIVMq9eeMJ2hrnF8GbnAh+KlstGw
         q9wzTzLOEGcCdcjjBHPDg/5+Lf75D0etSXl1T8p2pbihXw2FyRlJx4wqTaIsog0pgWBh
         zPgB2S/sF2tvU83g8AR1xYItuA2i6j4//AapPisDOZqqhYpFipJpGWDDIpdMqRkJjpwm
         LTYNN5+YvypcpcU4qUNDwxEVS/1PbSCReFqeJi0TQWxLkiwo6pxtSOsOJg+IPyMc4Ryh
         gP60lnMslQm6O81mXHPp4ih6pATqjlBrped6j5Ja9wM+uq4HUccjCtrU/PwS36rDz6Ew
         4txQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uEeDBkOwPid70UEg8pUacK6i7pi0+OoFq4mtLStZsZw=;
        b=GKn3mI2/8FvVFGXXlSuyRhnM2kMHykbMuKnIOCSE/GUjhHEUDPB44pSvSVBUFVv4xD
         d93kGfPKDpamp8ghp7/u+BMpQveWanCUmAVt3O8CIprH8EkCG8kkYhB5ZpkqmI7RoyXK
         3gGLZjIVoK5A90ws4HaWx6qjCM36D4CBiw97cRuehwIQyBlb2wtDBKqz6WIvxRC2G+XF
         J5+HO6IHkBJ4P6Sxvm6tuK4ZX3uH+9yV8GVqpqB+2IrYujCBbsachhY9faPUq7NrcMXZ
         BCcdH8c7D5HBG+DaZbh0ESxbQ/uAjyIU9094fPQfwLGpnIAT0LYkW2J+70I/UJsQ8AfI
         OSeQ==
X-Gm-Message-State: AA+aEWbjNftInARoEQZm3OHfsH8r84BQPZS6XqK+CXy/t0LirFT21RcC
        7+zYPHJoNWgmQnat2+YNEMUuhrxin5eCqQ==
X-Google-Smtp-Source: AFSGD/U7LG99CXnwN0oPfZJ5ILG0l3zs48UMyEUlQaMGw2AAX6bBWmNddFdHpo2gLpsU3cjh3CO+Eg==
X-Received: by 2002:a02:7a58:: with SMTP id z24mr24489660jad.22.1544723813975;
        Thu, 13 Dec 2018 09:56:53 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k6sm1022261ios.69.2018.12.13.09.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:56:53 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/26] fs: add an iopoll method to struct file_operations
Date:   Thu, 13 Dec 2018 10:56:20 -0700
Message-Id: <20181213175645.22181-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213175645.22181-1-axboe@kernel.dk>
References: <20181213175645.22181-1-axboe@kernel.dk>
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

