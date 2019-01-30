Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AF1C282D7
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 23:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308232086C
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 23:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SUfofssT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbfA3XtK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:49:10 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55666 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfA3XtK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 18:49:10 -0500
Received: by mail-it1-f193.google.com with SMTP id m62so1118862ith.5
        for <linux-block@vger.kernel.org>; Wed, 30 Jan 2019 15:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FBZUThjVgqlafR/VslkU6xBWVbQBqldD6jr0wVQhMXM=;
        b=SUfofssT1cTKvEC3b9eVnv18JhqlJyNCDeIzPqHmXZBtU2Bfjf12gmiWLbtBKnII/B
         L/aHiOuVquwoqw/wt0WHrBmXO8Y+bM1DfW1CQ8A8wwlfSWqTHTZOu4pphUQ2Wg2lyA/a
         kBJmdhMPmXhInZBv/ZsBpcER9bsblhOlPPUHDRyo9FiCmDGhks8R18m2LFAGIw6Rb1Fm
         zbAv15MS/GSXozLOz9OcNJCZkTCtFk6fJ1xS2eHy8sdM8OLGy1VyQjqMETC1fluzcaPw
         p7Vg8302uBTA8nsWkHSGXFuSY4zg2KYQfWl7E1Hge+J0MXft9vxifLv20JfuvsmaNhGw
         nJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FBZUThjVgqlafR/VslkU6xBWVbQBqldD6jr0wVQhMXM=;
        b=rYzEhE1mRYuhShGTEMfGjJWYfWceVdnPq68gFUd49vKgN7SpQjGpIdGeSAM47OIgFB
         DoAHIQdOQMbev0CluxwWmMbdejXp3KdcS6AueNqzIw9ISx1WlcKLmBhHpoh8mJ+Klp4C
         3lTBiBmz7bqxHfZJgzwt9wCHvTCnPSM3iz7SqsRs1LjU2lIMiFyUQxYEu0yPH8SuYsL1
         Bh57S99bvazGFDzVn9iW7F0HRjMf3mEzl1za7IcOkV0eTlDTw1NLPjQGHMtKewe2kdUV
         o4BAgmMKPwJxEj6a4z8lER+BrPZ+yBhhMc0VLAzYMk1v4i2XNu1GT/Vk350YPRXILaKx
         Cg4A==
X-Gm-Message-State: AJcUukeE3e7nKzPWi5OtquOYh3LnMS1wjWcquJhxuHhwI1OznVRGTlTP
        xcWFpvvUf/5qN6NiRHwCOlj2YqkyIn4=
X-Google-Smtp-Source: ALg8bN7jvcYQR5u0Qu/9yDNjcnXG7D03mvIklirXUuE0P+dp2ahYQlyzHPNQ+hnZTvb7CCdON/LXmg==
X-Received: by 2002:a24:3555:: with SMTP id k82mr15960286ita.84.1548885349746;
        Wed, 30 Jan 2019 13:55:49 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 189sm1805081itw.33.2019.01.30.13.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 13:55:48 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/18] block: add bio_set_polled() helper
Date:   Wed, 30 Jan 2019 14:55:25 -0700
Message-Id: <20190130215540.20871-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190130215540.20871-1-axboe@kernel.dk>
References: <20190130215540.20871-1-axboe@kernel.dk>
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

