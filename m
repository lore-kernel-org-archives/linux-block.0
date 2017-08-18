Return-Path: <linux-block-owner@vger.kernel.org>
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:10735 "EHLO
        BJEXMBX012.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750984AbdHRQh3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Aug 2017 12:37:29 -0400
Date: Sat, 19 Aug 2017 00:37:20 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH] block, bfq: fix error handle in bfq_init
Message-ID: <20170818163714.GA40576@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

if elv_register fail, bfq_pool should be free.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/bfq-iosched.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 436b6ca..bdb072f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5048,10 +5048,12 @@ static int __init bfq_init(void)
 
 	ret = elv_register(&iosched_bfq_mq);
 	if (ret)
-		goto err_pol_unreg;
+		goto slab_kill;
 
 	return 0;
 
+slab_kill:
+	bfq_slab_kill();
 err_pol_unreg:
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	blkcg_policy_unregister(&blkcg_policy_bfq);
-- 
2.9.4
