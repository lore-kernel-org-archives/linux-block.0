Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDB4C433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 15:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC35664FAB
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 15:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbhCKPUB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Mar 2021 10:20:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:40866 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233968AbhCKPTc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Mar 2021 10:19:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3560CAD74;
        Thu, 11 Mar 2021 15:19:30 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Martin Wilck <mwilck@suse.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2] block: Suppress uevent for hidden device when removed
Date:   Thu, 11 Mar 2021 16:19:17 +0100
Message-Id: <20210311151917.136091-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

register_disk() suppress uevents for devices with the GENHD_FL_HIDDEN
but enables uevents at the end again in order to announce disk after
possible partitions are created.

When the device is removed the uevents are still on and user land sees
'remove' messages for devices which were never 'add'ed to the system.

  KERNEL[95481.571887] remove   /devices/virtual/nvme-fabrics/ctl/nvme5/nvme0c5n1 (block)

Let's suppress the uevents for GENHD_FL_HIDDEN by not enabling the
uevents at all.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

This version behaves in the same way as v1, that is I don't see any
other effects than the expected missing uevent remove event.

v2:
  - never enable the uevents for GENHD_FL_HIDDEN
    instead adding another test add del_gendisk()

 block/genhd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index c55e8f0fced1..8c8f543572e6 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -534,10 +534,8 @@ static void register_disk(struct device *parent, struct gendisk *disk,
 		kobject_create_and_add("holders", &ddev->kobj);
 	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
 
-	if (disk->flags & GENHD_FL_HIDDEN) {
-		dev_set_uevent_suppress(ddev, 0);
+	if (disk->flags & GENHD_FL_HIDDEN)
 		return;
-	}
 
 	disk_scan_partitions(disk);
 
-- 
2.29.2

