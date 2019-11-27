Return-Path: <SRS0=Lpm0=ZT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBB6C432C0
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 01:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CEC2071E
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 01:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574816969;
	bh=lWeR3wbfc1t2Md0Qy2yffMpt+WdRJmJzcWE3zR70qMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zilJrjY24/CE1qkXxItNCNnoNsF7/D/Mrz9+ZewnZqGhp1VxvlsE/6nvW5rnWITJW
	 gDhss9jBaBvPFgYV1NrESDMDNjcVhPcvrfAuT5zcnRNrmuDyCp8svKBNCtGbjuG6//
	 h8R/FEiXNt00d1S92xvVQRdRljuynGFk4ZHr4NIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbfK0BJ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Nov 2019 20:09:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:53806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfK0BJ2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 20:09:28 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 382752071E;
        Wed, 27 Nov 2019 01:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574816967;
        bh=lWeR3wbfc1t2Md0Qy2yffMpt+WdRJmJzcWE3zR70qMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=knI27QdD3pWiYWY/Z8J0Hg8jN+ZZSm7tWVO64XHAIEDEtohxzi3FP5tvrigUNet1f
         k3l9S6Os6+CFTxigqa5ymPsKC8ewXaFpjLJjpjobITNgRHNEDM+3AQf9X64iLPULVA
         q+lZzUKdtw6h6ZvSGsO62/Z4Lq858oDbSNtpFzjg=
Date:   Tue, 26 Nov 2019 17:09:26 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] loop: avoid EAGAIN, if offset or block_size are
 changed
Message-ID: <20191127010926.GA34613@jaegeuk-macbookpro.roam.corp.google.com>
References: <a4e5d6bd-3685-379a-c388-cd2871827b21@acm.org>
 <20191125192251.GA76721@jaegeuk-macbookpro.roam.corp.google.com>
 <baaf9725-09b4-3f2d-1408-ead415f5c20d@acm.org>
 <4ab43c9d-8b95-7265-2b55-b6d526938b32@acm.org>
 <20191126182907.GA5510@jaegeuk-macbookpro.roam.corp.google.com>
 <73eb7776-6f13-8dce-28ae-270a90dda229@acm.org>
 <20191126223204.GA20652@jaegeuk-macbookpro.roam.corp.google.com>
 <e64f65cc-d86f-54b9-8b4d-fe74860e16ea@acm.org>
 <20191127000407.GC20652@jaegeuk-macbookpro.roam.corp.google.com>
 <3ca36251-57c4-b62c-c029-77b643ddea77@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ca36251-57c4-b62c-c029-77b643ddea77@acm.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26, Bart Van Assche wrote:
> On 11/26/19 4:04 PM, Jaegeuk Kim wrote:
> > Subject: [PATCH] loop: avoid EAGAIN, if offset or block_size are changed
> > 
> > This patch tries to avoid EAGAIN due to nrpages!=0 that was originally trying
> > to drop stale pages resulting in wrong data access.
> 
> Does this patch remove all code that returns EAGAIN from the code paths used
> for changing the offset and block size? If so, please make the commit
> message more affirmative.
> 
> >   	if (lo->lo_offset != info->lo_offset ||
> > -	    lo->lo_sizelimit != info->lo_sizelimit) {
> > -		sync_blockdev(lo->lo_device);
> > -		kill_bdev(lo->lo_device);
> > -	}
> > +	    lo->lo_sizelimit != info->lo_sizelimit)
> > +		drop_caches = true;
> 
> If the offset is changed and dirty pages are only flushed after the loop
> device offset has been changed, can that cause data to be written at a wrong
> LBA? In other words, I'd like to keep a sync_blockdev() call here.
> 
> > +	/* truncate stale pages cached by previous operations */
> > +	if (!err && drop_caches) {
> > +		sync_blockdev(lo->lo_device);
> > +		invalidate_bdev(lo->lo_device);
> > +	}
> 
> Is the invalidate_bdev() call necessary here?

We need this to reload 4KB-sized buffer caches back.

How about this?

