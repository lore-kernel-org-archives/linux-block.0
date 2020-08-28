Return-Path: <SRS0=Mrne=CG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED58CC433E2
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 07:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB19020DD4
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 07:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRqMDleA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgH1HsT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:48:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43351 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728094AbgH1HsR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Aug 2020 03:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598600895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R1PMnHtImmvXAZiOtq3DLz2D9wh4Y/dbknKxUEMgm8s=;
        b=KRqMDleAfm5yhA87b9IfP8wCfkCDcekSw1guj4stIeQjiQGN1N+OoOmddYMFfhvldOrAQ4
        WhM9QBsV0LSMmETGLSyO74SyecO4h9H1JkZrLlS5X1O4gJLxuMzNDlEsSYpuHF4guqoX7c
        MNM5rtTma0Plx73s31gZi0sH55xlVpQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-P4RIeJ64O_22SghSmhqcEw-1; Fri, 28 Aug 2020 03:48:11 -0400
X-MC-Unique: P4RIeJ64O_22SghSmhqcEw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A080B1074653;
        Fri, 28 Aug 2020 07:48:10 +0000 (UTC)
Received: from T590 (ovpn-13-119.pek2.redhat.com [10.72.13.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E1090747BD;
        Fri, 28 Aug 2020 07:48:05 +0000 (UTC)
Date:   Fri, 28 Aug 2020 15:48:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH RFC] block: defer task/vm accounting until successful
Message-ID: <20200828074801.GA224560@T590>
References: <bcee7873-198d-1e4a-27b6-8209f6154787@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcee7873-198d-1e4a-27b6-8209f6154787@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 27, 2020 at 08:41:30PM -0600, Jens Axboe wrote:
> We currently increment the task/vm counts when we first attempt to queue a
> bio. But this isn't necessarily correct - if the request allocation fails
> with -EAGAIN, for example, and the caller retries, then we'll over-account
> by as many retries as are done.
> 
> This can happen for polled IO, where we cannot wait for requests. Hence
> retries can get aggressive, if we're running out of requests. If this
> happens, then watching the IO rates in vmstat are incorrect as they count
> every issue attempt as successful and hence the stats are inflated by
> quite a lot potentially.
> 
> Abstract out the accounting function, and move the blk-mq accounting into
> blk_mq_make_request() when we know we got a request. For the non-mq path,
> just do it when the bio is queued.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d9d632639bd1..aabd016faf79 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -28,7 +28,6 @@
>  #include <linux/slab.h>
>  #include <linux/swap.h>
>  #include <linux/writeback.h>
> -#include <linux/task_io_accounting_ops.h>
>  #include <linux/fault-inject.h>
>  #include <linux/list_sort.h>
>  #include <linux/delay.h>
> @@ -1113,6 +1112,8 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
>  	struct bio_list bio_list_on_stack[2];
>  	blk_qc_t ret = BLK_QC_T_NONE;
>  
> +	blk_account_bio(bio);
> +
>  	BUG_ON(bio->bi_next);
>  
>  	bio_list_init(&bio_list_on_stack[0]);
> @@ -1232,35 +1233,6 @@ blk_qc_t submit_bio(struct bio *bio)
>  	if (blkcg_punt_bio_submit(bio))
>  		return BLK_QC_T_NONE;
>  
> -	/*
> -	 * If it's a regular read/write or a barrier with data attached,
> -	 * go through the normal accounting stuff before submission.
> -	 */
> -	if (bio_has_data(bio)) {
> -		unsigned int count;
> -
> -		if (unlikely(bio_op(bio) == REQ_OP_WRITE_SAME))
> -			count = queue_logical_block_size(bio->bi_disk->queue) >> 9;
> -		else
> -			count = bio_sectors(bio);
> -
> -		if (op_is_write(bio_op(bio))) {
> -			count_vm_events(PGPGOUT, count);
> -		} else {
> -			task_io_account_read(bio->bi_iter.bi_size);
> -			count_vm_events(PGPGIN, count);
> -		}
> -
> -		if (unlikely(block_dump)) {
> -			char b[BDEVNAME_SIZE];
> -			printk(KERN_DEBUG "%s(%d): %s block %Lu on %s (%u sectors)\n",
> -			current->comm, task_pid_nr(current),
> -				op_is_write(bio_op(bio)) ? "WRITE" : "READ",
> -				(unsigned long long)bio->bi_iter.bi_sector,
> -				bio_devname(bio, b), count);
> -		}
> -	}
> -
>  	/*
>  	 * If we're reading data that is part of the userspace workingset, count
>  	 * submission time as memory stall.  When the device is congested, or
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 0015a1892153..b77c66dfc19c 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -27,6 +27,7 @@
>  #include <linux/crash_dump.h>
>  #include <linux/prefetch.h>
>  #include <linux/blk-crypto.h>
> +#include <linux/task_io_accounting_ops.h>
>  
>  #include <trace/events/block.h>
>  
> @@ -2111,6 +2112,39 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
>  	}
>  }
>  
> +void blk_account_bio(struct bio *bio)
> +{
> +	unsigned int count;
> +
> +	/*
> +	 * If it's a regular read/write or a barrier with data attached,
> +	 * go through the normal accounting stuff before submission.
> +	 */
> +	if (unlikely(!bio_has_data(bio)))
> +		return;
> +
> +	if (unlikely(bio_op(bio) == REQ_OP_WRITE_SAME))
> +		count = queue_logical_block_size(bio->bi_disk->queue) >> 9;
> +	else
> +		count = bio_sectors(bio);
> +
> +	if (op_is_write(bio_op(bio))) {
> +		count_vm_events(PGPGOUT, count);
> +	} else {
> +		task_io_account_read(bio->bi_iter.bi_size);
> +		count_vm_events(PGPGIN, count);
> +	}
> +
> +	if (unlikely(block_dump)) {
> +		char b[BDEVNAME_SIZE];
> +		printk(KERN_DEBUG "%s(%d): %s block %Lu on %s (%u sectors)\n",
> +		current->comm, task_pid_nr(current),
> +			op_is_write(bio_op(bio)) ? "WRITE" : "READ",
> +			(unsigned long long)bio->bi_iter.bi_sector,
> +			bio_devname(bio, b), count);
> +	}
> +}
> +
>  /**
>   * blk_mq_submit_bio - Create and send a request to block device.
>   * @bio: Bio pointer.
> @@ -2165,6 +2199,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
>  		goto queue_exit;
>  	}
>  
> +	blk_account_bio(bio);

bio merged to plug list or sched will not be accounted in this way.


Thanks,
Ming

