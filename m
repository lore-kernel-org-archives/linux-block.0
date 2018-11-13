Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B6BC43441
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77B1214F1
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77B1214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbeKNBzF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:55:05 -0500
Received: from mga05.intel.com ([192.55.52.43]:56492 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731324AbeKNBzF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Nov 2018 20:55:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 07:56:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,499,1534834800"; 
   d="scan'208";a="90791609"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga006.jf.intel.com with ESMTP; 13 Nov 2018 07:56:23 -0800
Date:   Tue, 13 Nov 2018 08:52:55 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 06/11] block: add polled wakeup task helper
Message-ID: <20181113155255.GB9827@localhost.localdomain>
References: <20181113154233.15256-1-axboe@kernel.dk>
 <20181113154233.15256-7-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113154233.15256-7-axboe@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 13, 2018 at 08:42:28AM -0700, Jens Axboe wrote:
> If we're polling for IO on a device that doesn't use interrupts, then
> IO completion loop (and wake of task) is done by submitting task itself.
> If that is the case, then we don't need to enter the wake_up_process()
> function, we can simply mark ourselves as TASK_RUNNING.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/block_dev.c         |  6 ++----
>  fs/iomap.c             |  3 +--
>  include/linux/blkdev.h | 19 +++++++++++++++++++
>  3 files changed, 22 insertions(+), 6 deletions(-)

One more for swap read:

---
diff --git a/mm/page_io.c b/mm/page_io.c
index d4d1c89bcddd..57572ff46016 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -140,7 +140,7 @@ static void end_swap_bio_read(struct bio *bio)
 	unlock_page(page);
 	WRITE_ONCE(bio->bi_private, NULL);
 	bio_put(bio);
-	wake_up_process(waiter);
+	blk_wake_io_task(waiter);
 	put_task_struct(waiter);
 }
 
--
 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 2f920c03996e..0ed9be8906a8 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -181,8 +181,7 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
>  	struct task_struct *waiter = bio->bi_private;
>  
>  	WRITE_ONCE(bio->bi_private, NULL);
> -	smp_wmb();
> -	wake_up_process(waiter);
> +	blk_wake_io_task(waiter);
>  }
>  
>  static ssize_t
> @@ -309,8 +308,7 @@ static void blkdev_bio_end_io(struct bio *bio)
>  			struct task_struct *waiter = dio->waiter;
>  
>  			WRITE_ONCE(dio->waiter, NULL);
> -			smp_wmb();
> -			wake_up_process(waiter);
> +			blk_wake_io_task(waiter);
>  		}
>  	}
>  
> diff --git a/fs/iomap.c b/fs/iomap.c
> index 7898927e758e..a182699e28db 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -1526,8 +1526,7 @@ static void iomap_dio_bio_end_io(struct bio *bio)
>  			struct task_struct *waiter = dio->submit.waiter;
>  
>  			WRITE_ONCE(dio->submit.waiter, NULL);
> -			smp_wmb();
> -			wake_up_process(waiter);
> +			blk_wake_io_task(waiter);
>  		} else if (dio->flags & IOMAP_DIO_WRITE) {
>  			struct inode *inode = file_inode(dio->iocb->ki_filp);
>  
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index ad8474ec8c58..d1ef8cbbea04 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1798,4 +1798,23 @@ static inline int blkdev_issue_flush(struct block_device *bdev, gfp_t gfp_mask,
>  
>  #endif /* CONFIG_BLOCK */
>  
> +static inline void blk_wake_io_task(struct task_struct *waiter)
> +{
> +	/*
> +	 * If we're polling, the task itself is doing the completions. For
> +	 * that case, we don't need to signal a wakeup, it's enough to just
> +	 * mark us as RUNNING.
> +	 */
> +	if (waiter == current)
> +		__set_current_state(TASK_RUNNING);
> +	else {
> +		/*
> +		 * Ensure the callers waiter store is ordered and seen
> +		 * by the ->bi_end_io() function.
> +		 */
> +		smp_wmb();
> +		wake_up_process(waiter);
> +	}
> +}
> +
>  #endif
> -- 
> 2.17.1
> 
