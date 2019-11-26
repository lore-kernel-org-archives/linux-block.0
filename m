Return-Path: <SRS0=BQu2=ZS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36CDC432C0
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 22:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7622075C
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 22:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574807527;
	bh=uIyfCznq4dPXaqP/8ltHod77V6UDet8jjj25W6GiV1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E7bDUJAQMp6RJwnBqxdYnDPO8q5udRdDO/Y6Q6dI0qQFasG9jiWwy4HrZM9P5OQde
	 S49QM91LZ0MkVqglcX2/g4joWDWUsxUAQIWK/pUfB/9fnwnuSIKvuFkhShmwK48gF7
	 tSmYWKPR+ooFvNGZRafdNDhlG2QUTl5AmwpoSiJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfKZWcH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Nov 2019 17:32:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:54582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbfKZWcH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 17:32:07 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42F192071E;
        Tue, 26 Nov 2019 22:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574807525;
        bh=uIyfCznq4dPXaqP/8ltHod77V6UDet8jjj25W6GiV1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LP9TUV4KclLfTCFUph2rHtXbYtVgHZglfMh8CpeUF/ydhR4G1YeyvOM3vf8Tad56b
         q5KWoSaW1X7sfFkjqeot3DU8oPt4SgxBPuIBfqMJ5W3Y5YZFT7JJr1zU0xPwHXos1Q
         +73xYZ6xOsoOe+M8rNNRprPXDjhI1hU3vk0N66Sg=
Date:   Tue, 26 Nov 2019 14:32:04 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] loop: avoid EAGAIN, if offset or block_size are
 changed
Message-ID: <20191126223204.GA20652@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190518004751.18962-1-jaegeuk@kernel.org>
 <20190518005304.GA19446@jaegeuk-macbookpro.roam.corp.google.com>
 <1e1aae74-bd6b-dddb-0c88-660aac33872c@acm.org>
 <20191125175913.GC71634@jaegeuk-macbookpro.roam.corp.google.com>
 <a4e5d6bd-3685-379a-c388-cd2871827b21@acm.org>
 <20191125192251.GA76721@jaegeuk-macbookpro.roam.corp.google.com>
 <baaf9725-09b4-3f2d-1408-ead415f5c20d@acm.org>
 <4ab43c9d-8b95-7265-2b55-b6d526938b32@acm.org>
 <20191126182907.GA5510@jaegeuk-macbookpro.roam.corp.google.com>
 <73eb7776-6f13-8dce-28ae-270a90dda229@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73eb7776-6f13-8dce-28ae-270a90dda229@acm.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26, Bart Van Assche wrote:
> On 11/26/19 10:29 AM, Jaegeuk Kim wrote:
> > On 11/25, Bart Van Assche wrote:
> > > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > > index 739b372a5112..84bdb3a6f6d0 100644
> > > --- a/drivers/block/loop.c
> > > +++ b/drivers/block/loop.c
> > > @@ -1264,14 +1264,17 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
> > >   		goto out_unlock;
> > >   	}
> > > 
> > > -	if (lo->lo_offset != info->lo_offset ||
> > > -	    lo->lo_sizelimit != info->lo_sizelimit) {
> > > -		sync_blockdev(lo->lo_device);
> > > -		kill_bdev(lo->lo_device);
> > > -	}
> > > +	/*
> > > +	 * Drain the page cache and the request queue. Set the "dying" flag to
> > > +	 * prevent that kill_bdev() locks up.
> > > +	 */
> > > +	sync_blockdev(lo->lo_device);
> > > 
> > > -	/* I/O need to be drained during transfer transition */
> > > -	blk_mq_freeze_queue(lo->lo_queue);
> > > +	blk_set_queue_dying(lo->lo_queue);
> > > +	blk_mq_freeze_queue_wait(lo->lo_queue);
> > > +
> > > +	/* Kill buffers that got dirtied after the sync_blockdev() call. */
> > 
> > Any race condition where we can truncate any dirty pages written between
> > sync_blockdev() and kill_bdev()?
> > 
> > Thanks,
> > 
> > > +	kill_bdev(lo->lo_device);
> 
> Hi Jaegeuk,
> 
> As you know sync_blockdev() triggers a call to filemap_write_and_wait().
> That function in turn calls mapping->a_ops->writepages() with sync_mode ==
> WB_SYNC_ALL. I think that causes sync_blockdev() to wait until all dirty
> pages have been written so we don't have to worry about pages dirtied before
> the sync_blockdev() call started.

