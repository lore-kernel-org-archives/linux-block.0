Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F95C7EE25
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 22:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjECWwT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 18:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjECWwS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 18:52:18 -0400
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B246E44B6
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 15:52:17 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-24de9c66559so3549037a91.0
        for <linux-block@vger.kernel.org>; Wed, 03 May 2023 15:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683154337; x=1685746337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvS2OGkpDpx7sski0vLUQblDqC4xZTwM3EDqACfSkk4=;
        b=gI9QEWLAeEurKoiX6lTTua8zgBOI2E352nRweChN5rr/eGecq1F/yypbONs6zPcLwZ
         5aUNL8eDRLCa3sHS5g8RVgekLSZ0bFt8/bq+Zo7vLAp8CWMFt/LlekY4D5ez4myPQTAV
         0gYaP2e1cFIPWZgox0FK1u2TRDwXWAzbVQys+zZlyos4tvrmYvP3DfJArXY1uKenFZK/
         T0hr8vlim/NQ0zYZh2ZAEN80t4BPs4Q5bqUbNPB42JCXL7yDfSP3tm1yKAA4pk+1gpv0
         reSQdl2h9BwLJgvgovcFy7+RuQt2PYB8Q9UmSBQy7tvvYaGv4MRInKBzdE60GYWEcrqR
         jlWQ==
X-Gm-Message-State: AC+VfDyy7aPZJQsk932IdMWNs3tLh2xCK5dilF1QWiR/whqDlFoW4TBG
        BkXIpKbKXhACL3WcKFeKNTC054+Z6iY=
X-Google-Smtp-Source: ACHHUZ5aG1SdUJIociPQqeJCl99wwRlncHNbaZ2V+BTgjps+D4XpSlUqORVAAuFfZePwJ8XUZGM5iA==
X-Received: by 2002:a17:90a:f48d:b0:24e:37a8:a19 with SMTP id bx13-20020a17090af48d00b0024e37a80a19mr50917pjb.47.1683154337103;
        Wed, 03 May 2023 15:52:17 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:2c3b:81e:ce21:2437])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902744300b001aad4be4503sm227085plt.2.2023.05.03.15.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:52:16 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 03/11] block: Introduce op_is_zoned_write()
Date:   Wed,  3 May 2023 15:52:00 -0700
Message-ID: <20230503225208.2439206-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
In-Reply-To: <20230503225208.2439206-1-bvanassche@acm.org>
References: <20230503225208.2439206-1-bvanassche@acm.org>
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
Cc: Christoph Hellwig <hch@lst.de>
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
