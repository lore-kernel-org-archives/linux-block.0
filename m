Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FE5C47082
	for <linux-block@archiver.kernel.org>; Sat,  5 Jun 2021 15:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A3F3613AD
	for <linux-block@archiver.kernel.org>; Sat,  5 Jun 2021 15:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFEPB4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Jun 2021 11:01:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50221 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFEPB4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Jun 2021 11:01:56 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lpXmQ-000776-Ic; Sat, 05 Jun 2021 15:00:06 +0000
Subject: Re: [PATCH] block: loop: fix deadlock between open and remove
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     ming.lei@redhat.com, pasha.tatashin@soleen.com,
        linux-block@vger.kernel.org
References: <20210605140950.5800-1-hch@lst.de>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <9ae5d627-9ea0-8428-9467-c2a6eee7b917@canonical.com>
Date:   Sat, 5 Jun 2021 16:00:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210605140950.5800-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05/06/2021 15:09, Christoph Hellwig wrote:
> Commit c76f48eb5c08 ("block: take bd_mutex around delete_partitions in
> del_gendisk") adds disk->part0->bd_mutex in del_gendisk(), this way
> causes the following AB/BA deadlock between removing loop and opening
> loop:
> 
>  1) loop_control_ioctl(LOOP_CTL_REMOVE)
>      -> mutex_lock(&loop_ctl_mutex)
>      -> del_gendisk
>          -> mutex_lock(&disk->part0->bd_mutex)
> 
>  2) blkdev_get_by_dev
>      -> mutex_lock(&disk->part0->bd_mutex)
>      -> lo_open
>          -> mutex_lock(&loop_ctl_mutex)
> 
> Add a new Lo_deleting state to remove the need for clearing
> ->private_data and thus holding loop_ctl_mutex in the ioctl
> LOOP_CTL_REMOVE path.
> 
> Based on an analysis and earlier patch from
> Ming Lei <ming.lei@redhat.com>.
> 
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Fixes: c76f48eb5c08 ("block: take bd_mutex around delete_partitions in del_gendisk")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/loop.c | 25 +++++++------------------
>  drivers/block/loop.h |  1 +
>  2 files changed, 8 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index d58d68f3c7cd..76e12f3482a9 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1879,29 +1879,18 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
>  
>  static int lo_open(struct block_device *bdev, fmode_t mode)
>  {
> -	struct loop_device *lo;
> +	struct loop_device *lo = bdev->bd_disk->private_data;
>  	int err;
>  
> -	/*
> -	 * take loop_ctl_mutex to protect lo pointer from race with
> -	 * loop_control_ioctl(LOOP_CTL_REMOVE), however, to reduce contention
> -	 * release it prior to updating lo->lo_refcnt.
> -	 */
> -	err = mutex_lock_killable(&loop_ctl_mutex);
> -	if (err)
> -		return err;
> -	lo = bdev->bd_disk->private_data;
> -	if (!lo) {
> -		mutex_unlock(&loop_ctl_mutex);
> -		return -ENXIO;
> -	}
>  	err = mutex_lock_killable(&lo->lo_mutex);
> -	mutex_unlock(&loop_ctl_mutex);
>  	if (err)
>  		return err;
> -	atomic_inc(&lo->lo_refcnt);
> +	if (lo->lo_state == Lo_deleting)
> +		err = -ENXIO;
> +	else
> +		atomic_inc(&lo->lo_refcnt);
>  	mutex_unlock(&lo->lo_mutex);
> -	return 0;
> +	return err;
>  }
>  
>  static void lo_release(struct gendisk *disk, fmode_t mode)
> @@ -2285,7 +2274,7 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
>  			mutex_unlock(&lo->lo_mutex);
>  			break;
>  		}
> -		lo->lo_disk->private_data = NULL;
> +		lo->lo_state = Lo_deleting;
>  		mutex_unlock(&lo->lo_mutex);
>  		idr_remove(&loop_index_idr, lo->lo_number);
>  		loop_remove(lo);
> diff --git a/drivers/block/loop.h b/drivers/block/loop.h
> index a3c04f310672..5beb959b94d3 100644
> --- a/drivers/block/loop.h
> +++ b/drivers/block/loop.h
> @@ -22,6 +22,7 @@ enum {
>  	Lo_unbound,
>  	Lo_bound,
>  	Lo_rundown,
> +	Lo_deleting,
>  };
>  
>  struct loop_func_table;
> 

Tested and no longer hangs with the stress-ng loop test. Thank you for
the speedy turnaround on the fix.

Tested-by: Colin Ian King <colin.king@canonical.com>

Colin
