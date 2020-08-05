Return-Path: <SRS0=yU/V=BP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F9DC433DF
	for <linux-block@archiver.kernel.org>; Wed,  5 Aug 2020 04:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DCAF20842
	for <linux-block@archiver.kernel.org>; Wed,  5 Aug 2020 04:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgHEEkA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Aug 2020 00:40:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:51646 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgHEEkA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Aug 2020 00:40:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73E67AC61;
        Wed,  5 Aug 2020 04:40:13 +0000 (UTC)
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>, Xiao Ni <xni@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Evan Green <evgreen@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Christoph Hellwig <hch@lst.de>
References: <20200805035059.1989050-1-ming.lei@redhat.com>
From:   Coly Li <colyli@suse.de>
Autocrypt: addr=colyli@suse.de; keydata=
 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
Subject: Re: [PATCH V2] block: loop: set discard granularity and alignment for
 block device backed loop
Message-ID: <ebb43405-a808-ac8b-58b2-6d01b8ff19d0@suse.de>
Date:   Wed, 5 Aug 2020 12:39:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200805035059.1989050-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/8/5 11:50, Ming Lei wrote:
> In case of block device backend, if the backend supports write zeros, the
> loop device will set queue flag of QUEUE_FLAG_DISCARD. However,
> limits.discard_granularity isn't setup, and this way is wrong,
> see the following description in Documentation/ABI/testing/sysfs-block:
> 
> 	A discard_granularity of 0 means that the device does not support
> 	discard functionality.
> 
> Especially 9b15d109a6b2 ("block: improve discard bio alignment in
> __blkdev_issue_discard()") starts to take q->limits.discard_granularity
> for computing max discard sectors. And zero discard granularity may cause
> kernel oops, or fail discard request even though the loop queue claims
> discard support via QUEUE_FLAG_DISCARD.
> 
> Fix the issue by setup discard granularity and alignment.
> 
> Fixes: c52abf563049 ("loop: Better discard support for block devices")
> Cc: Coly Li <colyli@suse.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Xiao Ni <xni@redhat.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- mirror backing queue's discard_granularity to loop queue
> 	- set discard limit parameters explicitly when QUEUE_FLAG_DISCARD is
> 	set
> 
>  drivers/block/loop.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index d18160146226..661c0814d63c 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -878,6 +878,7 @@ static void loop_config_discard(struct loop_device *lo)
>  	struct file *file = lo->lo_backing_file;
>  	struct inode *inode = file->f_mapping->host;
>  	struct request_queue *q = lo->lo_queue;
> +	u32 granularity, max_discard_sectors;
>  
>  	/*
>  	 * If the backing device is a block device, mirror its zeroing
> @@ -890,11 +891,10 @@ static void loop_config_discard(struct loop_device *lo)
>  		struct request_queue *backingq;
>  
>  		backingq = bdev_get_queue(inode->i_bdev);
> -		blk_queue_max_discard_sectors(q,
> -			backingq->limits.max_write_zeroes_sectors);
>  
> -		blk_queue_max_write_zeroes_sectors(q,
> -			backingq->limits.max_write_zeroes_sectors);
> +		max_discard_sectors = backingq->limits.max_write_zeroes_sectors;
> +		granularity = backingq->limits.discard_granularity ?:
> +			queue_physical_block_size(backingq);

I assume logical_block_size >= physical_block_size, maybe
queue_logical_block_size(backing) is better ?

I am not sure, just because I see nvme host driver and virtio block
driver use the logical block size, and scsi sd driver uses
max(physical_block_size, unmap_granularity * logical_block_size).


>  
>  	/*
>  	 * We use punch hole to reclaim the free space used by the
> @@ -903,23 +903,26 @@ static void loop_config_discard(struct loop_device *lo)
>  	 * useful information.
>  	 */
>  	} else if (!file->f_op->fallocate || lo->lo_encrypt_key_size) {
> -		q->limits.discard_granularity = 0;
> -		q->limits.discard_alignment = 0;
> -		blk_queue_max_discard_sectors(q, 0);
> -		blk_queue_max_write_zeroes_sectors(q, 0);
> +		max_discard_sectors = 0;
> +		granularity = 0;
>  
>  	} else {
> -		q->limits.discard_granularity = inode->i_sb->s_blocksize;
> -		q->limits.discard_alignment = 0;
> -
> -		blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
> -		blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
> +		max_discard_sectors = UINT_MAX >> 9;
> +		granularity = inode->i_sb->s_blocksize;
>  	}
>  
> -	if (q->limits.max_write_zeroes_sectors)
> +	if (max_discard_sectors) {
> +		q->limits.discard_granularity = granularity;
> +		blk_queue_max_discard_sectors(q, max_discard_sectors);
> +		blk_queue_max_write_zeroes_sectors(q, max_discard_sectors);
>  		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
> -	else
> +	} else {
> +		q->limits.discard_granularity = 0;
> +		blk_queue_max_discard_sectors(q, 0);
> +		blk_queue_max_write_zeroes_sectors(q, 0);
>  		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
> +	}
> +	q->limits.discard_alignment = 0;
>  }
>  
>  static void loop_unprepare_queue(struct loop_device *lo)
> 

Overall the patch is good to me.

Acked-by: Coly Li <colyli@suse.de>

Thanks.

Coly Li
