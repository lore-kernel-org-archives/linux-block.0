Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36843 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753547AbdAZUZ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 15:25:28 -0500
Received: by mail-pf0-f177.google.com with SMTP id 189so67714435pfu.3
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2017 12:25:28 -0800 (PST)
Date: Thu, 26 Jan 2017 12:25:00 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, bart.vanassche@sandisk.com,
        hch@lst.de, osandov@fb.com, paolo.valente@linaro.org, hare@suse.com
Subject: Re: [PATCH 4/5] blk-mq-sched: fix starvation for multiple hardware
 queues and shared tags
Message-ID: <20170126202500.GD21449@vader.DHCP.thefacebook.com>
References: <1485460098-16608-1-git-send-email-axboe@fb.com>
 <1485460098-16608-5-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1485460098-16608-5-git-send-email-axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jan 26, 2017 at 12:48:17PM -0700, Jens Axboe wrote:
> If we have both multiple hardware queues and shared tag map between
> devices, we need to ensure that we propagate the hardware queue
> restart bit higher up. This is because we can get into a situation
> where we don't have any IO pending on a hardware queue, yet we fail
> getting a tag to start new IO. If that happens, it's not enough to
> mark the hardware queue as needing a restart, we need to bubble
> that up to the higher level queue as well.

One minor nit below. Otherwise, makes sense.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  block/blk-mq-sched.c   | 28 ++++++++++++++++++++++++++++
>  block/blk-mq-sched.h   | 15 +++++++++------
>  block/blk-mq.c         |  3 ++-
>  block/blk-mq.h         |  1 +
>  include/linux/blkdev.h |  1 +
>  5 files changed, 41 insertions(+), 7 deletions(-)

> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 25564857f5f8..73bcd201a9b7 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -602,6 +602,7 @@ struct request_queue {
>  #define QUEUE_FLAG_FLUSH_NQ    25	/* flush not queueuable */
>  #define QUEUE_FLAG_DAX         26	/* device supports DAX */
>  #define QUEUE_FLAG_STATS       27	/* track rq completion times */
> +#define QUEUE_FLAG_RESTART     28

All of the other queue flags have a comment, could you add one here,
too?

>  #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
>  				 (1 << QUEUE_FLAG_STACKABLE)	|	\
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
