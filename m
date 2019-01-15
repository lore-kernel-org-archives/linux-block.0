Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2412AC43444
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 02:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61B920656
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 02:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1n63Z3L+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfAOCzm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:55:42 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38160 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfAOCzk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 21:55:40 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so578565plb.5
        for <linux-block@vger.kernel.org>; Mon, 14 Jan 2019 18:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AAKxls5Es8ExKqpwMiUOBUcGduRQU3BNIbRWpRo7VtQ=;
        b=1n63Z3L+WalVM2JJ9cm201K70QNwbNg3PeLxo5EJqG5NdqlbFuqOa1rpvxCvT7/yBw
         eMMy3lsAXxnojDwAnawiv5RRyqSbz2pjMYsg74yAb9Lae8CLj4e6uPdGLiqG2ffM6rfQ
         Iyoima14bP+U467QDmYJh405CpfY8rstPd/tPFKjVs1EI852xVBL5QopDV+vZ0ie1L+Q
         iucJ5M/iZwc7bt/Z6huNhCZsfmriHJqjNGvBGHxvi5kA0iIQmKDAc1XEsUPvGh7294EQ
         3KioslnwrO3y1Tu2vnaXRlGK2QCle9SXcw7anPv97Anw5hzttB5VJAEkWNWYcr+gNw+O
         3M3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AAKxls5Es8ExKqpwMiUOBUcGduRQU3BNIbRWpRo7VtQ=;
        b=XDd6PagumBhUJkSiLyTrd0A7e5HzxDZ4tsV3g7Euu8EO7zHn9xmBb1tzPbbM0DkUje
         nkAhopxDgtqxaVGmftnuurXW6qfOPn34HoCLhYMAzDBzCa/Hx0HhV895+FlSdJAaBXLd
         FXLsFT3TxbUPnB/zYyvDHVyhmzdxiisXU/Xi3FCvKqzBOhVvphEGbuUQ4AxXMgrYmaV8
         1EkdguhGwciXMDl9M621vaHbSQ7OrKYiAgAdgEZ6ECghlSM0oXw/RIpve4VGcM5yyHMm
         EDKArt0ogkaUBqe5RAydTCdirriIEhV/0QA1PyeXOJsSBHz1t6V7DUMZog/Sg2Ft8882
         GC7g==
X-Gm-Message-State: AJcUukdN7v58OfZ6eLqqVC6/oWihOhhW0jv6T+ptm03DuUgbmpa8dPVB
        4Ep2rooJs7kq2WRCtUKPn5qXXw2brRuLrw==
X-Google-Smtp-Source: ALg8bN6Rcmuhxb+AObX2pINyJgEJOy3fJECMqIeiqavnx5uwO8Hh1L28VW5+sddCJDOaWUnwYaxkFA==
X-Received: by 2002:a17:902:6b0c:: with SMTP id o12mr1743172plk.291.1547520939331;
        Mon, 14 Jan 2019 18:55:39 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id c23sm2415544pfi.83.2019.01.14.18.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 18:55:38 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/16] fs: add an iopoll method to struct file_operations
Date:   Mon, 14 Jan 2019 19:55:16 -0700
Message-Id: <20190115025531.13985-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115025531.13985-1-axboe@kernel.dk>
References: <20190115025531.13985-1-axboe@kernel.dk>
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

