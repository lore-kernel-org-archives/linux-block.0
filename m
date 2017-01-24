Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33312 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750801AbdAXKBp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 05:01:45 -0500
Received: by mail-wm0-f66.google.com with SMTP id r144so33432246wme.0
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2017 02:01:44 -0800 (PST)
Subject: Re: BUG: KASAN: Use-after-free
To: Christoph Hellwig <hch@infradead.org>
References: <0b458b92-62ee-bffc-8f3e-fbd6490b26fd@bjorling.me>
 <20170123172021.GA28446@infradead.org>
 <400b4572-0994-8950-582b-c3372333f6c8@bjorling.me>
 <20170124095209.GA22003@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>
Message-ID: <60a5b26d-8819-4e8c-ecfa-b16659b0aa44@bjorling.me>
Date: Tue, 24 Jan 2017 11:01:42 +0100
MIME-Version: 1.0
In-Reply-To: <20170124095209.GA22003@infradead.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/24/2017 10:52 AM, Christoph Hellwig wrote:
> On Tue, Jan 24, 2017 at 10:32:11AM +0100, Matias Bj�rling wrote:
>> *(gdb) list *blkdev_direct_IO+0x50c
>> 0xffffffff8142ab8c is in blkdev_direct_IO (fs/block_dev.c:401).
>> 396			submit_bio(bio);
>> 397			bio = bio_alloc(GFP_KERNEL, nr_pages);
>> 398		}
>> 399		blk_finish_plug(&plug);
>> 400	
>> 401		if (!dio->is_sync)
>> 402			return -EIOCBQUEUED;
>>
>> It looks like the qc = submit_bio() completes the I/O before the
>> blkdev_direct_IO completes, which then leads to the use after free case,
>> when the private dio struct is accessed.
> 
> Ok, the is_sync check here is clearly a bug, we need a local variable
> for is_sync as well for the aio case:
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 5db5d13..3c47614 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -331,7 +331,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>  	struct blk_plug plug;
>  	struct blkdev_dio *dio;
>  	struct bio *bio;
> -	bool is_read = (iov_iter_rw(iter) == READ);
> +	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
>  	loff_t pos = iocb->ki_pos;
>  	blk_qc_t qc = BLK_QC_T_NONE;
>  	int ret;
> @@ -344,7 +344,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>  	bio_get(bio); /* extra ref for the completion handler */
>  
>  	dio = container_of(bio, struct blkdev_dio, bio);
> -	dio->is_sync = is_sync_kiocb(iocb);
> +	dio->is_sync = is_sync = is_sync_kiocb(iocb);
>  	if (dio->is_sync)
>  		dio->waiter = current;
>  	else
> @@ -398,7 +398,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>  	}
>  	blk_finish_plug(&plug);
>  
> -	if (!dio->is_sync)
> +	if (!is_sync)
>  		return -EIOCBQUEUED;
>  
>  	for (;;) {
> 

Yup. That fixes it. Should I put together the patch, or will you take
care of it?
