Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DE7C433F5
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 12:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiA0MXa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 07:23:30 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52392 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbiA0MX3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 07:23:29 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CDD111F37F;
        Thu, 27 Jan 2022 12:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643286207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2/zhGPBBKnmOu2pFSFHXFOJN2o1An1lof2yyfsoLaQ0=;
        b=ra6AOq1GWUa3pZmL30eaT8Ju3HxPIHJcRcZ2y7nV/61n6w+R4dpUdDxw//EplYjqqGwMOR
        VlrYfdJsERqDgK/+BhFSrDUOGbkIjAM3wqumB3aSX2ZjyOE/G3OX3vjoK0mO50t7pnWKlM
        EJA4RGTjG2XNZYKQ5wACgNLfLc6FUvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643286207;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2/zhGPBBKnmOu2pFSFHXFOJN2o1An1lof2yyfsoLaQ0=;
        b=4avwth8FJ6B6XxCNA43O3sh26m7+V3ada4fC2uu74hOb/fZJu6ZQRt6v66dRarHMmzCLHB
        9jmUyronTc3G/kAg==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B7E98A3B8B;
        Thu, 27 Jan 2022 12:23:27 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1EA0FA05E6; Thu, 27 Jan 2022 13:23:27 +0100 (CET)
Date:   Thu, 27 Jan 2022 13:23:27 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 3/8] block: remove the racy bd_inode->i_mapping->nrpages
 asserts
Message-ID: <20220127122327.ivzofycd6g7umox6@quack3.lan>
References: <20220126155040.1190842-1-hch@lst.de>
 <20220126155040.1190842-4-hch@lst.de>
 <20220127094737.dosrg7xbnwuw3ttx@quack3.lan>
 <20220127094942.GA14727@lst.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="37mr5yq4wgm3vwh3"
Content-Disposition: inline
In-Reply-To: <20220127094942.GA14727@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--37mr5yq4wgm3vwh3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu 27-01-22 10:49:42, Christoph Hellwig wrote:
> On Thu, Jan 27, 2022 at 10:47:37AM +0100, Jan Kara wrote:
> > On Wed 26-01-22 16:50:35, Christoph Hellwig wrote:
> > > Nothing prevents a file system or userspace opener of the block device
> > > from redirtying the page right afte sync_blockdev returned.  Fortunately
> > > data in the page cache during a block device change is mostly harmless
> > > anyway.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > My understanding was these warnings are there to tell userspace it is doing
> > something wrong. Something like the warning we issue when DIO races with
> > buffered IO... I'm not sure how useful they are but I don't see strong
> > reason to remove them either...
> 
> Well, it is not just a warning, but also fails the command.  With some of
> the reduced synchronization blktests loop/002 can hit them pretty reliably.

I see. I guess another place where using mapping->invalidate_lock would be
good to avoid these races... So maybe something like attached patch?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--37mr5yq4wgm3vwh3
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-loop-Protect-loop-device-invalidation-from-racing-pa.patch"

From 3914760aa538f55012f41859857cfe75bdcfc6a2 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 27 Jan 2022 12:43:26 +0100
Subject: [PATCH] loop: Protect loop device invalidation from racing page cache
 operations

Grab bdev->i_mutex and bdev->i_mapping->invalidate_lock to protect
operations invalidating loop device page cache from racing operations on
the page cache. As a result we can drop some warnings.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 01cbbfc4e9e2..170e3dc0d8a9 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1252,6 +1252,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	if (lo->lo_offset != info->lo_offset ||
 	    lo->lo_sizelimit != info->lo_sizelimit) {
 		size_changed = true;
+		inode_lock(lo->lo_device->bd_inode);
+		filemap_invalidate_lock(lo->lo_device->bd_inode->i_mapping);
 		sync_blockdev(lo->lo_device);
 		invalidate_bdev(lo->lo_device);
 	}
@@ -1259,15 +1261,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	/* I/O need to be drained during transfer transition */
 	blk_mq_freeze_queue(lo->lo_queue);
 
-	if (size_changed && lo->lo_device->bd_inode->i_mapping->nrpages) {
-		/* If any pages were dirtied after invalidate_bdev(), try again */
-		err = -EAGAIN;
-		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
-			__func__, lo->lo_number, lo->lo_file_name,
-			lo->lo_device->bd_inode->i_mapping->nrpages);
-		goto out_unfreeze;
-	}
-
 	prev_lo_flags = lo->lo_flags;
 
 	err = loop_set_status_from_info(lo, info);
@@ -1285,6 +1278,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		loff_t new_size = get_size(lo->lo_offset, lo->lo_sizelimit,
 					   lo->lo_backing_file);
 		loop_set_size(lo, new_size);
+		filemap_invalidate_unlock(lo->lo_device->bd_inode->i_mapping);
+		inode_unlock(lo->lo_device->bd_inode);
 	}
 
 	loop_config_discard(lo);
@@ -1474,26 +1469,18 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 	if (lo->lo_queue->limits.logical_block_size == arg)
 		return 0;
 
+	inode_lock(lo->lo_device->bd_inode);
+	filemap_invalidate_lock(lo->lo_device->bd_inode->i_mapping);
 	sync_blockdev(lo->lo_device);
 	invalidate_bdev(lo->lo_device);
-
 	blk_mq_freeze_queue(lo->lo_queue);
-
-	/* invalidate_bdev should have truncated all the pages */
-	if (lo->lo_device->bd_inode->i_mapping->nrpages) {
-		err = -EAGAIN;
-		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
-			__func__, lo->lo_number, lo->lo_file_name,
-			lo->lo_device->bd_inode->i_mapping->nrpages);
-		goto out_unfreeze;
-	}
-
 	blk_queue_logical_block_size(lo->lo_queue, arg);
 	blk_queue_physical_block_size(lo->lo_queue, arg);
 	blk_queue_io_min(lo->lo_queue, arg);
 	loop_update_dio(lo);
-out_unfreeze:
 	blk_mq_unfreeze_queue(lo->lo_queue);
+	filemap_invalidate_unlock(lo->lo_device->bd_inode->i_mapping);
+	inode_unlock(lo->lo_device->bd_inode);
 
 	return err;
 }
-- 
2.31.1


--37mr5yq4wgm3vwh3--
