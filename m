Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD96BC43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 02:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC74206BA
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 02:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0wnXVp8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfAOCzo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:55:44 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40114 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbfAOCzo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 21:55:44 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so555959pgp.7
        for <linux-block@vger.kernel.org>; Mon, 14 Jan 2019 18:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=27Lm/JhUsJpkymG55uhLhyMpM6M6IdPOsWlq/569Gqs=;
        b=0wnXVp8sPjXIcI2DRqW5NQpa5JbTUfYr8ISu4ct1qSW20ESRFEumqkBHMQuxTcap4t
         5PfndxbVSqb3BvqFkqrTf7fIZRXP0SxUi1jK4RTHIrQopndnbpNrG1+unDEZbz+uNtqI
         tubbRaqeVnYRwSdNJvPo0f1+R/B230v4k5sHg9V4WgH3wlnLJkrlpo0WHa1xyF3rFk9F
         kqrkAHO1tdpAxSleI/Pfm2lnzEFRtpHbdt+y8gW7kFDboRYOKta4GkePLlcgjI2rojdY
         Om7XIOrKsnZ9+7vBdTgCVACkrFQzvxVFOVmP6J3MPKNXDrvUdlRUF7ZIq6rXSIYYTYOc
         hPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=27Lm/JhUsJpkymG55uhLhyMpM6M6IdPOsWlq/569Gqs=;
        b=qc1ZudSpBCtmsBxyKVU3xyL0QmA+5o4f0eJi11Bn9VLEKA3GTsjBJxYTEiOfotlBtV
         pNFGaD4WTvUVdgToQPVwFvog8S8PDdLZ1OKuNLV0BRq9mx3muY/QCcGpmXTQcxeMj8fu
         Z9x4JvMYvZA3e5U4GXBuORtaHcjYn0zGvPcv3X2+pYA3BiPA5t02p4aPhLaWUqBwG1zn
         rLKjOS0kU0uRahCJ87oV3Mqj7FvgTmezEfxGLEvU9BN/XDTAqLbdqAG70kT9Not0jruG
         TCUmdNZU7t4OxGUGEpzZ69sf93GYrQz6F4ClEpggoRDp11Fr6qje2oBDct+5IzUckghG
         ruwg==
X-Gm-Message-State: AJcUukePnuDGp64jMnTWLcRkSnr+KxJLX0uk0TvVABtGIwwxBEiS/wCk
        H1koJTIwEAPoIgM7/UFW+ew/XA==
X-Google-Smtp-Source: ALg8bN6gmrakEt/b+NzMI6Uq3yPKk3hz5OZGbiJPgCxnSMSnLz1zvOOyPBPo+NdghzRYjwqkybpGiw==
X-Received: by 2002:a62:1e87:: with SMTP id e129mr1634807pfe.221.1547520943088;
        Mon, 14 Jan 2019 18:55:43 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id c23sm2415544pfi.83.2019.01.14.18.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 18:55:42 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/16] block: add bio_set_polled() helper
Date:   Mon, 14 Jan 2019 19:55:18 -0700
Message-Id: <20190115025531.13985-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115025531.13985-1-axboe@kernel.dk>
References: <20190115025531.13985-1-axboe@kernel.dk>
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

