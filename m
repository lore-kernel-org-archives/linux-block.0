Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:37014 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbdIRT6Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Sep 2017 15:58:25 -0400
Received: by mail-qk0-f193.google.com with SMTP id r66so1003466qke.4
        for <linux-block@vger.kernel.org>; Mon, 18 Sep 2017 12:58:25 -0700 (PDT)
Date: Mon, 18 Sep 2017 15:58:23 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Dan Melnic <dmm@fb.com>
Cc: josef@toxicpanda.com, axboe@fb.com, linux-block@vger.kernel.org,
        Kernel-team@fb.com
Subject: Re: [PATCH V2] block/ndb: add WQ_UNBOUND to the knbd-recv workqueue
Message-ID: <20170918195822.olbpxndtsgfetgmr@destiny>
References: <20170918195617.2411456-1-dmm@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170918195617.2411456-1-dmm@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Sep 18, 2017 at 12:56:17PM -0700, Dan Melnic wrote:
> Add WQ_UNBOUND to the knbd-recv workqueue so we're not bound
> to a single CPU that is selected at device creation time.
> 
> Signed-off-by: Dan Melnic <dmm@fb.com>
> ---
>  drivers/block/nbd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 2aa87cb..ac3c5ecc 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -2080,7 +2080,9 @@ static int __init nbd_init(void)
>  	if (nbds_max > 1UL << (MINORBITS - part_shift))
>  		return -EINVAL;
>  	recv_workqueue = alloc_workqueue("knbd-recv",
> -					 WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
> +					 WQ_MEM_RECLAIM | WQ_HIGHPRI |
> +					 WQ_UNBOUND,
> +					 0);

This can go on the line above.  You can add

Reviewed-by: Josef Bacik <jbacik@fb.com>

once you've made that adjustment.  Thanks,

Josef
