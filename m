Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B18C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 11:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8072086C
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 11:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfBULaI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:30:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:43674 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727505AbfBULaI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Feb 2019 06:30:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DE409B124;
        Thu, 21 Feb 2019 11:30:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 713D01E0900; Thu, 21 Feb 2019 12:30:05 +0100 (CET)
Date:   Thu, 21 Feb 2019 12:30:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, jack@suse.cz
Subject: Re: [PATCH 2/2] loop: set GENHD_FL_NO_PART_SCAN after
 blkdev_reread_part()
Message-ID: <20190221113005.GF27474@quack2.suse.cz>
References: <1550722655-15102-1-git-send-email-dongli.zhang@oracle.com>
 <1550722655-15102-3-git-send-email-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550722655-15102-3-git-send-email-dongli.zhang@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 21-02-19 12:17:35, Dongli Zhang wrote:
> Commit 0da03cab87e6
> ("loop: Fix deadlock when calling blkdev_reread_part()") moves
> blkdev_reread_part() out of the loop_ctl_mutex. However,
> GENHD_FL_NO_PART_SCAN is set before __blkdev_reread_part(). As a result,
> __blkdev_reread_part() will fail the check of GENHD_FL_NO_PART_SCAN and
> will not rescan the loop device to delete all partitions.
> 
> Below are steps to reproduce the issue:
> 
> step1 # dd if=/dev/zero of=tmp.raw bs=1M count=100
> step2 # losetup -P /dev/loop0 tmp.raw
> step3 # parted /dev/loop0 mklabel gpt
> step4 # parted -a none -s /dev/loop0 mkpart primary 64s 1
> step5 # losetup -d /dev/loop0

Can you perhaps write a blktest for this? Thanks!

> Step5 will not be able to delete /dev/loop0p1 (introduced by step4) and
> there is below kernel warning message:
> 
> [  464.414043] __loop_clr_fd: partition scan of loop0 failed (rc=-22)
> 
> This patch sets GENHD_FL_NO_PART_SCAN after blkdev_reread_part().
> 
> Fixes: 0da03cab87e6 ("loop: Fix deadlock when calling blkdev_reread_part()")
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  drivers/block/loop.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 7908673..736e55b 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1034,6 +1034,15 @@ loop_init_xfer(struct loop_device *lo, struct loop_func_table *xfer,
>  	return err;
>  }
>  
> +static void loop_disable_partscan(struct loop_device *lo)
> +{
> +	mutex_lock(&loop_ctl_mutex);
> +	lo->lo_flags = 0;
> +	if (!part_shift)
> +		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
> +	mutex_unlock(&loop_ctl_mutex);
> +}
> +
>  static int __loop_clr_fd(struct loop_device *lo, bool release)
>  {
>  	struct file *filp = NULL;
> @@ -1096,9 +1105,6 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>  
>  	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN && bdev;
>  	lo_number = lo->lo_number;
> -	lo->lo_flags = 0;
> -	if (!part_shift)
> -		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
>  	loop_unprepare_queue(lo);
>  out_unlock:
>  	mutex_unlock(&loop_ctl_mutex);
> @@ -1121,6 +1127,9 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>  		/* Device is gone, no point in returning error */
>  		err = 0;
>  	}
> +
> +	loop_disable_partscan(lo);
> +
>  	/*
>  	 * Need not hold loop_ctl_mutex to fput backing file.
>  	 * Calling fput holding loop_ctl_mutex triggers a circular

So I don't think this change is actually correct. The problem is that once
lo->lo_state is set to Lo_unbound and loop_ctl_mutex is unlocked, the loop
device structure can be reused for a new device (bound to a new file). So
you cannot safely manipulate flags on lo->lo_disk anymore. But I think we
can just move the setting of lo->lo_state to Lo_unbound after partscan has
finished as well. There cannot be anybody else entering __loop_clr_fd() as
lo->lo_backing_file is already cleared and Lo_rundown state protects us
from all the other places trying to change the 'lo' device (please make
this last sentence into a comment in the code explaining why setting
lo->lo_state so late is fine). Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
