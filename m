Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286B1C3A5A3
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 00:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F9E2173E
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 00:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UW/Fu5AF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfHWAPb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Aug 2019 20:15:31 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:30872 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbfHWAPb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Aug 2019 20:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566519331; x=1598055331;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=afa1tg1LDkqSoP1c7eXH5X/bvtdyWo7csNQ4j7EqvZo=;
  b=UW/Fu5AFM/l4Qw5ww12JgLyhSUcMfytgi+4TJUmwdipY9Iuf2roYBOe5
   vfMLlkLf7a1MriFNl2pKt1ot8EReJosof3074bJZ+fbjHgE63fRZzpRnt
   gBo5QKa8lC2ZSO4BnOh+uBIPQjFSlu8tcK5ISqT9ZeViW49ow3NuNl5dA
   fLeFIFji6T2xORJxWP0rfMwX+ZUjwiHy3NRFh9ziilKIWjyxqLuQCdLR5
   IRVw0n4hRZw48Fl73ueUoss4XN9dUoMMmtPpF34ZcskmM+od1BxB1msFo
   clV9u6fVRqU0w3gtv+7tU6JfJAurPYOkt7NJupaDYnrnHt9OLT4lPo345
   Q==;
IronPort-SDR: EIQYCN8HXo1s2f/xMykw7mFAHjvN6hOq0XOE0WFzMfDoX5sRt9JYyX9DLRGuMFMkvI115CH0dW
 Meq1ltr7GawhBQkWcB24wEq/hqhSmd3HZ55b0EjZtlBMElSGd47FJav8t/T5NwYmPYoMCDa9kv
 ACb4N0YMkuDkQ02L3zV+ccVWD4On97JjNhl+z261jVRExECFQXKDTPSheWefukoo88QD/QbxfE
 Zv2Glpd9LwLCVXinezVCO/k/PFdmePpJQus2hLuTXfO4UTMVR7qgPzztVHeUlnIRD5rqpFxm/W
 boE=
X-IronPort-AV: E=Sophos;i="5.64,419,1559491200"; 
   d="scan'208";a="121063664"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 08:15:30 +0800
IronPort-SDR: e/7RDop+a9nVGZ8JYjaGenwXDB7Szd037//NtnKk21Dq2Wyk3wPqMmkzw/NaoHh1srta2JruNW
 KM2tqKvQ4aJZHwbiE5R7gUJ/liA3/wml/owQNZbDNBOVk2OTEllIwQhmhdH/vZRZEWc1E9U/6Z
 RyprIXgefKNYW2GbM2EIqchshHhy/+CEQ0VGbMe2SXlTeGtsS+Hv1V2rsc3Erjj5wyXWtFxf/l
 QrHFsuOQUHgq9Bupagwpvl1+IW4RaSVoNZ50E17fC+zZ1/32qDDTBYXWF04Tj6AM1nTVV+kbrC
 X7nYOca31ta1TxgvfY/34Rko
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 17:12:49 -0700
IronPort-SDR: LXUp74Oo553PSa8NWjYlE7z8x7igdHo2eV8evB2gkLF+roK5fzBbT31GqzoJ3q4XHnKizZuDfx
 EPUAv3sQH3YduCC7zFS6ol8/iRyOC+F/ZD49FHg2/amHPIQS0V6LHWyuQ3H8seCcmzTJ6uplLw
 PudSOy1zvD9HJvKUY2U5aLiPdc5/jsYfWXeV03DA8ma85UaWZHQ4eWp4GHV64jkBHIdOS3O5WS
 jGHhTwPOpdPJ931Abn4onkgXRkWx0KdRTgDq5WO2mcok3SXuSN2sBSScXzlY19VlCsaJgP6Ppr
 0ZY=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Aug 2019 17:15:30 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/7] block: Cleanup elevator_init_mq() use
Date:   Fri, 23 Aug 2019 09:15:22 +0900
Message-Id: <20190823001528.5673-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190823001528.5673-1-damien.lemoal@wdc.com>
References: <20190823001528.5673-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of checking a queue tag_set BLK_MQ_F_NO_SCHED flag before
calling elevator_init_mq() to make sure that the queue supports IO
scheduling, use the elevator.c function elv_support_iosched() in
elevator_init_mq(). This does not introduce any functional change but
ensure that elevator_init_mq() does the right thing based on the queue
settings.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-mq.c   |  8 +++-----
 block/elevator.c | 23 +++++++++++++----------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 509f69fdfcf2..556c774a0f0d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2908,11 +2908,9 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	blk_mq_add_queue_tag_set(set, q);
 	blk_mq_map_swqueue(q);
 
-	if (!(set->flags & BLK_MQ_F_NO_SCHED)) {
-		ret = elevator_init_mq(q);
-		if (ret)
-			goto err_tag_set;
-	}
+	ret = elevator_init_mq(q);
+	if (ret)
+		goto err_tag_set;
 
 	return q;
 
diff --git a/block/elevator.c b/block/elevator.c
index 2f17d66d0e61..1ed2710f1950 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -594,16 +594,26 @@ int elevator_switch_mq(struct request_queue *q,
 	return ret;
 }
 
+static inline bool elv_support_iosched(struct request_queue *q)
+{
+	if (q->tag_set && (q->tag_set->flags & BLK_MQ_F_NO_SCHED))
+		return false;
+	return true;
+}
+
 /*
- * For blk-mq devices, we default to using mq-deadline, if available, for single
- * queue devices.  If deadline isn't available OR we have multiple queues,
- * default to "none".
+ * For blk-mq devices supporting IO scheduling, we default to using mq-deadline,
+ * if available, for single queue devices. If deadline isn't available OR we
+ * have multiple queues, default to "none".
  */
 int elevator_init_mq(struct request_queue *q)
 {
 	struct elevator_type *e;
 	int err = 0;
 
+	if (!elv_support_iosched(q))
+		return 0;
+
 	if (q->nr_hw_queues != 1)
 		return 0;
 
@@ -685,13 +695,6 @@ static int __elevator_change(struct request_queue *q, const char *name)
 	return elevator_switch(q, e);
 }
 
-static inline bool elv_support_iosched(struct request_queue *q)
-{
-	if (q->tag_set && (q->tag_set->flags & BLK_MQ_F_NO_SCHED))
-		return false;
-	return true;
-}
-
 ssize_t elv_iosched_store(struct request_queue *q, const char *name,
 			  size_t count)
 {
-- 
2.21.0

