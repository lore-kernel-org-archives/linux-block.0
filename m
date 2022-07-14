Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B41C43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240244AbiGNSJ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240548AbiGNSIy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:54 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919EB165BF
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:48 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id o18so2267365pgu.9
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JEeKBIBSjIWjxXePoK9YHpsjxDxx8u9/AFp6uEeHMRw=;
        b=jt3QjQ5xfmCILhApYtsdHGfAu6FbkNsj7PEP/tosuTtCJcTlEkFWXG9n1S+4FmRKWp
         LkgVZhuQrXpQlM6EZUN0FUAB/1g5xk8eSgh39Ky8bR5NSXqgsNeZcqCIsUcvQTSfHq6T
         dpyR5E42Cl1OFarrtEL2gN9EBFMokoVFHVpfy2k9kTpMCo3k+V0qEm/KwRnbOItsjQZ+
         dmhrMAe569J1qD5SnX8+pb2uDe8Q+W2TEPcIIKti6ibB0pqTTEzVx9f6ruJVJSr8egBR
         VfvkSd3/DUHufDN4JrGrMdCXvAMXyasHC9oXChGnxivEZF+16OVX/r4xdXRwrjb92NEM
         hfng==
X-Gm-Message-State: AJIora8/1rwk6qC4mvCXQJOXut1AtGbzx6R07xU3ChZBWLU4yfywSLZQ
        8cTPPgzcIpYVwcJiwBco9AqB1B7sGLY=
X-Google-Smtp-Source: AGRyM1vgKg23Fu1pImvcavUr1lwIfUyV8G/MrJfminJFuMbnA5t5ku1s2GHtrQMf04wRPSQw1H+vZQ==
X-Received: by 2002:a63:165c:0:b0:412:6f3a:1b4b with SMTP id 28-20020a63165c000000b004126f3a1b4bmr8950572pgw.98.1657822128008;
        Thu, 14 Jul 2022 11:08:48 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:47 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <michael.christie@oracle.com>,
        Bodo Stroesser <bostroesser@gmail.com>,
        Mingzhe Zou <mingzhe.zou@easystack.cn>
Subject: [PATCH v3 44/63] scsi/target: Use the new blk_opf_t type
Date:   Thu, 14 Jul 2022 11:07:10 -0700
Message-Id: <20220714180729.1065367-45-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for variables
that represent a request operation combined with request flags.

Cc: Mike Christie <michael.christie@oracle.com>
Cc: Bodo Stroesser <bostroesser@gmail.com>
Cc: Mingzhe Zou <mingzhe.zou@easystack.cn>
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
