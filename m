Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:28347 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753470AbdHQUPC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2017 16:15:02 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Akhil Bhansali <Akhil.Bhansali@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 13/55] skd: Remove a set-but-not-used variable from struct skd_device
Date: Thu, 17 Aug 2017 13:12:56 -0700
Message-Id: <20170817201338.16537-14-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch does not change any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index ef7c0384e9a8..53c84c846a5e 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -271,7 +271,6 @@ struct skd_device {
 	int gendisk_on;
 	int sync_done;
 
-	atomic_t device_count;
 	u32 devno;
 	u32 major;
 	char name[32];
@@ -4313,8 +4312,6 @@ static struct skd_device *skd_construct(struct pci_dev *pdev)
 	skdev->sgs_per_request = skd_sgs_per_request;
 	skdev->dbg_level = skd_dbg_level;
 
-	atomic_set(&skdev->device_count, 0);
-
 	spin_lock_init(&skdev->lock);
 
 	INIT_WORK(&skdev->completion_worker, skd_completion_worker);
-- 
2.14.0
