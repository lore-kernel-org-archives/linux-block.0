Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9220C4338F
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 06:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8851060F35
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 06:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbhHDGIN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Aug 2021 02:08:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229849AbhHDGIN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Aug 2021 02:08:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5EC060F25;
        Wed,  4 Aug 2021 06:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628057281;
        bh=DFlcx0vr+d1wmaDjeHL88TCqUtMejth+sQBELLiYgeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HqPN/dDfQSAyfAQS0LHbYpHvJi7niPZI3kLnRwSeNcLsp4wzwVHuxzXWqbU8JyM9b
         Gtxe4sGJ/RC/KEo/R30k5mWmw0S579jYgBOXqKl1kiX3vPJRuPh/GJ+drHM0UVrnz6
         Tk+ad5mjWqCMEAM1I9EHMcJA3BksHqLu+1EZ60x0=
Date:   Wed, 4 Aug 2021 08:07:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v2 3/3] loop: Add the default_queue_depth kernel module
 parameter
Message-ID: <YQouvmh3rTDz2WIE@kroah.com>
References: <20210803182304.365053-1-bvanassche@acm.org>
 <20210803182304.365053-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803182304.365053-4-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 03, 2021 at 11:23:04AM -0700, Bart Van Assche wrote:
> Recent versions of Android use the zram driver on top of the loop driver.
> There is a mismatch between the default loop driver queue depth (128) and
> the queue depth of the storage device in my test setup (32). That mismatch
> results in write latencies that are higher than necessary. Address this
> issue by making the default loop driver queue depth configurable. Compared
> to configuring the queue depth by writing into the nr_requests sysfs
> attribute, this approach does not involve calling synchronize_rcu() to
> modify the queue depth.
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Martijn Coenen <maco@android.com>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/block/loop.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index fa1c298a8cfb..b5dbf2d7447e 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -2098,6 +2098,9 @@ module_param(max_loop, int, 0444);
>  MODULE_PARM_DESC(max_loop, "Maximum number of loop devices");
>  module_param(max_part, int, 0444);
>  MODULE_PARM_DESC(max_part, "Maximum number of partitions per loop device");
> +static uint32_t default_queue_depth = 128;
> +module_param(default_queue_depth, uint, 0644);
> +MODULE_PARM_DESC(default_queue_depth, "Default loop device queue depth");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS_BLOCKDEV_MAJOR(LOOP_MAJOR);

Please no, this is not the 1990's, we do not need module-wide options
like this that are hard to ever remove.  Worst case, this should be a
per-device option so it needs to be controllable that way.

But really, why can this not just be "tuned" on the fly?  How would
anyone know what to set this value to?  Should we just bump it up anyway
given that modern memory limits are probably more now?

thanks,

greg k-h
