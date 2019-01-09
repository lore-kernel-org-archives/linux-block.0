Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA43C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 05:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6983420883
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 05:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547011357;
	bh=4+gpQWAzKL285mAFcSkebQtdYiJ07ZSZGgKxHBuSDx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1kXT2wTFGOIxcKPo+SOg2KJ7tLpmpYRfS6AOF6NBY+Be9dRWn813vB7GclH1rNpM+
	 SKmVxWJnc+hTQSdmGdYFYLiw0vXJBmlaTEgSQjogt3tTW3vvQU0ix7Kf2yGmuep9q9
	 2P4xg+z5yPqxWhr3Dpi75S5BoI2jiUxRLI96YPa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbfAIFWg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 00:22:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:60174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729132AbfAIFWg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Jan 2019 00:22:36 -0500
Received: from localhost (unknown [104.132.1.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8548620883;
        Wed,  9 Jan 2019 05:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547011355;
        bh=4+gpQWAzKL285mAFcSkebQtdYiJ07ZSZGgKxHBuSDx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gTxtz3mWApTaR0ATun8FzKXnOli/6jt7rw6jRIZp5HQeupr3SFF9nNWwYHkA3ISr0
         S03J5SpJQx9P/mGAS2+dXOZrA6J5WtwDqwPCgrYZN59V8R0PLsCQmDbax6Pg3lehFd
         JxjPhfgPDLk3Z7scjOUsfboZecstqQyCi2NIbyPI=
Date:   Tue, 8 Jan 2019 21:22:34 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v3] loop: drop caches if offset or block_size are changed
Message-ID: <20190109052234.GA81011@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181214203223.7063-1-jaegeuk@kernel.org>
 <20181217194236.GA50659@jaegeuk-macbookpro.roam.corp.google.com>
 <29369548-df14-a5a7-2bee-a40b3479df68@kernel.dk>
 <20181218224139.GB31062@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218224139.GB31062@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

May I ask whether this patch is acceptable?

Thanks,

On 12/18, Jaegeuk Kim wrote:
> If we don't drop caches used in old offset or block_size, we can get old data
> from new offset/block_size, which gives unexpected data to user.
> 
> For example, Martijn found a loopback bug in the below scenario.
> 1) LOOP_SET_FD loads first two pages on loop file
> 2) LOOP_SET_STATUS64 changes the offset on the loop file
> 3) mount is failed due to the cached pages having wrong superblock
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Reported-by: Martijn Coenen <maco@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> v2 -> v3:
>  - avoid to submit IOs on frozen mq
> 
> Jens, how about this?
> 
> Thanks,
> 
>  drivers/block/loop.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index cb0cc8685076..6b03121d62aa 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1126,6 +1126,12 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>  	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE)
>  		return -EINVAL;
>  
> +	if (lo->lo_offset != info->lo_offset ||
> +	    lo->lo_sizelimit != info->lo_sizelimit) {
> +		sync_blockdev(lo->lo_device);
> +		kill_bdev(lo->lo_device);
> +	}
> +
>  	/* I/O need to be drained during transfer transition */
>  	blk_mq_freeze_queue(lo->lo_queue);
>  
> @@ -1154,6 +1160,11 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>  
>  	if (lo->lo_offset != info->lo_offset ||
>  	    lo->lo_sizelimit != info->lo_sizelimit) {
> +		/* kill_bdev should have truncated all the pages */
> +		if (lo->lo_device->bd_inode->i_mapping->nrpages) {
> +			err = -EAGAIN;
> +			goto exit;
> +		}
>  		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit)) {
>  			err = -EFBIG;
>  			goto exit;
> @@ -1375,22 +1386,36 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)
>  
>  static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
>  {
> +	int err = 0;
> +
>  	if (lo->lo_state != Lo_bound)
>  		return -ENXIO;
>  
>  	if (arg < 512 || arg > PAGE_SIZE || !is_power_of_2(arg))
>  		return -EINVAL;
>  
> +	if (lo->lo_queue->limits.logical_block_size != arg) {
> +		sync_blockdev(lo->lo_device);
> +		kill_bdev(lo->lo_device);
> +	}
> +
>  	blk_mq_freeze_queue(lo->lo_queue);
>  
> +	/* kill_bdev should have truncated all the pages */
> +	if (lo->lo_queue->limits.logical_block_size != arg &&
> +			lo->lo_device->bd_inode->i_mapping->nrpages) {
> +		err = -EAGAIN;
> +		goto out;
> +	}
> +
>  	blk_queue_logical_block_size(lo->lo_queue, arg);
>  	blk_queue_physical_block_size(lo->lo_queue, arg);
>  	blk_queue_io_min(lo->lo_queue, arg);
>  	loop_update_dio(lo);
> -
> +out:
>  	blk_mq_unfreeze_queue(lo->lo_queue);
>  
> -	return 0;
> +	return err;
>  }
>  
>  static int lo_ioctl(struct block_device *bdev, fmode_t mode,
> -- 
> 2.19.0.605.g01d371f741-goog
