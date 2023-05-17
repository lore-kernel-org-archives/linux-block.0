Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2315FC77B7D
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 17:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjEQRpb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 13:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjEQRpa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 13:45:30 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2203DC67
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:44:56 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-643995a47f7so1120608b3a.1
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684345475; x=1686937475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPPtJLUNcWWEc/mSEtTotSAvLx2KABsnEcjgBEYWy8I=;
        b=A3ufuaYibewP3oi6I+JffFeVvxqsZ7tEa0WwVrjfJ7PLcTF2XS/iL0Y9Wwjr+hmebZ
         CIhHXksfVQSG/sCoA+WHxUlp0kUlhqN6qeBIdtwsOkhmjXaqgw1a2VSH4KVnS4cQAfeC
         DCae79H/HjRS3gz7VSDComZDL79+2RQY02bNcPHFqroWrz/lWuUJ5PKptjdzvplWF9Fi
         Q/varWbEgVj7qzMzJ9bqNzSLVPdb9OBZ2nQe/2W1x05dN6DiLhHw8iYCCfgsLLXsCGtt
         V+J6Vcyr7/UCLBdxpZSauWzzmyC6tA3OlSY/57fdgbpcjWU5J1ddfh1ihXvCm0U8tV5B
         Vk2g==
X-Gm-Message-State: AC+VfDwnpdRAe2xzj4zCbDP4n9NhYEqzY4kfo6KKL/j8lkAB90EDwT1L
        mPFMBt3LPvCClWSOG6IQ+5RnRlL39dQ=
X-Google-Smtp-Source: ACHHUZ7rXVB8dpmsjQzAPgENGHjCqeaNpNez2N/uBPH+ZaLmLMKQK7H/4yaTiAOEvDHQnI2svk8IHw==
X-Received: by 2002:a05:6a00:1696:b0:647:7ee8:6248 with SMTP id k22-20020a056a00169600b006477ee86248mr570126pfc.14.1684345475274;
        Wed, 17 May 2023 10:44:35 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id d22-20020aa78e56000000b00646e7d2b5a7sm15334410pfr.112.2023.05.17.10.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:44:34 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v6 04/11] block: Introduce op_needs_zoned_write_locking()
Date:   Wed, 17 May 2023 10:42:22 -0700
Message-ID: <20230517174230.897144-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230517174230.897144-1-bvanassche@acm.org>
References: <20230517174230.897144-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce a helper function for checking whether write serialization is
required if the operation will be sent to a zoned device. A second caller
for op_needs_zoned_write_locking() will be introduced in the next patch
in this series.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blkdev.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index db24cf98ccfb..3952c52d6cd1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1281,13 +1281,16 @@ static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
 	return disk_zone_no(bdev->bd_disk, sec);
 }
 
+/* Whether write serialization is required for @op on zoned devices. */
+static inline bool op_needs_zoned_write_locking(enum req_op op)
+{
+	return op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES;
+}
+
 static inline bool bdev_op_is_zoned_write(struct block_device *bdev,
 					  enum req_op op)
 {
-	if (!bdev_is_zoned(bdev))
-		return false;
-
-	return op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES;
+	return bdev_is_zoned(bdev) && op_needs_zoned_write_locking(op);
 }
 
 static inline sector_t bdev_zone_sectors(struct block_device *bdev)
