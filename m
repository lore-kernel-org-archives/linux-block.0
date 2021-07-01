Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320ECC11F64
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 07:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A6B961490
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 07:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbhGAHpD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jul 2021 03:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhGAHpC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Jul 2021 03:45:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F15C061756;
        Thu,  1 Jul 2021 00:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Gq2ljfs2CXXb3YhD80yiiPsmHKF8xMR8mqGstdWnGlQ=; b=wIM71vPuXgowFO5VOyaPi1mS0G
        +uM8DKlAu4CoK9uVAVNWLE2u4HIXcNdfMZMI91DdNZIFJB3z1AUcOwIT8No38azcqUYl5ivsc97x5
        e756gbK84Z7gZY1z1DxBLGTJJLU9Nsr1MPq1dfCZCAHVlwnB2cURPDPJtpD+27qHiD/BGytjNIBHO
        oYMA5ryciMg6EgNRB1PUQcuMPIc0R9bTiwDHvH7TlgsvzvQtfu3quNdjaZmeIikZ5Zlu6mu66SFYL
        PYVleWdAKfRdkUde4HpkwdDBsxuoq11Y3j513yH4Uh4TgcpcUUVVO8D19IqgW1CaQgp4JAi4a/J/E
        KlkVsR1g==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyrKm-006J4o-W0; Thu, 01 Jul 2021 07:42:12 +0000
Date:   Thu, 1 Jul 2021 08:42:04 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian L?hle <CLoehle@hyperstone.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] block: prevent sending events from removed device
Message-ID: <YN1xzGPbx8ac8r3j@infradead.org>
References: <CWXP265MB2680EBAF4FEE64FBE80FAF25C4019@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CWXP265MB2680EBAF4FEE64FBE80FAF25C4019@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 30, 2021 at 08:09:39AM +0000, Christian L?hle wrote:
> Skip kobject_uevent_env in case the associated kobject
> no longer exists, as calling kobject_uevent_env with
> NULL is not safe.
> 

I don't see how this is going to work.  If the device is being
deleted the reference count will be zero and refcount_inc as
called from kobject_get will WARN.  We'll need to check the
disk is marked up, and we need to do that under a lock.

Something like this completely untested patch:

diff --git a/block/disk-events.c b/block/disk-events.c
index a75931ff5da4..27b845c51f2a 100644
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -190,6 +190,9 @@ static void disk_check_events(struct disk_events *ev,
 
 	spin_unlock_irq(&ev->lock);
 
+	if (!(disk->flags & GENHD_FL_UP))
+		return;
+
 	/*
 	 * Tell userland about new events.  Only the events listed in
 	 * @disk->events are reported, and only if DISK_EVENT_FLAG_UEVENT
@@ -268,6 +271,8 @@ bool bdev_check_media_change(struct block_device *bdev)
 {
 	unsigned int events;
 
+	lockdep_assert_held(&bdev->bd_disk->open_mutex);
+
 	events = disk_clear_events(bdev->bd_disk, DISK_EVENT_MEDIA_CHANGE |
 				   DISK_EVENT_EJECT_REQUEST);
 	if (!(events & DISK_EVENT_MEDIA_CHANGE))
@@ -290,7 +295,10 @@ static void disk_events_workfn(struct work_struct *work)
 	struct delayed_work *dwork = to_delayed_work(work);
 	struct disk_events *ev = container_of(dwork, struct disk_events, dwork);
 
-	disk_check_events(ev, &ev->clearing);
+	mutex_lock(&ev->disk->open_mutex);
+	if (ev->disk->flags & GENHD_FL_UP)
+		disk_check_events(ev, &ev->clearing);
+	mutex_unlock(&ev->disk->open_mutex);
 }
 
 /*
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index a093644ac39f..b8e77da44235 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1735,8 +1735,10 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
 		/* invalidate the buffer track to force a reread */
 		BufferDrive = -1;
 		set_bit(drive, &fake_change);
+		mutex_lock(&bdev->bd_disk->open_mutex);
 		if (bdev_check_media_change(bdev))
 			floppy_revalidate(bdev->bd_disk);
+		mutex_unlock(&bdev->bd_disk->open_mutex);
 		return 0;
 	default:
 		return -EINVAL;
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 87460e0e5c72..2a97f22cfa0b 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3185,8 +3185,10 @@ static int invalidate_drive(struct block_device *bdev)
 	/* invalidate the buffer track to force a reread */
 	set_bit((long)bdev->bd_disk->private_data, &fake_change);
 	process_fd_request();
+	mutex_lock(&bdev->bd_disk->open_mutex);
 	if (bdev_check_media_change(bdev))
 		floppy_revalidate(bdev->bd_disk);
+	mutex_unlock(&bdev->bd_disk->open_mutex);
 	return 0;
 }
 
