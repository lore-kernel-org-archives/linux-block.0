Return-Path: <SRS0=ruTu=VG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FFDC73C53
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 19:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781FF2073D
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 19:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IRxaN5kY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfGITWI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jul 2019 15:22:08 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:43547 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGITWH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jul 2019 15:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562700128; x=1594236128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ytpWZszUqzeUhrU8DV5JxJn9zpbttH7vVOaguydt/co=;
  b=IRxaN5kYD8w38mOR1hX0K/tZAssYWNnCaoZxacKQ6LOTIEoR4+YmUtcL
   KqnCaNPe3zPbHeft3C2hmHsM9ZgBO1ofC7qj/74Wt8vFYwGTjYCpi4nOJ
   YDF1XyfkufPxuGqppf3ykR9py9ntAH/WAvBsRucIbCJRpmOnwOAkWySLj
   y4DryCqBmqb+2eqRLkISjHlVB1o5FcZGzGTbuBlVn6q/HJsJHVWQt2jSV
   rB+Th8jG68GbZu5gm3kKIiG99tD6VJk3F9wnjK6ZZL8cleLNgHwxcxJyA
   sWwUaDWuPkglv5olVtireT//78hGIf0jYiBZ0I1OW2b31XVxPNcl24Lh5
   w==;
IronPort-SDR: 69bY4ud+tbBkZFroL4Wt4FhFr627YELeB6zZ2pd4qBNr/yroWyoEwYp0kX7ZdSa/omqI9z9pyA
 ZqAQLv0L4MiZ15S8Kses6r7VBXZeA+dwXuV7ZfuCWH/bAR/hrwqLWjs7bSuoYOC3fD3xD5/gDl
 cMlptL7DUpz6lU1jFtEJueLGQM7eDr/fm6cWGfS2ws7v1A5MZhRnTNL92itMel7E8E8W6hLBp9
 ycAX7721h1sHwIcvIyqmxaVJ21eEm+rX0H177P+zmEQGoQ9hI3SZRJd/+tfZAZ4jwm4tvT+G7P
 nGw=
X-IronPort-AV: E=Sophos;i="5.63,471,1557158400"; 
   d="scan'208";a="112586188"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2019 03:22:00 +0800
IronPort-SDR: zmHG7aOdkHRK1+V8DA10wr5+UaSkqKS6qVsrqJp/nRUKzgB2MHTtpnENJaTOQQHL83fVaNycag
 XEz1zkP46WkjN7sgBpxHCCbsVi0qPKRO/D51zsmRKXiHobjw97q5ZbvrihhsaV8rktwrKo5zKZ
 dJ5Ku6tm1uU2rIZNN2memkvKcg5bfxfAbho3Ue2KHkuOEniwTDkIlVAEqvmhSEaGw8WxOPKHr2
 WvgmqPnA5seVkyDr46aRnR3mpSNYkJc66Tay5eveDelrd9EGVaWZibV165UZcwtY3MMaQMMYrV
 shKdvMQv6imDf4OyD9Z5j12Q
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 09 Jul 2019 12:20:46 -0700
IronPort-SDR: ljXeTsRS54v63TrgRoWZO2WRjkTnedRL6DjV20s2o25GG1Vzx07f0otGYjtL0Fek+18s4CWbMZ
 H88hsucaUBXyYVZ6yYABWCLMP5YZaTIPF2DVqeNJLRHq1fLcE9658g09lCcbngZduge9PGHwVs
 5BdUBCcj5yKZZb4688QSmOLQcF0lM272Sfd5ZxHlIIbfawcUbtH+VNkciYfPgN31qL2j2iotiq
 OYFT7Q5XjZV5I9rlec0dIT8hZ9dfFHw30vkbE3etT5wuFU4Crljy/hGIq903mNP1EukIgHywUC
 tHA=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Jul 2019 12:22:00 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 4/6] null_blk: create a helper for mem-backed ops
Date:   Tue,  9 Jul 2019 12:21:30 -0700
Message-Id: <20190709192132.24723-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190709192132.24723-1-chaitanya.kulkarni@wdc.com>
References: <20190709192132.24723-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch creates a helper for handling requests when null_blk is
memory backed in the null_handle_cmd(). Although the helper is very
simple right now, it makes the code flow consistent with the rest of
code in the null_handle_cmd() and provides a uniform code structure
for future code.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 51ddd8d3a6ff..7c503626a15c 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1168,13 +1168,26 @@ static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
 	return BLK_STS_OK;
 }
 
+static inline blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd,
+						     enum req_opf op)
+{
+	struct nullb_device *dev = cmd->nq->dev;
+	int err;
+
+	if (dev->queue_mode == NULL_Q_BIO)
+		err = null_handle_bio(cmd);
+	else
+		err = null_handle_rq(cmd);
+
+	return errno_to_blk_status(err);
+}
+
 static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
 				    sector_t nr_sectors, enum req_opf op)
 {
 	struct nullb_device *dev = cmd->nq->dev;
 	struct nullb *nullb = dev->nullb;
 	blk_status_t sts;
-	int err = 0;
 
 	if (test_bit(NULLB_DEV_FL_THROTTLED, &dev->flags)) {
 		sts = null_handle_throttled(cmd);
@@ -1193,14 +1206,8 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
 			goto out;
 	}
 
-	if (dev->memory_backed) {
-		if (dev->queue_mode == NULL_Q_BIO)
-			err = null_handle_bio(cmd);
-		else
-			err = null_handle_rq(cmd);
-	}
-
-	cmd->error = errno_to_blk_status(err);
+	if (dev->memory_backed)
+		cmd->error = null_handle_memory_backed(cmd, op);
 
 	if (!cmd->error && dev->zoned) {
 		if (op == REQ_OP_WRITE)
-- 
2.17.0

