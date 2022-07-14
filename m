Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A149CCA482
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240525AbiGNSJf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240584AbiGNSJS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:09:18 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D9127FF3
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:06 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id w185so2560489pfb.4
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JQy39SeZG+twTO0WI2+BNN0Zr2MVVoRDZTiM6bUMTPA=;
        b=2rxToKLfFAp9Wib19e3IlaK68EtRe/Ll3l0g5dk0+QiqackaPpSZu00ywj2Og17E+O
         UUcnYp9xgFGZQ3X9WUEaI+OML8Oatuee4TZumuXN3w2QKQ7gkq7TYlpYop8Y1xDHffnR
         +AxJW1lbiO/ru24Ekr6zw2rI0mCPbzyEE880rHxX9TsV7HUEQTw5LBNx8LNfs6f6FMRR
         8FbeT4X4kpRn/eNWAAlXvVeA74ZId4SUn/v5O58n7VgmoLuis2OoOULtu5b4ZntuauF4
         ZpfdqxyAqEDcZWKbQFfZgIN7VNz2rButyG4VrTQxX09IpR7xlPRVGBW9UMs8WoOrIsnE
         wEVA==
X-Gm-Message-State: AJIora9e+h7nuu51EPT1sgwoaeB8s287TcpjbYX6ml7TgvvXok2WZBly
        +rFEnNQXlxxv/VQq7vmLMYs=
X-Google-Smtp-Source: AGRyM1uVXUZbUvr/jBx4QvVcPIPnsfhyQd7EBWfl2b8NgNWA3PbaE7RPv98t+hiVPKsI/GVcwqHA/g==
X-Received: by 2002:a05:6a00:1da9:b0:52a:c339:c520 with SMTP id z41-20020a056a001da900b0052ac339c520mr9649171pfw.70.1657822146443;
        Thu, 14 Jul 2022 11:09:06 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:09:05 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v3 55/63] fs/iomap: Use the new blk_opf_t type
Date:   Thu, 14 Jul 2022 11:07:21 -0700
Message-Id: <20220714180729.1065367-56-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
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
