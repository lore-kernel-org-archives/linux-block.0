Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F8EC282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C42421872
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CbJ+5V72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfBGT4H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:56:07 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:34318 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfBGT4F (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 14:56:05 -0500
Received: by mail-it1-f193.google.com with SMTP id x124so6553228itd.1
        for <linux-block@vger.kernel.org>; Thu, 07 Feb 2019 11:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FBZUThjVgqlafR/VslkU6xBWVbQBqldD6jr0wVQhMXM=;
        b=CbJ+5V72kjc34QsLtPgRv2OcvWygok/Tnl/CMlQvwuca9fcdKTJGCR9CHOvLdaeJNk
         /nNO/3NcSZwaiKlqMiSxObO+w42oqAuBnjCxLWWqVhR2lBqan9dulz4Zkumo0WSD2DzE
         Po49AzTjmLvyTbCveO2Of7xTgKouU5viys11cL/XSFeGRE4dZrK3CjAUz+M+OKoq6UIn
         EGE1kI9VTuG5bH/vJ9FiJOi0neunCjWr+pkTwmkZRa7VDkHey992O4fuITnrxbH6cs4r
         2cw9rIPE5XYuqXNyh2GMUlLfohbVLx/lin2nPxKqrxcWO8q/BuOy02cB+7eB/WwOq2JX
         ap8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FBZUThjVgqlafR/VslkU6xBWVbQBqldD6jr0wVQhMXM=;
        b=Irdnx2/QUc4xdNyUjSQRagO09t1h0ytGdIyZ4bGNulvKxjEpWTa2gs9XN0J78o/LS5
         5mHm5Ft92gv5qTXuCdwV0pwMnZBumncZjBUaUZ6MUiOQxoqgUx0XdMZMdjZ+Zsxh+3kL
         N3I998pUxiXlC0MG+Gf+T+bh9O5A9y8shgH0w3SYvfZb4Xcd2VWza1BHFf4DIQy2HA9N
         3dzcn6NkqwH/hDw9nUn2tVLaULQkrBFdBUnvXsXH+Ij2M/i/KBnshOVVtHhwQy06qsWo
         irboHHYENYv7ws/fN4NGxW/By8tK5wvq5m+LI46cuuVQhz+iPx76TYfqBw5MUYCnJBrW
         7uNw==
X-Gm-Message-State: AHQUAuZ+mAmiRf6OQOxOM6mr/QX+K34ZAZ/Xt8bHgn5jqjrs9sY7tvc6
        2u7e8tv+R3OkB50j9ZeoU4IpSscS5REeqw==
X-Google-Smtp-Source: AHgI3IY0B0TzivNn0Pq+PspWdM2zL8NCyOVxaanLi9x/HWgZYN+soegHSNU+lbLhXkuz/9g6QgUCVg==
X-Received: by 2002:a02:284:: with SMTP id 126mr10064898jau.47.1549569364477;
        Thu, 07 Feb 2019 11:56:04 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y26sm5092782iob.16.2019.02.07.11.56.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 11:56:03 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/18] block: add bio_set_polled() helper
Date:   Thu,  7 Feb 2019 12:55:37 -0700
Message-Id: <20190207195552.22770-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190207195552.22770-1-axboe@kernel.dk>
References: <20190207195552.22770-1-axboe@kernel.dk>
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

