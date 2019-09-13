Return-Path: <SRS0=03jz=XI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A557EC49ED7
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832BD20CC7
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390226AbfIMWEY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:04:24 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60804 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387554AbfIMWEX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 18:04:23 -0400
Received: from turingmachine.home (unknown [IPv6:2804:431:c7f4:5bfc:5711:794d:1c68:5ed3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 37EF228EF34;
        Fri, 13 Sep 2019 23:04:18 +0100 (BST)
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, axboe@kernel.dk, kernel@collabora.com,
        krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v2 3/4] null_blk: format pr_* logs with pr_fmt
Date:   Fri, 13 Sep 2019 19:02:59 -0300
Message-Id: <20190913220300.422869-4-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913220300.422869-1-andrealmeid@collabora.com>
References: <20190913220300.422869-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of writing "null_blk: " at the beginning of each
pr_err/info/warn log message, format messages using pr_fmt() macro.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
Changes from v1:
- Use #undef instead of reorder #includes
- Use KBUILD_MODNAME instead of using the hardcoded module name
---
 drivers/block/null_blk.h       |  5 ++++-
 drivers/block/null_blk_main.c  | 16 ++++++++--------
 drivers/block/null_blk_zoned.c |  4 ++--
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index a1b9929bd911..8a65cb549dd5 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -2,6 +2,9 @@
 #ifndef __BLK_NULL_BLK_H
 #define __BLK_NULL_BLK_H
 
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/blkdev.h>
 #include <linux/slab.h>
 #include <linux/blk-mq.h>
@@ -96,7 +99,7 @@ void null_zone_reset(struct nullb_cmd *cmd, sector_t sector);
 #else
 static inline int null_zone_init(struct nullb_device *dev)
 {
-	pr_err("null_blk: CONFIG_BLK_DEV_ZONED not enabled\n");
+	pr_err("CONFIG_BLK_DEV_ZONED not enabled\n");
 	return -EINVAL;
 }
 static inline void null_zone_exit(struct nullb_device *dev) {}
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 5d20d65041bd..3821fdb85c94 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1311,7 +1311,7 @@ static bool should_requeue_request(struct request *rq)
 
 static enum blk_eh_timer_return null_timeout_rq(struct request *rq, bool res)
 {
-	pr_info("null_blk: rq %p timed out\n", rq);
+	pr_info("rq %p timed out\n", rq);
 	blk_mq_complete_request(rq);
 	return BLK_EH_DONE;
 }
@@ -1739,28 +1739,28 @@ static int __init null_init(void)
 	struct nullb_device *dev;
 
 	if (g_bs > PAGE_SIZE) {
-		pr_warn("null_blk: invalid block size\n");
-		pr_warn("null_blk: defaults block size to %lu\n", PAGE_SIZE);
+		pr_warn("invalid block size\n");
+		pr_warn("defaults block size to %lu\n", PAGE_SIZE);
 		g_bs = PAGE_SIZE;
 	}
 
 	if (!is_power_of_2(g_zone_size)) {
-		pr_err("null_blk: zone_size must be power-of-two\n");
+		pr_err("zone_size must be power-of-two\n");
 		return -EINVAL;
 	}
 
 	if (g_home_node != NUMA_NO_NODE && g_home_node >= nr_online_nodes) {
-		pr_err("null_blk: invalid home_node value\n");
+		pr_err("invalid home_node value\n");
 		g_home_node = NUMA_NO_NODE;
 	}
 
 	if (g_queue_mode == NULL_Q_RQ) {
-		pr_err("null_blk: legacy IO path no longer available\n");
+		pr_err("legacy IO path no longer available\n");
 		return -EINVAL;
 	}
 	if (g_queue_mode == NULL_Q_MQ && g_use_per_node_hctx) {
 		if (g_submit_queues != nr_online_nodes) {
-			pr_warn("null_blk: submit_queues param is set to %u.\n",
+			pr_warn("submit_queues param is set to %u.\n",
 							nr_online_nodes);
 			g_submit_queues = nr_online_nodes;
 		}
@@ -1803,7 +1803,7 @@ static int __init null_init(void)
 		}
 	}
 
-	pr_info("null_blk: module loaded\n");
+	pr_info("module loaded\n");
 	return 0;
 
 err_dev:
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index cb28d93f2bd1..b2b977be5ddd 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -17,7 +17,7 @@ int null_zone_init(struct nullb_device *dev)
 	unsigned int i;
 
 	if (!is_power_of_2(dev->zone_size)) {
-		pr_err("null_blk: zone_size must be power-of-two\n");
+		pr_err("zone_size must be power-of-two\n");
 		return -EINVAL;
 	}
 
@@ -31,7 +31,7 @@ int null_zone_init(struct nullb_device *dev)
 
 	if (dev->zone_nr_conv >= dev->nr_zones) {
 		dev->zone_nr_conv = dev->nr_zones - 1;
-		pr_info("null_blk: changed the number of conventional zones to %u",
+		pr_info("changed the number of conventional zones to %u",
 			dev->zone_nr_conv);
 	}
 
-- 
2.23.0

