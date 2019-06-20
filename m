Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085A6C43613
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 04:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78C6208CB
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 04:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GFQIlNdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbfFTE5B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 00:57:01 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:40493 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfFTE5B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 00:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561006621; x=1592542621;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=szSH/rrdK1fAzkGtQfVnDgZAthjAcIto1Vusqf3yRqU=;
  b=GFQIlNdoUaSLogZILwg7VDKnsLwGOra6VOO05FTtaZy9hdugh1n0VB+J
   pJyHlKyPzvH5PdSM88T1Az1JE42/Fy3JEtwrUnX3eUg12GJSzFMjchq3f
   OXcFDbb3cTgarUObB4A1s0QVM5FbFQeuxktROSlabtYhB7FepMYjatcBG
   TrtTBIMIBiM63O8z2t6YcMsMHF826+cRzf0TW66iiLBJBFwvJ4DXWDwVL
   3AU+/utoVUv+TojlEBBGubAuYp1DBG27LjfEKbmzHUMdkUyaNRptJJjFL
   rFczvrp2/1EaEBAQXQqNqdO8UMUKAiMhyqYC96uZ2g8FgI+gApzwzF1Ip
   g==;
X-IronPort-AV: E=Sophos;i="5.63,395,1557158400"; 
   d="scan'208";a="112666042"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2019 12:57:00 +0800
IronPort-SDR: m6L03fKHIoby6pep1ST3NAg7ZSG+CpNVICD0/hdBj0AYrkcFB5Kosv/iXA/blyTC1okrP9x7B3
 USAvQs66sEbqZoXi4xGhPwHnLXEb+0pGT+kLssr5/77d192bdLpi3w8lOmx2c/HyfSf5XlknNm
 KLtFZH2xujCL7pmUWxYjdouqd9/Hx++feEtXaYcJGCyMJqAWW78saoHMJdWWGdIEZ1XIECg0DM
 9ETAwssctxHd6HDLOZgYnB6D7KIRgOk0fmXwxEBUerz4MD4mxxv8eNQvZU+UtNbAm6K6H1Itrf
 xe7HYsInixcvA0JCsPI3jS2P
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 19 Jun 2019 21:56:26 -0700
IronPort-SDR: wA7ZAaMnGHe7cETIc6yMt1SryQxAWvF3KSU7KxxXqiq/cU6LKHO8RtYRlopmZHTMddhzEwOwWk
 /BYNok4P//2aNqq0ds++2gQnb7ER7JmQGNMhBB1qh1lZQRyW2rEWWpH9GKlNN99GQfk+Ka71QR
 dFR6gft/62v9wi7HdQn8HYT2alQtp5OTPgVZjqLFOh9wUaWVIkrCyshcdPsJ4YodSXlsS0vtBf
 Tv9nrrNB+CiyWHqPRoAUJ28Qu02b1AVS/eY7uD9RsOE5zD+2NcrJ9IYT4pndO5ke9N25YY3uiC
 caU=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Jun 2019 21:56:59 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] null_blk: remove duplicate 0 initialization
Date:   Wed, 19 Jun 2019 21:56:58 -0700
Message-Id: <20190620045658.3662-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In function null_add_dev() struct nullb *nullb member is allocated
using kzalloc_node() which returns 0red memory.

In function setup_queues() which is called from the null_add_dev(), on
successful queue allocation we set the nullb->nr_queues = 0 which is not
needed due to earlier use of kzalloc_node().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 2a4f8bc4f930..22303e59a274 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1489,7 +1489,6 @@ static int setup_queues(struct nullb *nullb)
 	if (!nullb->queues)
 		return -ENOMEM;
 
-	nullb->nr_queues = 0;
 	nullb->queue_depth = nullb->dev->hw_queue_depth;
 
 	return 0;
-- 
2.19.1

