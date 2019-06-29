Return-Path: <SRS0=xgQW=U4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC336C4321A
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 05:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06AE214AF
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 05:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gdpejC4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfF2FFA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Jun 2019 01:05:00 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31713 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfF2FE7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jun 2019 01:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561784710; x=1593320710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lkN9lEpspnIIS0j0TPEkwsMc1UYH09NPUvmC70jV3WQ=;
  b=gdpejC4P7LYM+UI+AcdJXjYnltVvb2ZCu79CMnj+wy8zS5UIJiQLtgPe
   F+iQUSEwNKxZrqWSNEVnVnYcLsLi5A05/tHmd/71zbtRN+T/ETgQFzEVf
   ujoG77zIQR7J181z7A5q0bvhfDhC0njaYkqkXwHtzmVjWvsPC6/7c8/sc
   iQ811wMz1MZ6bZBqNyChSGxqke6j/MNhTym02PSUEH1hnsuOzQhn+RLCH
   Jl6jLtbKXxDbIoro0EZgMl5M96pI9DNm11sWIrcNnaufv1NsJMuk4oOfL
   4NAAvFBnG+Jg8L0+SOT6qK2x2RGaVnkwsqOSz43plGB+sA7XhSvE+g8Qb
   A==;
X-IronPort-AV: E=Sophos;i="5.63,430,1557158400"; 
   d="scan'208";a="211658292"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2019 13:05:09 +0800
IronPort-SDR: U1YYRsja2kDK0pxYQ8IivJ5B+UPj93Q62YHhRx1RmT5gNnVqv8IJd8zMdL+U5fOXrhlGye3016
 9DnSyMn5VhJu6wFWDFGbLrzAvCygk/ANMP6fsaVX5qY40QYyXKsQGFOZU7pVQ8FzNCLvhD/wVJ
 5BVNsTFUI2OSpMTU0fOSB8M8Ox6ToGgXen785WNPPtxzFdL72RKtTISptx3/WPy8AC882EZKTD
 Edd+NYupO7CWQuw5AQ47J5uRR0a+NJkuEXjimTXdOFvIlnPzRf2lswe9PWg+gJDnWTjai2ANRe
 YDwHW3Q7pvvCgmoRkNmS5USp
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 28 Jun 2019 22:04:03 -0700
IronPort-SDR: zBSfKx6IBq7BipP4+OS/GFDPfLlS5kLtWol3iSqGf8NuLRjOUd2uy7pm+hNKhLPuAMNWRxeMTR
 UuvxlI6+aLsDuiJZNd+dAGrgY4tv5hRBcvCGaSEePc4lRAK5qyn52sqWVjpIBVB9GDUx6/So73
 8n9v6NIpPKUDfz7pr+KW2mMCMgQ2PXEqG+67N30OMlhlEhiXLhN8Wn4LnzHzfgmxEzfMoyP/GT
 TZZgWla8TZ6bp5wA78zORcnWDvQS8TR0W6b9sPLWDzyfnEKVqLUlb23rz/z76VcDiv4O7ic0Xw
 c0M=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Jun 2019 22:04:59 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, bvanassche@acm.org, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/5] null_blk: create a helper for throttling
Date:   Fri, 28 Jun 2019 22:04:38 -0700
Message-Id: <20190629050442.8459-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190629050442.8459-1-chaitanya.kulkarni@wdc.com>
References: <20190629050442.8459-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch creates a helper for handling throttling code in the
null_handle_cmd().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 43 +++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 99328ded60d1..98e2985f57fc 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1133,28 +1133,41 @@ static void null_restart_queue_async(struct nullb *nullb)
 		blk_mq_start_stopped_hw_queues(q, true);
 }
 
-static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
+static inline blk_status_t null_handle_throttled(struct nullb_cmd *cmd)
 {
 	struct nullb_device *dev = cmd->nq->dev;
 	struct nullb *nullb = dev->nullb;
-	int err = 0;
+	blk_status_t sts = BLK_STS_OK;
+	struct request *rq = cmd->rq;
 
-	if (test_bit(NULLB_DEV_FL_THROTTLED, &dev->flags)) {
-		struct request *rq = cmd->rq;
+	if (!test_bit(NULLB_DEV_FL_THROTTLED, &dev->flags))
+		goto out;
 
-		if (!hrtimer_active(&nullb->bw_timer))
-			hrtimer_restart(&nullb->bw_timer);
+	if (!hrtimer_active(&nullb->bw_timer))
+		hrtimer_restart(&nullb->bw_timer);
 
-		if (atomic_long_sub_return(blk_rq_bytes(rq),
-				&nullb->cur_bytes) < 0) {
-			null_stop_queue(nullb);
-			/* race with timer */
-			if (atomic_long_read(&nullb->cur_bytes) > 0)
-				null_restart_queue_async(nullb);
-			/* requeue request */
-			return BLK_STS_DEV_RESOURCE;
-		}
+	if (atomic_long_sub_return(blk_rq_bytes(rq), &nullb->cur_bytes) < 0) {
+		null_stop_queue(nullb);
+		/* race with timer */
+		if (atomic_long_read(&nullb->cur_bytes) > 0)
+			null_restart_queue_async(nullb);
+		/* requeue request */
+		sts = BLK_STS_DEV_RESOURCE;
 	}
+out:
+	return sts;
+}
+
+static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
+{
+	struct nullb_device *dev = cmd->nq->dev;
+	struct nullb *nullb = dev->nullb;
+	blk_status_t sts;
+	int err = 0;
+
+	sts = null_handle_throttled(cmd);
+	if (sts != BLK_STS_OK)
+		return sts;
 
 	if (nullb->dev->badblocks.shift != -1) {
 		int bad_sectors;
-- 
2.21.0

