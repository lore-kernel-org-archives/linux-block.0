Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67019C43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiF2XdN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiF2XdI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:33:08 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3F929823
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:01 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id a15so16459319pfv.13
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wa/sr+NP/FT4fKWkIMXc8lgZJSIyAgOvOxw719smI0c=;
        b=KttYHkQqKlv8hKQBKuhHiSh9m75XhNfaOm9jyRuR92Djy+oXsymJ3w9PLtCbML3POX
         WYO4di8KbGA7cTuR1yWMatx0LBxuBxc3ts12sWwDjlOIi0D+hXHj/c07ICzOECJ+fTMK
         hW9IJHy7jdbXPWj5ucvoNzoEOxIkN7DuxehYCk+Jme6YxAmAXPSZLZiMYUPzqJwCgE15
         m78DPHn3wVVIbB5wzQo+ISlKhFyQ4xlVpSX7xQdJso79NZAzJZAzD0lrHRjWk8PAeVMv
         Q+i94j+HgDReBIkSW1pLTVAr7NwJDf03FbIP/GYnF7U4xxfzeVtcS++xrwWAQyxAZiyl
         VylQ==
X-Gm-Message-State: AJIora+NOtJj3Jy1SgNqHbu9kWUxG/s5CTxTzIdPSOP64Phub/sM+WY5
        Eq4wnSVUjR2o/JMYB2+9AXk=
X-Google-Smtp-Source: AGRyM1tku6Yx5Qvhkqx2r34dMNN3j+sK/Niu5XZWbY+cewhb9Y4CUq0rHxGthjF5vGT0b0D70clhZA==
X-Received: by 2002:a63:1943:0:b0:411:5e12:4e4f with SMTP id 3-20020a631943000000b004115e124e4fmr4985690pgz.400.1656545580875;
        Wed, 29 Jun 2022 16:33:00 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:33:00 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v2 44/63] scsi/target: Use the new blk_opf_t type
Date:   Wed, 29 Jun 2022 16:31:26 -0700
Message-Id: <20220629233145.2779494-45-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for variables
that represent a request operation combined with request flags.

Cc: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/target/target_core_iblock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 378c80313a0f..5fef19af88df 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -343,7 +343,7 @@ static void iblock_bio_done(struct bio *bio)
 }
 
 static struct bio *iblock_get_bio(struct se_cmd *cmd, sector_t lba, u32 sg_num,
-				  unsigned int opf)
+				  blk_opf_t opf)
 {
 	struct iblock_dev *ib_dev = IBLOCK_DEV(cmd->se_dev);
 	struct bio *bio;
@@ -719,7 +719,7 @@ iblock_execute_rw(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 	struct bio_list list;
 	struct scatterlist *sg;
 	u32 sg_num = sgl_nents;
-	unsigned int opf;
+	blk_opf_t opf;
 	unsigned bio_cnt;
 	int i, rc;
 	struct sg_mapping_iter prot_miter;
