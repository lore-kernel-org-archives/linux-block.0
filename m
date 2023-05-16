Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C6AC7EE23
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 22:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjEPWde (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 18:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEPWdd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 18:33:33 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC7A6189
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:33:32 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1aaf2ede38fso2055125ad.2
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684276412; x=1686868412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGoTIX5x/s8cU4eYpFurYc77b8Ta9ocu9yvDP7N1aU8=;
        b=e3+kc8Ozcin7/PW+upfk8E2gmPlVd51NUjk+FiGS/MfDVCCExN3FgTqNMJO0xfsz7H
         37vePXS2SUqcyLPVUiXwHD5OrCZ1L2QQKI+GSDIinjdc7kdVfq1v0j7e31DauQhVF5VG
         kFhZV5AWU23GmHJdlD8Fq6u2Yz1IGztSWSDBy+19+YXRWXYmxG5nh9CJhmhO+v4TwyOu
         Cm6GbZ3laYL5ABq04xCOvEpH9NTczkFclMndpWi3y1W6MC2oLWv9iYXx0zyPFfyWK8c3
         7Wg/WnfWMkjZqvi2s4GcL9GAFf2fzElUcLMgUApLy8qAxV6w8u9g0fVE+Ig8UiJGliTD
         9bYw==
X-Gm-Message-State: AC+VfDwk8BmGgpXZqogV/3eII+meJlX3hzB5GKVPOnIQX4rcOTloWVNE
        Dilwo3kX5cmbkdF58Ob7KkI=
X-Google-Smtp-Source: ACHHUZ7fw8/VGw0SsK+6QdEfBJx2x7ejPjaIfTE3QFIp7SDJz74ZoSu0nUXpwkiLnFoSwf1SQwI/rQ==
X-Received: by 2002:a17:902:da91:b0:1ae:f37:c1ab with SMTP id j17-20020a170902da9100b001ae0f37c1abmr13435592plx.25.1684276411680;
        Tue, 16 May 2023 15:33:31 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:baed:ee38:35e4:f97d])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902654800b001ae48d441desm839255pln.148.2023.05.16.15.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:33:31 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v5 03/11] block: Introduce op_is_zoned_write()
Date:   Tue, 16 May 2023 15:33:12 -0700
Message-ID: <20230516223323.1383342-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230516223323.1383342-1-bvanassche@acm.org>
References: <20230516223323.1383342-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce a helper function for checking whether write serialization is
required if the operation will be sent to a zoned device. A second caller
for op_is_zoned_write() will be introduced in the next patch in this
series.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blkdev.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index db24cf98ccfb..a4f85781060c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1281,13 +1281,16 @@ static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
 	return disk_zone_no(bdev->bd_disk, sec);
 }
 
+/* Whether write serialization is required for @op on zoned devices. */
+static inline bool op_is_zoned_write(enum req_op op)
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
+	return bdev_is_zoned(bdev) && op_is_zoned_write(op);
 }
 
 static inline sector_t bdev_zone_sectors(struct block_device *bdev)
