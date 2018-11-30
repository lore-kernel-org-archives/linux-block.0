Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7DCC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62FE2145D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="f5taqLSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62FE2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeLAEGw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:06:52 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38332 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbeLAEGv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:06:51 -0500
Received: by mail-io1-f67.google.com with SMTP id l14so5080001ioj.5
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uEeDBkOwPid70UEg8pUacK6i7pi0+OoFq4mtLStZsZw=;
        b=f5taqLSyd9amqf+/notpD8cM/uAHKrvFZ1+1t1oNMkXdH/u6ERvkkIhUfui86QDSVB
         RhlMR4NqYDIZyLECu/iRSKGPc0JTvyHkmrSR3afNRb5g2kJSadGl01Db/HrSJmy7UYnf
         +ovSEBBjmj9PUNDHtG/mrFTADwbXMvCtdN7vODRqi9/O7iz4LvaxTlNbUnvwmvZnlac2
         pdauQFUFS70yBqHA84CfMKNhyNdThAaz2M0ZnW0kztaku0z1Nfv2OUsxX6j5VCOQU7t5
         5wtJXdI8d/OwSLLdQ1mVMFtLURn6RS4ETyHuJLwZWCzYlzAsEb9z9QeXEIeYenvlp4K6
         55Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uEeDBkOwPid70UEg8pUacK6i7pi0+OoFq4mtLStZsZw=;
        b=L05LJqbq+Qgd7BvcMl+a42HPjZ9OogaLorzGOwldsybSuHOdJtmRbABocCYDHcXRrI
         qlB6IWrBE6oOg/u60Z4L8D3E5HfdT396afNGobqUNIOz8ZK4vAkJ75EkVk2jq0KfnxsZ
         ype+ysWjtelDP7domv7JmEKDXAZ2JITWhIkK23WS+AEVzVVtROPGVHexvl5B9LN/3go/
         VQ65HRapg2fX+xIZTruyVwn73uRjRh6f60o1qmil0lTpaDi16uZpvzT8tyIzCPu3HoSU
         juXUJqEjlic23kOCjBKN9deCX61lMaDVCbc9MTfeS7uQFVaC+ZHN94SaxJ95HQJBkMvn
         gJ0Q==
X-Gm-Message-State: AA+aEWaLspJ4+HHOj328NojJfkTtt94sxCqsIAg0fV4QrIBVmI66fsW4
        964KK7DNIGz0jYLK6q9sxVbCQTP1a08=
X-Google-Smtp-Source: AFSGD/VCaBbQ1iMBZWcXa71Z3wKiswhL1TGQNN8LHLMVoyyOS6f1Q69UGtAsdgT7gTPk8FWpQmuHzQ==
X-Received: by 2002:a6b:9207:: with SMTP id u7mr5321601iod.286.1543597015179;
        Fri, 30 Nov 2018 08:56:55 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:56:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/27] fs: add an iopoll method to struct file_operations
Date:   Fri, 30 Nov 2018 09:56:22 -0700
Message-Id: <20181130165646.27341-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130165646.27341-1-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
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

