Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA15C3A5A3
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 00:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9489A2173E
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 00:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GYlhlWf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfHWAPg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Aug 2019 20:15:36 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:30877 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbfHWAPg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Aug 2019 20:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566519335; x=1598055335;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=gtr27q1T5jaqplfXgBqq2AoDZe91muleoBZ33dLpJ34=;
  b=GYlhlWf9hObVEJLOr+u3qThdicBn5b9hrMLHfRQxYQ+6sGUbxwldfWpR
   +5MLXARBYIvjbG37YutkkLu8mkYJdChjfhsYQ/PtfV8BYx1Qd/vPt3Kvu
   YM70btNIkRyzn2vhyRoNc9DFGAgZ0DyBmN5BY52ZjEvXnH1BZc3IvzlRz
   ZwEdnRoj9E14p5NBOAW+cY6EsaAE2WY4cg1gD6OTWV/deG0GQtZjeg96j
   MBD0fnGLxGMYeRsDajyAM07gjgy9bFU5G2wuFspMHbj0/B1GJl7gOQbwm
   c4ClfXb5feCnsoQqQpF3WtQmR5LW5QaCbZRhT5UPYbEVmfeijzJSjYcvn
   w==;
IronPort-SDR: mF9kPbEBb88pRuND6oE98yWOuoqMDOOXm2/ijr296mOxg4PwjvFWDrsE/FZ5Esv+K6nT7VnP83
 OoM25q7exJC1rdLNBp+6Yo3GhEKug+D8cXNH+NyazsbPK1aXRnY2e/pq7l8/I2zbtl23/b+n+Z
 W5UWhnwNrCJF8rS7oKeU9lxqhyMQpGu75Y+8fu1oJ//KdqhdO2OrErWoYbRyltdsOs4OWgZ3zQ
 1+lIzMphm5WVk3TC/224dWidOLT/0YROKipzWdHnpxxZkd5n0l3ONkzqAMApBLK+iTy2Cn1tv0
 kMg=
X-IronPort-AV: E=Sophos;i="5.64,419,1559491200"; 
   d="scan'208";a="121063671"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 08:15:34 +0800
IronPort-SDR: zHbvVgtDShhXEAn2vXNsnwmtc5+BUT/PnUrjB7rawW9KJOJS7oshFXL69w+tW9IgnDAHqRyScV
 d5GAOXsR9HpzuI8lTxy+gWlYqsjABK5rDmANh23TXVMnZta0ZauYzjX2m14B/rClH9aAooCC+x
 SIaObDONXMT/J7gdDveCErxkdosF8CdqeVMNoYjBUMlxKmX4Min8FD5yeNT9//A7Pv2ZT+eG+K
 0J3kiG0uIfUTY5aNgBrzdV0FLTt1E0EbWMIJWCTVBm4GLL43bBxBLP8QhKSyDVORMy/RtotzVa
 xQ/A49XPo5LTdcAWBHX8IaT0
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 17:12:53 -0700
IronPort-SDR: TDSawHVk5v+e/BdIxiCgG7NHjWRW2BqiIed+YnI4kpFP8OV9iISCK5/khNrM8ymTn2AvRxssET
 443VsbVND3HjV87R9dD2yRWGaAEmnCv3zZ0QYJcoq2FmwkwvHKWSrQ1SvoX/O96z+qzoKt+qB2
 dFC/jrbQoDlzXRCAmVQpRplsLPpIkt7Fwoft7VYKfzaLVZvnE78spGJvwWFwzYzsXwVoFBKmbA
 4h9Tqt5iA1s9qDhMQHTbX1MvPChQLYun5rOsRxKSpnuKC3t0Oyx8w51JMwgyQjH+G7vgZLPKtK
 Z58=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Aug 2019 17:15:33 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/7] block: Improve default elevator selection
Date:   Fri, 23 Aug 2019 09:15:27 +0900
Message-Id: <20190823001528.5673-7-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190823001528.5673-1-damien.lemoal@wdc.com>
References: <20190823001528.5673-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For block devices that do not specify required features, preserve the
current default elevator selection (mq-deadline for single queue
devices, none for multi-queue devices). For devices specifying a
required feature (e.g. zoned block devices ELEVATOR_F_ZONED_BLOCK_DEV
feature), select the first available elevator providing the required
features. In all cases, default to "none" if no elevator is available or
if the initialization of the default elevator fails.

This change allows in particular the selection of the correct
mq-deadline elevator for zoned block devices that are also multi-queue,
such as null_blk devices with zoned mode enabled or any SMR disk
connected to a smartpqi HBA (and exposed as multi-queue devices by the
HBA).

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/elevator.c | 50 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index de11beb32893..ec75dfee7e96 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -626,14 +626,51 @@ static inline bool elv_support_iosched(struct request_queue *q)
 }
 
 /*
- * For blk-mq devices supporting IO scheduling, we default to using mq-deadline,
- * if available, for single queue devices. If deadline isn't available OR
- * deadline initialization fails OR we have multiple queues, default to "none".
+ * For single queue devices, default to using mq-deadline. If we have multiple
+ * queues or mq-deadline is not available, default to "none".
+ */
+static struct elevator_type *elevator_get_default(struct request_queue *q)
+{
+	if (q->nr_hw_queues != 1)
+		return NULL;
+
+	return elevator_get(q, "mq-deadline", false);
+}
+
+/*
+ * Get the first elevator providing the features required by the request queue.
+ * Default to "none" if no matching elevator is found.
+ */
+static struct elevator_type *elevator_get_by_features(struct request_queue *q)
+{
+	struct elevator_type *e;
+
+	spin_lock(&elv_list_lock);
+
+	list_for_each_entry(e, &elv_list, list) {
+		if (elv_support_features(e->elevator_features,
+					 q->required_elevator_features))
+			break;
+	}
+
+	if (e && !try_module_get(e->elevator_owner))
+		e = NULL;
+
+	spin_unlock(&elv_list_lock);
+
+	return e;
+}
+
+/*
+ * For a device queue that has no required features, use the default elevator
+ * settings. Otherwise, use the first elevator available matching the required
+ * features. If no suitable elevator is find or if the chosen elevator
+ * initialization fails, fall back to the "none" elevator (no elevator).
  */
 void elevator_init_mq(struct request_queue *q)
 {
 	struct elevator_type *e;
-	int err = 0;
+	int err;
 
 	if (!elv_support_iosched(q))
 		return;
@@ -644,7 +681,10 @@ void elevator_init_mq(struct request_queue *q)
 	if (unlikely(q->elevator))
 		return;
 
-	e = elevator_get(q, "mq-deadline", false);
+	if (!q->required_elevator_features)
+		e = elevator_get_default(q);
+	else
+		e = elevator_get_by_features(q);
 	if (!e)
 		return;
 
-- 
2.21.0