My concern is on some dirty pages after sync_blockdev(), since
truncate_inode_pages() in kill_bdev() will cancel dirty pages.

> 
> Should we try to handle read and write requests that are submitted to a loop
> device while the loop device block size, offset and/or size are being
> modified or is it OK to fail such requests? The blk_set_queue_dying() and
> blk_mq_freeze_queue_wait() calls set the DYING queue flag and also wait for
> all ongoing block layer requests submitted to the loop device to finish. All
> later submit_bio(), generic_make_request(), direct_make_request() and
> blk_get_request() calls will fail with BLK_STS_IOERR or -ENODEV, including
> those triggered by kill_bdev(). In other words, the above patch causes I/O
> to fail that is submitted concurrently with kill_bdev(). Do you agree with
> failing I/O requests submitted to a loop device while the loop device block
> size, offset and/or size are being modified?

Actually, the previous patch returned EAGAIN, if there was an interim IO which
produced some dirty pages betwen kill_bdev() and blk_mq_freeze_queue_wait().
IMHO, we can't do blk_set_queue_dying() which gives EIO to those IOs.

Looking at the flow again, how about this?
---
 drivers/block/loop.c | 67 ++++++++++++++++++++++----------------------
 fs/block_dev.c       | 12 ++++++++
 include/linux/fs.h   |  3 ++
 3 files changed, 48 insertions(+), 34 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f6f77eaa7217..0f3eca774655 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1224,6 +1224,23 @@ static int loop_clr_fd(struct loop_device *lo)
 	return __loop_clr_fd(lo, false);
 }
 
+static void
+loop_mq_freeze_queue(struct loop_device *lo)
+{
+	for (;;) {
+		sync_blockdev(lo->lo_device);
+
+		/* I/O need to be drained during transfer transition */
+		blk_mq_freeze_queue(lo->lo_queue);
+
+		if (is_dirty_bdev(lo->lo_device))
+			blk_mq_unfreeze_queue(lo->lo_queue);
+		else
+			break;
+	}
+	kill_bdev(lo->lo_device);
+}
+
 static int
 loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 {
@@ -1232,6 +1249,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	kuid_t uid = current_uid();
 	struct block_device *bdev;
 	bool partscan = false;
+	bool drop_cache;
 
 	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
@@ -1251,14 +1269,14 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		goto out_unlock;
 	}
 
-	if (lo->lo_offset != info->lo_offset ||
-	    lo->lo_sizelimit != info->lo_sizelimit) {
-		sync_blockdev(lo->lo_device);
-		kill_bdev(lo->lo_device);
-	}
+	drop_cache = (lo->lo_offset != info->lo_offset ||
+	    lo->lo_sizelimit != info->lo_sizelimit);
 
 	/* I/O need to be drained during transfer transition */
-	blk_mq_freeze_queue(lo->lo_queue);
+	if (drop_cache)
+		loop_mq_freeze_queue(lo);
+	else
+		blk_mq_freeze_queue(lo->lo_queue);
 
 	err = loop_release_xfer(lo);
 	if (err)
@@ -1283,16 +1301,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	if (err)
 		goto out_unfreeze;
 
