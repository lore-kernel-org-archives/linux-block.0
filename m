Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6CFC73C69
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 04:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8417C2084B
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 04:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="b3oVVzeA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfGJEDN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 00:03:13 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:6843 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfGJEDM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 00:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562731393; x=1594267393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=lha345VPWEluSrVvFGkyYRW7XQMD3aEhi6Xbrftcjvs=;
  b=b3oVVzeAX0v6pVzdYIM2qQRQidV0KRQG1SMv4uQi1iQWT/3kPQn5ZY2Y
   A0byZMBEXw0Tb9YY9ygpwEAkQbqDx4JDe5ya7ntFFsIPPOGGcOybrr1b9
   DCaNaq1FOOclKD/FFtmTsLS9G37sG8vX0aCK14ktobPJtvc4rN1TYm4KF
   W4+vuwpSMl+wRIPZqxyCwgwwrExAygn3pXFmFae8CZOQnhedG6IK+498D
   6F1kRbmouxOkbkyEVzNOCAR2evz29t0IbtDeHTLncitYj9gU1aaatw6dK
   Xcfn+lpcADktKkv9TtrvOtIC3ZyMnEk9LbyExGabiOF0q9+4b0bHbex7w
   w==;
IronPort-SDR: +84oQg1qLtNAl13DxbVvE+MRPgcj2JuYjU7k7HoijtuTTBfeQ759R3r8daYpkawk+0AufGhhpX
 SR483kWwAlbQPhyTppKUyiguaT+UlyzYMSobLPepRHdTiNtNG3tA2VqNQh/82XbrU8pbW9l6SE
 M2BgF2qUzONCbW9MYkmVtVzAiPAcBi/9uyrMLpqhsTDNTYo/qQFZRZehDRGzxgUb/wyH9myO8A
 hSdXgjr8kTlRTZUN3TmzJRLg4BED7CvXi3kXob2F69mDsMCYPELnCvwFQSxPtYGga4E6vkNzqX
 JcM=
X-IronPort-AV: E=Sophos;i="5.63,473,1557158400"; 
   d="scan'208";a="113789908"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2019 12:03:12 +0800
IronPort-SDR: nMSXNz0C5OTD1tlOzIJumtORaoS24k4rz90tyAkL5hPo9gS+DX/ZEwWeId6GGwI7DQfVddlY7w
 Ii8OFP4aYPl+RE9kbEV7pda3bFON/l/hm0Oylkzed+u7/ZmE57K+ggWoAo19rqrzpiTMt0lJpv
 NliaRfIQ5bQ+Hak7iYqibMmfJ9ovH5pKeupMbstwFx51avrTqVcma12bKtgxm8pN4uf3siIWkQ
 o44i+1wZny1clzVCco6EZy6SFYC2HtYVIWPGu7areZRJZ4VoTs8MyizsBp8pihz8LE8Hbwk8+u
 N+9g60ulDrdTw0l4BckkXWpb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 09 Jul 2019 21:01:58 -0700
IronPort-SDR: 43OrMaMz3sSXFSSVMxhUmwD3yiuMFaUyvouZ/FxtVMQbRCi0WgDnE54Sr8qSX1D43BZihGpBhp
 qfLQve7h/exwrCmcLVlhT/02C6KmEUDiJTx5iJ/EJOcxoxuIrx+wYV3g/1IFc1vRc8j04WlHoc
 zUieXQN/dMRtYnroPdbRl0WNjdrtvtQqGy4lKXO+Zi+mXnjEnc8m756pNWaqA7tAz0Rp25kObn
 CXIx3guTvSJ/YJadmoFn3shB6XLioUdZJIph/1+aExa+cdI9FT7sWCuSIfipnaE93wXWaG6gyj
 fvY=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Jul 2019 21:03:12 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, axboe@kernel.dk,
        hch@lst.de
Subject: [PATCH 2/3] block: set ioprio for flush bio
Date:   Tue,  9 Jul 2019 21:02:23 -0700
Message-Id: <20190710040224.12342-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190710040224.12342-1-chaitanya.kulkarni@wdc.com>
References: <20190710040224.12342-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Set the current process's iopriority for flush bio.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-flush.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index aedd9320e605..21013fcdf42c 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -69,6 +69,7 @@
 #include <linux/blkdev.h>
 #include <linux/gfp.h>
 #include <linux/blk-mq.h>
+#include <linux/ioprio.h>
 
 #include "blk.h"
 #include "blk-mq.h"
@@ -445,6 +446,7 @@ int blkdev_issue_flush(struct block_device *bdev, gfp_t gfp_mask,
 	bio = bio_alloc(gfp_mask, 0);
 	bio_set_dev(bio, bdev);
 	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
+	bio_set_prio(bio, get_current_ioprio());
 
 	ret = submit_bio_wait(bio);
 
-- 
2.17.0

