Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F50C76196
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 00:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbjDGARb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 20:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238666AbjDGAR1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 20:17:27 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039269757
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 17:17:27 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso42137629pjb.2
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 17:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680826646; x=1683418646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0rraQvI0NSDkdGimavbgcqDUTGPiPZaZulhFDWUQ2I=;
        b=TOBna3HKtQ2O4bRH0MqjyO4MRXPuBiE3yvMwgg/QU0izn5uNHFmz/W9S63FY15R1SV
         vFKKtJkVf1QB+1irGOQRMTbuTBxnrRDAkdGTEVP8RHOOkCBZF3NEx4QfdKhCkdfXvP3J
         odeQ4NAin7F5V71Aub7Uia9/mfsyLWba0H1fPYb79uGmEbTtys6NvyAJvjPC4cyEvM6L
         GXIKOTehNTSgKtR0C3SZZQ0kz7UhQ2jbx4Nw4mNQxpdLmby9iwOsdooy3mik260KaUtU
         eE9FDKv8xcaMJrXt0+Y4IChH8i2vVpowlnoLbsNFXV5J0slNzaS5mDQKpAd7KIjIJtp5
         endQ==
X-Gm-Message-State: AAQBX9cQsi/cj4tP2Qkdk+/5aBzsvxMdymrCSsJZrtL2kqq73IdXpaSc
        bqvMFZx/ab26d753Dix8WFI=
X-Google-Smtp-Source: AKy350ZeMOFpCwtskN2LBCnDEDifosZNJFmIvD5zGf7js3IBK0Ev4MhVVygPa4ZXmASfPDTxD+kurg==
X-Received: by 2002:a17:902:cec8:b0:1a1:80ea:4364 with SMTP id d8-20020a170902cec800b001a180ea4364mr1117393plg.31.1680826646642;
        Thu, 06 Apr 2023 17:17:26 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id x9-20020a1709028ec900b0019a773419a6sm1873676plo.170.2023.04.06.17.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 17:17:25 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 09/12] block: mq-deadline: Disable head insertion for zoned writes
Date:   Thu,  6 Apr 2023 17:17:07 -0700
Message-Id: <20230407001710.104169-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230407001710.104169-1-bvanassche@acm.org>
References: <20230407001710.104169-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make sure that zoned writes are submitted in LBA order.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 50a9d3b0a291..891ee0da73ac 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -798,7 +798,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	trace_block_rq_insert(rq);
 
-	if (at_head) {
+	if (at_head && !blk_rq_is_seq_zoned_write(rq)) {
 		list_add(&rq->queuelist, &per_prio->dispatch);
 		rq->fifo_time = jiffies;
 	} else {
