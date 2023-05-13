Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3BDC77B7F
	for <linux-block@archiver.kernel.org>; Sat, 13 May 2023 20:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjEMUya (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 May 2023 16:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjEMUy3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 May 2023 16:54:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EABDBD
        for <linux-block@vger.kernel.org>; Sat, 13 May 2023 13:54:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ACE760FF9
        for <linux-block@vger.kernel.org>; Sat, 13 May 2023 20:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9312EC433D2;
        Sat, 13 May 2023 20:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684011267;
        bh=2A+xL3FxnGAo3Gj7UR5JLmQYQjmcswIboDtUo9t8oII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f7BOnv817u7tiN3UdoJmVFDAS7QgvSw/rwCQChXEh/WRaGc/RkTa343EwNst2LrLL
         PWJrHuUuZTB/aN5IHD/W7y0iEL9tGHxkNqkYoPlf0SFKmAz9+WZpxYYznhpcnoW6ri
         Ts8kXiUV9F8auj2mc9NxA41901EibMTY3hvlWHrdkwKnTtZi+MPj/WRpgdOgyuXFBF
         DOBFtOKPYfTSAIvfTklrbE+too05p7te3A3mv0674/kxvyCu+TTpiFth29JLHDFoZh
         19CHSO7eKwWn70VjwIwEhv7Fz5a7BAXasTbO9+NU6PYD9lzAJQnGk2iwXEo6ujJzZj
         Wh219hKQhGdmw==
Date:   Sat, 13 May 2023 22:54:22 +0200
From:   Simon Horman <horms@kernel.org>
To:     Tian Lan <tilan7663@gmail.com>
Cc:     lkp@intel.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        tian.lan@twosigma.com
Subject: Re: [PATCH 1/1] blk-mq: fix blk_mq_hw_ctx active request accounting
Message-ID: <ZF/4/k+u3h2fXgHU@kernel.org>
References: <202305140021.WvuGBjaZ-lkp@intel.com>
 <20230513190534.331274-1-tilan7663@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230513190534.331274-1-tilan7663@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 13, 2023 at 03:05:34PM -0400, Tian Lan wrote:
> From: Tian Lan <tian.lan@twosigma.com>
> 
> The nr_active counter continues to increase over time which causes the
> blk_mq_get_tag to hang until the thread is rescheduled to a different
> core despite there are still tags available.
> 
> kernel-stack
> 
>   INFO: task inboundIOReacto:3014879 blocked for more than 2 seconds
>   Not tainted 6.1.15-amd64 #1 Debian 6.1.15~debian11
>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>   task:inboundIOReacto state:D stack:0  pid:3014879 ppid:4557 flags:0x00000000
>     Call Trace:
>     <TASK>
>     __schedule+0x351/0xa20
>     scheduler+0x5d/0xe0
>     io_schedule+0x42/0x70
>     blk_mq_get_tag+0x11a/0x2a0
>     ? dequeue_task_stop+0x70/0x70
>     __blk_mq_alloc_requests+0x191/0x2e0
> 
> kprobe output showing RQF_MQ_INFLIGHT bit is not cleared before
> __blk_mq_free_request being called.
> 
>   320    320  kworker/29:1H __blk_mq_free_request rq_flags 0x220c0 in-flight 1
>          b'__blk_mq_free_request+0x1 [kernel]'
>          b'bt_iter+0x50 [kernel]'
>          b'blk_mq_queue_tag_busy_iter+0x318 [kernel]'
>          b'blk_mq_timeout_work+0x7c [kernel]'
>          b'process_one_work+0x1c4 [kernel]'
>          b'worker_thread+0x4d [kernel]'
>          b'kthread+0xe6 [kernel]'
>          b'ret_from_fork+0x1f [kernel]'
> 
> Signed-off-by: Tian Lan <tian.lan@twosigma.com>
> ---
>  block/blk-mq.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 9c8dc70020bc..732a39d88cd6 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -716,6 +716,10 @@ static void __blk_mq_free_request(struct request *rq)
>  	blk_crypto_free_request(rq);
>  	blk_pm_mark_last_busy(rq);
>  	rq->mq_hctx = NULL;
> +
> +	if (rq->rq_flags & RQF_MQ_INFLIGHT)
> +		__blk_mq_dec_active_requests(hctx);
> +
>  	if (rq->tag != BLK_MQ_NO_TAG)
>  		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
>  	if (sched_tag != BLK_MQ_NO_TAG)
> @@ -733,9 +737,6 @@ void blk_mq_free_request(struct request *rq)
>  	    q->elevator->type->ops.finish_request)
>  		q->elevator->type->ops.finish_request(rq);
>  
> -	if (rq->rq_flags & RQF_MQ_INFLIGHT)
> -		__blk_mq_dec_active_requests(hctx);
> -

Unless I am mistaken, hctx is now unused in this function.

>  	if (unlikely(laptop_mode && !blk_rq_is_passthrough(rq)))
>  		laptop_io_completion(q->disk->bdi);
>  
