Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0400D157A57;
	Fri, 31 May 2024 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717156614; cv=none; b=IYZ7L5xkGXgdL1pO6QxrXutUR/ecqm+zE6KdXiYdzKG8Z2ftJRRQ3W4ON6z9oErJzSMSMRu7cHPpv1Utm6vyptS/axW3T9K5oD7Ns2HiBgC4fk32Z+zkwu3YZOLk8O1NJ+5BWmdxibvGuqnrMpIqj+nWrAcZhpUkOl4wf4LkeJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717156614; c=relaxed/simple;
	bh=v5Glmb6ZuhDTz587nJUEfkIG11ufUSkYKVodRGPZILU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRhoIvlughegEDSMT4Vf+C34re+1F1BWa+QzdKDZCLrcyKPtkrPE1XRA/ioplZN46XIyIH92TLVFA51hjE9cPdw8SYodPvJhpk7QyHyyVdOAKI8WAxq0GO90M/zJfB9Dtd8NYbMg0sslvXPf2Q/1oIilJy4E5ncK0rvPLNPmJ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C879C68BFE; Fri, 31 May 2024 13:56:44 +0200 (CEST)
Date: Fri, 31 May 2024 13:56:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com, hch@lst.de, axboe@kernel.dk
Subject: Re: [PATCH V3 for-6.10/block] loop: Fix a race between loop detach
 and loop open
Message-ID: <20240531115644.GA23881@lst.de>
References: <20240529200240.133331-1-gulam.mohamed@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529200240.133331-1-gulam.mohamed@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 29, 2024 at 08:02:40PM +0000, Gulam Mohamed wrote:
> Test case involves the following two scripts:
> 
> script1.sh:
> 
> while [ 1 ];
> do
>         losetup -P -f /home/opt/looptest/test10.img
>         blkid /dev/loop0p1
> done
> 
> script2.sh:
> 
> while [ 1 ];
> do
>         losetup -d /dev/loop0
> done

When just running these in the background, I just get spam of
losetup errors.  Maybe you can turn this into a proper blktests
test case with a sensible timeout?

A for the fix: I suspect it is bette to simply always defer the
actual work of disconnecting the backing device, as that avoid the
race entirely, and simplifies the code in nbd by removing special
cases.  Something like this:


diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 93780f41646b75..c2238c1e2ad68d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1131,7 +1131,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	return error;
 }
 
-static void __loop_clr_fd(struct loop_device *lo, bool release)
+static void __loop_clr_fd(struct loop_device *lo)
 {
 	struct file *filp;
 	gfp_t gfp = lo->old_gfp_mask;
@@ -1139,14 +1139,6 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	if (test_bit(QUEUE_FLAG_WC, &lo->lo_queue->queue_flags))
 		blk_queue_write_cache(lo->lo_queue, false, false);
 
-	/*
-	 * Freeze the request queue when unbinding on a live file descriptor and
-	 * thus an open device.  When called from ->release we are guaranteed
-	 * that there is no I/O in progress already.
-	 */
-	if (!release)
-		blk_mq_freeze_queue(lo->lo_queue);
-
 	spin_lock_irq(&lo->lo_lock);
 	filp = lo->lo_backing_file;
 	lo->lo_backing_file = NULL;
@@ -1164,8 +1156,6 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	mapping_set_gfp_mask(filp->f_mapping, gfp);
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
-	if (!release)
-		blk_mq_unfreeze_queue(lo->lo_queue);
 
 	disk_force_media_change(lo->lo_disk);
 
@@ -1180,11 +1170,7 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 		 * must be at least one and it can only become zero when the
 		 * current holder is released.
 		 */
-		if (!release)
-			mutex_lock(&lo->lo_disk->open_mutex);
 		err = bdev_disk_changed(lo->lo_disk, false);
-		if (!release)
-			mutex_unlock(&lo->lo_disk->open_mutex);
 		if (err)
 			pr_warn("%s: partition scan of loop%d failed (rc=%d)\n",
 				__func__, lo->lo_number, err);
@@ -1232,25 +1218,16 @@ static int loop_clr_fd(struct loop_device *lo)
 		loop_global_unlock(lo, true);
 		return -ENXIO;
 	}
+
 	/*
-	 * If we've explicitly asked to tear down the loop device,
-	 * and it has an elevated reference count, set it for auto-teardown when
-	 * the last reference goes away. This stops $!~#$@ udev from
-	 * preventing teardown because it decided that it needs to run blkid on
-	 * the loopback device whenever they appear. xfstests is notorious for
-	 * failing tests because blkid via udev races with a losetup
-	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup -d
-	 * command to fail with EBUSY.
+	 * Mark the device for removing the backing device on last close.
+	 * If we are the only opener, also switch the state to roundown here to
+	 * prevent new openers from coming in.
 	 */
-	if (disk_openers(lo->lo_disk) > 1) {
-		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
-		loop_global_unlock(lo, true);
-		return 0;
-	}
-	lo->lo_state = Lo_rundown;
+	lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
+	if (disk_openers(lo->lo_disk) == 1)
+		lo->lo_state = Lo_rundown;
 	loop_global_unlock(lo, true);
-
-	__loop_clr_fd(lo, false);
 	return 0;
 }
 
@@ -1720,22 +1697,24 @@ static int lo_compat_ioctl(struct block_device *bdev, blk_mode_t mode,
 static void lo_release(struct gendisk *disk)
 {
 	struct loop_device *lo = disk->private_data;
+	bool need_clear;
 
 	if (disk_openers(disk) > 0)
 		return;
 
+	/*
+	 * Clear the backing device information if this is the last close of
+	 * a device that's been marked for auto clear, or on which LOOP_CLR_FD
+	 * has been called.
+	 */
 	mutex_lock(&lo->lo_mutex);
-	if (lo->lo_state == Lo_bound && (lo->lo_flags & LO_FLAGS_AUTOCLEAR)) {
+	if (lo->lo_state == Lo_bound && (lo->lo_flags & LO_FLAGS_AUTOCLEAR))
 		lo->lo_state = Lo_rundown;
-		mutex_unlock(&lo->lo_mutex);
-		/*
-		 * In autoclear mode, stop the loop thread
-		 * and remove configuration after last close.
-		 */
-		__loop_clr_fd(lo, true);
-		return;
-	}
+	need_clear = (lo->lo_state == Lo_rundown);
 	mutex_unlock(&lo->lo_mutex);
+
+	if (need_clear)
+		__loop_clr_fd(lo);
 }
 
 static void lo_free_disk(struct gendisk *disk)
