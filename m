Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3171EC282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30D821738
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tD+izKTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfA1Vft (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:35:49 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38299 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfA1Vft (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 16:35:49 -0500
Received: by mail-it1-f193.google.com with SMTP id z20so864146itc.3
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 13:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FY7i8A/t+ar+CVDsIpMVwrTPPHLhDb6dZzvnPNdG5Kc=;
        b=tD+izKTf/RvtHGxxpIPO06GijzUttam+cbly+QTFYVvyOYuUz+PE+B0TJlRrU4CUfb
         QBts6mHpfcCM0s6YQ1MaqQHg0eO+eki8OmoQLAaWMcPI8VG9YUKF4mt/t6stj4ceD+bz
         iS021fSmfx7jVYezMQQsUmj1lRWWhJNBorhLQ0sjKqVoshY5XpXIr4Wehfx6bi7xqrbn
         LBzuevZqSnyaEiWXyOXs6Rl9WRRg+beBWzJmBQ7MAyWWbJDdzy+ki1JGQyebk0sgDGZM
         Qlu9BCAH0QKR936oL22BjJL9vD4ydf8wm7p9ocjJSKs5hFtcifauRIaGuucLhLApN3oG
         i1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FY7i8A/t+ar+CVDsIpMVwrTPPHLhDb6dZzvnPNdG5Kc=;
        b=AxsvGHla5qCjN6BN/jnDzvSlve0aMhIqoHHlUjSP8ss7zmNKyAd/Cpbtsi54IepPkJ
         oOv9ecn98gUgQi1lAF483yBzwrlPle2ffwkLhilAJ3r96p+F7SV2xSJ9RHO103f/0Lpp
         E/FTvIFueZWVm3XMko/fTWRhd4Mc/D5ytE21IVzm/29xHz3fo+ynYI3UsHmsafG+3dIN
         7IWVKAhteX1VJIMfogbFFVi67re4WyGdw2ZwIG6cykbp4Qg9Uu0JRXozGOWOs5HFDZyC
         8RU67zCPLOUboIz5PDzNx744yNFrmTwEmYRT5PvKoRvax5Z2C40ZobZj36hIaxEp4dRS
         6KjQ==
X-Gm-Message-State: AJcUukfewXncvnMN6fIm3pOLSdGalxhy0XA6LYoiBnbjBLkcyja0TogM
        h+iZequgWE9FsQkGVTN6cOvQQQ==
X-Google-Smtp-Source: ALg8bN4R2/yKdZbaozBi6ZQUeEUR+1SeVmRFQZ9ErIHe0Bbfr6subtqEmVl5TlKf8TeetFUwS2Uqmw==
X-Received: by 2002:a24:88:: with SMTP id 130mr4401012ita.92.1548711346749;
        Mon, 28 Jan 2019 13:35:46 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u25sm13782077iob.23.2019.01.28.13.35.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 13:35:45 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/18] fs: add an iopoll method to struct file_operations
Date:   Mon, 28 Jan 2019 14:35:21 -0700
Message-Id: <20190128213538.13486-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128213538.13486-1-axboe@kernel.dk>
References: <20190128213538.13486-1-axboe@kernel.dk>
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

