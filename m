Return-Path: <SRS0=GKfo=62=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10D5C47255
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 02:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A332071A
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 02:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="St9kOhhR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgELCW2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 May 2020 22:22:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29359 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727942AbgELCW1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 May 2020 22:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589250145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lMnpwRjbHlyV5NI7jXDKNNUrcWMTqmfGX8/dyF5bT7Y=;
        b=St9kOhhRC06AOleJwgBdBqrhLEiA6Q0wlJWLHdMC4QYZL+ZBHkR+QoKk6YzvoTwep/MVRB
        GTS+tYAub/N1zpal+WW9tPGl+CL+ENC5fcxvU4otSCOriD7plXp7CLCI1Stn21UZG4xjci
        wQrnYkHTVOs9EhoVPM/XTQNYK3apBYA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-hG78JmEsOrC2ESIApRJWLA-1; Mon, 11 May 2020 22:22:22 -0400
X-MC-Unique: hG78JmEsOrC2ESIApRJWLA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD71D80183C;
        Tue, 12 May 2020 02:22:20 +0000 (UTC)
Received: from T590 (ovpn-13-57.pek2.redhat.com [10.72.13.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DD36F781E9;
        Tue, 12 May 2020 02:22:14 +0000 (UTC)
Date:   Tue, 12 May 2020 10:22:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Salman Qazi <sqazi@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V2] block: add blk_io_schedule() for avoiding task hung
 in sync dio
Message-ID: <20200512022210.GD1531898@T590>
References: <20200503015422.1123994-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200503015422.1123994-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, May 03, 2020 at 09:54:22AM +0800, Ming Lei wrote:
> Sync dio could be big, or may take long time in discard or in case of
> IO failure.
> 
> We have prevented task hung in submit_bio_wait() and blk_execute_rq(),
> so apply the same trick for prevent task hung from happening in sync dio.
> 
> Add helper of blk_io_schedule() and use io_schedule_timeout() to prevent
> task hung warning.
> 
> Cc: Salman Qazi <sqazi@google.com>
> Cc: Jesse Barnes <jsbarnes@google.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- drop helper of blk_default_io_timeout()
> 
> 
>  fs/block_dev.c         |  4 ++--
>  fs/direct-io.c         |  2 +-
>  fs/iomap/direct-io.c   |  2 +-
>  include/linux/blkdev.h | 12 ++++++++++++
>  4 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 5eb30a474f6d..3b396f8c967c 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -256,7 +256,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
>  			break;
>  		if (!(iocb->ki_flags & IOCB_HIPRI) ||
>  		    !blk_poll(bdev_get_queue(bdev), qc, true))
> -			io_schedule();
> +			blk_io_schedule();
>  	}
>  	__set_current_state(TASK_RUNNING);
>  
> @@ -450,7 +450,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>  
>  		if (!(iocb->ki_flags & IOCB_HIPRI) ||
>  		    !blk_poll(bdev_get_queue(bdev), qc, true))
> -			io_schedule();
> +			blk_io_schedule();
>  	}
>  	__set_current_state(TASK_RUNNING);
>  
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 00b4d15bb811..6d5370eac2a8 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -500,7 +500,7 @@ static struct bio *dio_await_one(struct dio *dio)
>  		spin_unlock_irqrestore(&dio->bio_lock, flags);
>  		if (!(dio->iocb->ki_flags & IOCB_HIPRI) ||
>  		    !blk_poll(dio->bio_disk->queue, dio->bio_cookie, true))
> -			io_schedule();
> +			blk_io_schedule();
>  		/* wake up sets us TASK_RUNNING */
>  		spin_lock_irqsave(&dio->bio_lock, flags);
>  		dio->waiter = NULL;
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 20dde5aadcdd..fd3bd06fabb6 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -561,7 +561,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  			    !dio->submit.last_queue ||
>  			    !blk_poll(dio->submit.last_queue,
>  					 dio->submit.cookie, true))
> -				io_schedule();
> +				blk_io_schedule();
>  		}
>  		__set_current_state(TASK_RUNNING);
>  	}
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index f00bd4042295..222eb5f32279 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -27,6 +27,7 @@
>  #include <linux/percpu-refcount.h>
>  #include <linux/scatterlist.h>
>  #include <linux/blkzoned.h>
> +#include <linux/sched/sysctl.h>
>  
>  struct module;
>  struct scsi_ioctl_command;
> @@ -1827,4 +1828,15 @@ static inline void blk_wake_io_task(struct task_struct *waiter)
>  		wake_up_process(waiter);
>  }
>  
> +static inline void blk_io_schedule(void)
> +{
> +	/* Prevent hang_check timer from firing at us during very long I/O */
> +	unsigned long timeout = sysctl_hung_task_timeout_secs * HZ / 2;
> +
> +	if (timeout)
> +		io_schedule_timeout(timeout);
> +	else
> +		io_schedule();
> +}
> +
>  #endif

Hi Jens and Guys,

Ping...

thanks, 
Ming

