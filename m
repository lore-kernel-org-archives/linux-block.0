Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B94BC43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiFWTBg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiFWTBM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:12 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DEC10E673
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:28 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id k127so288056pfd.10
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wa/sr+NP/FT4fKWkIMXc8lgZJSIyAgOvOxw719smI0c=;
        b=mIhLjUKauphq6cdPr/+abnNhI0mTrAscs6w5fAqWayH8CMr3byY80NWX3aPo3bII4S
         xGz+OUFlB1AUVTSWJlbFATzoql0CWUm5sWVQ3WPcKoAHOnQUlMGq3JRq783HhPvaP8b8
         aunljK7L2hbU69qViLaS1mOX0N2UmCTz5xA4yjKgLK5Crm14yH8fkuxNg3p/wwQyrtyx
         ce6ITp+Z5WsjIoGEg1knyi+/WtLmWCbCl1uOKlr+m6yVOTYqAAHy+MnylG92fim1iqaX
         bH4kWnxr0fkF0MdpH956jrOQXJjq/ivNSl7BxVksuOCSK7D6AiS+7rBMk1Ddp3gQU8no
         uDCg==
X-Gm-Message-State: AJIora93ukKzIf0aCLhUETnhLWPN72osUKLJ+pJN2dWjazFlpTdOCz1P
        b/bbUuOP2lhqYVjCeSDbpcI=
X-Google-Smtp-Source: AGRyM1tRGaBl/bW98h5/DKKZgjSXaxtAeOJKvM2wtJqd7pEIFCt+oLNoKBUKIJ8k+65s9yHrmQ/BkA==
X-Received: by 2002:a05:6a00:1306:b0:512:ca3d:392f with SMTP id j6-20020a056a00130600b00512ca3d392fmr42378220pfu.79.1656007587793;
        Thu, 23 Jun 2022 11:06:27 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:27 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 34/51] scsi/target: Use the new blk_opf_t type
Date:   Thu, 23 Jun 2022 11:05:11 -0700
Message-Id: <20220623180528.3595304-35-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
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
