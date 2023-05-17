Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F04AC77B7F
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 17:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjEQRpl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 13:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjEQRph (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 13:45:37 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966AFAD20
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:45:08 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6439f186366so779061b3a.2
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684345474; x=1686937474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gy/YzMXYBbHQ6xn4xkeaIqLzTZzU9fXUdvN/JMs2Vas=;
        b=hKpVAD0SUtL4qLJLrzbWx2Fazrlffoib1pc5hLRIz3yHb/6vS1rmDcBuSXVqM6W5YP
         IhQf+THU81hqCBQ/ZliAx5+wjOqq+K0uoaY8rn677DZ3+cvhUpO+tJwd4FZxoIBZcuvC
         X5SrcQzldRkAznFvwNWTUk357uZjt0997mKYK+x6fOrIyHazkpB8r1aucDuOnTcNXEfk
         UQG+fr9ySgbY1NFvjxwKBnDasdUBQUDOQKgBBlKEocLoEXDQb9+ww2wvfy0wdUiSw21g
         i8BusqL54M9ZiiZf3x7fVP7bjycvdyjaGBPMO1aeZULUmw9gD5UUBCbXfsRlytkjn2eT
         tVHw==
X-Gm-Message-State: AC+VfDxmdZ0uvm/NfT1VNDW2KRmBnGCOYfV9CilpAS+FpEubBzXJVgnf
        NLYR8M6umjbiuB4B9fdK8EA=
X-Google-Smtp-Source: ACHHUZ7geWLB0MlA+iDGypy54HwYLGSkMVeHzSGC0qhxXaz1j/Z6ZnaUvFtuZ4GozilxvVmJVabNgw==
X-Received: by 2002:a05:6a00:138f:b0:64a:a1ba:50fd with SMTP id t15-20020a056a00138f00b0064aa1ba50fdmr610590pfg.22.1684345473991;
        Wed, 17 May 2023 10:44:33 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id d22-20020aa78e56000000b00646e7d2b5a7sm15334410pfr.112.2023.05.17.10.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:44:33 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v6 03/11] block: Fix the type of the second bdev_op_is_zoned_write() argument
Date:   Wed, 17 May 2023 10:42:21 -0700
Message-ID: <20230517174230.897144-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230517174230.897144-1-bvanassche@acm.org>
References: <20230517174230.897144-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Change the type of the second argument of bdev_op_is_zoned_write() from
blk_opf_t into enum req_op because this function expects an operation
without flags as second argument.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
Fixes: 8cafdb5ab94c ("block: adapt blk_mq_plug() to not plug for writes that require a zone lock")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b441e633f4dd..db24cf98ccfb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1282,7 +1282,7 @@ static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
 }
 
 static inline bool bdev_op_is_zoned_write(struct block_device *bdev,
-					  blk_opf_t op)
+					  enum req_op op)
 {
 	if (!bdev_is_zoned(bdev))
 		return false;
