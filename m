Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C564C433F5
	for <linux-block@archiver.kernel.org>; Wed,  5 Jan 2022 06:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbiAEGCL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jan 2022 01:02:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234761AbiAEGCK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Jan 2022 01:02:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641362530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UsnDgBrLAEwGQTfXYYh2c/WBcbW4GDhYu26dlbXvFFE=;
        b=I4Fw/nc/lXfVXlyS4Q6fjUvqP1nWOy+DFpucSOCd64oKGZSR2qNHe39LlG3PVxKLTDUw9y
        tXvnuKyl8B7TopFSn7DSe/By/sFi9ePi/VBgaQnEDQ9ItIQa4BXEcWjHp/CTU240aoHJIM
        xRLfdoCWbpWM2hd3Kz7PhhcBV+dmR0g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-0XCTeaNtP42UoDumonxJwA-1; Wed, 05 Jan 2022 01:02:08 -0500
X-MC-Unique: 0XCTeaNtP42UoDumonxJwA-1
Received: by mail-wm1-f72.google.com with SMTP id 83-20020a1c0256000000b00346a78f8fd7so315456wmc.8
        for <linux-block@vger.kernel.org>; Tue, 04 Jan 2022 22:02:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UsnDgBrLAEwGQTfXYYh2c/WBcbW4GDhYu26dlbXvFFE=;
        b=g7hwYNESKtfqSXn+B39UH1TbvxSl/6fK0OGPx2OThN5rXEWq9rb5S4FuHn490BnvvM
         4rYD3/QiJipzsuZKfwCsjSdOFDdkqNOkrfRHtqV1cNc7g/+NFFeQTc66+CpyjCiUa16M
         Nm9gv2gZgQVT8QVVTt/Nh03ZC6Db9LVy6eCQjprngkldI0fxUjON4RTz4gXfdkegTmal
         w07gL4MfnpTR19whhynr2pK4ofjcxmXhE5n1OO3V8MCA8XyUHz04Pdpvc8n2jdpvDgRc
         /ntKQEVhMmfhXqFPXH/zxGPue+DQuVzzpLd6BjSsb+vyWV3ruhJU2nnFVSsu7HFW0GG/
         C6uA==
X-Gm-Message-State: AOAM530+5GOI8lGNCyIDvNx3+DdNk3qIzYYYn2VMdoecChVZTnws2bum
        MXH1r+CHk8UBm3aiJAFw/5Zetr8nmnx5T4zoINyTavsd/XzhSOf65HBg9BY6yZpscIk0z1V/hEl
        8ktFof34IkX2aXISnrkX45r8=
X-Received: by 2002:a5d:6289:: with SMTP id k9mr44195062wru.501.1641362527026;
        Tue, 04 Jan 2022 22:02:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFua50IjNGi5PRHE2pOwFiMtCEhgZWRl+dkzr5nM9kJN3A/N6yn0CRBxAiG0rLOgncXlQlgg==
X-Received: by 2002:a5d:6289:: with SMTP id k9mr44195036wru.501.1641362526760;
        Tue, 04 Jan 2022 22:02:06 -0800 (PST)
Received: from janakin.usersys.redhat.com ([83.148.38.137])
        by smtp.gmail.com with ESMTPSA id p1sm1462112wma.42.2022.01.04.22.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 22:02:06 -0800 (PST)
Date:   Wed, 5 Jan 2022 07:02:04 +0100
From:   Jan Stancek <jstancek@redhat.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block <linux-block@vger.kernel.org>, ltp@lists.linux.it
Subject: Re: [PATCH] make autoclear operation synchronous again
Message-ID: <20220105060201.GA2261405@janakin.usersys.redhat.com>
References: <03f43407-c34b-b7b2-68cd-d4ca93a993b8@i-love.sakura.ne.jp>
 <20211229172902.GC27693@lst.de>
 <4e7b711f-744b-3a78-39be-c9432a3cecd2@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4e7b711f-744b-3a78-39be-c9432a3cecd2@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 30, 2021 at 07:52:34PM +0900, Tetsuo Handa wrote:
>OK. Two patches shown below. Are these look reasonable?
>
>
>
>>From 1409a49181efcc474fbae2cf4e60cbc37adf34aa Mon Sep 17 00:00:00 2001
>From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>Date: Thu, 30 Dec 2021 18:41:05 +0900
>Subject: [PATCH 1/2] loop: Revert "loop: make autoclear operation asynchronous"
>

Thanks, the revert fixes failures we saw recently in LTP tests,
which do mount/umount in close succession:

# for i in `seq 1 2`;do mount -t iso9660 -o loop /root/isofs.iso /mnt/isofs; umount /mnt/isofs/; done
mount: /mnt/isofs: WARNING: source write-protected, mounted read-only.
mount: /mnt/isofs: wrong fs type, bad option, bad superblock on /dev/loop0, missing codepage or helper program, or other error.
umount: /mnt/isofs/: not mounted.

