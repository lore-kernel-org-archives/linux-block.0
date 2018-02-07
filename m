Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44776 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753733AbeBGRjI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Feb 2018 12:39:08 -0500
Received: by mail-pf0-f194.google.com with SMTP id 17so614706pfw.11
        for <linux-block@vger.kernel.org>; Wed, 07 Feb 2018 09:39:08 -0800 (PST)
Subject: Re: [PATCH v5 07/10] bcache: fix inaccurate io state for detached
 bcache devices
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Tang Junhui <tang.junhui@zte.com.cn>
References: <20180206042100.65021-1-colyli@suse.de>
 <20180206042100.65021-8-colyli@suse.de>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <e55f7656-0f19-a997-1777-f6cd5abda3b5@lyle.org>
Date: Wed, 7 Feb 2018 09:39:05 -0800
MIME-Version: 1.0
In-Reply-To: <20180206042100.65021-8-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

detatched should be detached, otherwise lgtm.

Reviewed-by: Michael Lyle <mlyle@lyle.org>

On 02/05/2018 08:20 PM, Coly Li wrote:
> From: Tang Junhui <tang.junhui@zte.com.cn>
> 
> When we run IO in a detached device,  and run iostat to shows IO status,
> normally it will show like bellow (Omitted some fields):
> Device: ... avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
> sdd        ... 15.89     0.53    1.82    0.20    2.23   1.81  52.30
> bcache0    ... 15.89   115.42    0.00    0.00    0.00   2.40  69.60
> but after IO stopped, there are still very big avgqu-sz and %util
> values as bellow:
> Device: ... avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
> bcache0   ...      0   5326.32    0.00    0.00    0.00   0.00 100.10
> 
> The reason for this issue is that, only generic_start_io_acct() called
> and no generic_end_io_acct() called for detached device in
> cached_dev_make_request(). See the code:
> //start generic_start_io_acct()
> generic_start_io_acct(q, rw, bio_sectors(bio), &d->disk->part0);
> if (cached_dev_get(dc)) {
> 	//will callback generic_end_io_acct()
> }
> else {
> 	//will not call generic_end_io_acct()
> }
> 
> This patch calls generic_end_io_acct() in the end of IO for detached
> devices, so we can show IO state correctly.
> 
> (Modified to use GFP_NOIO in kzalloc() by Coly Li)
> 
> Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
> Reviewed-by: Coly Li <colyli@suse.de>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/md/bcache/request.c | 58 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 51 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
> index 02296bda6384..e09c5ae745be 100644
> --- a/drivers/md/bcache/request.c
> +++ b/drivers/md/bcache/request.c
> @@ -986,6 +986,55 @@ static void cached_dev_nodata(struct closure *cl)
>  	continue_at(cl, cached_dev_bio_complete, NULL);
>  }
>  
> +struct detached_dev_io_private {
> +	struct bcache_device	*d;
> +	unsigned long		start_time;
> +	bio_end_io_t		*bi_end_io;
> +	void			*bi_private;
> +};
> +
> +static void detatched_dev_end_io(struct bio *bio)
> +{
> +	struct detached_dev_io_private *ddip;
> +
> +	ddip = bio->bi_private;
> +	bio->bi_end_io = ddip->bi_end_io;
> +	bio->bi_private = ddip->bi_private;
> +
> +	generic_end_io_acct(ddip->d->disk->queue,
> +			    bio_data_dir(bio),
> +			    &ddip->d->disk->part0, ddip->start_time);
> +
> +	kfree(ddip);
> +
> +	bio->bi_end_io(bio);
> +}
> +
> +static void detached_dev_do_request(struct bcache_device *d, struct bio *bio)
> +{
> +	struct detached_dev_io_private *ddip;
> +	struct cached_dev *dc = container_of(d, struct cached_dev, disk);
> +
> +	/*
> +	 * no need to call closure_get(&dc->disk.cl),
> +	 * because upper layer had already opened bcache device,
> +	 * which would call closure_get(&dc->disk.cl)
> +	 */
> +	ddip = kzalloc(sizeof(struct detached_dev_io_private), GFP_NOIO);
> +	ddip->d = d;
> +	ddip->start_time = jiffies;
> +	ddip->bi_end_io = bio->bi_end_io;
> +	ddip->bi_private = bio->bi_private;
> +	bio->bi_end_io = detatched_dev_end_io;
> +	bio->bi_private = ddip;
> +
> +	if ((bio_op(bio) == REQ_OP_DISCARD) &&
> +	    !blk_queue_discard(bdev_get_queue(dc->bdev)))
> +		bio->bi_end_io(bio);
> +	else
> +		generic_make_request(bio);
> +}
> +
>  /* Cached devices - read & write stuff */
>  
>  static blk_qc_t cached_dev_make_request(struct request_queue *q,
> @@ -1028,13 +1077,8 @@ static blk_qc_t cached_dev_make_request(struct request_queue *q,
>  			else
>  				cached_dev_read(dc, s);
>  		}
> -	} else {
> -		if ((bio_op(bio) == REQ_OP_DISCARD) &&
> -		    !blk_queue_discard(bdev_get_queue(dc->bdev)))
> -			bio_endio(bio);
> -		else
> -			generic_make_request(bio);
> -	}
> +	} else
> +		detached_dev_do_request(d, bio);
>  
>  	return BLK_QC_T_NONE;
>  }
> 
