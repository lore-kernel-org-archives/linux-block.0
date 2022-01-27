Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F273EC433EF
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 10:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiA0K2v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 05:28:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35402 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbiA0K2u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 05:28:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DB2101F37E;
        Thu, 27 Jan 2022 10:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643279328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JQ5nQP5ZEIHmMcjQjjt2+k+LECZmocgxkccRc8UrERo=;
        b=RkZLod4TAKpE4W1uPfUXJv9J4462bNB6Xqh1wDDgRf3sBZTjX4x2FLnq/wX99n3ngJF6Dr
        nFfq00y4sux7j6ky2tj1VgcohVK1OHriKZxjZ2wMeFvPg5ePG7+zrNkCfbEOqyVKjZrAu2
        VGd+I9JyJKIqu460z5AttJ/Jl8BTH+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643279328;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JQ5nQP5ZEIHmMcjQjjt2+k+LECZmocgxkccRc8UrERo=;
        b=aImBtpNk8TCEs+C9eJXARTZFKrCseIsVCuMUv2mtCokJ+/kMR4PXd6t19SsqIohAGaaTia
        aFo6TBCPZjVgNdCg==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C9E69A3B83;
        Thu, 27 Jan 2022 10:28:48 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 76223A05E6; Thu, 27 Jan 2022 11:28:48 +0100 (CET)
Date:   Thu, 27 Jan 2022 11:28:48 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 5/8] loop: only take lo_mutex for the first reference in
 lo_open
Message-ID: <20220127102848.eyzf5wwbssbvgkim@quack3.lan>
References: <20220126155040.1190842-1-hch@lst.de>
 <20220126155040.1190842-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126155040.1190842-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 26-01-22 16:50:37, Christoph Hellwig wrote:
> lo_refcnt is only incremented in lo_open and decremented in lo_release,
> and thus protected by open_mutex.  Only take lo_mutex when lo_open is
> called the first time, as only for the first open there is any affect
> on the driver state (incremental opens on partitions don't end up in
> lo_open at all already).
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/loop.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 43980ec69dfdd..4b0058a67c48e 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1725,13 +1725,16 @@ static int lo_open(struct block_device *bdev, fmode_t mode)
>  	struct loop_device *lo = bdev->bd_disk->private_data;
>  	int err;
>  
> +	if (atomic_inc_return(&lo->lo_refcnt) > 1)
> +		return 0;
> +
>  	err = mutex_lock_killable(&lo->lo_mutex);
>  	if (err)
>  		return err;
> -	if (lo->lo_state == Lo_deleting)
> +	if (lo->lo_state == Lo_deleting) {
> +		atomic_dec(&lo->lo_refcnt);
>  		err = -ENXIO;
> -	else
> -		atomic_inc(&lo->lo_refcnt);
> +	}
>  	mutex_unlock(&lo->lo_mutex);
>  	return err;

So this also relies on disk->open_mutex for correctness. Otherwise a race
like:

Thread1			Thread2
lo_open()
  if (atomic_inc_return(&lo->lo_refcnt) > 1)
  mutex_lock_killable(&lo->lo_mutex);
			lo_open()
			if (atomic_inc_return(&lo->lo_refcnt) > 1)
			  return 0;
  ..

can result in Thread2 using the loop device before Thread1 actually did the
"first open" checks. So perhaps one common comment for lo_open + lo_release
explaining the locking?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
