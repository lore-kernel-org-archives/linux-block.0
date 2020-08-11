Return-Path: <SRS0=2P2f=BV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017A2C433DF
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 01:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB50320748
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 01:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgHKB5J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Aug 2020 21:57:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37728 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727985AbgHKB5I (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Aug 2020 21:57:08 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0C0EB708600E28356009;
        Tue, 11 Aug 2020 09:57:07 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Tue, 11 Aug 2020
 09:57:04 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <jbacik@fb.com>, <tj@kernel.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH] blkcg: fix memleak for iolatency
Date:   Mon, 10 Aug 2020 21:57:44 -0400
Message-ID: <20200811015744.1823282-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Normally, blkcg_iolatency_exit() will free related memory in iolatency
when cleanup queue. But if blk_throtl_init() return error and queue init
fail, blkcg_iolatency_exit() will not do that for us. Then it cause
memory leak.

Fixes: d70675121546 ("block: introduce blk-iolatency io controller")
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-cgroup.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 619a79b51068..6f91b2ae0b27 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1152,15 +1152,17 @@ int blkcg_init_queue(struct request_queue *q)
 	if (preloaded)
 		radix_tree_preload_end();
 
-	ret = blk_iolatency_init(q);
-	if (ret)
-		goto err_destroy_all;
-
 	ret = blk_throtl_init(q);
 	if (ret)
 		goto err_destroy_all;
 	return 0;
 
+	ret = blk_iolatency_init(q);
+	if (ret) {
+		blk_throtl_exit(q);
+		goto err_destroy_all;
+	}
+
 err_destroy_all:
 	blkg_destroy_all(q);
 	return ret;
-- 
2.25.4

