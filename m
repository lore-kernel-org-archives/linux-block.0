Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A75C433ED
	for <linux-block@archiver.kernel.org>; Fri, 30 Apr 2021 09:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B58456145A
	for <linux-block@archiver.kernel.org>; Fri, 30 Apr 2021 09:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhD3JVy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Apr 2021 05:21:54 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:60898 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhD3JVy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Apr 2021 05:21:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UXFYWaH_1619774458;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UXFYWaH_1619774458)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 30 Apr 2021 17:21:04 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     philipp.reisner@linbit.com
Cc:     lars.ellenberg@linbit.com, axboe@kernel.dk,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] block: drbd: drbd_receiver: Remove redundant assignment to err
Date:   Fri, 30 Apr 2021 17:20:56 +0800
Message-Id: <1619774456-116567-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Variable err is set to '-EIO' but this value is never read as
it is overwritten or not used later on, hence it is a redundant
assignment and can be removed.

Clean up the following clang-analyzer warning:

drivers/block/drbd/drbd_receiver.c:3955:5: warning: Value stored to
'err' is never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/block/drbd/drbd_receiver.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 69284eb..e3b1e87 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3952,7 +3952,6 @@ static int receive_SyncParam(struct drbd_connection *connection, struct packet_i
 				drbd_err(device, "verify-alg of wrong size, "
 					"peer wants %u, accepting only up to %u byte\n",
 					data_size, SHARED_SECRET_MAX);
-				err = -EIO;
 				goto reconnect;
 			}
 
-- 
1.8.3.1

