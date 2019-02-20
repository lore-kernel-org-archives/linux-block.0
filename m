Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F33C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 13:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2ED32086C
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 13:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfBTNXE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:23:04 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4241 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726455AbfBTNXE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 08:23:04 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8B925CDD7F53A312B66F;
        Wed, 20 Feb 2019 21:22:57 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Feb 2019
 21:22:48 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <houtao1@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 1/1] Fix NULL pointer dereference in register_disk
Date:   Wed, 20 Feb 2019 21:27:05 +0800
Message-ID: <1550669225-77623-2-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550669225-77623-1-git-send-email-zhengbin13@huawei.com>
References: <1550669225-77623-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If __device_add_disk-->bdi_register_owner-->bdi_register-->
bdi_register_va-->device_create_vargs fails, bdi->dev is still
NULL, __device_add_disk-->register_disk will visit bdi->dev->kobj.
This patch fixes that.

Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 block/genhd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 1dd8fd6..78b82d2 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -655,10 +655,12 @@ static void register_disk(struct device *parent, struct gendisk *disk,
 		kobject_uevent(&part_to_dev(part)->kobj, KOBJ_ADD);
 	disk_part_iter_exit(&piter);

-	err = sysfs_create_link(&ddev->kobj,
-				&disk->queue->backing_dev_info->dev->kobj,
-				"bdi");
-	WARN_ON(err);
+	if (disk->queue->backing_dev_info->dev) {
+		err = sysfs_create_link(&ddev->kobj,
+			  &disk->queue->backing_dev_info->dev->kobj,
+			  "bdi");
+		WARN_ON(err);
+	}
 }

 /**
--
2.7.4

