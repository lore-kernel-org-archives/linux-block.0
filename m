Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C39BC43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA74214C6
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="m4N8NbAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfAHQ5A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:57:00 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:33132 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729061AbfAHQ47 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 11:56:59 -0500
Received: by mail-it1-f195.google.com with SMTP id m8so10453560itk.0
        for <linux-block@vger.kernel.org>; Tue, 08 Jan 2019 08:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=27Lm/JhUsJpkymG55uhLhyMpM6M6IdPOsWlq/569Gqs=;
        b=m4N8NbARBmEwjUvDpzAXBUWrau2jEhutC5ECDj8VGmEbtQpJvzj35KpKuVpYHFQ2Rl
         dsY3c3D1wr2PT5wYDpdF/Gw7YVXxn0Jj7/325gbgSzsXNH6KpcGHKPYUXMeYazv8fecc
         dQTCTWAS/zK9AMa032Li31lC2wzb/pADJz5Xzw13r9PKEHuCSkm//p06YPi2A6j5PMNW
         Jba7LXfjj0oZEnJDfhyT/ZRWJqVlcZvAUL5aK4UEewbWsaF/RLCDZgUJ5d5600VQtjMk
         wd2LeWfP5BhMsGbztssjp8CE1ZBuMSIybpNrpUxWe7Vhljd8JTQJ5AcAzFFdgvzHH2xX
         amOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=27Lm/JhUsJpkymG55uhLhyMpM6M6IdPOsWlq/569Gqs=;
        b=E/QSUgf0JidtixFW0sdMoIvtfp+OOnPwh13fDriA6NKEbjOFBMLb5a0owsPw9LmAzz
         a0hQJphIiNM+XQSNPjWKBInzgv4Y5f6GDWNLRHpvmXsjG/4d1NPqhg2tducgKwlotNkb
         phP2jyUgpf1UnGaVeIGy9T3nyQQG4xgdQBJc8ksfS4FkP2dJ07GLc5gtDslZUKd+Z76C
         nDQfZKMaQcXoobTOThBRginoAxMj5trnTbk5cNj+NGAZuYKcwdnsC89O52JSvtNUHTgW
         xs0Jtfjs3ymI3j5Fg348u4gMXPmP/qcFPq1oj/QkygCRh8khloGe5AzTAFqn8MX4DsoG
         nhsA==
X-Gm-Message-State: AJcUukeV7xg32dRCyz4yf9amupGYI+j9HsbR8rDAMgoEqMEmcv93bngY
        tx1dbUwB2jK5TQ0D63yho/xHDw==
X-Google-Smtp-Source: ALg8bN6TPENNxihDWK16Dxc8BFhdm+oMKGCX3xZYLJa6OFE2je4LJDm652HDumCWUla6DzRFA/vpPQ==
X-Received: by 2002:a24:411d:: with SMTP id x29mr1443879ita.0.1546966618374;
        Tue, 08 Jan 2019 08:56:58 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m10sm17563442ioq.25.2019.01.08.08.56.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 08:56:57 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/16] block: add bio_set_polled() helper
Date:   Tue,  8 Jan 2019 09:56:32 -0700
Message-Id: <20190108165645.19311-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108165645.19311-1-axboe@kernel.dk>
References: <20190108165645.19311-1-axboe@kernel.dk>
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

