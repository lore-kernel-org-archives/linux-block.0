Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB52C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiF2Xdv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbiF2Xde (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:33:34 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9F4265C
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:21 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id l6so15466680plg.11
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JQy39SeZG+twTO0WI2+BNN0Zr2MVVoRDZTiM6bUMTPA=;
        b=E87MJ4PpO5va1N0NnskZYUiBaPiM/4GZl1k5pivIQDECdnBzy3TXbBcePEOYIgF6dK
         LkVnAhEbZzaSOlGro8WtVk+7g6ci2e59ze03vF++AMqPahfVHuyxVVaoc74l43FXrrmG
         W+wr/aCqHk/Q2kIcvrIhdm9bws01xHHf2Hb+KvEO/+nnMpb2n2iDqlFj8oDi6tlSxFfu
         iMKdW6lgUt8TcU9Uf1KVJUXNh6A/GjGyw0Da6D7Ocj2nmFf0W1R9DBXo+JMKhQyktzub
         s4ljhlUpOilZfcrtOeYolnvI7E8m6KVLdZCqjNTkFk67QBdDZtRSFQsI/4BccjAM/yP+
         0Glw==
X-Gm-Message-State: AJIora8Dz48f9C1PXPoIG7TvB+iWWQtvkm4cFhMBikkPdfSAU6otkXV0
        2YfS1H4ZSS5PpLnA8KokUWg=
X-Google-Smtp-Source: AGRyM1sf5lX9GDcN1tWFAXwtvZo3/5ZFTscHbZvoVXxcyeRF6ORISIH70eHC5OqTmlUPZSmFInqMKA==
X-Received: by 2002:a17:90a:b88c:b0:1ec:9449:219a with SMTP id o12-20020a17090ab88c00b001ec9449219amr8410005pjr.243.1656545596994;
        Wed, 29 Jun 2022 16:33:16 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:33:16 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 55/63] fs/iomap: Use the new blk_opf_t type
Date:   Wed, 29 Jun 2022 16:31:37 -0700
Message-Id: <20220629233145.2779494-56-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
the combination of a request operation and request flags.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/iomap/direct-io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5d098adba443..18a3d9357dce 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -52,7 +52,7 @@ struct iomap_dio {
 };
 
 static struct bio *iomap_dio_alloc_bio(const struct iomap_iter *iter,
-		struct iomap_dio *dio, unsigned short nr_vecs, unsigned int opf)
+		struct iomap_dio *dio, unsigned short nr_vecs, blk_opf_t opf)
 {
 	if (dio->dops && dio->dops->bio_set)
 		return bio_alloc_bioset(iter->iomap.bdev, nr_vecs, opf,
@@ -212,10 +212,10 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
  * mapping, and whether or not we want FUA.  Note that we can end up
  * clearing the WRITE_FUA flag in the dio request.
  */
-static inline unsigned int iomap_dio_bio_opflags(struct iomap_dio *dio,
+static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
 		const struct iomap *iomap, bool use_fua)
 {
-	unsigned int opflags = REQ_SYNC | REQ_IDLE;
+	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
 
 	if (!(dio->flags & IOMAP_DIO_WRITE)) {
 		WARN_ON_ONCE(iomap->flags & IOMAP_F_ZONE_APPEND);
@@ -244,7 +244,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	unsigned int fs_block_size = i_blocksize(inode), pad;
 	loff_t length = iomap_length(iter);
 	loff_t pos = iter->pos;
-	unsigned int bio_opf;
+	blk_opf_t bio_opf;
 	struct bio *bio;
 	bool need_zeroout = false;
 	bool use_fua = false;
