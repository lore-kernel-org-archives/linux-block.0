Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF0CC3A589
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 04:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEEC2341F
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 04:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QPL1mIod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391754AbfHWEpl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Aug 2019 00:45:41 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:3468 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389942AbfHWEpl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 00:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566535541; x=1598071541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=eTHJ36L8lpxjIW8iVH/66KmAi0WMFhcw2gBisuHAuYk=;
  b=QPL1mIod1PymsZFYyNEUieSCZJ45oxog1GUNx95a8CfTCmDsnV16xo3z
   9s9FArD3kOHCecyxTlHAs+br+xiWVqpDCP9UbtvNr6UMO2xOI4DE7EsM/
   2Et14rCis/xM8V/w4NVqB5jbymrjoqK3x0smzlp5kmpqb5wfg+6sbjt99
   eU73UE1GsqoXk1fkxBubEfCf4xhJbMfw5QEbB9dsHQc/7ad5Vk2948EMO
   whLxSbneZrBxSjsUmLQDd+3MR8AhrFbGz8m/yAPrZFWJTySMmpYp8ufj4
   iwzDkbTvzOiZ3xNcxE/ecK8Chiqr04Xifm73OX67+n8T9q4sUCXWNzxZs
   g==;
IronPort-SDR: AalEe0DolhGFf1Jqxfqk2TDiYekVr37xggJxC3VoWrirVdiZxgpH1CzUFUTIiouXA96cb3ZZf7
 VTXwm2t3jHz1BoJodlclHuGh9jYR6INo406V1Z3ixscsRjOD5HnPjF5kaayZbpoxpdNR79rEAD
 vnJoIjpGQYoywn+oaJOdoj1X1CPjNVQkvK41Eggk8K0lYzIJtRqwYtNWAB2ilhTlkQgCac0J1s
 dgm6yz66V9LqD8U46qbAfXOCWOHASgwjZiYRPfcXy9ncoPSq6v7/mjyj8Yjdz+0man5Y3wNkm2
 /+s=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="116493563"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 12:45:41 +0800
IronPort-SDR: +ZgMdn02/RqbSyYl4H31u0+xCXxx0RJbr6jHvXY1SY3W53j+so4Tk2C46ATuoID/dixSw3Q7Qm
 wWnSKiLb4oU9kErq5CnJ94QIx9lTYsc+8UMlWyIkQASWnH6QCzrs8hvGbN2rEQnqa5h9edvOd8
 ak411EYrWLj8AZUxiAOyUrdo6bBgQklDh2yBYRc+OEquv/uJwCAMsy/MTiZBDifHuthMd0eKEI
 8RKDrdlgsjGi/Fklj6KrPL7NM/hAyxOetlo2xHLXLEFMJDxWnm03BVDTUKwnevG/K1a2GvxlWP
 IpHX2ZiBaldhP/9X6NeLrA7M
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 21:43:00 -0700
IronPort-SDR: q3qWJW5bjTQWiBSTJzXKKdE4f1an1JF0FU41ug8/xgvLsrqjyLYeZbF6oxdMU74+BMpFA7qFDc
 VQuh0nN37NNSbX2IN97ScULTF3t5b853TOkyQ9OF5M0fiCZuq7vSAqwjNHDP2l5edM7S8uwW+6
 gfcLKeubS6JwoZsaPRLwGMx+xcjOK87PBsCNT9wxGbaMa0yxDmG5TWlhdcDTEMRuHoWnxsrw/J
 T/l+J+SFvsQ6e1mnjDAczL4jHKLFwlCIUAyw6MK+Y4nSQNn3XLXbxhyJHSv9d9FSopEdQ7scSj
 HEY=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Aug 2019 21:45:40 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 2/6] null_blk: create a helper for throttling
Date:   Thu, 22 Aug 2019 21:45:15 -0700
Message-Id: <20190823044519.3939-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190823044519.3939-1-chaitanya.kulkarni@wdc.com>
References: <20190823044519.3939-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch creates a helper for handling throttling code in the
null_handle_cmd().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 39 ++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 7277f2db8ec9..751679fadc9d 100644
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

