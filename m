Return-Path: <SRS0=wI0I=WY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9F5C3A5A1
	for <linux-block@archiver.kernel.org>; Wed, 28 Aug 2019 04:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343E62189D
	for <linux-block@archiver.kernel.org>; Wed, 28 Aug 2019 04:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fHiw8lNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfH1EkX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Aug 2019 00:40:23 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:6867 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfH1EkX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Aug 2019 00:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566967223; x=1598503223;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yYmwTzjmt1KjiHSuzT1/YH/U5kzvWF3eLuwcY6UTprk=;
  b=fHiw8lNFTpGok40S0xltjKiKJzJ3lbvbaufQ6OvNCe50aMCCVfTM1tgH
   0+rTh5Tg1ei06AFi+GT1mCEWDy6nFQ1KN2ulDDedj7/CXzW+ON+VuvwF4
   LGgOTlNFxUXl4ork7d7ET7j/evyBkacARzTPYuPPPa2/Xy/5oAJHC5p4v
   yksKssvrNhvAmTVGKn37UKD68Eo5GVBUoMeN75SRqxJzWSKAWbgeOFUD2
   Fk+SnVYgEjLlsoGiN+4we1jn6VADkayvQ1dMlvyvBCjMPVjPvkqG+7cey
   dhiuBxDcaEAiPdz9PwlxE/tNdwy85Qqbe257jLt+C04rLVxWJ8WExgiS3
   Q==;
IronPort-SDR: /ktbm+FZrhyYWjPcKce1E8qmif1gEU0Uu7wf4vuj65vSfilRpl8oBFzptpZLceVXQNx6QIlvGt
 Y0gCxc9M2wsEXCdc/gU3aABGJZ4Vh4pBjqDt+Rsky4aRAfi9pMnY69fBQbOI5ImUGRmvyOM6Lh
 pmP9ULDYxSUTWheX06w3scJSPEbCRCeZVZUtzteX9u6IX73b90EjoX6iHb/55nHqiYTuidG5Ru
 0fIw99vodrC3qU7oXd25GJLr2iLnLQpKf/ZLjMuiesRHQ0Dln5b8NjbYCLcZ7iXQrZg1VhRfQ+
 wEU=
X-IronPort-AV: E=Sophos;i="5.64,439,1559491200"; 
   d="scan'208";a="117741157"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2019 12:40:22 +0800
IronPort-SDR: uRGxQHTG5FMf33pYWanD+nQXa1NRTKo+7HXztcnMbe6CG2BwTxuTIo92blN3MXa3NOe+Jjl9EC
 esIxzauCOZ8TPLGb8aeqIWEm7+2wBz6ByYjLEwUpc2+aHnVGVxs4/ezLNXnmIiRetafawTVE7C
 JbSJVDT4I8VuXkWNouDcivU3mAJzBuNqCYuinyfKci8+Js1UrjUq/VUqHNWHLGeYYKV6E+G1ZL
 lgYCYbsnuGCDh81kN5zf/VFR3p/49dtma+ieR/UBtRqEj6hv9jlaNEvgscMRbirwh66NwirXzT
 5B9E0N72s1l9zYO5gwQQSyEk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 21:37:32 -0700
IronPort-SDR: CaaTwcJHzqgVkDZJUGFJfK3yGPobA6nC5jS4KMegQGCpl1f0W1qteSeQnSL47gtJFGviA34GWV
 Kw0izig8vKYVzjJb8a9L1eQquajzGtk2vyhhLcFz6NwbaqsJFsHurQPYIJOQX8hpoFUOGEqJxc
 21Jot+Thi54I41gMidkot0vLf1Av9o9b3AW6J371O0ELfpdGnumGFR2cET7Ig2CDSP+GCVcqyz
 iwIv240YJmPpb+GQMHzeHj8+3mnnXPIPjIzKLrPdhGye2RocH2UaaOySJImuGPKMq8A+rliMJ/
 YM4=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Aug 2019 21:40:21 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>
