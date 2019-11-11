Return-Path: <SRS0=2XXV=ZD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C71C43331
	for <linux-block@archiver.kernel.org>; Mon, 11 Nov 2019 01:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D526204EC
	for <linux-block@archiver.kernel.org>; Mon, 11 Nov 2019 01:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfKKBma (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Nov 2019 20:42:30 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6176 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726733AbfKKBma (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Nov 2019 20:42:30 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 988E55D1D787317EDE88;
        Mon, 11 Nov 2019 09:42:27 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 11 Nov 2019
 09:42:22 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: genhd: skip blk_register_region() for disk using ext-dev
Date:   Mon, 11 Nov 2019 09:49:46 +0800
Message-ID: <20191111014946.54533-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It doesn't incur any harm now when the range parameter of
blk_register_region() is zero, but let's skip the useless call of
blk_register_region() for disk which uses ext-dev.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 block/genhd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 26b31fcae217..c61b59b550b0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -739,8 +739,9 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 		ret = bdi_register_owner(disk->queue->backing_dev_info,
 						disk_to_dev(disk));
 		WARN_ON(ret);
-		blk_register_region(disk_devt(disk), disk->minors, NULL,
-				    exact_match, exact_lock, disk);
+		if (disk->minors)
+			blk_register_region(disk_devt(disk), disk->minors, NULL,
+						exact_match, exact_lock, disk);
 	}
 	register_disk(parent, disk, groups);
 	if (register_queue)
-- 
2.22.0

