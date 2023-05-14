Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94D9C77B7F
	for <linux-block@archiver.kernel.org>; Sun, 14 May 2023 14:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjENOXu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 May 2023 10:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjENOXt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 May 2023 10:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4F61BF6
        for <linux-block@vger.kernel.org>; Sun, 14 May 2023 07:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684074181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1IEUSmLxYOkN7/5gxP2VLJ7HTpoVibQRAdt0XoniD6I=;
        b=KvNnWzOk7sVbPuGM8Ylcju6fw6wQsxyFwt70ON//VtLNZ7nX15teN6sVM7XFfbsAOoFqT+
        fy/ML8PRLVBLVNBRKb1cmnEeuuUZclR0ok6q+uJbJrxgUlINUEJo5W3f4J18DD6jAN7ViF
        mkIsX7+7Em/zuK5JL9Ag686PZ26ieNg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-lFHrxw53MXewW08VHsCgEA-1; Sun, 14 May 2023 10:22:50 -0400
X-MC-Unique: lFHrxw53MXewW08VHsCgEA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10E2B29AA3BC;
        Sun, 14 May 2023 14:22:50 +0000 (UTC)
Received: from ovpn-8-17.pek2.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82BE4C15BA0;
        Sun, 14 May 2023 14:22:44 +0000 (UTC)
Date:   Sun, 14 May 2023 22:22:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Tian Lan <tilan7663@gmail.com>
Cc:     axboe@kernel.dk, horms@kernel.org, linux-block@vger.kernel.org,
        lkp@intel.com, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        tian.lan@twosigma.com, ming.lei@redhat.com
Subject: Re: [PATCH 1/1] blk-mq: fix blk_mq_hw_ctx active request accounting
Message-ID: <ZGDur5+koRgNh5Ih@ovpn-8-17.pek2.redhat.com>
References: <892f5292-884b-42ef-fe24-05cfac56e527@kernel.dk>
 <20230513221227.497327-1-tilan7663@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230513221227.497327-1-tilan7663@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 13, 2023 at 06:12:27PM -0400, Tian Lan wrote:
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
>  block/blk-mq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f6dad0886a2f..850bfb844ed2 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -683,6 +683,10 @@ static void __blk_mq_free_request(struct request *rq)
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
> @@ -694,15 +698,11 @@ static void __blk_mq_free_request(struct request *rq)
>  void blk_mq_free_request(struct request *rq)
>  {
>  	struct request_queue *q = rq->q;
> -	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>  
>  	if ((rq->rq_flags & RQF_ELVPRIV) &&
>  	    q->elevator->type->ops.finish_request)
>  		q->elevator->type->ops.finish_request(rq);
>  
> -	if (rq->rq_flags & RQF_MQ_INFLIGHT)
> -		__blk_mq_dec_active_requests(hctx);
> -
>  	if (unlikely(laptop_mode && !blk_rq_is_passthrough(rq)))
>  		laptop_io_completion(q->disk->bdi);

This patch looks fine, but please add words about why this way fixes the issue
with fixes tag:

- the difference between blk_mq_free_request() and blk_mq_end_request_batch(),
wrt. when to call __blk_mq_dec_active_requests(), the former does it
before calling req_ref_put_and_test(), and the later decreases active
request after req_ref_put_and_test().

- Fixes: f794f3351f26 ("block: add support for blk_mq_end_request_batch()")

Once the above is done, feel free to add:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

