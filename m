Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F13C4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 10:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6442147A
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 10:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfDCK0n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:26:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbfDCK0n (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Apr 2019 06:26:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D11B9C1306F9;
        Wed,  3 Apr 2019 10:26:42 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD74060147;
        Wed,  3 Apr 2019 10:26:39 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Subject: [PATCH V3 5/6] block: don't drain in-progress dispatch in blk_cleanup_queue()
Date:   Wed,  3 Apr 2019 18:26:08 +0800
Message-Id: <20190403102609.18707-6-ming.lei@redhat.com>
In-Reply-To: <20190403102609.18707-1-ming.lei@redhat.com>
References: <20190403102609.18707-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 03 Apr 2019 10:26:42 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now freeing hw queue resource is moved to hctx's release handler,
we don't need to worry about the race between blk_cleanup_queue and
run queue any more.

So don't drain in-progress dispatch in blk_cleanup_queue().

This is basically revert of c2856ae2f315 ("blk-mq: quiesce queue before
freeing queue").

Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-scsi@vger.kernel.org,
Cc: Martin K . Petersen <martin.petersen@oracle.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
Cc: jianchao wang <jianchao.w.wang@oracle.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ad17e999f79e..82b630da7e2c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -338,18 +338,6 @@ void blk_cleanup_queue(struct request_queue *q)
 
 	blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
 
-	/*
-	 * make sure all in-progress dispatch are completed because
-	 * blk_freeze_queue() can only complete all requests, and
-	 * dispatch may still be in-progress since we dispatch requests
-	 * from more than one contexts.
-	 *
-	 * We rely on driver to deal with the race in case that queue
-	 * initialization isn't done.
-	 */
-	if (queue_is_mq(q) && blk_queue_init_done(q))
-		blk_mq_quiesce_queue(q);
-
 	/* for synchronous bio-based driver finish in-flight integrity i/o */
 	blk_flush_integrity();
 
-- 
2.9.5

