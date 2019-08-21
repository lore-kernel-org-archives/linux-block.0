Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90775C3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 06:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6006A22D6D
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 06:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qEXCGhyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfHUGNf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 02:13:35 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:49419 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfHUGNe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 02:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566368014; x=1597904014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=TUb7VQETiYuhnpK2IfbU0g9qfGEQPnwxmGRJkLzjW50=;
  b=qEXCGhyzWWwOL/7yQwRpNbfNyAVrK0Ue2ijo9Lxgbp5c2tYCfV6L4T9m
   haaeXGgf5nY+y4gAbufKO9UmVSKS8HEnxxGv1Uxdtlo2RXl3fQLjNYUxN
   d/YHBKJXEUbKNjv4XsX9X9JGs14OxibCGXpIFu7EZFpauOtoh4ZizHgsk
   hXcBqgOg9X4BQ0L44yW6AeClZF76PTI9rvX/PtkZJXVlbFG9JvDhev578
   ncokeoy4PxUlY0B4QH76yxc4zXMzLy2PjJZpcjh9dJ1PGX7sB1b5WT3MP
   PaMjmvTa44HRhmpQm0iqsxp7hJXiOU8GjOT/dKPYXD5eYPZ3Hk5VwHHIN
   g==;
IronPort-SDR: PxjOdCWwVHl/9qYKP49FwMejSuMmRX2NSfNQEGZO1aaZ5jQ4svd2i31KLTVXm8xhQ0HpKnUpcK
 i//qBpR7akcFj36N5En/ZuiAqBlr87Ln8UadbVQbzEFLOgIsFFohv2TXhvmJnsVk3dcHVYWP8Q
 p2N38EKL77Z1R8MuPDOOUepryH49W5TAkBbQOGo0it2vZK+f0La1MhjFtCA8hXAvsOXMLNDRQ8
 00eNajHD7tm4SythMonO4mHe8YcspgAYA0g/bv5ndBKf0MGPTagL2jQqA1UuJnCKK/+8G7O+5H
 l/w=
X-IronPort-AV: E=Sophos;i="5.64,411,1559491200"; 
   d="scan'208";a="116306211"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2019 14:13:34 +0800
IronPort-SDR: dL67fke1T2EHTeY2Vx2PDh4Z15NBTVL+wojnIcG6DYELiJcvlu21xcn4ndI8Lz3u4ppJ/dT3W0
 E4tHhQnMZIyE04JtKOI4OZExZGNjXG6tgD9g2jKPWcIupxdWLA1U8WVLdL+Ej8+Y6gN1sgg0XY
 HS/evS1WKMQhEKGLz+XhmkZH2BLuzxMwwyQmoPNe7CTbdnZ0m5xUAHsikRj3XGmobiwp+/goQF
 OrX0XAY2fLXcDk0W+lnd1FLJdm8VzcAg1K/94WFHeUagxaWeso8jC2scpoQ0YvQjqMy+puup5P
 LAhfvpt01Xdeu4j6sTbIr+a+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 23:10:55 -0700
IronPort-SDR: k36J9yY30MlKBu+3U9vLiGmRUhBqX9KrLFRxiL2k+9bSVnGEepuEdzvru8Wpl9ZExk9SjMKPYG
 +3X6WmxDx0T8W+prokX1j4k1rEBnpi8ZVXB6dedxWCmKHbvaH4Ojhbt+ObFyfz0ulyQUINbAzX
 K0E2lxsYLR9P5JZGeGNg3EbzxhteM/5WPOYw0pKgGf9k/PZj0Qda1KWqoTfc3g2hlK+jrkAgp1
 tbcz3nQDuB+vmLM+s2XJYXRDOyGWwpAT3xswmzky3uWhcksKIDhKKwdkNGhShzLWQe3rW+Odf5
 3+o=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Aug 2019 23:13:34 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 2/6] null_blk: create a helper for throttling
Date:   Tue, 20 Aug 2019 23:13:10 -0700
Message-Id: <20190821061314.3262-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190821061314.3262-1-chaitanya.kulkarni@wdc.com>
References: <20190821061314.3262-1-chaitanya.kulkarni@wdc.com>
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

