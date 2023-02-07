Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA82C636CC
	for <linux-block@archiver.kernel.org>; Tue,  7 Feb 2023 07:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBGHDX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Feb 2023 02:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjBGHDW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 02:03:22 -0500
Received: from out199-2.us.a.mail.aliyun.com (out199-2.us.a.mail.aliyun.com [47.90.199.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01DB46A4;
        Mon,  6 Feb 2023 23:02:49 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vb61Xcn_1675753327;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0Vb61Xcn_1675753327)
          by smtp.aliyun-inc.com;
          Tue, 07 Feb 2023 15:02:08 +0800
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
To:     axboe@kernel.dk, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH 3/3] ublk: pass NULL to blk_mq_alloc_disk() as queuedata
Date:   Tue,  7 Feb 2023 15:00:33 +0800
Message-Id: <20230207070033.367423-4-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20230207070033.367423-1-ZiyangZhang@linux.alibaba.com>
References: <20230207070033.367423-1-ZiyangZhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

queuedata is not referenced in ublk_drv and we can use driver_data
instead. Pass NULL to blk_mq_alloc_disk() as queuedata while allocating
ublk's gendisk.

Fixes: 6d9e6dfdf3b2 ("ublk: defer disk allocation")
Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 06eddefdf02a..d83fe2c2b3ba 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1578,7 +1578,7 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 		goto out_unlock;
 	}
 
-	disk = blk_mq_alloc_disk(&ub->tag_set, ub);
+	disk = blk_mq_alloc_disk(&ub->tag_set, NULL);
 	if (IS_ERR(disk)) {
 		ret = PTR_ERR(disk);
 		goto out_unlock;
-- 
2.18.4

