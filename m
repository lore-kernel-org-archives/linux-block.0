Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255B4C433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105686135E
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhJSV06 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhJSV04 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 17:26:56 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D925C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:43 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n7-20020a05600c4f8700b00323023159e1so5671127wmq.2
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7qTPRZgyDT08UP4tOI5cRqE6rGaKmGvoqqyH8NygZgg=;
        b=lpqqBwa7G0fG0NqFCwGTYPWdceC7YgZi5jV2go14jTyYKpnmrEFDAqjWl+gkkWla3W
         MMOMom7q/oCiAp4KpqtrQSBChgfy1TkCSMqQdrlouL8s/41fEaPtp4eYnN2y9rivH/tk
         QwKOmow0rvGCyhj+DCGo901i45zwAwJcZhWc6i+9f3QlwFDe48ceyRg5f5b/X8sTpwIG
         bRyvVC/0K5lysWRyBtyD35Tb5IXnvyBlLzuuvNDbLhEmpx4YCvBThW6G9jnfDExl1FQr
         4Nz8GvICECOVNcQW/gsmvJpDNB33yWNQzfj1MU1bKDL7+BHOAbuZNlS7dsuSmJl4xwfv
         yBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7qTPRZgyDT08UP4tOI5cRqE6rGaKmGvoqqyH8NygZgg=;
        b=RYiQrLfrgZhxsdY06NLADSO7OjKNOPNCjMq1iVRylmEiWECwLfjLo3CHQvqesQWbVX
         2XFpga7MjHFyIEsfbl0jCsOjvcveiBLKjlfHrdSdYbwN3iH+D/smLvu9oIGSv32ni0GM
         D+orwaqpOBYEno2sUTPiQ/h67mi4NHUee9RAC6NBULw2L4q+o0XWw2O/qcujI6ejDByj
         e19p1nQlRKP5pJgEiMbal/R/elEMa/ESytUtczImwP61rNAGs2LGHK1tTBCfI/RBmxbT
         9TMobxQUykke032oONXonST0x/BJbFmLhBpxFKbfYn366FgXiSj2YAEDh7IXPvU7coIN
         /riA==
X-Gm-Message-State: AOAM531F/9K2N2DnDoM+LUNGsjrPPNi6+PAwlD0vRdkefnxG/zX7IfwG
        8UyE2NSindL1osboNWsO/e+3zZn4tS3thw==
X-Google-Smtp-Source: ABdhPJy8cTCeXpHb3uLNKBnb9FL/J7NIFnKvj2rlu32fIjM9A7bQVLO+2gyxsPxXkR0o6qLBqsoccQ==
X-Received: by 2002:adf:a78a:: with SMTP id j10mr46784944wrc.231.1634678681879;
        Tue, 19 Oct 2021 14:24:41 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.194])
        by smtp.gmail.com with ESMTPSA id m14sm216020wms.25.2021.10.19.14.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:24:41 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 11/16] block: add optimised version bio_set_dev()
Date:   Tue, 19 Oct 2021 22:24:20 +0100
Message-Id: <3c908cb74959c631995341111a7ce116487da5c5.1634676157.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634676157.git.asml.silence@gmail.com>
References: <cover.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If a bio was just allocated its flags should be zero and there is no
need to clear them. Add __bio_set_dev(), which is faster and doesn't
care about clering flags.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c        |  4 ++--
 include/linux/bio.h | 10 ++++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 8e3790faafb8..7cf98db0595a 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -75,7 +75,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 	}
 
 	bio_init(&bio, vecs, nr_pages);
-	bio_set_dev(&bio, bdev);
+	__bio_set_dev(&bio, bdev);
 	bio.bi_iter.bi_sector = pos >> 9;
 	bio.bi_write_hint = iocb->ki_hint;
 	bio.bi_private = current;
@@ -224,7 +224,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		blk_start_plug(&plug);
 
 	for (;;) {
-		bio_set_dev(bio, bdev);
+		__bio_set_dev(bio, bdev);
 		bio->bi_iter.bi_sector = pos >> 9;
 		bio->bi_write_hint = iocb->ki_hint;
 		bio->bi_private = dio;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index c88700d1bdc3..0ab4fa2c89c3 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -453,13 +453,19 @@ static inline void bio_clone_blkg_association(struct bio *dst,
 					      struct bio *src) { }
 #endif	/* CONFIG_BLK_CGROUP */
 
+/* can be used only with freshly allocated bios */
+static inline void __bio_set_dev(struct bio *bio, struct block_device *bdev)
+{
+	bio->bi_bdev = bdev;
+	bio_associate_blkg(bio);
+}
+
 static inline void bio_set_dev(struct bio *bio, struct block_device *bdev)
 {
 	bio_clear_flag(bio, BIO_REMAPPED);
 	if (bio->bi_bdev != bdev)
 		bio_clear_flag(bio, BIO_THROTTLED);
-	bio->bi_bdev = bdev;
-	bio_associate_blkg(bio);
+	__bio_set_dev(bio, bdev);
 }
 
 static inline void bio_copy_dev(struct bio *dst, struct bio *src)
-- 
2.33.1

