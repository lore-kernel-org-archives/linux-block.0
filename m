Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315B1C282C0
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 15:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0248921855
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 15:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="W8fYjlmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfAWPfo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:35:44 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42546 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfAWPfo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 10:35:44 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so1343557plp.9
        for <linux-block@vger.kernel.org>; Wed, 23 Jan 2019 07:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AAKxls5Es8ExKqpwMiUOBUcGduRQU3BNIbRWpRo7VtQ=;
        b=W8fYjlmAap63dXhJL/NIfdg1UICeIQcibXB+Ya3X+dNvzkJ7I2Dc4zbnZhGJp/g0V6
         Nh+DWdA2MrqO/TFRcmmVYfUr377DyjwGF8xYT5Hg/CndrKW5ZWZfkYt93s7DIpXnHAba
         ZOHtQOIr1Rm+8V35Eh56pjLs/72Bz+NjOz/eviWnd8156qYT5UV5nzCUGhu1LOhUwguV
         8VkK8gUJ587KUh9lRS94ABra15+qHwEECPOpUQT/ZRcvOZKBhqU4wqJaLxXQGu2PcVfn
         PJ+P7PY+dTgj72o76h41eHJf6yYS1eWwofNyCl5f7kAWpCMjfGYdzTIzwX2q/TlHqBJL
         gwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AAKxls5Es8ExKqpwMiUOBUcGduRQU3BNIbRWpRo7VtQ=;
        b=kgNWRMCTjt7daEvhV3fmjYRTib5tX2oSCb90g5Ep7uPiCCiORBwdL68eXIZRqz1YYR
         RKcFYtTlAzwFInPtzLUy5v8sp9/tbTqmKAVQTSamNn30EBus/P87DfUY7Sll6ITL41an
         NIOfYjQFQwbUX2UE2llP9GRj49b4+j8DeWeCDmVbn/PZRdVgIkYoSNa2tHgF0//NKK8+
         e+K29bFW2o2LQXk5/5P6qvb6eY03HTkwvXJEx8GcDr4eNqarVLwh6vZz9rIaB34frXZ9
         j4apsoV5Tl7XsmGGspu9hsJY7WYoAbjf5+6A6t6291numgGYs+cqBPEiD1qfAEMxyetU
         W96g==
X-Gm-Message-State: AJcUukcxZgzA3lpqPtSCOU5nRizNzcevzR+zjSPty9BrTUrSLkw/gElT
        WbgRG0PEAYuMlj5jPw/vVhSnxw==
X-Google-Smtp-Source: ALg8bN7W1OD3h5dC2dDYAUwqgDJEvYg7lbbxzk7H291+n4oKzPzQfC/ahvZgaq8S1ZwcnbLnJOieHA==
X-Received: by 2002:a17:902:f20b:: with SMTP id gn11mr2556559plb.274.1548257743614;
        Wed, 23 Jan 2019 07:35:43 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm30731715pfl.16.2019.01.23.07.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 07:35:42 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/18] fs: add an iopoll method to struct file_operations
Date:   Wed, 23 Jan 2019 08:35:12 -0700
Message-Id: <20190123153536.7081-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190123153536.7081-1-axboe@kernel.dk>
References: <20190123153536.7081-1-axboe@kernel.dk>
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

