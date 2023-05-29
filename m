Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5383DC77B7A
	for <linux-block@archiver.kernel.org>; Mon, 29 May 2023 07:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjE2HeJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 May 2023 03:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjE2HeI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 May 2023 03:34:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9544103
        for <linux-block@vger.kernel.org>; Mon, 29 May 2023 00:32:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E08361237
        for <linux-block@vger.kernel.org>; Mon, 29 May 2023 07:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E47C4339B;
        Mon, 29 May 2023 07:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685345558;
        bh=Spx60uDvJwHXFy0gSwdc2ELUIPNMb53LXadbHOP9W0M=;
        h=From:To:Cc:Subject:Date:From;
        b=Ce5dt47SMAmrcbX++sAW9HxIgCyPxMkdNP38SRNItOgwa8bmNbEVAxLy5iZTucBqC
         k8sqgw9zQleacOsgxMsoNDPzgSEPNJo0SfIturSltH+OshWvH9u7jR72E6qF4C5gD+
         fWvPssGgi1hiH8nHKLIcSpSdj9gZHCmTjP1kt7QmjjASQ66TduqEUdfFJ0cur5FCG8
         s3X8dJL9U8neHf9gIPfapcVfaXQPjO/wp2pbC9MPybB+hUBfT7AWUmkzr4xgzOG0qS
         omH4cUKejD7Du6YWX0Lx6tDxds7biesZYpGZpgj0OqDUj2XTNb1Zp111DXNeXzW0zr
         NhS0Fr5mWgGgg==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Brian Bunker <brian@purestorage.com>
Subject: [PATCH v2] block: fix revalidate performance regression
Date:   Mon, 29 May 2023 16:32:37 +0900
Message-Id: <20230529073237.1339862-1-dlemoal@kernel.org>
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
request queued to be frozen, even if there are no zone resources to
free.

Avoid this overhead for non-zoned devices by not calling
disk_clear_zone_settings() in disk_set_zoned() if the device model
was already set to BLK_ZONED_NONE, which is always the case for regular
devices.

Reported by: Brian Bunker <brian@purestorage.com>
Fixes: 508aebb80527 ("block: introduce blk_queue_clear_zone_settings()")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---

Changes from v1:
 * s/quiesced/frozen in commit message
 * Added Ming's review tag

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

