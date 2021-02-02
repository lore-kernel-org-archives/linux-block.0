Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CFAC433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3571864ED9
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhBBF1e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:27:34 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:41972 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhBBF1d (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612243652; x=1643779652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d0/IH7i+oVuHvN9VVrN5674v1nvrYU6Nas++JivtJic=;
  b=O76Dg56y/cIU9icbaAnhelPM5E1Ha6guWPg2Q7mIghZGAdm/Br8elFyx
   /QJO1MXaRE2f4kRoRVYywa6qO28CyaHQrU1e4lKEw4g7CebpaMSB8soQU
   YhS58n4tNcmMqXYEibI7Xmeb2qQthjRVU1M/vPyMnswPXA6JZfnsaPYpo
   uk5bKnYtc2VrCDnPxQV9PQ3sCKXwGLyK2EPKcV0amOVZy0pU6ap1+k3av
   AhUcQvmigZ7l5SFvmXRGDQ3WI4InyN6Q75Wlnmq0cmVa1AkqFOFpww4Tx
   5G6KH6vBbmjkxEpwB1s3LNc3sExxSOF2FaKbew3PV28mdZDT/5tYVcBSb
   Q==;
IronPort-SDR: a291amdiaVzdOvHv6OWWj5Qx+/f8VDLXjyymjDtpx8VBTWMvj6RQrlkR/Yyt5U3FsmZAAQQ/bh
 DHlMcnufIoU0pG0xraULO/NXA6RoFqCfHSLXHDVYks+YUM0CG5XRqtpCO1rWUDVmotT1tao3uB
 lv+KrkWC1nKGaQTw+UYOSx6z02psnJCcHLgdTOpQXUoJ0/EvovyNI5090YQFBe1O1gLTHTWQX4
 uTZRhIbc4HIIalCm0FkjOixP1fnvPQV1nodtjfDcyfH/0SvBwTA74HJtLko/ah5bCRsvY9APs0
 2CA=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="158885018"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:26:27 +0800
IronPort-SDR: +m+bZKbAQLSXLcbjmDXizpS2lqtITOBoizaQkRyosKJWD1fihuPGcKDnqcF5afHe6wu+aOR7xI
 QPSerl/FM0ZIUQMHDCpMVG5Or8naXzWrZiEFvNVgEXvAY5LMOUmBBI1pupZZIMIRe82A5vdYA7
 KO0/dgDVLWFB9ERtKehn9kMJfsyqNsIoP+ydDf9Wun4LEOiGW7qMWlRoU0t4US8f1mLndwXe3N
 DHYKyLhXrfHev0VokbMsx6lGlVdrWoeshcXF61Nbwe07aKufZC81PUFlHkQuH4LjbxagEj/5TH
 hzdsp8Zrs7NguqsgnGfz8pvx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:08:36 -0800
IronPort-SDR: NQNQgZQJDOrFIQ6Rfm/gl2rVyUkLtKWboGqCVWLyw7mtNwrJznJw9ERbVj829ykdRaxMjlfskA
 Drpp5eKUeH0Z4dFzFKLgiaV2UbpdSpV1rexMGQg85u2Np7/IvCj+TrVSKYxcMJ1T0LICPaRVWM
 AqrV6Yx9yYMMUm+SI78b+So3BEaUhzEsI2c3EYxn2x0V7UfG+2q1zx4Yc73v7o3fQKB7W8mF5f
 Yb+PVaQAfaZaDaNIYcoMMM9ExugSj07ZsqbM5sjiRoLZX2fTRcDvhva9LOyw9bTp6Y7PbVkMOa
 1t4=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:26:27 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     paolo.valente@linaro.org, axboe@kernel.dk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        akpm@linux-foundation.org, aravind.ramesh@wdc.com,
        joshi.k@samsung.com, niklas.cassel@wdc.com, hare@suse.de,
        colyli@suse.de, tj@kernel.org, rdunlap@infradead.org, jack@suse.cz,
        hch@lst.de
Subject: [PATCH 4/7] blktrace: fix blk_rq_merge documentation
Date:   Mon,  1 Feb 2021 21:25:33 -0800
Message-Id: <20210202052544.4108-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The commit f3bdc62fd82e ("blktrace: Provide event for request merging")
added the comment for blk_rq_merge() tracepoint. Remove the duplicate
word from the tracepoint documentation.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/trace/events/block.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 004cfe34ef37..cc5ab96a7471 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -210,7 +210,7 @@ DEFINE_EVENT(block_rq, block_rq_issue,
 
 /**
  * block_rq_merge - merge request with another one in the elevator
- * @rq: block IO operation operation request
+ * @rq: block IO operation request
  *
  * Called when block operation request @rq from queue @q is merged to another
  * request queued in the elevator.
-- 
2.22.1

