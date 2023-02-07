Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82120C64EC4
	for <linux-block@archiver.kernel.org>; Tue,  7 Feb 2023 07:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjBGHD0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Feb 2023 02:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjBGHDZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 02:03:25 -0500
Received: from out199-17.us.a.mail.aliyun.com (out199-17.us.a.mail.aliyun.com [47.90.199.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0732011653;
        Mon,  6 Feb 2023 23:02:50 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vb61Xbz_1675753325;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0Vb61Xbz_1675753325)
          by smtp.aliyun-inc.com;
          Tue, 07 Feb 2023 15:02:07 +0800
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
To:     axboe@kernel.dk, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH 2/3] ublk: mention WRITE_ZEROES in comment of ublk_complete_rq()
Date:   Tue,  7 Feb 2023 15:00:32 +0800
Message-Id: <20230207070033.367423-3-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20230207070033.367423-1-ZiyangZhang@linux.alibaba.com>
References: <20230207070033.367423-1-ZiyangZhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

WRITE_ZEROES won't return bytes returned just like FLUSH and DISCARD,
and we can end it directly. Add missing comment for it in
ublk_complete_rq().

Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 55fccce68a9c..06eddefdf02a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -665,7 +665,7 @@ static void ublk_complete_rq(struct request *req)
 	}
 
 	/*
-	 * FLUSH or DISCARD usually won't return bytes returned, so end them
+	 * FLUSH, DISCARD or WRITE_ZEROES usually won't return bytes returned, so end them
 	 * directly.
 	 *
 	 * Both the two needn't unmap.
-- 
2.18.4

