Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774AEC169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 17:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F072146E
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 17:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="T/2Vfyze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfBHRel (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:34:41 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36557 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfBHRel (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 12:34:41 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so10857054itj.1
        for <linux-block@vger.kernel.org>; Fri, 08 Feb 2019 09:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FBZUThjVgqlafR/VslkU6xBWVbQBqldD6jr0wVQhMXM=;
        b=T/2VfyzezUkUT1XKLMk3FA8NicLQsSQcupgK9kATOpDKbLaExL8NqjfmrHVKTEULa6
         9SNoMI1oBtOuLzCYjmK1ZWJJ678W7zJx/NHzLanV8X/Ex/L9CPxylkls9nm8BTGI3UW/
         AWIfKOcuSneFteo6wNvVWb4P669ekaKtHvu2Ayn7O2TcVvsxqpsrfhU5q/XVK1JdwWtD
         R1PLwYWPxgxgEwS317Khf2+MCeFHiyK7tk5eYLOVZI3+YuqzMcU8jcWCaqof/96C5/E4
         lZuLYKQNo/4kytA36PdWitk1vDPmgCdOTpeO2qCVaf8ZAPig9ZypT2iVrShdxWJihyRz
         q1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FBZUThjVgqlafR/VslkU6xBWVbQBqldD6jr0wVQhMXM=;
        b=fxtITzJttqLRydYT3ZmIhLHJLlIn5AgDOu4L2SO8UWOwYrcrLTU5GTYpgyL4nLfVqO
         rGyvyckF0L8+uzd3K7aXoyZTns1il6rHi7czA5ALj26nmjGxyE0Z8GNpzmIUJUjvSQJf
         V+4xUTcErdnwq5SkmDdLqSKoYruwkkGm+0xznwHGz6CjXS6oqBvOk9+BZvczbOTaponb
         A80HYCbTqNdjhsDH0mrcz78fuizmSTWLljKtTiD/AoSEzI+7Ew2LexDMrhcAFzwTu1YN
         4KuvVlqvZF1ZcNe/Y6iWNX4PxFXKKWAD4aA+XXvLk4s6CQLz0mNvbZVBF8ZUhWyDs50p
         WuuQ==
X-Gm-Message-State: AHQUAuYXsDr0cmGWG4c/S9yMQpgRWzbbvW5kEoOU+SaYm6ymk3kE8lqk
        WnwDOSVuqR2yFEHqMEWjuSxNzg==
X-Google-Smtp-Source: AHgI3IYXR147umZZ5eD2vVfTVLCaGiOaEPwCGtRT3PId75Wwv8i2/JsjKLwR6exjeN6Ehmva5QDiuQ==
X-Received: by 2002:a24:bd48:: with SMTP id x69mr8357291ite.81.1549647280519;
        Fri, 08 Feb 2019 09:34:40 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f142sm1522627itc.15.2019.02.08.09.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:34:39 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/19] block: add bio_set_polled() helper
Date:   Fri,  8 Feb 2019 10:34:07 -0700
Message-Id: <20190208173423.27014-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190208173423.27014-1-axboe@kernel.dk>
References: <20190208173423.27014-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For the upcoming async polled IO, we can't sleep allocating requests.
If we do, then we introduce a deadlock where the submitter already
has async polled IO in-flight, but can't wait for them to complete
since polled requests must be active found and reaped.

Utilize the helper in the blockdev DIRECT_IO code.

Reviewed-by: Christoph Hellwig <hch@lst.de>
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

