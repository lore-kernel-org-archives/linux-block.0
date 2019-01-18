Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2958C43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 16:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A984420850
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 16:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tBJafw9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfARQMl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:12:41 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35236 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbfARQMk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 11:12:40 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so6275390pgs.2
        for <linux-block@vger.kernel.org>; Fri, 18 Jan 2019 08:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=27Lm/JhUsJpkymG55uhLhyMpM6M6IdPOsWlq/569Gqs=;
        b=tBJafw9ns5NBiaGA9T3NqjcHIIYmW+YPCTAkqeXIUIg7zvwHikklv8ZMwrdh1nmh08
         OlA5W0kppJcjCGIv09pBN9HtI+76ZaDPDtF5uS5Ir1eLJEsVRe7b75ybjkvv8ZFtX9ht
         HgEVYKjhK+GS33YlaWcO79q1/McNWX9zzfk5F+2vems8Boymzu8cDP2kmUOFj4h2QsHA
         GHEizMkL//r57Lkh4bDthHX8KX/PMw5lDVTpoTwvSJlRBZFJcWvUIi70SX47LXejG/2Z
         S0bmwjKhQiMM/A+KkG5ib4VgZRAZA8+A0YZOumwqJsItC8/qd3tUcAG7MJtsZ2OXNEQ1
         IGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=27Lm/JhUsJpkymG55uhLhyMpM6M6IdPOsWlq/569Gqs=;
        b=BY7Ghsx6RKEHGFH1U7hPdeUh5uBTkMXa+rSuen4BFMV/JQAMVAV5JhrjGMXo5HCabg
         hzGeL2cQ4LhWAR5FsgvWyyU0nmYb+S2pkcvVQnTIA0ozWLdwVnfbq6DZC5DlriPGgCPi
         POhsODDAqnRhYIuzf0nYAQwMhfBVt9GrHyCtxaobKC8Lz5Ey9/cq6yERy3/ySrEHj2Rj
         Lz7qOHtyNclFb8WFB6BWVzaieWAL7gquN9WM1aH3x9PzgMhV1euPLN/1fPrsDaTrXNx0
         6vebQ6Ix9z/xs4z3KEwnJS6Te/Ep2vf1BqNjMrDn6CaBQ2Ac6JTZgR/0Kw5tzkzipEyS
         KJjQ==
X-Gm-Message-State: AJcUukeeNCDsTJdFcahB8+BBeGvNx0rTZNhKqWMeX/bdFObDS0oRHi/o
        bny1GkAZO4qBImiS4TMRgunhFQ==
X-Google-Smtp-Source: ALg8bN76NkY8wIc2R0UryPmgdKuJYeJhKTqnJ5FG5pgXgACr42yVVuFZMkeyjrALp6xTb6HFyoPzjA==
X-Received: by 2002:a63:134f:: with SMTP id 15mr18168131pgt.19.1547827959789;
        Fri, 18 Jan 2019 08:12:39 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m20sm5317804pgv.93.2019.01.18.08.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 08:12:38 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/17] block: add bio_set_polled() helper
Date:   Fri, 18 Jan 2019 09:12:11 -0700
Message-Id: <20190118161225.4545-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190118161225.4545-1-axboe@kernel.dk>
References: <20190118161225.4545-1-axboe@kernel.dk>
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
index 5415579f3e14..2ebd2a0d7789 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -233,7 +233,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 		task_io_account_write(ret);
 	}
 	if (iocb->ki_flags & IOCB_HIPRI)
-		bio.bi_opf |= REQ_HIPRI;
+		bio_set_polled(&bio, iocb);
 
 	qc = submit_bio(&bio);
 	for (;;) {
@@ -401,7 +401,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
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

