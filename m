Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C31CCA47C
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiF2Xct (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiF2Xcr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:47 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE387B01
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:46 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id bo5so16512155pfb.4
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KTrDKBRbhjdsx+OGEpxSwrjVQ1ShQO8gv8693CNLUuA=;
        b=OL59wcVMB3nLhHfFMqcEPsgv8+oJLhkedwP8iVG2+B5zxd2QMexn2B0+jOU1z4jpAY
         2DYkOR8BQx/N7v3cBEzGbzdsA0OdSoegW7S5PSMCUpQhHjUIum8+EuYZnFvvBA2sD1AT
         B6NE8rARf5qYHZga2KSWsqGwisGbTaAvBIDaxoBSK0aFV7mEylboAOXi72vLSCXODybw
         7Y4IpK1W9uBqbnWr6jCSUtECwhIwnDUWzATUoMA1iz/YOtJlVgFAPQFq6L7Up8++fGTL
         I7+vial3YTVTVIOH8iVXkeSmXyfVx/Q0NnWi1B+pNtQclDV/RIabac1auWAQhx6g1LPY
         WGKQ==
X-Gm-Message-State: AJIora+Vy6i6qJFkNQkKxfKCCVkKwCO4yCONDKeXogdFAVaxorVob3zX
        stoJEhoHZz1+SxNW+8JFAl0=
X-Google-Smtp-Source: AGRyM1uIwzUvp+Es1+czoSF5PsCkcWY+zDqH2Jv/BVhWF8wZhi+/s41nJIuHvGBRKcXnTgmaUNVvEw==
X-Received: by 2002:a63:904b:0:b0:40d:1d01:39aa with SMTP id a72-20020a63904b000000b0040d1d0139aamr4919303pge.68.1656545566136;
        Wed, 29 Jun 2022 16:32:46 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:45 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Song Liu <song@kernel.org>
Subject: [PATCH v2 34/63] md/raid1: Use the new blk_opf_t type
Date:   Wed, 29 Jun 2022 16:31:16 -0700
Message-Id: <20220629233145.2779494-35-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for
variables that represent request flags.

Cc: Song Liu <song@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/raid1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index e7cd1d30d68a..8180b57be040 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1220,8 +1220,8 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	struct raid1_info *mirror;
 	struct bio *read_bio;
 	struct bitmap *bitmap = mddev->bitmap;
-	const int op = bio_op(bio);
-	const unsigned long do_sync = (bio->bi_opf & REQ_SYNC);
+	const enum req_op op = bio_op(bio);
+	const blk_opf_t do_sync = bio->bi_opf & REQ_SYNC;
 	int max_sectors;
 	int rdisk;
 	bool r1bio_existed = !!r1_bio;
