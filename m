Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C962C64EB1
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5969C20850
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5969C20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbeLFQs2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:48:28 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44131 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbeLFQs2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 11:48:28 -0500
Received: from [191.13.27.189] (helo=calabresa.spo.virtua.com.br)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <cascardo@canonical.com>)
        id 1gUwp7-0000io-TB; Thu, 06 Dec 2018 16:48:26 +0000
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH 4/4] block: expose devt for GENHD_FL_HIDDEN disks
Date:   Thu,  6 Dec 2018 14:48:12 -0200
Message-Id: <20181206164812.30925-5-cascardo@canonical.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206164812.30925-1-cascardo@canonical.com>
References: <20181206164812.30925-1-cascardo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Without this exposure, lsblk will fail as it tries to find out the
device's dev_t numbers. This causes a real problem for nvme multipath
devices, as their slaves are hidden.

Exposing them fixes the problem, even though trying to open the devices
returns an error in the case of nvme multipath. So, right now, it's the
driver's responsibility to return a failure to open hidden devices.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 block/genhd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 7674fce32fca..65a7fa664188 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -687,6 +687,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 
 	disk_alloc_events(disk);
 
+	disk_to_dev(disk)->devt = devt;
 	if (disk->flags & GENHD_FL_HIDDEN) {
 		/*
 		 * Don't let hidden disks show up in /proc/partitions,
@@ -698,13 +699,12 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 		int ret;
 
 		/* Register BDI before referencing it from bdev */
-		disk_to_dev(disk)->devt = devt;
 		ret = bdi_register_owner(disk->queue->backing_dev_info,
 						disk_to_dev(disk));
 		WARN_ON(ret);
-		blk_register_region(disk_devt(disk), disk->minors, NULL,
-				    exact_match, exact_lock, disk);
 	}
+	blk_register_region(disk_devt(disk), disk->minors, NULL,
+			    exact_match, exact_lock, disk);
 	register_disk(parent, disk, groups);
 	if (register_queue)
 		blk_register_queue(disk);
@@ -776,8 +776,7 @@ void del_gendisk(struct gendisk *disk)
 		WARN_ON(1);
 	}
 
-	if (!(disk->flags & GENHD_FL_HIDDEN))
-		blk_unregister_region(disk_devt(disk), disk->minors);
+	blk_unregister_region(disk_devt(disk), disk->minors);
 
 	kobject_put(disk->part0.holder_dir);
 	kobject_put(disk->slave_dir);
-- 
2.19.1

