Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5140CC433FE
	for <linux-block@archiver.kernel.org>; Mon,  7 Nov 2022 06:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiKGGXB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Nov 2022 01:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiKGGXB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 01:23:01 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14BC11152;
        Sun,  6 Nov 2022 22:22:59 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VU7DUxD_1667802176;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VU7DUxD_1667802176)
          by smtp.aliyun-inc.com;
          Mon, 07 Nov 2022 14:22:57 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] block: Fix some kernel-doc comments
Date:   Mon,  7 Nov 2022 14:22:55 +0800
Message-Id: <20221107062255.2685-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove the description of @required_features in elevator_match()
to clear the below warning:

block/elevator.c:103: warning: Excess function parameter 'required_features' description in 'elevator_match'

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2734
Fixes: ffb86425ee2c ("block: don't check for required features in elevator_match")
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 block/elevator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/elevator.c b/block/elevator.c
index 800e0038be0d..a5bdc3b1e7e5 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -94,7 +94,6 @@ static inline bool elv_support_features(struct request_queue *q,
  * elevator_match - Test an elevator name and features
  * @e: Scheduler to test
  * @name: Elevator name to test
- * @required_features: Features that the elevator must provide
  *
  * Return true if the elevator @e name matches @name and if @e provides all
  * the features specified by @required_features.
-- 
2.20.1.7.g153144c