>The kernel test robot is reporting that xfstest can fail at
>
>  umount ext2 on xfs
>  umount xfs
>
>sequence, for commit 322c4293ecc58110 ("loop: make autoclear operation
>asynchronous") broke what commit ("loop: Make explicit loop device
>destruction lazy") wanted to achieve.
>
>Although we cannot guarantee that nobody is holding a reference when
>"umount xfs" is called, we should try to close a race window opened
>by asynchronous autoclear operation.
>
>Reported-by: kernel test robot <oliver.sang@intel.com>
>Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>---
> drivers/block/loop.c | 65 ++++++++++++++++++++------------------------
> drivers/block/loop.h |  1 -
> 2 files changed, 29 insertions(+), 37 deletions(-)
>
>diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>index b1b05c45c07c..e52a8a5e8cbc 100644
>--- a/drivers/block/loop.c
>+++ b/drivers/block/loop.c
>@@ -1082,7 +1082,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
> 	return error;
> }
>
>-static void __loop_clr_fd(struct loop_device *lo)
>+static void __loop_clr_fd(struct loop_device *lo, bool release)
> {
> 	struct file *filp;
> 	gfp_t gfp = lo->old_gfp_mask;
>@@ -1144,6 +1144,8 @@ static void __loop_clr_fd(struct loop_device *lo)
> 	/* let user-space know about this change */
> 	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
> 	mapping_set_gfp_mask(filp->f_mapping, gfp);
>+	/* This is safe: open() is still holding a reference. */
>+	module_put(THIS_MODULE);
> 	blk_mq_unfreeze_queue(lo->lo_queue);
>
> 	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
>@@ -1151,52 +1153,44 @@ static void __loop_clr_fd(struct loop_device *lo)
> 	if (lo->lo_flags & LO_FLAGS_PARTSCAN) {
> 		int err;
>
>-		mutex_lock(&lo->lo_disk->open_mutex);
>+		/*
>+		 * open_mutex has been held already in release path, so don't
>+		 * acquire it if this function is called in such case.
>+		 *
>+		 * If the reread partition isn't from release path, lo_refcnt
>+		 * must be at least one and it can only become zero when the
>+		 * current holder is released.
>+		 */
>+		if (!release)
>+			mutex_lock(&lo->lo_disk->open_mutex);
> 		err = bdev_disk_changed(lo->lo_disk, false);
>-		mutex_unlock(&lo->lo_disk->open_mutex);
>+		if (!release)
>+			mutex_unlock(&lo->lo_disk->open_mutex);
> 		if (err)
> 			pr_warn("%s: partition scan of loop%d failed (rc=%d)\n",
> 				__func__, lo->lo_number, err);
> 		/* Device is gone, no point in returning error */
> 	}
>
>+	/*
>+	 * lo->lo_state is set to Lo_unbound here after above partscan has
>+	 * finished. There cannot be anybody else entering __loop_clr_fd() as
>+	 * Lo_rundown state protects us from all the other places trying to
>+	 * change the 'lo' device.
>+	 */
> 	lo->lo_flags = 0;
> 	if (!part_shift)
> 		lo->lo_disk->flags |= GENHD_FL_NO_PART;
>-
>-	fput(filp);
>-}
>-
>-static void loop_rundown_completed(struct loop_device *lo)
>-{
> 	mutex_lock(&lo->lo_mutex);
> 	lo->lo_state = Lo_unbound;
> 	mutex_unlock(&lo->lo_mutex);
>-	module_put(THIS_MODULE);
>-}
>-
>-static void loop_rundown_workfn(struct work_struct *work)
>-{
>-	struct loop_device *lo = container_of(work, struct loop_device,
>-					      rundown_work);
>-	struct block_device *bdev = lo->lo_device;
>-	struct gendisk *disk = lo->lo_disk;
>-
>-	__loop_clr_fd(lo);
>-	kobject_put(&bdev->bd_device.kobj);
>-	module_put(disk->fops->owner);
>-	loop_rundown_completed(lo);
>-}
>
>-static void loop_schedule_rundown(struct loop_device *lo)
>-{
>-	struct block_device *bdev = lo->lo_device;
>-	struct gendisk *disk = lo->lo_disk;
>-
>-	__module_get(disk->fops->owner);
>-	kobject_get(&bdev->bd_device.kobj);
>-	INIT_WORK(&lo->rundown_work, loop_rundown_workfn);
>-	queue_work(system_long_wq, &lo->rundown_work);
>+	/*
>+	 * Need not hold lo_mutex to fput backing file. Calling fput holding
>+	 * lo_mutex triggers a circular lock dependency possibility warning as
>+	 * fput can take open_mutex which is usually taken before lo_mutex.
>+	 */
>+	fput(filp);
> }
>
> static int loop_clr_fd(struct loop_device *lo)
>@@ -1228,8 +1222,7 @@ static int loop_clr_fd(struct loop_device *lo)
> 	lo->lo_state = Lo_rundown;
> 	mutex_unlock(&lo->lo_mutex);
>
>-	__loop_clr_fd(lo);
>-	loop_rundown_completed(lo);
>+	__loop_clr_fd(lo, false);
> 	return 0;
> }
>
>@@ -1754,7 +1747,7 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
> 		 * In autoclear mode, stop the loop thread
> 		 * and remove configuration after last close.
> 		 */
>-		loop_schedule_rundown(lo);
>+		__loop_clr_fd(lo, true);
> 		return;
> 	} else if (lo->lo_state == Lo_bound) {
> 		/*
>diff --git a/drivers/block/loop.h b/drivers/block/loop.h
>index 918a7a2dc025..082d4b6bfc6a 100644
>--- a/drivers/block/loop.h
>+++ b/drivers/block/loop.h
>@@ -56,7 +56,6 @@ struct loop_device {
> 	struct gendisk		*lo_disk;
> 	struct mutex		lo_mutex;
> 	bool			idr_visible;
>-	struct work_struct      rundown_work;
> };
>
> struct loop_cmd {
>-- 
>2.32.0
>

