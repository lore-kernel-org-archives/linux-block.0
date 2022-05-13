Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4085EC433EF
	for <linux-block@archiver.kernel.org>; Fri, 13 May 2022 17:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359072AbiEMRN0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 May 2022 13:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382794AbiEMRNY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 May 2022 13:13:24 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C1045AE0
        for <linux-block@vger.kernel.org>; Fri, 13 May 2022 10:13:21 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id j14so8556466plx.3
        for <linux-block@vger.kernel.org>; Fri, 13 May 2022 10:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mmsQAq3pDdoQPAibvdtuABUHGERA0yWqJedTHtxw11Y=;
        b=e+xycRavT00dAyi0vLVlOIhYuvzcgkpIVflkGnV9fM+5TXo4kuMh3jTwdtF+mawsiz
         2pOiMb6DxXtcgCCS1I/FlR0DpdXOyhaqY+jtv8MUMz2T38JYqwNb99hAsRUSzyVswSQn
         laHmcsAwiC589py7RzTVRV/lhBAGuEHrA1QZrYX5Fc9iimsFiDs7njkgNpwXNgytNJ1o
         28TxqBK3OTlYj3Nueh0X7dIAnQ2E6UOnR+T9KxSnKiJznnR8SNRhWuGVeameU97/Jf42
         OPDzooPcHefiy2p20Jiy0IdTgldYOCTub6KGtxrcbg139S53f+S6g6nx/bFDAIXNYx6v
         RYsQ==
X-Gm-Message-State: AOAM531+UUBijjtOuVgj6i6a6FKMGF2hK8psdQ4YuHCJ5NK99w0IT/OZ
        pIdMhRWzkxZZpWn9ws+JGRQ=
X-Google-Smtp-Source: ABdhPJyRDSBPuK8xWpy/xlzYCUCh8kviKTfazLzTbnuhbtEK5extm4GwqFHxfzBMnA+rNlbhc1Te9A==
X-Received: by 2002:a17:90a:4897:b0:1c7:5fce:cbcd with SMTP id b23-20020a17090a489700b001c75fcecbcdmr17088245pjh.45.1652462000614;
        Fri, 13 May 2022 10:13:20 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a1a4900b001dcf9fe5cddsm1817718pjl.38.2022.05.13.10.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 10:13:19 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH] block/mq-deadline: Set the fifo_time member also if inserting at head
Date:   Fri, 13 May 2022 10:13:07 -0700
Message-Id: <20220513171307.32564-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before commit 322cff70d46c the fifo_time member of requests on a dispatch
list was not used. Commit 322cff70d46c introduces code that reads the
fifo_time member of requests on dispatch lists. Hence this patch that sets
the fifo_time member when adding a request to a dispatch list.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Fixes: 322cff70d46c ("block/mq-deadline: Prioritize high-priority requests")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 3ed5eaf3446a..6ed602b2f80a 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -742,6 +742,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	if (at_head) {
 		list_add(&rq->queuelist, &per_prio->dispatch);
+		rq->fifo_time = jiffies;
 	} else {
 		deadline_add_rq_rb(per_prio, rq);
 