From ceef42dbf4ec74c34d58125a20cc11ef13e2e1c4 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 17 May 2019 16:37:50 -0700
Subject: [PATCH] loop: avoid EAGAIN, if offset or block_size are changed

Previously, there was a bug where user could see stale buffer cache (e.g, 512B)
attached in the 4KB-sized pager cache, when the block size was changed from
512B to 4KB. That was fixed by:
commit 5db470e229e2 ("loop: drop caches if offset or block_size are changed")

But, there were some regression reports saying the fix returns EAGAIN easily.
So, this patch removes previously added EAGAIN condition, nrpages != 0.

Instead, it changes the flow like this:
- sync_blockdev()
- blk_mq_freeze_queue()
 : change the loop configuration
- blk_mq_unfreeze_queue()
- sync_blockdev()
- invalidate_bdev()

After invalidating the buffer cache, we must see the full valid 4KB page.

Additional concern came from Bart in which we can lose some data when
changing the lo_offset. In that case, this patch adds:
- sync_blockdev()
- blk_set_queue_dying
- blk_mq_freeze_queue()
 : change the loop configuration
- blk_mq_unfreeze_queue()
- blk_queue_flag_clear(QUEUE_FLAG_DYING);
- sync_blockdev()
- invalidate_bdev()

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
 drivers/block/loop.c | 59 ++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f6f77eaa7217..9c1985de85e0 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1232,6 +1232,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	kuid_t uid = current_uid();
 	struct block_device *bdev;
 	bool partscan = false;
+	bool drop_request = false;
+	bool drop_cache = false;
 
 	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
@@ -1251,11 +1253,16 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		goto out_unlock;
 	}
 
+	if (lo->lo_offset != info->lo_offset)
+		drop_request = true;
 	if (lo->lo_offset != info->lo_offset ||
-	    lo->lo_sizelimit != info->lo_sizelimit) {
-		sync_blockdev(lo->lo_device);
-		kill_bdev(lo->lo_device);
-	}
+	    lo->lo_sizelimit != info->lo_sizelimit)
+		drop_cache = true;
+
+	sync_blockdev(lo->lo_device);
+
+	if (drop_request)
+		blk_set_queue_dying(lo->lo_queue);
 
 	/* I/O need to be drained during transfer transition */
 	blk_mq_freeze_queue(lo->lo_queue);
@@ -1285,14 +1292,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 
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
@@ -1329,6 +1328,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 
 out_unfreeze:
 	blk_mq_unfreeze_queue(lo->lo_queue);
+	if (drop_request)
+		blk_queue_flag_clear(QUEUE_FLAG_DYING, lo->lo_queue);
 
 	if (!err && (info->lo_flags & LO_FLAGS_PARTSCAN) &&
 	     !(lo->lo_flags & LO_FLAGS_PARTSCAN)) {
@@ -1337,6 +1338,12 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		bdev = lo->lo_device;
 		partscan = true;
 	}
+
+	/* truncate stale pages cached by previous operations */
+	if (!err && drop_cache) {
+		sync_blockdev(lo->lo_device);
+		invalidate_bdev(lo->lo_device);
+	}
 out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
 	if (partscan)
@@ -1518,7 +1525,7 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)
 
 static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 {
-	int err = 0;
+	bool drop_cache = false;
 
 	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
@@ -1526,31 +1533,23 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 	if (arg < 512 || arg > PAGE_SIZE || !is_power_of_2(arg))
 		return -EINVAL;
 
-	if (lo->lo_queue->limits.logical_block_size != arg) {
-		sync_blockdev(lo->lo_device);
-		kill_bdev(lo->lo_device);
-	}
+	if (lo->lo_queue->limits.logical_block_size != arg)
+		drop_cache = true;
 
+	sync_blockdev(lo->lo_device);
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
+	if (drop_cache) {
+		sync_blockdev(lo->lo_device);
+		invalidate_bdev(lo->lo_device);
+	}
+	return 0;
 }
 
 static int lo_simple_ioctl(struct loop_device *lo, unsigned int cmd,
-- 
2.19.0.605.g01d371f741-goog


