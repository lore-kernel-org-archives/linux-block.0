Return-Path: <SRS0=D5/G=64=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F76C433DF
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 01:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92622205ED
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 01:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aHnh+JY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgENBLP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 21:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725943AbgENBLP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 21:11:15 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E511C061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 18:11:15 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a5so11835625pjh.2
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 18:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qZxhnV5raUlszEo34TdlJZf63NBbWmvu5JhbOc8FDvM=;
        b=aHnh+JY/PdUOs1lwK7pA0bbrp3xicd2VNEFt+Arcq6w6MBt5MPCQ/LCC2Sz7SYnRaD
         EL9Gc1O9K4V3saU4eu4vwtuQ4WEsWwkoRXut+I9U60JNLfDJDEcvIEmNjQcC26T5S/JX
         WyxuWUskXj7bcVOt0KRrPcurF3sh30LXLxhNWszPXeATaZTy7AKZ/nm4MV9gqRWSz5+R
         gJ/RgTpVI9Mvhk/zem+TtiN+JxHDaShkZFX56BQYXseMViHT1IGQa+EE8sA5pB1Yw5kT
         Vx0PWnIdDfcwx03PuoHYx00lApA9JcQr+5fOky+4G2uAghlRkT+3aZDPLINSLBjt1PVX
         BZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qZxhnV5raUlszEo34TdlJZf63NBbWmvu5JhbOc8FDvM=;
        b=ebVeT9kL4e53gTOs/3YXJgft2pMr557ZcACxuQlLjp4RmkJ1OtcQIfmSwniU3FgM6s
         ceirD0QmlVHaz/YYsC6Tvj2LGym6UNLo+sFaaxOEPP0ATtJ7yXi2oul9QoIP5t8XzFX7
         cnkRjOXtMOax9YGINfDeDRopgWIQWx/jc2bIUiIuKKeUMDHLgmGu1q5oT0N5XYFUaUgi
         y+jSspz5rYzw5RB5xMGIgLfH4+8PI5/kGPTYdzrL9jl9Le4RhF9hWmgASTshUqn7/4SP
         CUQ/1BQQfJ3e6ShvI4GrjNwz5k+bIXpdjTk37PDrQvYCB+0pSGWqgXIluSR6UqF89BMp
         pUSA==
X-Gm-Message-State: AGi0Pub+JsuyAlAM4eUfjlTpfm1lm9/wuXGWaD0Z2vQH1PJL6edZPYRb
        v/FVZcGY3jB8G9LYCGl2cUeVMGw49rlOzQ==
X-Google-Smtp-Source: APiQypJNEaK91dlJxXJLjbVqrQ1LTHZfkKuOh627v+ZuiyVzOM/HzZQQtLqu+e/SWih96CSIj7mn0w==
X-Received: by 2002:a17:90a:fd16:: with SMTP id cv22mr34455003pjb.169.1589418674344;
        Wed, 13 May 2020 18:11:14 -0700 (PDT)
Received: from google.com (240.242.82.34.bc.googleusercontent.com. [34.82.242.240])
        by smtp.gmail.com with ESMTPSA id v3sm659366pfv.186.2020.05.13.18.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 18:11:13 -0700 (PDT)
Date:   Thu, 14 May 2020 01:11:10 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Salman Qazi <sqazi@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V2] block: add blk_io_schedule() for avoiding task hung
 in sync dio
Message-ID: <20200514011110.GA79384@google.com>
References: <20200503015422.1123994-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200503015422.1123994-1-ming.lei@redhat.com>
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
This won't compile without CONFIG_BLOCK, since this patch includes
linux/sched/sysctl.h only inside the #ifdef CONFIG_BLOCK, while blk_io_schedule
is declared outside the #ifdef CONFIG_BLOCK, but references
sysctl_hung_task_timeout_secs defined in linux/sched/sysctl.h. Afaict, the
function isn't needed without CONFIG_BLOCK, so maybe we should move the
function into the #ifdef CONFIG_BLOCK too?

> -- 
> 2.25.2
> 
