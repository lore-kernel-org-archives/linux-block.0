Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2708C77B75
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 22:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjDRWkZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 18:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjDRWkX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 18:40:23 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC4893CA
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 15:40:09 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2472a5dbbdcso1265794a91.0
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 15:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681857609; x=1684449609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPEqYdqY9x8oBw3C6GBCLbSRvqVeT6wInbSRkBCgpDU=;
        b=UOSlnHUtCJLDFIipODJHDz0mBGxMprn8gpsEiYTm9fK41pSCcKzjd9+lPrZWO4HjWu
         ACqkGfwJ9XJynEMYGfAQN6fAsq7Ab9Sg0B/SQsoPKq8zcLpcGFFMhmh3BdeppEmPQJLi
         kwimZkEbr93samyNTR2cp0nMJ1FupQaAorH83IXIhSlTAcsjA1C9Dd2nJwpgVot5WFHe
         1K3j3DmAZzaWjzKetE2JlzwWDiKgUrpJzze845cw7IeCTV5PJnQiQyLZAdVp4oMv1b3c
         Yr6y/hBMKLaKNypxi2dX6Ieo/XGPBgSYnY55K3LnggQiOu0jM3s7JO0kLt53DoF7M6yD
         C10A==
X-Gm-Message-State: AAQBX9dTmbiFJ93qpZ8aYggOH68D4P5y/mN5mqLcWXmX3MZ6wifa1jKP
        YzfdeZxlncJJnM2uP7DIEQQSws589hM=
X-Google-Smtp-Source: AKy350ZIjQJ5qhghZMSedXZADmFmFHH3hxRRI5+YbQ4AoGw1TiCHAfmuwXl1xcMBKYm4RJ/+UxTfYQ==
X-Received: by 2002:a17:90b:1c10:b0:247:603a:bd60 with SMTP id oc16-20020a17090b1c1000b00247603abd60mr857927pjb.45.1681857609079;
        Tue, 18 Apr 2023 15:40:09 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:5d9b:263d:206c:895a])
        by smtp.gmail.com with ESMTPSA id bb6-20020a170902bc8600b001a4ee93efa2sm8285646plb.137.2023.04.18.15.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:40:08 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 01/11] block: Simplify blk_req_needs_zone_write_lock()
Date:   Tue, 18 Apr 2023 15:39:52 -0700
Message-ID: <20230418224002.1195163-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230418224002.1195163-1-bvanassche@acm.org>
References: <20230418224002.1195163-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove the blk_rq_is_passthrough() check because it is redundant:
bdev_op_is_zoned_write() evaluates to false for pass-through requests.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index fce9082384d6..835d9e937d4d 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -57,9 +57,6 @@ EXPORT_SYMBOL_GPL(blk_zone_cond_str);
  */
 bool blk_req_needs_zone_write_lock(struct request *rq)
 {
-	if (blk_rq_is_passthrough(rq))
-		return false;
-
 	if (!rq->q->disk->seq_zones_wlock)
 		return false;
 
