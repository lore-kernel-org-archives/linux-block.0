Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A1CC4332F
	for <linux-block@archiver.kernel.org>; Thu, 17 Nov 2022 00:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiKQAne (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 19:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiKQAnT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 19:43:19 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EC964A1B;
        Wed, 16 Nov 2022 16:43:16 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1ovSzk-0002VB-PV; Thu, 17 Nov 2022 01:43:08 +0100
Date:   Thu, 17 Nov 2022 00:43:03 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/4] block: add new flag to add partitions read-only
Message-ID: <31b78b87ece4e095aa082d09ca3d4058a2484f3c.1668644705.git.daniel@makrotopia.org>
References: <cover.1668644705.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1668644705.git.daniel@makrotopia.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add flag ADDPART_FLAG_READONLY to allow partition parsers marking a
partition to be set read-only.
This is needed for the uImage.FIT partition parser added by a follow-up
commit: we need to be sure the contents of uImage.FIT sub-images
remain unaltered they are validated using a hash within the uImage.FIT
structure which also serves as partition table.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 block/blk.h             | 1 +
 block/partitions/core.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/block/blk.h b/block/blk.h
index e85703ae81dd..05ac426350b2 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -414,6 +414,7 @@ void blk_free_ext_minor(unsigned int minor);
 #define ADDPART_FLAG_NONE	0
 #define ADDPART_FLAG_RAID	1
 #define ADDPART_FLAG_WHOLEDISK	2
+#define ADDPART_FLAG_READONLY	4
 int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 		sector_t length);
 int bdev_del_partition(struct gendisk *disk, int partno);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index b8112f52d388..355646b0707d 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -398,6 +398,9 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 			goto out_del;
 	}
 
+	if (flags & ADDPART_FLAG_READONLY)
+		bdev->bd_read_only = true;
+
 	/* everything is up and running, commence */
 	err = xa_insert(&disk->part_tbl, partno, bdev, GFP_KERNEL);
 	if (err)
-- 
2.38.1

