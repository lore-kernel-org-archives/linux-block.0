Return-Path: <SRS0=Lpm0=ZT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA63CC432C3
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 00:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB746206CC
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 00:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574813050;
	bh=IOoJizwedE90TYxPEZ85AcM8mDCV17gUrKiseQrscdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TYd39us9IIzEBI/5HsACztXT8dHUxCuluV4hvnDFM07qYrMQ+K7VTPDuZsvgQsIqz
	 QcwacmWB0K9/pVUkDtaneee3Cm9p9BSxdjEF4GFRDDFTkat1eQg+moRjUjxTLzGP8A
	 9MmOhOvUysmuL6vduVRzMyAseE3Md8pJpgk9FWFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfK0AEK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Nov 2019 19:04:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:59096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbfK0AEK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 19:04:10 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A664E20665;
        Wed, 27 Nov 2019 00:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574813048;
        bh=IOoJizwedE90TYxPEZ85AcM8mDCV17gUrKiseQrscdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GNeXwbjsH9PfRCBmn60JbZUgH4560suUZv89E4fyGE/WnHkaEBtOVMg1qR9SG2cET
         sIYV9GPSr4XEq/5tyWEzKBIPodSEyMWKssa8eD13CdEAAbyadZkpPo9uAj1ePt2eVB
         HZAnEFlFsEgJdsh84QWm5W3q2E6Ecs9vhYTI2BGk=
Date:   Tue, 26 Nov 2019 16:04:07 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] loop: avoid EAGAIN, if offset or block_size are
 changed
Message-ID: <20191127000407.GC20652@jaegeuk-macbookpro.roam.corp.google.com>
References: <1e1aae74-bd6b-dddb-0c88-660aac33872c@acm.org>
 <20191125175913.GC71634@jaegeuk-macbookpro.roam.corp.google.com>
 <a4e5d6bd-3685-379a-c388-cd2871827b21@acm.org>
 <20191125192251.GA76721@jaegeuk-macbookpro.roam.corp.google.com>
 <baaf9725-09b4-3f2d-1408-ead415f5c20d@acm.org>
 <4ab43c9d-8b95-7265-2b55-b6d526938b32@acm.org>
 <20191126182907.GA5510@jaegeuk-macbookpro.roam.corp.google.com>
 <73eb7776-6f13-8dce-28ae-270a90dda229@acm.org>
 <20191126223204.GA20652@jaegeuk-macbookpro.roam.corp.google.com>
 <e64f65cc-d86f-54b9-8b4d-fe74860e16ea@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e64f65cc-d86f-54b9-8b4d-fe74860e16ea@acm.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26, Bart Van Assche wrote:
> On 11/26/19 2:32 PM, Jaegeuk Kim wrote:
> > +static void
> > +loop_mq_freeze_queue(struct loop_device *lo)
> > +{
> > +	for (;;) {
> > +		sync_blockdev(lo->lo_device);
> > +
> > +		/* I/O need to be drained during transfer transition */
> > +		blk_mq_freeze_queue(lo->lo_queue);
> > +
> > +		if (is_dirty_bdev(lo->lo_device))
> > +			blk_mq_unfreeze_queue(lo->lo_queue);
> > +		else
> > +			break;
> > +	}
> > +	kill_bdev(lo->lo_device);
> > +}
> 
> Maybe I overlooked something, but how does the above code prevent that pages
> get dirtied after is_dirty_bdev() returns false? blk_mq_freeze_queue()
> freezes lo->lo_queue but not the filesystem that uses that request queue.
> Did you perhaps want to call a function that freezes filesystem activity
> from inside the loop (not sure if such a function already exists)?

Ah, no. Indeed, I realize that that's why I posted v2 patch at the first time.
We don't need to care about any stale cached pages during transition, but
after transition, it'd be enough to refresh the page cache.

The below should be v3.

From 7700e52a9e04c02256923222d8948ac6e1182b60 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 17 May 2019 16:37:50 -0700
Subject: [PATCH] loop: avoid EAGAIN, if offset or block_size are changed

This patch tries to avoid EAGAIN due to nrpages!=0 that was originally trying
to drop stale pages resulting in wrong data access.

Report: https://bugs.chromium.org/p/chromium/issues/detail?id=938958#c38

Cc: <stable@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Fixes: 5db470e229e2 ("loop: drop caches if offset or block_size are changed")
Reported-by: Gwendal Grignou <gwendal@chromium.org>
Reported-by: grygorii tertychnyi <gtertych@cisco.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 drivers/block/loop.c | 48 +++++++++++++++++---------------------------
 1 file changed, 18 insertions(+), 30 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f6f77eaa7217..aeab5897ec8f 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1232,6 +1232,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	kuid_t uid = current_uid();
 	struct block_device *bdev;
 	bool partscan = false;
+	bool drop_caches = false;
 
 	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
@@ -1252,10 +1253,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	}
 
 	if (lo->lo_offset != info->lo_offset ||
-	    lo->lo_sizelimit != info->lo_sizelimit) {
-		sync_blockdev(lo->lo_device);
-		kill_bdev(lo->lo_device);
-	}
+	    lo->lo_sizelimit != info->lo_sizelimit)
+		drop_caches = true;
 
 	/* I/O need to be drained during transfer transition */
 	blk_mq_freeze_queue(lo->lo_queue);
@@ -1285,14 +1284,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 
 	if (lo->lo_offset != info->lo_offset ||
 	    lo->lo_sizelimit != info->lo_sizelimit) {
-		/* kill_bdev should have truncated all the pages */
-		if (lo->lo_device->bd_inode->i_mapping->nrpages) {
-			err = -EAGAIN;
-			pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
-				__func__, lo->lo_number, lo->lo_file_name,
-				lo->lo_device->bd_inode->i_mapping->nrpages);
-			goto out_unfreeze;
-		}
 		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit)) {
 			err = -EFBIG;
 			goto out_unfreeze;
@@ -1337,6 +1328,12 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		bdev = lo->lo_device;
 		partscan = true;
 	}
+
+	/* truncate stale pages cached by previous operations */
+	if (!err && drop_caches) {
+		sync_blockdev(lo->lo_device);
+		invalidate_bdev(lo->lo_device);
+	}
 out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
 	if (partscan)
@@ -1518,7 +1515,7 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)
 
 static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 {
-	int err = 0;
+	bool drop_caches = false;
 
 	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
@@ -1526,31 +1523,22 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 	if (arg < 512 || arg > PAGE_SIZE || !is_power_of_2(arg))
 		return -EINVAL;
 
-	if (lo->lo_queue->limits.logical_block_size != arg) {
-		sync_blockdev(lo->lo_device);
-		kill_bdev(lo->lo_device);
-	}
+	if (lo->lo_queue->limits.logical_block_size != arg)
+		drop_caches = true;
 
 	blk_mq_freeze_queue(lo->lo_queue);
-
-	/* kill_bdev should have truncated all the pages */
-	if (lo->lo_queue->limits.logical_block_size != arg &&
-			lo->lo_device->bd_inode->i_mapping->nrpages) {
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
 
-	return err;
+	/* truncate stale pages cached by previous operations */
+	if (drop_caches) {
+		sync_blockdev(lo->lo_device);
+		invalidate_bdev(lo->lo_device);
+	}
+	return 0;
 }
 
 static int lo_simple_ioctl(struct loop_device *lo, unsigned int cmd,
-- 
2.19.0.605.g01d371f741-goog