-	if (lo->lo_offset != info->lo_offset ||
-	    lo->lo_sizelimit != info->lo_sizelimit) {
-		/* kill_bdev should have truncated all the pages */
-		if (lo->lo_device->bd_inode->i_mapping->nrpages) {
-			err = -EAGAIN;
-			pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
-				__func__, lo->lo_number, lo->lo_file_name,
-				lo->lo_device->bd_inode->i_mapping->nrpages);
-			goto out_unfreeze;
-		}
+	if (drop_cache) {
 		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit)) {
 			err = -EFBIG;
 			goto out_unfreeze;
@@ -1518,7 +1527,7 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)
 
 static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 {
-	int err = 0;
+	bool drop_cache;
 
 	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
@@ -1526,31 +1535,21 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 	if (arg < 512 || arg > PAGE_SIZE || !is_power_of_2(arg))
 		return -EINVAL;
 
-	if (lo->lo_queue->limits.logical_block_size != arg) {
-		sync_blockdev(lo->lo_device);
-		kill_bdev(lo->lo_device);
-	}
-
-	blk_mq_freeze_queue(lo->lo_queue);
+	drop_cache = (lo->lo_queue->limits.logical_block_size != arg);
 
-	/* kill_bdev should have truncated all the pages */
-	if (lo->lo_queue->limits.logical_block_size != arg &&
-			lo->lo_device->bd_inode->i_mapping->nrpages) {
-		err = -EAGAIN;
-		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
-			__func__, lo->lo_number, lo->lo_file_name,
-			lo->lo_device->bd_inode->i_mapping->nrpages);
-		goto out_unfreeze;
-	}
+	/* I/O need to be drained during transfer transition */
+	if (drop_cache)
+		loop_mq_freeze_queue(lo);
+	else
+		blk_mq_freeze_queue(lo->lo_queue);
 
 	blk_queue_logical_block_size(lo->lo_queue, arg);
 	blk_queue_physical_block_size(lo->lo_queue, arg);
 	blk_queue_io_min(lo->lo_queue, arg);
 	loop_update_dio(lo);
-out_unfreeze:
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
-	return err;
+	return 0;
 }
 
 static int lo_simple_ioctl(struct loop_device *lo, unsigned int cmd,
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9c073dbdc1b0..81fe3beef92b 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -74,6 +74,18 @@ static void bdev_write_inode(struct block_device *bdev)
 	spin_unlock(&inode->i_lock);
 }
 
+bool is_dirty_bdev(struct block_device *bdev)
+{
+	struct inode *inode = bdev->bd_inode;
+	bool dirty;
+
+	spin_lock(&inode->i_lock);
+	dirty = inode->i_state & I_DIRTY ? true: false;
+	spin_unlock(&inode->i_lock);
+	return dirty;
+}
+EXPORT_SYMBOL(is_dirty_bdev);
+
 /* Kill _all_ buffers and pagecache , dirty or not.. */
 void kill_bdev(struct block_device *bdev)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e0d909d35763..02156ad96be2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2570,6 +2570,7 @@ extern void bdput(struct block_device *);
 extern void invalidate_bdev(struct block_device *);
 extern void iterate_bdevs(void (*)(struct block_device *, void *), void *);
 extern int sync_blockdev(struct block_device *bdev);
+extern bool is_dirty_bdev(struct block_device *bdev);
 extern void kill_bdev(struct block_device *);
 extern struct super_block *freeze_bdev(struct block_device *);
 extern void emergency_thaw_all(void);
@@ -2583,9 +2584,11 @@ static inline bool sb_is_blkdev_sb(struct super_block *sb)
 {
 	return sb == blockdev_superblock;
 }
+
 #else
 static inline void bd_forget(struct inode *inode) {}
 static inline int sync_blockdev(struct block_device *bdev) { return 0; }
+static inline bool is_dirty_bdev(struct block_device *bdev) { return false; }
 static inline void kill_bdev(struct block_device *bdev) {}
 static inline void invalidate_bdev(struct block_device *bdev) {}
 
-- 
2.19.0.605.g01d371f741-goog


