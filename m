Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BAEEB64D8
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 20:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjFUUMr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 16:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjFUUMq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 16:12:46 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F470199B
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 13:12:45 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6687446eaccso3410319b3a.3
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 13:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687378364; x=1689970364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVq8bMavG+J+TItlo7eDuWtvWGDPFyniiDmNwZ7+h6o=;
        b=lyQK4h7dGOzvRpgzkn1I4JsgkkAOEzUKW7ml/CxNzr98OPYDia9c/B4ZiIMRY41/Pe
         yaQBz2vuo04llDSKkYq1ZLNqRjqnPgaI0bMI4fkeUSDWiGNkGOWVI9NTL4x/wCbJJgNe
         gVZ7g3GJhomyzhwkbjjY82LE5VqRZAlvlc70q8+cpv4PnMBTSMVDCpFyWszQXq0bU/mM
         sxlPNlAhHgader8Kv1zrDzA/WEwt2yR7IMdplm0rvJoaRBcb+lqgZSGuW/wHv8gNWnJS
         YicZF9pGeNdFyBOD71FWt/+2/ViMKAELJ4MipFdXWwG+ge91IH0sRwzKCpeNVPQR3SaC
         0vZw==
X-Gm-Message-State: AC+VfDxpxss+emWoB6aUxwyNHj5C0mFGH4XiMhlM/m2TR6QPLR6Y7U36
        p5tJQH1XVZRUbeV3hEoqNZQ=
X-Google-Smtp-Source: ACHHUZ53e8v6By9/4mpy8k7Lk4XxQoYz1U+xzEX8PzKNEjWzj6cQ00lcn6KJe86ujnUYa2OavZRF8w==
X-Received: by 2002:a05:6a20:1450:b0:121:9e73:5531 with SMTP id a16-20020a056a20145000b001219e735531mr11971446pzi.40.1687378364417;
        Wed, 21 Jun 2023 13:12:44 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:c0b7:6a6f:751b:b854])
        by smtp.gmail.com with ESMTPSA id h8-20020a63df48000000b00548fb73874asm3522983pgj.37.2023.06.21.13.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:12:44 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v4 2/7] block: Simplify blk_mq_requeue_work()
Date:   Wed, 21 Jun 2023 13:12:29 -0700
Message-ID: <20230621201237.796902-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230621201237.796902-1-bvanassche@acm.org>
References: <20230621201237.796902-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move common code in front of the if-statement.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 41ee393c80a9..f440e4aaaae3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1458,13 +1458,11 @@ static void blk_mq_requeue_work(struct work_struct *work)
 		 * already.  Insert it into the hctx dispatch list to avoid
 		 * block layer merges for the request.
 		 */
-		if (rq->rq_flags & RQF_DONTPREP) {
-			list_del_init(&rq->queuelist);
+		list_del_init(&rq->queuelist);
+		if (rq->rq_flags & RQF_DONTPREP)
 			blk_mq_request_bypass_insert(rq, 0);
-		} else {
-			list_del_init(&rq->queuelist);
+		else
 			blk_mq_insert_request(rq, BLK_MQ_INSERT_AT_HEAD);
-		}
 	}
 
 	while (!list_empty(&flush_list)) {
