Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5BAC43334
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 01:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiGRByi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Jul 2022 21:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiGRByh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Jul 2022 21:54:37 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D579FCE10;
        Sun, 17 Jul 2022 18:54:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VJb26jE_1658109272;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VJb26jE_1658109272)
          by smtp.aliyun-inc.com;
          Mon, 18 Jul 2022 09:54:33 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ublk_drv: remove unneeded semicolon
Date:   Mon, 18 Jul 2022 09:54:31 +0800
Message-Id: <20220718015431.40185-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Eliminate the following coccicheck warnings:
./drivers/block/ublk_drv.c:1467:2-3: Unneeded semicolon
./drivers/block/ublk_drv.c:1528:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 52fd0af8a4f2..b005cb1354e4 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1464,7 +1464,7 @@ static int ublk_ctrl_cmd_validate(struct io_uring_cmd *cmd,
 			return -EINVAL;
 		if (!header->addr)
 			return -EINVAL;
-	};
+	}
 
 	return 0;
 }
@@ -1525,7 +1525,7 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		break;
 	default:
 		break;
-	};
+	}
  out:
 	io_uring_cmd_done(cmd, ret, 0);
 	pr_devel("%s: cmd done ret %d cmd_op %x, dev id %d qid %d\n",
-- 
2.20.1.7.g153144c

