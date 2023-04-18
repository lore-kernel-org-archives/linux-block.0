Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BA4C7EE20
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 22:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjDRWk3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 18:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjDRWkY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 18:40:24 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DF0A24E
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 15:40:16 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1a6bc48aec8so11591165ad.2
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 15:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681857615; x=1684449615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvVUDhfzxvDto383Bl91m7mAMsd3sic7UnlWPq1gf8o=;
        b=D/575cQV+xc753lnn44tC12QlikcQ8oCpXxXAlI+x+m74LrFx2rLzPsMBo6OvYEvoM
         lLHRnxj/+SOHNYJIDuhTZWq7hPU6HA8foxRxCx+sXCjV62EihLlyGCESM0ZOy9rbInFu
         bDZzJKghnTLz6xkXGbq63UZ0KQQ+F3zAdO5pi3/A595jU0H+fpWn+GU99Hz7Y7u6pvSr
         ikvjcQVBO/OK80DxmEpZQFxNSLm5uRwdWnyYg5DfmmOPdKMXx6B/i3Kov/McEe1L+XaE
         hkIb6v4mYR1CVQwqUQhu1Nk8VVYCrRwdwBlr5mqA86ZelhBC6WuxAbo2oQcrkQesiVz2
         Efhg==
X-Gm-Message-State: AAQBX9doBudfgr06Cdgbo0H27PGRQ1fkgzd49qfcEbVaAKwBhxu8bo0L
        0TfiDv+mUvFtKp4txYmEK7s=
X-Google-Smtp-Source: AKy350YrIowWxWabW8nlyBPt7JLvo/reJWOa7py2IU54Ze2EjqpeuIGXYeHmTUOUTW3jB+evxrL2Eg==
X-Received: by 2002:a17:902:c613:b0:1a2:8c7e:f310 with SMTP id r19-20020a170902c61300b001a28c7ef310mr2939758plr.35.1681857615478;
        Tue, 18 Apr 2023 15:40:15 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:5d9b:263d:206c:895a])
        by smtp.gmail.com with ESMTPSA id bb6-20020a170902bc8600b001a4ee93efa2sm8285646plb.137.2023.04.18.15.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:40:15 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 06/11] block: mq-deadline: Disable head insertion for zoned writes
Date:   Tue, 18 Apr 2023 15:39:57 -0700
Message-ID: <20230418224002.1195163-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230418224002.1195163-1-bvanassche@acm.org>
References: <20230418224002.1195163-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make sure that zoned writes (REQ_OP_WRITE and REQ_OP_WRITE_ZEROES) are
submitted in LBA order. This patch does not affect REQ_OP_WRITE_APPEND
requests.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 4a0a269db382..a73e16d3f8ac 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -796,7 +796,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	trace_block_rq_insert(rq);
 
-	if (flags & BLK_MQ_INSERT_AT_HEAD) {
+	if ((flags & BLK_MQ_INSERT_AT_HEAD) && !blk_rq_is_seq_zoned_write(rq)) {
 		list_add(&rq->queuelist, &per_prio->dispatch);
 		rq->fifo_time = jiffies;
 	} else {
