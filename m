Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B18C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbiF2Xcw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiF2Xcv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:51 -0400
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEF0112B
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:49 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id d129so16760841pgc.9
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=knKlLEHn8hCQZqUlhnKOmaPVcm9Kj1Qvvc0B3u5dn7k=;
        b=n6854aQ2uGAOP/yQw7kzFFcn0ZWeGcjLXCw/VB641m6Moez8MuxOOPlTeHM43Du9h6
         urp8wCkKo4o3yVCntjLcTUQmVV1j92SYqMcdDz8YxMHHAJ6AwYyMoZy0PHSV27zPgcn6
         aF/KyOVb8c5ubMIQiPVoCEm4Y4kveAt5WXDCz/LLqFnTBcIA3MUxq84jOU/Xj2Jh5k6l
         IbGhh6Ah/DaWPifjzuF3qeJXVFAzFQ9R9/WLIsZtvGR6umA4ZhRDJ+MBZGV/2kImh+Km
         q6jXJI7bvfJ4BaZWwgjVeBp+yA393SwPZ0NTMNMbGR2ZlXYLzvTuBi3n4b7BYmLcLJ3t
         WpTA==
X-Gm-Message-State: AJIora+WdZL/xSrNhR4bGUeNWuJg23N5yKe18PGwCdJh4u1IhrKwvXpI
        LSJ1Vuj3/wseRkzxi13ZOjs=
X-Google-Smtp-Source: AGRyM1tirgUeNLE6fIRPxJB9eF36uTuj+Vxwf08K8eV0i3f19xQtIP2TCfrF2ZjZonqqktJdWESu/w==
X-Received: by 2002:a63:1809:0:b0:408:417a:6fa5 with SMTP id y9-20020a631809000000b00408417a6fa5mr5044344pgl.228.1656545569072;
        Wed, 29 Jun 2022 16:32:49 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:48 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Song Liu <song@kernel.org>
Subject: [PATCH v2 36/63] md/raid5: Use the enum req_op and blk_opf_t types
Date:   Wed, 29 Jun 2022 16:31:18 -0700
Message-Id: <20220629233145.2779494-37-bvanassche@acm.org>
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
variables that represent request flags.

Cc: Song Liu <song@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/raid5.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 5d09256d7f81..b11d8b6a2dc2 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1082,7 +1082,8 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 	should_defer = conf->batch_bio_dispatch && conf->group_cnt;
 
 	for (i = disks; i--; ) {
-		int op, op_flags = 0;
+		enum req_op op;
+		blk_opf_t op_flags = 0;
 		int replace_only = 0;
 		struct bio *bi, *rbi;
 		struct md_rdev *rdev, *rrdev = NULL;
@@ -5896,7 +5897,7 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 			(unsigned long long)logical_sector);
 
 		sh = raid5_get_active_stripe(conf, new_sector, previous,
-				       (bi->bi_opf & REQ_RAHEAD), 0);
+					     !!(bi->bi_opf & REQ_RAHEAD), 0);
 		if (sh) {
 			if (unlikely(previous)) {
 				/* expansion might have moved on while waiting for a
