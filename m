Return-Path: <SRS0=tPwK=PU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3FFC43387
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E152084C
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SQrjJm2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfALVa2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:30:28 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45457 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfALVa0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Jan 2019 16:30:26 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so7786690pgc.12
        for <linux-block@vger.kernel.org>; Sat, 12 Jan 2019 13:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=27Lm/JhUsJpkymG55uhLhyMpM6M6IdPOsWlq/569Gqs=;
        b=SQrjJm2d4O/dCVxq7WPIWMZIVgwaZsZtOrJhsJ87Y23N+dky/TdoejMAKM/k84Pl+/
         fV26n+/7ZItJN2MIJB957EzgMGDlvBGYB7jPPwy5DqWTkLYuHBs7z+qYUeAjT76aHyEA
         1OknA4EVp93wxftH4Her70ydD8iJwvlcHxa+vW0CBqUjqfMT2yLRXqP97822pLo9fktE
         Ib15M29BbJ3Ehp4GeOXnAXzC0sXuepmgdHR6VNr7NVKUJsoy03816ET8YCCOfIld++RA
         NcccVEOjQoluw7l+4F6hMXKxKu/Mu3bzTTnBEf5z5CHW+SgA5GveJF3ZdkWgoCAGh7yK
         OdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=27Lm/JhUsJpkymG55uhLhyMpM6M6IdPOsWlq/569Gqs=;
        b=bI0V68q33CWuGfS7XM2oc38KlPUQE9AeTavzitMXQN6wOGhg/fRgZvnN623ONEk1Yy
         4KEKkP5OZRyUNPyRFOIzUvcWj9I0PyI2hw9OjyZ2JZiIooVgaCCAHRyfLS7dQSQMROY8
         YAU6e4Aw+AjscY1AYV9mkTR5H1036n6IJD7yifV4oqSi8zkzt5kOki7zNFa5QoIA1aWg
         B1aRYhSc9iAWGD44klxJR9OuCb4fpzCw7PxGwob9apw809p0a+dQpls8lW9Pq+6w89R8
         EEPdrt5d99UFwIsyvmHJ40KMbg7LY0DoygmVzu5UP7SVvMVNfmESr5WLp3/MA/SsXsix
         QeGg==
X-Gm-Message-State: AJcUukepKhek1yd8Y5UWN4jmbu7nO+9fdMxz6hVkgvxy6ldq3qj7DdaP
        akCcarqMIxy9ZZQU2Uk7UeMDIA==
X-Google-Smtp-Source: ALg8bN6ZPEFDB29dv+5Cv6HS1EIYRsOhBUSlU2TbBb3IFmfD/CPD4cdEAantzhuniiZoRUjRPJu36w==
X-Received: by 2002:a63:c848:: with SMTP id l8mr17773719pgi.78.1547328625225;
        Sat, 12 Jan 2019 13:30:25 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y6sm151629818pfd.104.2019.01.12.13.30.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 13:30:24 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/16] block: add bio_set_polled() helper
Date:   Sat, 12 Jan 2019 14:29:58 -0700
Message-Id: <20190112213011.1439-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190112213011.1439-1-axboe@kernel.dk>
References: <20190112213011.1439-1-axboe@kernel.dk>
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

