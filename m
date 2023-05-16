Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1357DC77B75
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 22:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjEPWdc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 18:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjEPWdb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 18:33:31 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E693A80
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:33:31 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1aaf21bb42bso1437555ad.2
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684276410; x=1686868410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MJbfIY4s3b5GVikbVG1xJxZkHbW16AzSAn+W99G4rY=;
        b=eytDAL+uw7+1WutU9gR59ujZ2Xu7vFxXO8v5IeWBjK4s272d/cwhjXSCTMQr3QEJv7
         TNGIuSMZL9HCgFedyCQKJZFv7BB+s6aXboRJsUB2L83wRAvVzNJfUoa1LUTSlPuSjnht
         oX7Ngd4WNDa9zAY6PXBoEk9eoNNiWnADGX3lWNnfP0qtEDJR/pCgsB+jHuvB2buNm9Cg
         wtBDLdId8yB8VTIxg+qNnPpLmYnG4876tJHmORWzkkro1z7ACorPcR+Rv/vf7nuoSjNy
         DuqkXAIgZBAtQ7UxJWwKwp1S96D0ky6JwfBj11ZsYjC3W49svjl1fTlD9aGNFkUmPetj
         Yy0A==
X-Gm-Message-State: AC+VfDydKZOtp/rr8P10MKvoaHa3Qf/jEjo9QLj6fSkkt48B1jBnF6Z8
        1knQdpcAZKY6fpM2DQMCg5o=
X-Google-Smtp-Source: ACHHUZ7lVUtRDE2gpo0joCTbdV8ntpwVRq9a6P0l6WiC7I6TqyP3WfkkE/kTEq3aAfOE7qPsW5OJMg==
X-Received: by 2002:a17:903:1249:b0:1ab:220a:9068 with SMTP id u9-20020a170903124900b001ab220a9068mr51204015plh.42.1684276410412;
        Tue, 16 May 2023 15:33:30 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:baed:ee38:35e4:f97d])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902654800b001ae48d441desm839255pln.148.2023.05.16.15.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:33:30 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v5 02/11] block: Fix the type of the second bdev_op_is_zoned_write() argument
Date:   Tue, 16 May 2023 15:33:11 -0700
Message-ID: <20230516223323.1383342-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230516223323.1383342-1-bvanassche@acm.org>
References: <20230516223323.1383342-1-bvanassche@acm.org>
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
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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
