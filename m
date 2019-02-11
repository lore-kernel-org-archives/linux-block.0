Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B0CC169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 19:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A872229E
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 19:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fJPa5b3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733251AbfBKTA4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:00:56 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:34297 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732948AbfBKTA4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 14:00:56 -0500
Received: by mail-it1-f193.google.com with SMTP id x124so762876itd.1
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 11:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tT12zaPG5ttnRf843TjoHKrkkXLpnihT1wJ80AwYbNQ=;
        b=fJPa5b3Wex3mfZrEiYLFXWckjjgktFOVxPWIV7dfCmCz4DuMTRSPAeGUBj47ocABIh
         nDot96IeRYPtkq3uPf6eWzT3zhgIlmEmO8YoaeCcrl4dNO1aEUhTVzIP0M2/SDk7AoX4
         HrTkXeWJuftoWfKNBNFxwmlf2thvggwCAOiwF8p1ffFPQ2KgKKjDhrRhwN55Losz/uXS
         fu1QP8hpTrWoliQ47b+6VTeKthLIYGOJmBGTQsoxpvJoGXBqZhKiRZq6RJE+16sk/iWR
         SVZHPW7sQMlX+Ae+5IdevpfDzDU155hZyh1mJGPQ0XUpBU4KXAz9pYV9U5t9Y5LHBFbx
         y7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tT12zaPG5ttnRf843TjoHKrkkXLpnihT1wJ80AwYbNQ=;
        b=ZxVX6edkQJkN9ljc/l2UgBC4gQ9UlzApSTAp5IyYk1mkBxV1a1RwMWOB9NfE2R9AvJ
         arZfnBOPdLdvRece8sByApNNhTBN6qAgzG32ifqvZ653g9o+U2N+zDRP6NgWIB8t3/bP
         sJW9+6oXX+e1J+gDJ0nCFd5Abnc/Zfa2KOT6qaLy3b6vd26aIyilbNdeSxeW/zVxOtGO
         5A2atpNykbwunVe0QGJKE5b2vNlIuoS/BHfA0TbVokybLUmoAggg5CmRU1FusuoourlQ
         MHyilWujcFDWsDux0o9UVeAkzEcihInn0ZiRgF1vmOLnE1Nowux9qAvC3U8TFOpQUMZn
         jSmQ==
X-Gm-Message-State: AHQUAuaBZd6fqRM7vWlLPxezWax8saGkEYUHGZfza5E0P3yT0pdnjc99
        fq2QdRKtHPKGGz9TGBQwpijjQw==
X-Google-Smtp-Source: AHgI3IbyvS8WiHVoHQ//BskfXcqw3nbGfFtJhTkS+LX5caZcdAOkNmnhD+WlpiUbu2hf3aRY3yRk9A==
X-Received: by 2002:a24:54d0:: with SMTP id t199mr602912ita.57.1549911655567;
        Mon, 11 Feb 2019 11:00:55 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h184sm62446ith.41.2019.02.11.11.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:00:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/19] fs: add an iopoll method to struct file_operations
Date:   Mon, 11 Feb 2019 12:00:30 -0700
Message-Id: <20190211190049.7888-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211190049.7888-1-axboe@kernel.dk>
References: <20190211190049.7888-1-axboe@kernel.dk>
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

