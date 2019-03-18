Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F5BC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 14:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDEC206C0
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 14:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbfCROCw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:02:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36380 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727602AbfCROCv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 10:02:51 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A8BEA6084FFF19F973FC;
        Mon, 18 Mar 2019 22:02:47 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Mon, 18 Mar 2019
 22:02:46 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <tj@kernel.org>, <hch@lst.de>
Subject: [PATCH 2/2] block: remove unnecessary statement in blk_free_devt
Date:   Mon, 18 Mar 2019 22:07:03 +0800
Message-ID: <20190318140703.28963-3-yuyufen@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
In-Reply-To: <20190318140703.28963-1-yuyufen@huawei.com>
References: <20190318140703.28963-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If devt is MKDEV(0, 0), its MAJOR cannot be BLOCK_EXT_MAJOR,
so, I think we can remove the statement.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/genhd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index f00198e6758a..961b2bc4634f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -522,9 +522,6 @@ int blk_alloc_devt(struct hd_struct *part, dev_t *devt)
  */
 void blk_free_devt(dev_t devt)
 {
-	if (devt == MKDEV(0, 0))
-		return;
-
 	if (MAJOR(devt) == BLOCK_EXT_MAJOR) {
 		spin_lock_bh(&ext_devt_lock);
 		idr_remove(&ext_devt_idr, blk_mangle_minor(MINOR(devt)));
-- 
2.16.2.dirty

