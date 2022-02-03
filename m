Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E9FC433F5
	for <linux-block@archiver.kernel.org>; Thu,  3 Feb 2022 03:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346800AbiBCDah (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Feb 2022 22:30:37 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:50846 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231626AbiBCDah (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Feb 2022 22:30:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V3Tur6c_1643859034;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V3Tur6c_1643859034)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Feb 2022 11:30:35 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] mm/fs: fix boolreturn.cocci warning
Date:   Thu,  3 Feb 2022 11:30:33 +0800
Message-Id: <20220203033033.52214-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Return statement in function returning bool should use true/false
instead of 1/0.

Eliminate the following coccicheck warning:
./drivers/block/drbd/drbd_req.c:912:9-10: WARNING: return of 0/1 in
function 'remote_due_to_read_balancing' with return type bool

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/block/drbd/drbd_req.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 2e5fb7e442e3..c8448379bbcd 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -909,7 +909,7 @@ static bool remote_due_to_read_balancing(struct drbd_device *device, sector_t se
 
 	switch (rbm) {
 	case RB_CONGESTED_REMOTE:
-		return 0;
+		return false;
 	case RB_LEAST_PENDING:
 		return atomic_read(&device->local_cnt) >
 			atomic_read(&device->ap_pending_cnt) + atomic_read(&device->rs_pending_cnt);
-- 
2.20.1.7.g153144c

