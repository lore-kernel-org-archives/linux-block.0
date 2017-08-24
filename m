Return-Path: <linux-block-owner@vger.kernel.org>
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:6068 "EHLO
        BJEXCAS001.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752653AbdHXMIa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2017 08:08:30 -0400
Date: Thu, 24 Aug 2017 20:08:11 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: remove blk_free_devt in add_partition
Message-ID: <20170824120806.GB18246@localhost.didichuxing.com>
References: <20170818155439.GA30487@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20170818155439.GA30487@localhost.didichuxing.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Aug 18, 2017 at 11:54:45PM +0800, weiping zhang wrote:
> put_device(pdev) will call pdev->type->release finally, and blk_free_devt
> has been called in part_release(), so remove it.
> 
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> ---
>  block/partition-generic.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/block/partition-generic.c b/block/partition-generic.c
> index c5ec824..04d82dd 100644
> --- a/block/partition-generic.c
> +++ b/block/partition-generic.c
> @@ -391,7 +391,6 @@ struct hd_struct *add_partition(struct gendisk *disk, int partno,
>  	device_del(pdev);
>  out_put:
>  	put_device(pdev);
> -	blk_free_devt(devt);
>  	return ERR_PTR(err);
>  }
>  
> -- 
> 2.9.4
> 

Hi Jens,

would you please look this trivial patch at your convenience?

Thanks
