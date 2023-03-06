Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD83C678D4
	for <linux-block@archiver.kernel.org>; Mon,  6 Mar 2023 12:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjCFMBw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Mar 2023 07:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjCFMBp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Mar 2023 07:01:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF38298F4
        for <linux-block@vger.kernel.org>; Mon,  6 Mar 2023 04:01:41 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 678B22212D;
        Mon,  6 Mar 2023 12:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678104099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vEOtrYMiDN6Nn1CrMt7w5wRmebvrPq2lUJZ1L1Apqoc=;
        b=sUvzsnb3uOXBctXGslYrrXPb8JQwUlfv5r+nwUG+5dAIyoWlbgBz3mmlz1VCuTJgkIldVG
        DfBUrFBBAmhw/rOxYpL5BLGR4+Sc87vLVLsVT0ml6CS4KGvxOQ+WaJs6bE5f6PPn+80/+k
        HBiEK8l2qulP0oEV72Mxz3xvnfDyRZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678104099;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vEOtrYMiDN6Nn1CrMt7w5wRmebvrPq2lUJZ1L1Apqoc=;
        b=7Ng+PaaKg0mGCT4zneq9LOi539yHiuPMLBCkkv1pE9J3x9c5dTdB8GtdK6dwRTucAEKOH8
        W2BRHIgmwHMvRQCg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 57FB72C14E;
        Mon,  6 Mar 2023 12:01:39 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 4DD3151BE38F; Mon,  6 Mar 2023 13:01:39 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/5] brd: limit maximal block size to 32M
Date:   Mon,  6 Mar 2023 13:01:26 +0100
Message-Id: <20230306120127.21375-5-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230306120127.21375-1-hare@suse.de>
References: <20230306120127.21375-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use an arbitrary limit of 32M for the maximal blocksize so as not
to overflow the page cache.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/brd.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 11bac3c3f1b6..1ed114cd5cb0 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -348,6 +348,7 @@ static int max_part = 1;
 module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
 
+#define RD_MAX_SECTOR_SIZE 65536
 static unsigned int rd_blksize = PAGE_SIZE;
 module_param(rd_blksize, uint, 0444);
 MODULE_PARM_DESC(rd_blksize, "Blocksize of each RAM disk in bytes.");
@@ -410,15 +411,14 @@ static int brd_alloc(int i)
 	disk->private_data	= brd;
 	strscpy(disk->disk_name, buf, DISK_NAME_LEN);
 	set_capacity(disk, rd_size * 2);
-	
-	/*
-	 * This is so fdisk will align partitions on 4k, because of
-	 * direct_access API needing 4k alignment, returning a PFN
-	 * (This is only a problem on very small devices <= 4M,
-	 *  otherwise fdisk will align on 1M. Regardless this call
-	 *  is harmless)
-	 */
+
+	if (rd_blksize > RD_MAX_SECTOR_SIZE) {
+		/* Arbitrary limit maximum block size to 32M */
+		err = -EINVAL;
+		goto out_cleanup_disk;
+	}
 	blk_queue_physical_block_size(disk->queue, rd_blksize);
+	blk_queue_max_hw_sectors(disk->queue, RD_MAX_SECTOR_SIZE);
 
 	/* Tell the block layer that this is not a rotational device */
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
-- 
2.35.3

