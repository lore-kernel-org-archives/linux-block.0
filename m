Return-Path: <SRS0=U0+/=T3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF05C04AB3
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 12:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0465B20673
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 12:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfE0MZM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 May 2019 08:25:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:47954 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726206AbfE0MZM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 May 2019 08:25:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42DA3AD05;
        Mon, 27 May 2019 12:25:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C2E3D1E3C2F; Mon, 27 May 2019 14:25:10 +0200 (CEST)
Date:   Mon, 27 May 2019 14:25:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, hare@suse.de, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] block: Don't revalidate bdev of hidden gendisk
Message-ID: <20190527122510.GA9998@quack2.suse.cz>
References: <20190515065740.12397-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515065740.12397-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 15-05-19 08:57:40, Jan Kara wrote:
> When hidden gendisk is revalidated, there's no point in revalidating
> associated block device as there's none. We would thus just create new
> bdev inode, report "detected capacity change from 0 to XXX" message and
> evict the bdev inode again. Avoid this pointless dance and confusing
> message in the kernel log.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Jens, ping?

								Honza

> ---
>  fs/block_dev.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 0f7552a87d54..9e671bbf7362 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1405,20 +1405,27 @@ void check_disk_size_change(struct gendisk *disk, struct block_device *bdev,
>   */
>  int revalidate_disk(struct gendisk *disk)
>  {
> -	struct block_device *bdev;
>  	int ret = 0;
>  
>  	if (disk->fops->revalidate_disk)
>  		ret = disk->fops->revalidate_disk(disk);
> -	bdev = bdget_disk(disk, 0);
> -	if (!bdev)
> -		return ret;
>  
> -	mutex_lock(&bdev->bd_mutex);
> -	check_disk_size_change(disk, bdev, ret == 0);
> -	bdev->bd_invalidated = 0;
> -	mutex_unlock(&bdev->bd_mutex);
> -	bdput(bdev);
> +	/*
> +	 * Hidden disks don't have associated bdev so there's no point in
> +	 * revalidating it.
> +	 */
> +	if (!(disk->flags & GENHD_FL_HIDDEN)) {
> +		struct block_device *bdev = bdget_disk(disk, 0);
> +
> +		if (!bdev)
> +			return ret;
> +
> +		mutex_lock(&bdev->bd_mutex);
> +		check_disk_size_change(disk, bdev, ret == 0);
> +		bdev->bd_invalidated = 0;
> +		mutex_unlock(&bdev->bd_mutex);
> +		bdput(bdev);
> +	}
>  	return ret;
>  }
>  EXPORT_SYMBOL(revalidate_disk);
> -- 
> 2.16.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
