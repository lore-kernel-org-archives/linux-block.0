Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F05FC282C2
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 15:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5522184C
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 15:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sk06TBxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfAWPfs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:35:48 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45969 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfAWPfs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 10:35:48 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so1214408pgc.12
        for <linux-block@vger.kernel.org>; Wed, 23 Jan 2019 07:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oXSaLjvtWEpXD5M1aK3RP2qw9Q0jIOZ1RMvQl5ZkAok=;
        b=sk06TBxW4vhtLw5c88569/UYWN5jyx/uzN/b97RCn5oGMy48/jNsTl0JoGktFRt3QR
         6PJjH6aaWHhPWxeDPaGHHDuJhvdf9ph9qQPPuZCL0WMQPDHnzPlBeUjVxja+HVXQTVbX
         BzW1ZrUMIuYuwhuIhC0K1V+9hPwM62QTOu+uzFQZEdtv8yZZXW/M+idTsiYl7ll8WzDF
         3gl8tbnyB9gyX4eVluenW9ULIugH7Mw4b48bXINoZ4sckxGaR7a6pz9SzSh4UTdGz52c
         4F7vNYbuO9SIx8khgYWWPyP0TqKVPDntwOHpro7p2cD7tR97DTrbWySGdce6Z8nZWn+a
         9nVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oXSaLjvtWEpXD5M1aK3RP2qw9Q0jIOZ1RMvQl5ZkAok=;
        b=lSZDOfveekkXuaXoDQgw/6Lh91rmWwL4eRXglnoqFkuZBVb2RDEVqdctt93LgQ0aPU
         07cMlCOKUBP3qcPMFwh5Yb2phxNtl3r2gMMaoVH4q2xtAbn+tnmV+qF4oTkNC3CG4cFh
         du9n8FvJxqfjlXWRKeNlfDIAmQ6VjjdV7GY/p/4yk+ULlX92b3yrBZb2MBFtXee36sm/
         4HLZenBNIDwc0QxEuOOMdqi3L8EFGE2GJZBufXwf3Gdxwcbn6UM1OUocsNlTSvRFwZjq
         0hpR2huXkU5rjgWVtjWgAzrOCMePjZNTnI62BPT7sJYs8LMk0NlqMLQWHvHkEjrHUpeS
         1qvw==
X-Gm-Message-State: AJcUukcPlfyuy7qHC/4c12Zh7dNLoObjEYEErWNvRuq44fWrlnHFhExp
        7Dn9Zh1AKM2Jxf1kcE4FuxPYCw==
X-Google-Smtp-Source: ALg8bN5rFQGZzZx9gYna4WBMG7Lrd5baxNFkr7+RN49t0yvJdirH1B9jBFRJ4B9PTHiBto3YHJYGxg==
X-Received: by 2002:a62:5fc4:: with SMTP id t187mr2436064pfb.66.1548257747468;
        Wed, 23 Jan 2019 07:35:47 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm30731715pfl.16.2019.01.23.07.35.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 07:35:46 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/18] block: add bio_set_polled() helper
Date:   Wed, 23 Jan 2019 08:35:14 -0700
Message-Id: <20190123153536.7081-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190123153536.7081-1-axboe@kernel.dk>
References: <20190123153536.7081-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For the upcoming async polled IO, we can't sleep allocating requests.
If we do, then we introduce a deadlock where the submitter already
has async polled IO in-flight, but can't wait for them to complete
since polled requests must be active found and reaped.

Utilize the helper in the blockdev DIRECT_IO code.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c      |  4 ++--
 include/linux/bio.h | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index f18d076a2596..392e2bfb636f 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -247,7 +247,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 		task_io_account_write(ret);
 	}
 	if (iocb->ki_flags & IOCB_HIPRI)
-		bio.bi_opf |= REQ_HIPRI;
+		bio_set_polled(&bio, iocb);
 
 	qc = submit_bio(&bio);
 	for (;;) {
@@ -415,7 +415,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
 		if (!nr_pages) {
 			if (iocb->ki_flags & IOCB_HIPRI)
-				bio->bi_opf |= REQ_HIPRI;
+				bio_set_polled(bio, iocb);
 
 			qc = submit_bio(bio);
 			WRITE_ONCE(iocb->ki_cookie, qc);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 7380b094dcca..f6f0a2b3cbc8 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -823,5 +823,19 @@ static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
 
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
+/*
+ * Mark a bio as polled. Note that for async polled IO, the caller must
+ * expect -EWOULDBLOCK if we cannot allocate a request (or other resources).
+ * We cannot block waiting for requests on polled IO, as those completions
+ * must be found by the caller. This is different than IRQ driven IO, where
+ * it's safe to wait for IO to complete.
+ */
+static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
+{
+	bio->bi_opf |= REQ_HIPRI;
+	if (!is_sync_kiocb(kiocb))
+		bio->bi_opf |= REQ_NOWAIT;
+}
+
 #endif /* CONFIG_BLOCK */
 #endif /* __LINUX_BIO_H */
-- 
2.17.1

