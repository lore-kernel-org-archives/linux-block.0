Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0021C433FE
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 04:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C78F5610CC
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 04:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhJTEG6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 00:06:58 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39862 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhJTEG5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 00:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634702684; x=1666238684;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6gb3s1zVXQceT0cndY6bROxz31Z1zp2P/F3Gu6V2XyI=;
  b=l8xWpwdVmng/JdQDHmZu+unqoT6UhTJMMNGXxdJWIewJHJ6xOKwv176I
   36qqY56+JQjc9gXhpXX+uwPyUask4F8eCYLqBtL6g8JGVGgqLTq4SqNnB
   WXPSt3/DkTYatmUdluDfJ9sZh5fGyxUH6hgmkCICtiII9hRjyfTPEnnVu
   CgME/MouTIObMKeG54lILYuOl0E+Rkcxi19vFU2xg9REJClCiBW5acr9N
   wxsuuiZuCnX8VYvaWMgO4Npa1yPnxDZXlkPmXr+Vv72QaCGA7sAG//RJ0
   uo6vGyfovpjF+sP9cFxWLi2KVuC14d0bDdRwqD9Vb9GRwn0txjkedRn1M
   w==;
X-IronPort-AV: E=Sophos;i="5.87,165,1631548800"; 
   d="scan'208";a="287242371"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2021 12:04:43 +0800
IronPort-SDR: jVDntCGLt2kGL90etJTFfMmTsPtU5VZDqdWxaZAqvuv0NZz06JlUnBhuLZtDbYTyjjt/fe3aaE
 1ttOkoixXHwxUeB+pr93GBGLUoAy8v3592xVdTdLTJC6HMDHHag4zPQx+sJj+07aV5wdObsz4s
 5ixbPcjSDPu23Mh3i/Smei3tqcDJwO3gYMUZrnUnJ2rG5weBC7zAenxwk33liwd10tFTHp5J56
 R9YZimoG6zd2K1nguDVNAAtDkyAh+9J+sZZNdwJUhRoNc/fyckrptjufrpuKzY+HBP4h8yZ3VU
 jwaE7+zSG54gg4mICj6Ql79r
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 20:38:49 -0700
IronPort-SDR: 4wQrjwGwvw+OWurqzimUm4b8acbqLaHLMOQqaCy2MODOlZ/Zu+uFUw6nuOiWWaaxzOSnLmmN1B
 871xHBqMvXI6D/iBqdHOWle17CN3xgBOLJz9rD55FijGDjBbIinNliU5NNPF5IvG+tGUEWw6UE
 ZrsXJABHfz/3Tedh3kWhRSUXpGkZqshsPHk0jBLzhCOz99C/eRpYwiDk1pchkiH2avjHOK2fm4
 1R4S0py31hW1tMnaGoiQ3gVd6z6YeV+3J6i6w5q4QNYp9Cr3hXt9cVmODC8Cw0eHQ5GEulTH+K
 M9I=
WDCIronportException: Internal
Received: from hy7bl13.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.195])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Oct 2021 21:04:43 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] block: schedule queue restart after BLK_STS_ZONE_RESOURCE
Date:   Wed, 20 Oct 2021 13:04:04 +0900
Message-Id: <20211020040404.132984-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When dispatching a zone append write request to a SCSI zoned block device,
if the target zone of the request is already locked, the device driver will
return BLK_STS_ZONE_RESOURCE and the request will be pushed back to the
hctx dipatch queue. The queue will be marked as RESTART in
dd_finish_request() and restarted in __blk_mq_free_request(). However, this
restart applies to the hctx of the completed request. If the requeued
request is on a different hctx, dispatch will no be retried until another
request is submitted or the next periodic queue run triggers, leading to up
to 30 seconds latency for the requeued request.

Fix this problem by scheduling a queue restart similarly to the
BLK_STS_RESOURCE case or when we cannot get the budget.

Also, consolidate the checks into the "need_resource" variable to simplify
the condition.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 block/blk-mq.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9c64f0025a56..439f78b0d86a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1318,6 +1318,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	int errors, queued;
 	blk_status_t ret = BLK_STS_OK;
 	LIST_HEAD(zone_list);
+	bool need_resource = false;
 
 	if (list_empty(list))
 		return false;
@@ -1363,6 +1364,8 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 			queued++;
 			break;
 		case BLK_STS_RESOURCE:
+			need_resource = true;
+			fallthrough;
 		case BLK_STS_DEV_RESOURCE:
 			blk_mq_handle_dev_resource(rq, list);
 			goto out;
@@ -1373,6 +1376,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 			 * accept.
 			 */
 			blk_mq_handle_zone_resource(rq, &zone_list);
+			need_resource = true;
 			break;
 		default:
 			errors++;
@@ -1399,7 +1403,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 		/* For non-shared tags, the RESTART check will suffice */
 		bool no_tag = prep == PREP_DISPATCH_NO_TAG &&
 			(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED);
-		bool no_budget_avail = prep == PREP_DISPATCH_NO_BUDGET;
 
 		if (nr_budgets)
 			blk_mq_release_budgets(q, list);
@@ -1440,14 +1443,15 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 		 * If driver returns BLK_STS_RESOURCE and SCHED_RESTART
 		 * bit is set, run queue after a delay to avoid IO stalls
 		 * that could otherwise occur if the queue is idle.  We'll do
-		 * similar if we couldn't get budget and SCHED_RESTART is set.
+		 * similar if we couldn't get budget or couldn't lock a zone
+		 * and SCHED_RESTART is set.
 		 */
 		needs_restart = blk_mq_sched_needs_restart(hctx);
+		need_resource |= (prep == PREP_DISPATCH_NO_BUDGET);
 		if (!needs_restart ||
 		    (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
 			blk_mq_run_hw_queue(hctx, true);
-		else if (needs_restart && (ret == BLK_STS_RESOURCE ||
-					   no_budget_avail))
+		else if (needs_restart && need_resource)
 			blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
 
 		blk_mq_update_dispatch_busy(hctx, true);
-- 
2.33.1

