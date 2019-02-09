Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154A1C282CB
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 21:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1D7218D2
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 21:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tLVDGdZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfBIVNy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 16:13:54 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41874 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfBIVNy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Feb 2019 16:13:54 -0500
Received: by mail-pg1-f195.google.com with SMTP id m1so3118135pgq.8
        for <linux-block@vger.kernel.org>; Sat, 09 Feb 2019 13:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tT12zaPG5ttnRf843TjoHKrkkXLpnihT1wJ80AwYbNQ=;
        b=tLVDGdZKVJuJEVjzwoe6ZmL2mRjwOQePcP1E41xshZcGRsZa243Js/8PJ3WRIAoqNe
         1QMNAzoqW2VQDFUC0yAVcddHvOClfalZcKki5s877cEbp8FzbLa87xn546hRGMttGgB3
         msDwXOMxOVpwenGfadlZt6ppBHCD041V1MdH1AYiNXieu/8PHpuObModSOf7TW+jVrrw
         fdDyNII7z/+nsGCPaWfVcuu+Wbt0paXce6dqnC950Nr2/46qSBo2j8SExCSUfybC/MJX
         h+WJHs++FvXiQk4EczMMSO1ZLGOVzjBg4eqJvEvK9vmYGwkiS/Y/xdNtuSq5rNsZ3f59
         91VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tT12zaPG5ttnRf843TjoHKrkkXLpnihT1wJ80AwYbNQ=;
        b=Sc4RBh9UQAPKEsmxfeONoRSwpP6W156RhGiPCHa1FSVD5UmtyWksoJVuumRPDS/tQW
         MhOgCaAV1WuYgL4oPN6woPHUxsZWdg6PkTX7Wyo9u0Nx/HB03rEAxX61+K10UowNsAPa
         YNX2yhH+eiHe1vbXFhm9+ZW/M1D3MHYPwZhAv1bnP0XerxWkC1qwpyGGEVN5olr4BI5y
         NQtXGu+e8sCjy28wyjz4AWxPzBHd8hhZ4s6jcBZxWWEy4K1W7FuSwa3RwZknVL5tTQCo
         LghUi4byhea1AKzo/yMR9+kbpEMiQnqkttzmsXlb1nHId2mYUMMy0+aKFzCmLOKrScUp
         nxvA==
X-Gm-Message-State: AHQUAubaYUVB8MogGfc6aIdvV/7eIkuwQR+YprLogpkoeYAD+g0O1Rhd
        WfBZpab0q6OYy1sjzJcyGQ5rxQ==
X-Google-Smtp-Source: AHgI3IYviB89KOsH/QesLMikD1zbCE5z+RQv8rehiRk+6HM3sDPsE357SOctzoxJ8Ujiyls2rOGWVw==
X-Received: by 2002:a63:f10c:: with SMTP id f12mr7405907pgi.374.1549746833831;
        Sat, 09 Feb 2019 13:13:53 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a17sm7004942pgm.26.2019.02.09.13.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 13:13:52 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/19] fs: add an iopoll method to struct file_operations
Date:   Sat,  9 Feb 2019 14:13:28 -0700
Message-Id: <20190209211346.26060-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209211346.26060-1-axboe@kernel.dk>
References: <20190209211346.26060-1-axboe@kernel.dk>
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

Reviewed-by: Hannes Reinecke <hare@suse.com>
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
index 29d8e2cfed0e..dedcc2e9265c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -310,6 +310,7 @@ struct kiocb {
 	int			ki_flags;
 	u16			ki_hint;
 	u16			ki_ioprio; /* See linux/ioprio.h */
+	unsigned int		ki_cookie; /* for ->iopoll */
 } __randomize_layout;
 
 static inline bool is_sync_kiocb(struct kiocb *kiocb)
@@ -1787,6 +1788,7 @@ struct file_operations {
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
 	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
+	int (*iopoll)(struct kiocb *kiocb, bool spin);
 	int (*iterate) (struct file *, struct dir_context *);
 	int (*iterate_shared) (struct file *, struct dir_context *);
 	__poll_t (*poll) (struct file *, struct poll_table_struct *);
-- 
2.17.1

