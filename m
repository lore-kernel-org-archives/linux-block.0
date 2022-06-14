Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0197DC43334
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 17:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344840AbiFNR5o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 13:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344154AbiFNR5k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 13:57:40 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D0828E2E
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 10:57:36 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so12509476pjm.2
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 10:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j0WMnw3s5H1gU6py81+g5xCi1MPpvvGla3Z8sOJv3wM=;
        b=PwasZf5FOq4XPQKu5uFYbXcHun2+O5QPo0Z0CbM6L2VJJabFJ9u2VnaEe/gRI4pXwf
         P1FJSI5kB0rx8tIPydTKVENveYyOMkEFwHJQ6oCHK6LceukcuP03HylMz7FY8jVHEJJG
         5dtWF8DSDJizvW5Jr79S8M8fwvUOfvQfPrHme/3gVjYfTkmEkVXqpSpw33zYCVUsHogM
         j5hwbXq2ZLtJPy+Z/fX1FdfES1i+ucHk2hyn+U4j2810P8zHAV3uRJETvwKWkJKDkWJo
         TSNzViy+Exe4hMZEFgpoh+KAXTfFcSdhzsjE6TrUZFR2sWMyNy+A4FuCUqeZ2sVMrin1
         PWPA==
X-Gm-Message-State: AJIora8IpXga7ME5WNSoZoHJr3TbvzemM4otbFbPHJuhe8yXDSUQQpaB
        wSJMEkqaN7YeTJ3BMuxDjCk=
X-Google-Smtp-Source: AGRyM1u38GywY2Zgo57XhQLJa0PPDf88pV7i7uLgH0BmsGuMfxSV3TsHn7haJ9EazGkn6ZiPoCAS5Q==
X-Received: by 2002:a17:90b:4d0a:b0:1e2:c0b4:8bb8 with SMTP id mw10-20020a17090b4d0a00b001e2c0b48bb8mr5740263pjb.94.1655229455832;
        Tue, 14 Jun 2022 10:57:35 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ab60:e1ea:e2eb:c1b6])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b0015e8d4eb1f7sm7519666plb.65.2022.06.14.10.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 10:57:34 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/3] block: Specify the operation type when calling blk_mq_map_queue()
Date:   Tue, 14 Jun 2022 10:57:25 -0700
Message-Id: <20220614175725.612878-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220614175725.612878-1-bvanassche@acm.org>
References: <20220614175725.612878-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the introduction of blk_mq_get_hctx_type() the operation type in
the second argument of blk_mq_get_hctx_type() matters. Make sure that
a hardware queue of type HCTX_TYPE_DEFAULT is selected instead of a
hardware queue of type HCTX_TYPE_READ.

Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e9bf950983c7..9b1518ef1aa1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2168,7 +2168,7 @@ static struct blk_mq_hw_ctx *blk_mq_get_sq_hctx(struct request_queue *q)
 	 * just causes lock contention inside the scheduler and pointless cache
 	 * bouncing.
 	 */
-	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, 0, ctx);
+	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, REQ_OP_WRITE, ctx);
 
 	if (!blk_mq_hctx_stopped(hctx))
 		return hctx;
