Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BFEC7EE22
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 22:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjECWwS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 18:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjECWwR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 18:52:17 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853DC44B6
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 15:52:16 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ab14cb3aaeso17457955ad.2
        for <linux-block@vger.kernel.org>; Wed, 03 May 2023 15:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683154336; x=1685746336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9xEHhsfF8lF/PhpCFPK0EOTIgfdfEU9U94/xuYJ5AY=;
        b=fzQeRU8QIoWOAIyD3RSV+kri+K3r/f27pvTzjzjK9zU5ALgIjo83YO5m21MoOHDRJf
         +C3+RajS8xWLWuMpFw8mwsFf+kWZZPPIfz92dMxvAGTx3WhlWmIq1MzubPiN+4Nu6XT4
         pkMXRWUumd41m8rQxQ73p0xlI1cPackmGlJty9BMD9PXJTgiWcBstooPivkNO13dt+24
         QnKg/ekhXt2BSf+8HrHiXREyLLCMeM4cqxp2xJ2zTuLAEjqEeFHURkt72Q9qeJqNxgrt
         n/3P+tuKKHa4LrpSOGgSogQTYIsOFR+1BX2NS1CCn7w8/9sJpsCca1UReVpcZZtAbd8z
         x2GQ==
X-Gm-Message-State: AC+VfDxPhP9emEvUjHRyN78G1rnM5a4lgfAfN6O6B8uYobm4aDD1iRwB
        4payHrFaEgVtTSsvmXsQddw=
X-Google-Smtp-Source: ACHHUZ6wFEBSvPbeEjZiEd0FdKy7CjqXWMnHDEN6al5UTX23duHDX9JgMC5sNpUTcfGACZTKJ59cGw==
X-Received: by 2002:a17:902:cec2:b0:1a6:dba5:2e60 with SMTP id d2-20020a170902cec200b001a6dba52e60mr1738278plg.25.1683154335913;
        Wed, 03 May 2023 15:52:15 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:2c3b:81e:ce21:2437])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902744300b001aad4be4503sm227085plt.2.2023.05.03.15.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:52:15 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 02/11] block: Fix the type of the second bdev_op_is_zoned_write() argument
Date:   Wed,  3 May 2023 15:51:59 -0700
Message-ID: <20230503225208.2439206-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
In-Reply-To: <20230503225208.2439206-1-bvanassche@acm.org>
References: <20230503225208.2439206-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Change the type of the second argument of bdev_op_is_zoned_write() from
blk_opf_t into enum req_op because this function expects an operation
without flags as second argument.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>
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
