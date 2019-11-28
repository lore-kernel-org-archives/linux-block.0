Return-Path: <SRS0=c8VV=ZU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0507FC432C3
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 03:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9902168B
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 03:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfK1DCW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Nov 2019 22:02:22 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:56690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727444AbfK1DCW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Nov 2019 22:02:22 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B495E880EC284FB42DC7;
        Thu, 28 Nov 2019 11:02:19 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 28 Nov 2019
 11:02:10 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <philipp.reisner@linbit.com>, <lars.ellenberg@linbit.com>,
        <axboe@kernel.dk>, <drbd-dev@lists.linbit.com>,
        <linux-block@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 3/3] ataflop: Remove unneeded semicolon
Date:   Thu, 28 Nov 2019 11:09:32 +0800
Message-ID: <1574910572-42062-4-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574910572-42062-1-git-send-email-zhengbin13@huawei.com>
References: <1574910572-42062-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fixes coccicheck warning:

drivers/block/ataflop.c:860:53-54: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/block/ataflop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index bd7d3bb..1553d41 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -857,7 +857,7 @@ static void fd_calibrate( void )
 	}

 	if (ATARIHW_PRESENT(FDCSPEED))
-		dma_wd.fdc_speed = 0; 	/* always seek with 8 Mhz */;
+		dma_wd.fdc_speed = 0;   /* always seek with 8 Mhz */
 	DPRINT(("fd_calibrate\n"));
 	SET_IRQ_HANDLER( fd_calibrate_done );
 	/* we can't verify, since the speed may be incorrect */
--
2.7.4

