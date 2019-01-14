Return-Path: <SRS0=WI6O=PW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F515C43387
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 08:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8522086D
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 08:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbfANIsR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:48:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:48712 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbfANIsR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 03:48:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D4F6AF0F;
        Mon, 14 Jan 2019 08:48:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 79FEC1E07FF; Mon, 14 Jan 2019 09:48:15 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, Josef Bacik <jbacik@fb.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] nbd: Use set_blocksize() to set device blocksize
Date:   Mon, 14 Jan 2019 09:48:09 +0100
Message-Id: <20190114084811.14455-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190114084811.14455-1-jack@suse.cz>
References: <20190114084811.14455-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

NBD can update block device block size implicitely through
bd_set_size(). Make it explicitely set blocksize with set_blocksize() as
this behavior of bd_set_size() is going away.

CC: Josef Bacik <jbacik@fb.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/nbd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 08696f5f00bb..7c9a949e876b 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -288,9 +288,10 @@ static void nbd_size_update(struct nbd_device *nbd)
 	blk_queue_physical_block_size(nbd->disk->queue, config->blksize);
 	set_capacity(nbd->disk, config->bytesize >> 9);
 	if (bdev) {
-		if (bdev->bd_disk)
+		if (bdev->bd_disk) {
 			bd_set_size(bdev, config->bytesize);
-		else
+			set_blocksize(bdev, config->blksize);
+		} else
 			bdev->bd_invalidated = 1;
 		bdput(bdev);
 	}
-- 
2.16.4

