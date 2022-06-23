Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DF6CCA47C
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiFWTBr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiFWTBc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:32 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF0160F0D
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:43 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id cv13so330393pjb.4
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4QISfDrQdl2eEQhQFuFgah+fp2LY7IkAXfTzhiFh0/Q=;
        b=Za76Wg9zBeDPmmVLcPatu/5AekDHix16BFiFFrm9Sw/nHv9C8MH4cfxwmqxQRAxT+M
         urpdQnccHRwDAfBiChMEHn026+FR2qvtq99AHmAsC1i7+JpYQL9XBaM2nvkxeRgFNMBd
         cxSP/3R4703JfketjZCR0QCG7M//YeePfVkOV2Q06MXeidVw3Fv8RY3yLWsbMSGU9qGN
         AzUcik2ycjA6o8IILdDTPrJxhDNorMKJC1Nk+iwjsvglV1rTWd7YBp/K4wdZ0J8Md8vJ
         JyEPDuUWzCs8wZMxcN5PUuIzI97urYXi9Mw+Q2SjFdy0tOXZw4MZAd/LlmwkMOzBZAi5
         6l4g==
X-Gm-Message-State: AJIora+AcH1E7YiUvW10yTG1ZoI7fxCTDfNHOfcAdYG4cpGCBQQ1QrNG
        CJjb5GHHOL9EeZvh/FGuft0=
X-Google-Smtp-Source: AGRyM1s1C8oHsKkRXCY+0LotXE28NNpDG6T+SsLOJ6SRBZe4dA2sitqDl1w78BAasOIebUB+TxtNjQ==
X-Received: by 2002:a17:90a:c402:b0:1e6:8254:3478 with SMTP id i2-20020a17090ac40200b001e682543478mr5279006pjt.101.1656007602762;
        Thu, 23 Jun 2022 11:06:42 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:42 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 43/51] fs/hfsplus: Use the enum req_op and blk_opf_t types
Date:   Thu, 23 Jun 2022 11:05:20 -0700
Message-Id: <20220623180528.3595304-44-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
variables that represent request flags.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/hfsplus/hfsplus_fs.h | 2 +-
 fs/hfsplus/wrapper.c    | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 396e73aa0961..ac93c2445b29 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -525,7 +525,7 @@ int hfsplus_compare_dentry(const struct dentry *dentry, unsigned int len,
 
 /* wrapper.c */
 int hfsplus_submit_bio(struct super_block *sb, sector_t sector, void *buf,
-		       void **data, int op, int op_flags);
+		       void **data, enum req_op op, blk_opf_t op_flags);
 int hfsplus_read_wrapper(struct super_block *sb);
 
 /*
diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index 0b8ad6586df5..bf5e89748df0 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -45,7 +45,8 @@ struct hfsplus_wd {
  * will work correctly.
  */
 int hfsplus_submit_bio(struct super_block *sb, sector_t sector,
-		       void *buf, void **data, int op, int op_flags)
+		       void *buf, void **data, enum req_op op,
+		       blk_opf_t op_flags)
 {
 	struct bio *bio;
 	int ret = 0;
@@ -66,7 +67,7 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t sector,
 	bio = bio_alloc(sb->s_bdev, 1, op | op_flags, GFP_NOIO);
 	bio->bi_iter.bi_sector = sector;
 
-	if (op != WRITE && data)
+	if (op != REQ_OP_WRITE && data)
 		*data = (u8 *)buf + offset;
 
 	while (io_size > 0) {
