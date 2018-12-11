Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3820C04EB8
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9F62086D
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Lq7qeaFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9F62086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeLKAQB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:16:01 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46530 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbeLKAQA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 19:16:00 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so6013502ply.13
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 16:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uEeDBkOwPid70UEg8pUacK6i7pi0+OoFq4mtLStZsZw=;
        b=Lq7qeaFCpFyXlVMtW7yM6Vsj8ZETaJYbuLZxoJifsF0BsjdFCr3BJQbKIy9/E6B7RD
         SdGLRxNQZ7EimEu11CIYK4cvl0ozgq52fFnTchIdDeTZTtOJ2pdQjwFj20SDUyVkCj8c
         QdTsbrC5CibxGmHTliMp6Tx/LvgN8E8bxgyQZLla3h3O9Pwretg6bs2Q7nY66pwMbuj6
         JD2teF7tU9nhngX+rNY1T5ViTWiIpA1nQq42KyKWdktDzqZBS/QqWyZSTeqYHb5WO4qn
         ohy7acdfuSHlPgXZAZOARRXID0T5GaEer4VG4EDEfJ++x6wP9RCh4NmfJ2r62gjCMbzS
         V4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uEeDBkOwPid70UEg8pUacK6i7pi0+OoFq4mtLStZsZw=;
        b=M5Btd8VfSD6amjVHgAHgEYPy1xNdLJtBu+Ql5Gx7FdXW7IjmdP9wXIUu44OuWk0P02
         HI7SEJKVS0eowwGogZlKH1nd6ce+j6yyGJElp9bJUStzXG8kbkwRRCbR2bTgBc5fpzcb
         aaHSCPc0ZXg3mG7BgMn7VcYMvVONLm2dMsG5s+3cgkIXCLP2Qdoto+5ATgQ+BfpyCnG0
         NKHQ3eHuZ5vlEKqgJYmSEUAREozjedP1dZK/AWzmKA4ZTrmq1ryTbs2lxSw7SN9MS35z
         V2L/7K6fWfBeQK1ShvWWHPRptCgIGavMMcN7gpp+ph2PeI8UrfmicQtQru/bcKT7fSA9
         kDJQ==
X-Gm-Message-State: AA+aEWZ3g3g92eKPJrZTunrtAnLftS/1XMdZYToAWwLgQmnpGFTZhih0
        uIJDLc/p85ZTcxgfeqy8AjHMFzy4sOCufQ==
X-Google-Smtp-Source: AFSGD/VefVID8JlzG58AAeyltkYw4p/pWt/MxSZ6QHbBDi9nGTy6oU1/OmoLQBZwie1RlX/terIDOw==
X-Received: by 2002:a17:902:ba8b:: with SMTP id k11mr13870542pls.177.1544487359353;
        Mon, 10 Dec 2018 16:15:59 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm16872856pfl.16.2018.12.10.16.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:15:58 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/27] fs: add an iopoll method to struct file_operations
Date:   Mon, 10 Dec 2018 17:15:23 -0700
Message-Id: <20181211001549.30085-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211001549.30085-1-axboe@kernel.dk>
References: <20181211001549.30085-1-axboe@kernel.dk>
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

