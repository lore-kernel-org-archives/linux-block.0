Return-Path: <SRS0=ruTu=VG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72393C73C53
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 19:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4252082A
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 19:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WiE6J7l2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfGITVs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jul 2019 15:21:48 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:63323 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGITVs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jul 2019 15:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562700108; x=1594236108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=qTE8enHLzqH4ca+dq1xEYRK9TO6PQQjULTVfQGS6ZVM=;
  b=WiE6J7l2u/XpiH5qJrxcQ8CJ17P1lmCiNJa1btrzk/KvYSELmWEYQfsN
   TQHOPfv/029m0S/1A+AUJMPEXjJ+u/NuC2tY4bfkG3vKodE99psP7KP/1
   Sf1VBQ9eK4Pa3Z2FWKvWDYmzgmBmPwmG6X3PIzkj6t+PIrwFB8D1kDzBg
   1G8q1WAqRXNC5hM2OU6rF3uUG2JgLEp0gHNmlcFPU9K6P3e4OWQ7y62h6
   7sWhgGDhwQVJL3a0PQLfp1BGTY+PuvGkPCa87agtOtOpbhDFH2UzsoJ15
   5lcSslg2ZGSWuCKwkoDpEqIkt7Q2tu5e6bFVHoPyzhpCfxftnpPsmJfjs
   A==;
IronPort-SDR: nh4qCIMuyO3JbgXJfv2amjKYwnDzWCO5cXw94LTG+0rJd9VBjyZmv2wMBM8lUAdyzVJ+92eOq4
 RWhM+lZ5ixMQfVDIo9pJCFVUckUuwMCGTPiXaHnWJOszPOQBT4DvTojL13rxxenmfUX/9Kv5yn
 UKTxZMvUdyXOQ246qaUjpufO4vqS1e2LFS/fnYke9uk5J1i+mHccyNImnJkkgpQY7pXztrb3Oz
 w4fZWDibNuOKVA2/Vvt8kE4awkuxvlhOunO+5d6exizE6bYLMSUc5dTVQGpQPo1Tp1aFHNakfv
 8xE=
X-IronPort-AV: E=Sophos;i="5.63,471,1557158400"; 
   d="scan'208";a="114198797"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2019 03:21:47 +0800
IronPort-SDR: WCI0+jFpLLoX8h0GllL6PEf2zAhIImGKtnWnw8HV/NEqwEtRinnKeallcGtIJm55vx83CCq2Dx
 t88YbdAf0XHxF4fFZM/qlaRRARbKQwEqCFF6Cc3hPsGj3xgLY5DcXFSjEQaPCVdFjXgEwcntXY
 DAj63lPeygu8Z5wrXnasysoyJJCD0RBYu+sNu+9Zq6C2xkUVs22H/HX0yXXoKlnQDmrGEBk43A
 wdKQVLmuxp/UYuXyo+pUDojrxkeL2x5/Mf3gLco91QoX3gI+Ch5itJtjAtcQO4H7jc34MbxCXz
 rNl6WD46vsOrL2lu2bUyvEtW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 09 Jul 2019 12:20:34 -0700
IronPort-SDR: RvvxTnNCmVe4eiZneO+4y8GfUHMJIOENi3CBe4NOUnpaZQY6+btsijgUHqSuCxkomfCuX8DpFc
 khGX2VHQ8RCpxlGb1J83wXc/JtPi/Fm6S2wTGGF88r3t5wpYvkDNAJfAYUwTDYhyd/VgrudMxF
 GhjKu9wOqivtT5FH+3VmYfBx+3FdjcMrTa5Ww11+qviw1BUHZTXlciQhIjcoS1B7dZZu+Nso8C
 yplLaASkKUKI2ZGNhHh7mn2hwu2LtcGy6aB3gawycUfdJ9hAR7ehRbDaqJfl82PVrpjtkj5LeL
 a80=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Jul 2019 12:21:48 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 2/6] null_blk: create a helper for throttling
Date:   Tue,  9 Jul 2019 12:21:28 -0700
Message-Id: <20190709192132.24723-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190709192132.24723-1-chaitanya.kulkarni@wdc.com>
References: <20190709192132.24723-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch creates a helper for handling throttling code in the
null_handle_cmd().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 39 ++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index b3be08edea43..4447c9729827 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1133,28 +1133,39 @@ static void null_restart_queue_async(struct nullb *nullb)
 		blk_mq_start_stopped_hw_queues(q, true);
 }
 
+static inline blk_status_t null_handle_throttled(struct nullb_cmd *cmd)
+{
+	struct nullb_device *dev = cmd->nq->dev;
+	struct nullb *nullb = dev->nullb;
+	blk_status_t sts = BLK_STS_OK;
+	struct request *rq = cmd->rq;
+
+	if (!hrtimer_active(&nullb->bw_timer))
+		hrtimer_restart(&nullb->bw_timer);
+
+	if (atomic_long_sub_return(blk_rq_bytes(rq), &nullb->cur_bytes) < 0) {
+		null_stop_queue(nullb);
+		/* race with timer */
+		if (atomic_long_read(&nullb->cur_bytes) > 0)
+			null_restart_queue_async(nullb);
+		/* requeue request */
+		sts = BLK_STS_DEV_RESOURCE;
+	}
+	return sts;
+}
+
 static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
 				    sector_t nr_sectors, enum req_opf op)
 {
 	struct nullb_device *dev = cmd->nq->dev;
 	struct nullb *nullb = dev->nullb;
+	blk_status_t sts;
 	int err = 0;
 
 	if (test_bit(NULLB_DEV_FL_THROTTLED, &dev->flags)) {
-		struct request *rq = cmd->rq;
-
-		if (!hrtimer_active(&nullb->bw_timer))
-			hrtimer_restart(&nullb->bw_timer);
-
-		if (atomic_long_sub_return(blk_rq_bytes(rq),
-				&nullb->cur_bytes) < 0) {
-			null_stop_queue(nullb);
-			/* race with timer */
-			if (atomic_long_read(&nullb->cur_bytes) > 0)
-				null_restart_queue_async(nullb);
-			/* requeue request */
-			return BLK_STS_DEV_RESOURCE;
-		}
+		sts = null_handle_throttled(cmd);
+		if (sts != BLK_STS_OK)
+			return sts;
 	}
 
 	if (op == REQ_OP_FLUSH) {
-- 
2.17.0

