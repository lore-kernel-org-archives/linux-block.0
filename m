Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7669C433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 11:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348140AbiCPLYQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 07:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245571AbiCPLYP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 07:24:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321C132991
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 04:23:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B7FA121123;
        Wed, 16 Mar 2022 11:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647429778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=36zD6y1IL8V1LtkkkK3OzWNglp6FD/lvZtQELa++Kmk=;
        b=jh0wL69AWozALfmFRdHTjqajbDKm7IOOtBNzJZ6AzCtEHevw6ZJ5y5EovF9k8kDYZUFrPI
        Ex0c0enIkDFH+NUF4CvQoTumco9HkiEG47ZEWB3EcDe6D0gCuWlOGA4VBvyuXFbB3pMGK2
        Ip86wjhSrG+RExe1fFHcvIQ4KcUK/7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647429778;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=36zD6y1IL8V1LtkkkK3OzWNglp6FD/lvZtQELa++Kmk=;
        b=B16dDQeFIJkd/l1WDVeORhlOnfo8S3Xa2gGTBcrT68NRvOhS3yDBuEYCcW/FwrzCK0R8qM
        T3YFuwvjQ53xOoCw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9B9ECA3B98;
        Wed, 16 Mar 2022 11:22:58 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 44EB7A0615; Wed, 16 Mar 2022 12:22:58 +0100 (CET)
Date:   Wed, 16 Mar 2022 12:22:58 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 7/8] loop: remove lo_refcount and avoid lo_mutex in
 ->open / ->release
Message-ID: <20220316112258.6hjksrv7yqiqcncu@quack3.lan>
References: <20220316084519.2850118-1-hch@lst.de>
 <20220316084519.2850118-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316084519.2850118-8-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 16-03-22 09:45:18, Christoph Hellwig wrote:
> lo_refcount counts how many openers a loop device has, but that count
> is already provided by the block layer in the bd_openers field of the
> whole-disk block_device.  Remove lo_refcount and allow opens to
> succeed even on devices beeing deleted - now that ->free_disk is
> implemented we can handle that race gracefull and all I/O on it will
> just fail. Similarly there is a small race window now where
> loop_control_remove does not synchronize the delete vs the remove
> due do bd_openers not being under lo_mutex protection, but we can
> handle that just as gracefully.

Honestly, I'm a bit uneasy about these races and ability to have open
removed loop device (given use of loop devices in container environments
potential problems could have security implications). But I guess it is no
different to having open hot-unplugged scsi disk. There may be just an
expectation from userspace that your open either blocks loop device removal
or open fails. But I guess we can deal with that if some real breakage
happens - it does not seem that hard to solve - we just need
loop_control_remove() to grab disk->open_mutex to make transition to
Lo_deleting state safe and keep Lo_deleting check in lo_open(). Plus we'd
need to use READ_ONCE / WRITE_ONCE for lo_state accesses.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/loop.c | 36 +++++++-----------------------------
>  drivers/block/loop.h |  1 -
>  2 files changed, 7 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index cbaa18bcad1fe..c270f3715d829 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1244,7 +1244,7 @@ static int loop_clr_fd(struct loop_device *lo)
>  	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup -d
>  	 * command to fail with EBUSY.
>  	 */
> -	if (atomic_read(&lo->lo_refcnt) > 1) {
> +	if (lo->lo_disk->part0->bd_openers > 1) {

But bd_openers can be read safely only under disk->open_mutex. So for this
to be safe against compiler playing nasty tricks with optimizations, we
need to either make bd_openers atomic_t or use READ_ONCE / WRITE_ONCE when
accessing it.

> @@ -1724,33 +1724,15 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
>  }
>  #endif
>  
> -static int lo_open(struct block_device *bdev, fmode_t mode)
> -{
> -	struct loop_device *lo = bdev->bd_disk->private_data;
> -	int err;
> -
> -	err = mutex_lock_killable(&lo->lo_mutex);
> -	if (err)
> -		return err;
> -	if (lo->lo_state == Lo_deleting)
> -		err = -ENXIO;
> -	else
> -		atomic_inc(&lo->lo_refcnt);
> -	mutex_unlock(&lo->lo_mutex);
> -	return err;
> -}
> -

Tetsuo has observed [1] that not grabbing lo_mutex when opening loop device
tends to break systemd-udevd because in loop_configure() we send
DISK_EVENT_MEDIA_CHANGE event before the device is fully configured (but
the configuration gets finished before we release the lo_mutex) and so
systemd-udev gets spurious IO errors when probing new loop devices and is
unhappy. So I think this is the right way to go but we need to reshuffle
loop_configure() a bit first.

[1] https://lore.kernel.org/all/a72c59c6-298b-e4ba-b1f5-2275afab49a1@I-love.SAKURA.ne.jp/T/#u


								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
