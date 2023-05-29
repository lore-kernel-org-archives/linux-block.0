Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AECC7EE23
	for <linux-block@archiver.kernel.org>; Mon, 29 May 2023 02:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjE2Cik (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 May 2023 22:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjE2Cij (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 May 2023 22:38:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A978A7
        for <linux-block@vger.kernel.org>; Sun, 28 May 2023 19:38:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 374BE61347
        for <linux-block@vger.kernel.org>; Mon, 29 May 2023 02:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FBBC433D2;
        Mon, 29 May 2023 02:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685327917;
        bh=js3UunmIdZlhSMQN6aJ0m8gTu7OFO8tkvtN/EMHscuo=;
        h=From:To:Cc:Subject:Date:From;
        b=jypd3ntMB4nwXzxoivrplQag6z0/iuMkCfagHVuX+d4J/EaIw7u4dGytMsc3hPdfY
         UglSXtpG0q78YLIW+Oi79ODmMmYhdvOxUKbacw/rrsFYwBim6GEHZDdHgV9H4ZBgb7
         n9msU78CgMNWF8twIaHVaeCXcQqWSXmUW2oSM6yF/oJNJL1sD/I3Zm1KteyVn/Brl/
         BLy11/r+cvNYYwhiWNVOLLO9SyqM6qVtNeu3eGsSFJj/J97fvoztxLAjY6/Cgexwii
         AT8dzdm7FbtMByOiZYpUzCigjuWDEhFzhUwnBap0xYVq09gEuMvlF9wwxBj47dSU9N
         ePp+SrWIdQAOw==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Brian Bunker <brian@purestorage.com>
Subject: [PATCH] block: fix revalidate performance regression
Date:   Mon, 29 May 2023 11:38:36 +0900
Message-Id: <20230529023836.1209558-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The scsi driver function sd_read_block_characteristics() always calls
disk_set_zoned() to a disk zoned model correctly, in case the device
model changed. This is done even for regular disks to set the zoned
model to BLK_ZONED_NONE and free any zone related resources if the drive
previously was zoned.

This behavior significantly impact the time it takes to revalidate disks
on a large system as the call to disk_clear_zone_settings() done from
disk_set_zoned() for the BLK_ZONED_NONE case results in the device
request queued to be quiesced, even if there is no zone resource to
free.

Avoid this overhead for non zoned devices by not calling
disk_clear_zone_settings() in disk_set_zoned() if the device model
already was set to BLK_ZONED_NONE.

Reported by: Brian Bunker <brian@purestorage.com>
Fixes: 508aebb80527 ("block: introduce blk_queue_clear_zone_settings()")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-settings.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 896b4654ab00..4dd59059b788 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -915,6 +915,7 @@ static bool disk_has_partitions(struct gendisk *disk)
 void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
 {
 	struct request_queue *q = disk->queue;
+	unsigned int old_model = q->limits.zoned;
 
 	switch (model) {
 	case BLK_ZONED_HM:
@@ -952,7 +953,7 @@ void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
 		 */
 		blk_queue_zone_write_granularity(q,
 						queue_logical_block_size(q));
-	} else {
+	} else if (old_model != BLK_ZONED_NONE) {
 		disk_clear_zone_settings(disk);
 	}
 }
-- 
2.40.1

