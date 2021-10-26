Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17494C433F5
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 16:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2C3E60E8B
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 16:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbhJZQyB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 12:54:01 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:48179 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbhJZQx7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 12:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635267093; x=1666803093;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qZ6hwyvPxJb5cGU1xV/Z814Nl/QSyx2D6YLcmVFesAE=;
  b=fj1gYqN+N0EIT68ELHcfjf+fay1I/4JuqIIXduL/l+DwVe2nD3mterzo
   HpMTh4SQKN42iiTQX6cbxStdyWyrDrOeK4I8+8TQFbZuHcSwR/ckS0Upn
   zNFB3YnFMeUPL2DrfqfOr0jZPhQuKHhmcnwP5imfUdfNYQoHyxbUP8GYE
   TwtSlivyPziclTSFxNbMmIB4FvKwC9d2269VJedSVh6yse/7fX7ntG8pv
   XWMhVZ1tWmc2kON5WLNyVnSbYi+/HTXKsnWrnqMf1QHa98X7Msraj6654
   06rZ9RExV+MdZm1psfJkh0njv39j7jgFyZ85czMbHs7rO9ij995TQFe9C
   w==;
X-IronPort-AV: E=Sophos;i="5.87,184,1631548800"; 
   d="scan'208";a="183889430"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2021 00:51:33 +0800
IronPort-SDR: dbffmHeYS6qb+GJv9idlyetMxPD6RxrFxrDXXbu3KDdE28925anCW0YSXjAHwofTvdAk0Oe0cW
 fpFFh5PzdotMVC/CFLqh808elE6Twwq81qv1n8apQLafziMcpOVJj+O349VA55/MXAnjrhDJdo
 vtEDg451TnfX7ImnCQ7h9qcAMQFP5rDo6Jwna9yOvHG/f9YZdGalSPRUzXVIpDGs8UF8whEA1T
 tsYRQvzRNGl14gCAuPs9UrDd+/wc11TE7M73m1gIH3+/57lwEXgn0Yp3b6zl+O5AMfZr9Ym1uD
 xvLDzgvPWqj4J+s21ugqFnBr
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 09:25:32 -0700
IronPort-SDR: CBtzhmOEgEB6+xT4dcNmNA4qOE7KrJ/EccPcFSeQxFFi2kH0p+/IttplThYuYUzM8+JM4TRlv1
 mHsTh0dwcYyJiOPg+g/6ajrGdg2smbeftXKNVlYx+UIhLZozuMSZnH4DPxXVJ2KIx8gTCEJt65
 xcYW8ZIfb33aOhxlmFpWSlBBFyt6oJd8GGa8X1wufrnIcKWDyEWb2aWEl1b3ncviX8yXHOv5U7
 /Wywp/kNxn1uR5mAezLDWLjNxOoEKlJHfvGe8DPpTLUxINnlmP3DYVOTErd/asnEvGLG7a6nzm
 3jY=
WDCIronportException: Internal
Received: from 3lpbl13.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Oct 2021 09:51:35 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: [PATCH v2] block: schedule queue restart after BLK_STS_ZONE_RESOURCE
Date:   Wed, 27 Oct 2021 01:51:27 +0900
Message-Id: <20211026165127.4151055-1-naohiro.aota@wdc.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>
---
Changes from v1
- Rename need_resource to needs_resource to be consistent with
  needs_restart
- Use the if- to set needs_resource when prep == PREP_DISPATCH_NO_BUDGET.

 block/blk-mq.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9c64f0025a56..dc49483334c7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1318,6 +1318,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	int errors, queued;
 	blk_status_t ret = BLK_STS_OK;
 	LIST_HEAD(zone_list);
+	bool needs_resource = false;
 
 	if (list_empty(list))
 		return false;
@@ -1363,6 +1364,8 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 			queued++;
 			break;
 		case BLK_STS_RESOURCE:
+			needs_resource = true;
+			fallthrough;
 		case BLK_STS_DEV_RESOURCE:
 			blk_mq_handle_dev_resource(rq, list);
 			goto out;
@@ -1373,6 +1376,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 			 * accept.
 			 */
 			blk_mq_handle_zone_resource(rq, &zone_list);
+			needs_resource = true;
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
@@ -1440,14 +1443,16 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 		 * If driver returns BLK_STS_RESOURCE and SCHED_RESTART
 		 * bit is set, run queue after a delay to avoid IO stalls
 		 * that could otherwise occur if the queue is idle.  We'll do
-		 * similar if we couldn't get budget and SCHED_RESTART is set.
+		 * similar if we couldn't get budget or couldn't lock a zone
+		 * and SCHED_RESTART is set.
 		 */
 		needs_restart = blk_mq_sched_needs_restart(hctx);
+		if (prep == PREP_DISPATCH_NO_BUDGET)
+			needs_resource = true;
 		if (!needs_restart ||
 		    (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
 			blk_mq_run_hw_queue(hctx, true);
-		else if (needs_restart && (ret == BLK_STS_RESOURCE ||
-					   no_budget_avail))
+		else if (needs_restart && needs_resource)
 			blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
 
 		blk_mq_update_dispatch_busy(hctx, true);
-- 
2.33.1

