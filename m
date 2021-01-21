Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FABC433E0
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 18:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F4B023A57
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 18:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbhAUSOi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 13:14:38 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:54673 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728253AbhAUJo2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 04:44:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UMQMPHG_1611222203;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UMQMPHG_1611222203)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Jan 2021 17:43:44 +0800
From:   Yang Li <abaci-bugfix@linux.alibaba.com>
To:     josh.h.morris@us.ibm.com
Cc:     pjk1939@linux.ibm.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] rsxx: remove redundant NULL check
Date:   Thu, 21 Jan 2021 17:43:22 +0800
Message-Id: <1611222202-114248-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix below warnings reported by coccicheck:
./drivers/block/rsxx/dma.c:948:3-8: WARNING: NULL check
before some freeing functions is not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <abaci-bugfix@linux.alibaba.com>
---
 drivers/block/rsxx/dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/rsxx/dma.c b/drivers/block/rsxx/dma.c
index 1914f54..0574f44 100644
--- a/drivers/block/rsxx/dma.c
+++ b/drivers/block/rsxx/dma.c
@@ -944,8 +944,7 @@ int rsxx_dma_setup(struct rsxx_cardinfo *card)
 			ctrl->done_wq = NULL;
 		}
 
-		if (ctrl->trackers)
-			vfree(ctrl->trackers);
+		vfree(ctrl->trackers);
 
 		if (ctrl->status.buf)
 			dma_free_coherent(&card->dev->dev, STATUS_BUFFER_SIZE8,
-- 
1.8.3.1