Subject: [PATCH] block: mq-deadline: Fix queue restart handling
Date:   Wed, 28 Aug 2019 13:40:20 +0900
Message-Id: <20190828044020.23915-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 7211aef86f79 ("block: mq-deadline: Fix write completion
handling") added a call to blk_mq_sched_mark_restart_hctx() in
dd_dispatch_request() to make sure that write request dispatching does
not stall when all target zones are locked. This fix left a subtle race
when a write completion happens during a dispatch execution on another
CPU:

CPU 0: Dispatch			CPU1: write completion

dd_dispatch_request()
    lock(&dd->lock);
    ...
    lock(&dd->zone_lock);	dd_finish_request()
    rq = find request		lock(&dd->zone_lock);
    unlock(&dd->zone_lock);
    				zone write unlock
				unlock(&dd->zone_lock);
				...
				__blk_mq_free_request
                                      check restart flag (not set)
				      -> queue not run
    ...
    if (!rq && have writes)
        blk_mq_sched_mark_restart_hctx()
    unlock(&dd->lock)

Since the dispatch context finishes after the write request completion
handling, marking the queue as needing a restart is not seen from
__blk_mq_free_request() and blk_mq_sched_restart() not executed leading
to the dispatch stall under 100% write workloads.

Fix this by moving the call to blk_mq_sched_mark_restart_hctx() from
dd_dispatch_request() into dd_finish_request() under the zone lock to
ensure full mutual exclusion between write request dispatch selection
and zone unlock on write request completion.

Fixes: 7211aef86f79 ("block: mq-deadline: Fix write completion handling")
Cc: stable@vger.kernel.org
Reported-by: Hans Holmberg <Hans.Holmberg@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/mq-deadline.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index a17466f310f4..b490f47fd553 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -377,13 +377,6 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
  * hardware queue, but we may return a request that is for a
  * different hardware queue. This is because mq-deadline has shared
  * state for all hardware queues, in terms of sorting, FIFOs, etc.
- *
- * For a zoned block device, __dd_dispatch_request() may return NULL
- * if all the queued write requests are directed at zones that are already
- * locked due to on-going write requests. In this case, make sure to mark
- * the queue as needing a restart to ensure that the queue is run again
- * and the pending writes dispatched once the target zones for the ongoing
- * write requests are unlocked in dd_finish_request().
  */
 static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 {
@@ -392,9 +385,6 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 
 	spin_lock(&dd->lock);
 	rq = __dd_dispatch_request(dd);
-	if (!rq && blk_queue_is_zoned(hctx->queue) &&
-	    !list_empty(&dd->fifo_list[WRITE]))
-		blk_mq_sched_mark_restart_hctx(hctx);
 	spin_unlock(&dd->lock);
 
 	return rq;
@@ -561,6 +551,13 @@ static void dd_prepare_request(struct request *rq, struct bio *bio)
  * spinlock so that the zone is never unlocked while deadline_fifo_request()
  * or deadline_next_request() are executing. This function is called for
  * all requests, whether or not these requests complete successfully.
+ *
+ * For a zoned block device, __dd_dispatch_request() may have stopped
+ * dispatching requests if all the queued requests are write requests directed
+ * at zones that are already locked due to on-going write requests. To ensure
+ * write request dispatch progress in this case, mark the queue as needing a
+ * restart to ensure that the queue is run again after completion of the
+ * request and zones being unlocked.
  */
 static void dd_finish_request(struct request *rq)
 {
@@ -572,6 +569,8 @@ static void dd_finish_request(struct request *rq)
 
 		spin_lock_irqsave(&dd->zone_lock, flags);
 		blk_req_zone_write_unlock(rq);
+		if (!list_empty(&dd->fifo_list[WRITE]))
+			blk_mq_sched_mark_restart_hctx(rq->mq_hctx);
 		spin_unlock_irqrestore(&dd->zone_lock, flags);
 	}
 }
-- 
2.21.0

