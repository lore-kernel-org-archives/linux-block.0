Return-Path: <SRS0=tPwK=PU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8252C43444
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967A42086C
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gpSSOGxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfALVaW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:30:22 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35193 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfALVaW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Jan 2019 16:30:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so7810813pgs.2
        for <linux-block@vger.kernel.org>; Sat, 12 Jan 2019 13:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AAKxls5Es8ExKqpwMiUOBUcGduRQU3BNIbRWpRo7VtQ=;
        b=gpSSOGxgIEn2qmUpaDMDasAgpRZt4HpFc3bEmUg4SbTxyEiA6gi4La+rYe7a7YU0k/
         kwcccd8qW08Qk2crkbTmg2KZ5CkHBauOOrcq/sKnXfyYirD/lNc1wGVnJUH2slUlVTMg
         Siz0nZpfdNwOH2J3jaPBvIGPKXFPRKX2yyj9pS7qoa4qWjOZaU69oPqFs/y9KuJE/lkE
         XlcxJxHN6woxZU4k0nJ+YzfVc3ZuKuAVNqVNQzmkKJ2PYuRX06haNxGuB80Rzk/v5zOF
         KUk9479hFx3yvqk2iYQ8/dwy0/7IMYjNGDsIcfoHDjqyhISscigI3AST9Zz6Y7v1LbaY
         Cafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AAKxls5Es8ExKqpwMiUOBUcGduRQU3BNIbRWpRo7VtQ=;
        b=RDte+1BxCvFs3rzYmzHar1FqNxmCOC+AbiQmFRoTAxNK/U8n44N0ILh8QyxAqeXWqT
         kPr3wP+lmq1tZJyVev0HY/LZglhdVKe2DN5Q2ahpLR3qqKV1aCp/tRVjTPHoQPhy9wSM
         US++VAYyochrUUeISZZ13uuT+DT/xpmI82Qo9Uges7ZrRsnjqXrJ/jPFudY8qmmITFkT
         kTLQ9PD2Cl8DZxsVAVTuXwYYnqUWEB8syOBq5psfQhzoe+3qU7Xr8Ue8gltq5lrxzIBf
         k9Ep+632uyjZx+cTMDMxL9xbMEVIOsXd7VK9gX8QXoGk/PPdKm2W0ExdwAH66jv6gLnr
         6/sQ==
X-Gm-Message-State: AJcUukfg2WWubQISfQ0orBJGLFUuAEiUvztanAO6ZhZpU3m0hRZUZrUV
        tgIrJSwbyDcbOr18zCFUHgimUQ==
X-Google-Smtp-Source: ALg8bN50vz8qqguarHVsPWJG2FG95KrCg0wsoXqCkboquEDqWmxk1qNETLttB5B5Fh8jwvjKq7v0Rg==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr15655759pgh.265.1547328621707;
        Sat, 12 Jan 2019 13:30:21 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y6sm151629818pfd.104.2019.01.12.13.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 13:30:20 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/16] fs: add an iopoll method to struct file_operations
Date:   Sat, 12 Jan 2019 14:29:56 -0700
Message-Id: <20190112213011.1439-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190112213011.1439-1-axboe@kernel.dk>
References: <20190112213011.1439-1-axboe@kernel.dk>
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

