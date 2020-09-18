Return-Path: <SRS0=GCUE=C3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957B1C43465
	for <linux-block@archiver.kernel.org>; Fri, 18 Sep 2020 01:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56AD42087D
	for <linux-block@archiver.kernel.org>; Fri, 18 Sep 2020 01:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgIRBrd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Sep 2020 21:47:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13281 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726134AbgIRBrd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Sep 2020 21:47:33 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 648019D9BDF5865273B3;
        Fri, 18 Sep 2020 09:47:31 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 09:47:24 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hch@lst.de>,
        <yuyufen@huawei.com>
Subject: [PATCH 4/4] block: get rid of unnecessary local variable
Date:   Thu, 17 Sep 2020 21:47:06 -0400
Message-ID: <20200918014706.1962485-5-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200918014706.1962485-1-yuyufen@huawei.com>
References: <20200918014706.1962485-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since whole elevator register is protectd by sysfs_lock, we
don't need extras 'has_elevator'. Just use q->elevator directly.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-sysfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index ee2cd4d1054c..d13a70ed39bf 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -976,7 +976,6 @@ int blk_register_queue(struct gendisk *disk)
 	int ret;
 	struct device *dev = disk_to_dev(disk);
 	struct request_queue *q = disk->queue;
-	bool has_elevator = false;
 
 	if (WARN_ON(!q))
 		return -ENXIO;
@@ -1040,7 +1039,6 @@ int blk_register_queue(struct gendisk *disk)
 			kobject_put(&dev->kobj);
 			return ret;
 		}
-		has_elevator = true;
 	}
 
 	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
@@ -1049,7 +1047,7 @@ int blk_register_queue(struct gendisk *disk)
 
 	/* Now everything is ready and send out KOBJ_ADD uevent */
 	kobject_uevent(&q->kobj, KOBJ_ADD);
-	if (has_elevator)
+	if (q->elevator)
 		kobject_uevent(&q->elevator->kobj, KOBJ_ADD);
 	mutex_unlock(&q->sysfs_lock);
 
-- 
2.25.4

