Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E58C43612
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D6421928
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LXsX+uQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391647AbeLUTWt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:22:49 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:32837 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391648AbeLUTWs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Dec 2018 14:22:48 -0500
Received: by mail-io1-f67.google.com with SMTP id t24so4514569ioi.0
        for <linux-block@vger.kernel.org>; Fri, 21 Dec 2018 11:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f0KZxg5yR4mj57pII4LTrUbSsPgKpU6QWnRq22MUurc=;
        b=LXsX+uQ+w/Du8z23ZxABBs5jzyTvWJyBKXEmiy7m8ddztxlRbTVkisJbRWnmLddzzl
         jZCoMv+qc/aaizWLRXsTH3c3t/ImIOgQ+IkfZl7bDeeDxkCx3TcMwsOv0vm55Ou3IRN/
         g3MWl/7SG71TUoO0qob7Cb04QDyTbe8C8rc/QXUwbYMUDTBJ1vFlmXqLja8xzJByfrZO
         C3VXtnQEWzfs7dAUfRJjD9+Borz2gT18IuXfnOpPZAf73Z2JQ4d2VoIyg8+rZIgfNqEt
         POr2QoDlUcjfaSXxfSp0lwvBwVD65QxxJ9KtpvlzVMJX0ZKKlQ63kUcT0qBMXWwcn5K0
         ciEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f0KZxg5yR4mj57pII4LTrUbSsPgKpU6QWnRq22MUurc=;
        b=Vp7TAUf9Qrca/dlilourItunAj/vc1PTF5Qaz+aj154/NNtQ7U8jBRmdQgaP8dF9R0
         UfPnuSrN7wc+Z9J8d9WRKqwmMFUm9AlQz6Y3ByoTwa3X9wxL2Xevqt0IDH5xz5YDX2HD
         rfGXsqApsnSKz4pvU3Nf5dgAL2I6xH7ZqzrDqIz/4O6Rg72BQjc70bCP1Y3PqIO23tx5
         s5GFTek6KPHdmot1i1ZabxH10PDmmkjrXib1yqU+KE5RYZ7XyoMVaLsOxVsayZ9DSW7/
         WFhEgb7HmDOzZfJv1zRh99icZWm4x8TSeDIoBHbdAHexnRGzMTbZCX8QJazwOdBuDmlm
         AZqQ==
X-Gm-Message-State: AJcUukdA6tdmn1k35X/LctflPGaJZSyJvLwJb7rxZakmFPmzDB6W7o75
        /BqYVp/xtym7x0K9XfiEWWx/tA==
X-Google-Smtp-Source: ALg8bN6NWo3JDXfAKN+2hcy+TvoiXIDi7H0mhoaATgM6ncrsuvJAdpNuEmih+1id2Vm2GiHIah5t2w==
X-Received: by 2002:a6b:7b43:: with SMTP id m3mr508028iop.105.1545420167774;
        Fri, 21 Dec 2018 11:22:47 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t1sm12456290iol.85.2018.12.21.11.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:22:47 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/22] block: use bio_set_polled() helper for O_DIRECT
Date:   Fri, 21 Dec 2018 12:22:19 -0700
Message-Id: <20181221192236.12866-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221192236.12866-1-axboe@kernel.dk>
References: <20181221192236.12866-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We need to treat sync and async IO differently. Use the provided helper
instead of setting it manually, then we also get the async case correct
by marking it NOWAIT.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index b8f574615792..9d96c1e30854 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -232,8 +232,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 		bio.bi_opf = dio_bio_write_op(iocb);
 		task_io_account_write(ret);
 	}
-	if (iocb->ki_flags & IOCB_HIPRI)
-		bio.bi_opf |= REQ_HIPRI;
+	bio_set_polled(&bio, iocb);
 
 	qc = submit_bio(&bio);
 	for (;;) {
@@ -402,12 +401,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 
 		nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
 		if (!nr_pages) {
-			if (iocb->ki_flags & IOCB_HIPRI) {
-				if (!is_sync)
-					bio->bi_opf |= REQ_HIPRI_ASYNC;
-				else
-					bio->bi_opf |= REQ_HIPRI;
-			}
+			if (iocb->ki_flags & IOCB_HIPRI)
+				bio_set_polled(bio, iocb);
 
 			qc = submit_bio(bio);
 			WRITE_ONCE(iocb->ki_cookie, qc);
-- 
2.17.1

