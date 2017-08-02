Return-Path: <linux-block-owner@vger.kernel.org>
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:29650 "EHLO
        BJEXCAS001.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751172AbdHBQ1q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Aug 2017 12:27:46 -0400
Date: Thu, 3 Aug 2017 00:27:37 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH 2/2] null_blk: make sure submit_queues > 0
Message-ID: <20170802162729.GA30524@bogon.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

set submit_queues to 1 by default, and make sure it's value > 0.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 drivers/block/null_blk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index 72e2bc5..f1d0ca0 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -65,7 +65,7 @@ enum {
 	NULL_Q_MQ		= 2,
 };
 
-static int submit_queues;
+static int submit_queues = 1;
 module_param(submit_queues, int, S_IRUGO);
 MODULE_PARM_DESC(submit_queues, "Number of submission queues");
 
@@ -849,7 +849,7 @@ static int __init null_init(void)
 		}
 	} else if (submit_queues > nr_cpu_ids)
 		submit_queues = nr_cpu_ids;
-	else if (!submit_queues)
+	else if (submit_queues <= 0)
 		submit_queues = 1;
 
 	if (queue_mode == NULL_Q_MQ && shared_tags) {
-- 
2.9.4
