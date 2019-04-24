Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE69FC10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 11:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB22218D3
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 11:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfDXLDN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:03:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfDXLDN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 07:03:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BF08FC062EC4;
        Wed, 24 Apr 2019 11:03:12 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC67E5C28D;
        Wed, 24 Apr 2019 11:03:09 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: [PATCH V7 8/9] block: don't drain in-progress dispatch in blk_cleanup_queue()
Date:   Wed, 24 Apr 2019 19:02:20 +0800
Message-Id: <20190424110221.17435-9-ming.lei@redhat.com>
In-Reply-To: <20190424110221.17435-1-ming.lei@redhat.com>
References: <20190424110221.17435-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 24 Apr 2019 11:03:12 +0000 (UTC)
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
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Tested-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f5b5f21ae4fd..e24cfcefdc19 100644
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

