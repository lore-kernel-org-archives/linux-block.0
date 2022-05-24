Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40C4C433EF
	for <linux-block@archiver.kernel.org>; Tue, 24 May 2022 13:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiEXNGh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 May 2022 09:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbiEXNGf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 May 2022 09:06:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0BE1CB24
        for <linux-block@vger.kernel.org>; Tue, 24 May 2022 06:06:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 88FCC68AFE; Tue, 24 May 2022 15:06:30 +0200 (CEST)
Date:   Tue, 24 May 2022 15:06:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        shinichiro.kawasaki@wdc.com, dan.j.williams@intel.com,
        yukuai3@huawei.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: remove per-disk debugfs files in
 blk_unregister_queue
Message-ID: <20220524130630.GA25398@lst.de>
References: <20220524083325.833981-1-hch@lst.de> <YozFt0qFCvZVt67m@T590> <20220524120134.GB17563@lst.de> <YozMGvN/3TJirE3N@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YozMGvN/3TJirE3N@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 24, 2022 at 08:14:18PM +0800, Ming Lei wrote:
> Then please move it to disk release at least, when blk-mq debug becomes
> less useful.

No. del_gendisk is where we need stop all new external access to the
queue so that we can sanely unwind it without chasing one little thing
after another.  This is where we stop allowing opening it, stop allowing
sysfs access, and stop requests from being sent to the driver.  What
we could do is something like the patch below.  It passes basic removal
testing, but I'm a lot less confident in it than the debugfs changes
themselves:

---
From 5d553acccfc6bfbda48f13d252f1411ef65a3d0d Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Tue, 24 May 2022 14:33:09 +0200
Subject: block: freeze the queue earlier in del_gendisk

Ming mentioned that being able to observer request in debugfs might
be useful while the queue is being frozen in del_gendisk.  Move the
free wait before blk_unregister_queue to make that possible.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 36532b9318419..8ff5b187791af 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -621,6 +621,7 @@ void del_gendisk(struct gendisk *disk)
 	 * Prevent new I/O from crossing bio_queue_enter().
 	 */
 	blk_queue_start_drain(q);
+	blk_mq_freeze_queue_wait(q);
 
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
 		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
@@ -644,8 +645,6 @@ void del_gendisk(struct gendisk *disk)
 	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
 	device_del(disk_to_dev(disk));
 
-	blk_mq_freeze_queue_wait(q);
-
 	blk_throtl_cancel_bios(disk->queue);
 
 	blk_sync_queue(q);
-- 
2.30.2

