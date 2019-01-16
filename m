Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762BEC43444
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 17:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496BC2082F
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 17:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JAjYdqRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfAPRuO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:50:14 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:35357 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbfAPRuO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 12:50:14 -0500
Received: by mail-io1-f66.google.com with SMTP id f4so5607638ion.2
        for <linux-block@vger.kernel.org>; Wed, 16 Jan 2019 09:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AAKxls5Es8ExKqpwMiUOBUcGduRQU3BNIbRWpRo7VtQ=;
        b=JAjYdqRpFCWSALrrMNGoaq4Q6g1wZltZ+wP7rIrj8GJnPvz1ZIH112d/Is7kTVeFZi
         rBg2KZFToJCKtuvT0w+zv+/8hBxNpZMDC19u6Bpy7VC/tg7ZLn8+RiXceBsucKMXKulz
         dVVFLn6XacmgRpRxcsH59uYTeRn0eK0x1b8cAwAvPGZDf3aVlF5enIZ45rUixTF5SXRn
         ly9VzimSKbCGr31OgNjW7asySBgszrwMO20EqSQZ5cWFq5ffZeKhnrjbYL9SxWzvDyMe
         I7igqcaPyHcwnohegEqV3ue5PQBBsK1vLEZgDy/mVD7NlpYJqEBtwsmCsaUnTtXYq6ii
         zALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AAKxls5Es8ExKqpwMiUOBUcGduRQU3BNIbRWpRo7VtQ=;
        b=jpkoWk5XwJu9lgL8MoVhr+eiXDnsu2xRssYMfhc1fHGPk0eq5s165bdLaDFyPD66FI
         IMV6Tsr+hUdkPYpMYI+X4Q5r0dzkcdQ0ykU77+rrMi4WMnZGrkWZCEQAJIfGLiMm8jIG
         KVQdng7rSjTUGFqKOfuFnVJXEQJ1R4Dlk2DmH0Ib2JNOWwiW8Mz/2s5ue4fstgtsDd/F
         gtI3Rglvin/NAzrwv28Ox/N/R+RLlOLwLGSietJc5VVOJa4X2llUhG5BxNEAX8Z9fWtN
         rfSJCihf/wyHHT5faL6i5hmkWAqBdeeEenbIDhY/cgVSWluE3THp6nTETxpHLakUZWpu
         mSZA==
X-Gm-Message-State: AJcUukfDmIwh41QaHm8xJnJ96h7lxjpMJ0YYQ4vXOPefCoizy9W8vZXb
        HohUSfCITbeqhS64lo33hIe9jw==
X-Google-Smtp-Source: ALg8bN7SaUv3pm0Mmji9ZYEsqX8JYxytaBbb+529Vo4M4SAlY1VFvslRQZa8Imy2FPYKoqNSjCKg4g==
X-Received: by 2002:a6b:b502:: with SMTP id e2mr5114023iof.43.1547661013181;
        Wed, 16 Jan 2019 09:50:13 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x128sm3705690itb.8.2019.01.16.09.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 09:50:12 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/15] fs: add an iopoll method to struct file_operations
Date:   Wed, 16 Jan 2019 10:49:49 -0700
Message-Id: <20190116175003.17880-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190116175003.17880-1-axboe@kernel.dk>
References: <20190116175003.17880-1-axboe@kernel.dk>
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

