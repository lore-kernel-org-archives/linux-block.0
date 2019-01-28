Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F47DC282D0
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DBC2177E
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1go5eIlZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfA1Vfv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:35:51 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42645 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfA1Vfu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 16:35:50 -0500
Received: by mail-io1-f67.google.com with SMTP id x6so14797241ioa.9
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 13:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FBZUThjVgqlafR/VslkU6xBWVbQBqldD6jr0wVQhMXM=;
        b=1go5eIlZTAt/LYcZZJlKDhBMvmSbVy6XT/R57jDUucbluf/eCRMZBGdK+j1R8iCnBG
         p2aoCyx2f3JT7KmccKmjUPc+ViYvLmbZCKpFUrgfngIkQYITy1RbKQXlHY7ZXUBo5yhv
         8UHmrEnxgww7xPbuWVpsZOijjzlHBnI8vWX4qqcRIx9WdqtcJkp/5y2MolcSX4SjvKGj
         ki5xM62NHVRhVeyeCSVAxbrsR2t6nYQJqui18NrcBLXPyTWGBXjXlSKarCu9z/9gvAzP
         V3yW26ZPZBcWRYwiN2DDDTqjKkh/PDg8Qqj1x9efGycSVFe3AjBBi8uCiNNyZ1q+rAvx
         1RVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FBZUThjVgqlafR/VslkU6xBWVbQBqldD6jr0wVQhMXM=;
        b=tRu7NrJ5V7akFUiXF07RCOZ3Fw4BKVrTd0sYEbZBc+1E6+fVuLQVO0s4+aOfzSpLPe
         Tx+Plr0ulbb47eNOD6b1v+irapmBwHVOM7Ri931tUPiHK+nlIq4y+ImNS+KyNMAuhgvh
         TKDKfXfavoP4cWjj0F/gP4bNHFovvgkXbeqPs/K7z+IcggOCicjcJ//2W54zqmt2LAj2
         TbagohjMjnng9ay8TxLomlxii/AhmDe6WCDb7fHtriOi8GooGczaiYO2ht8QitlWdW5m
         THwP8LQH1fiPpWtQDThrKp83CsRvTkzSadjRQRtje5Bc575gKSwr36jS+6sGRictMP9e
         hSCg==
X-Gm-Message-State: AHQUAua9OwfTf+9Of/ao+rf3pXKx/+yVmel7dxAzfDULvAzdIkhrvcbp
        NyoAQagjABKCBeVTkyXbxMarjA==
X-Google-Smtp-Source: ALg8bN5Q+XwNIP+FyNdS+6WVb0QThcIrX3Zc5SzYXChvG7+F02t7kwEFyZo3bOcTTW8WrZLpMbA9oA==
X-Received: by 2002:a6b:c815:: with SMTP id y21mr12735283iof.98.1548711349997;
        Mon, 28 Jan 2019 13:35:49 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u25sm13782077iob.23.2019.01.28.13.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 13:35:49 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/18] block: add bio_set_polled() helper
Date:   Mon, 28 Jan 2019 14:35:23 -0700
Message-Id: <20190128213538.13486-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128213538.13486-1-axboe@kernel.dk>
References: <20190128213538.13486-1-axboe@kernel.dk>
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

