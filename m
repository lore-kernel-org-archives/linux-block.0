Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA030C54EE9
	for <linux-block@archiver.kernel.org>; Fri, 23 Sep 2022 03:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiIWDHk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 23:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiIWDHg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 23:07:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5308DD6938
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 20:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663902454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fr8czVG2wYfHW+RouA6XThWwGeq19frCetNsMgGGqEc=;
        b=WO5HPwr75Xj7eIO14RVKzXI/1iIN94ufvH/juGVCQZdMujPJTFOEI4c54N3oK3lZlA8Cun
        Bh0OEfGPW8/YE1DiGZLd1qfLJI12uYAc6+Us3pRJRHeAaq0r9/q+eR7mk32ZnoXDpOSxvz
        7FvEY/MxtpnK6wdoqkdfA4XkM5ijBrQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-2Aeoedo-O0SwnLWV31gvAw-1; Thu, 22 Sep 2022 23:07:31 -0400
X-MC-Unique: 2Aeoedo-O0SwnLWV31gvAw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB5443810D2A;
        Fri, 23 Sep 2022 03:07:30 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EFE321121314;
        Fri, 23 Sep 2022 03:07:26 +0000 (UTC)
Date:   Fri, 23 Sep 2022 11:07:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH V5 3/7] ublk_drv: requeue rqs with recovery feature
 enabled
Message-ID: <Yy0i6V/Qr1Wgw0Hu@T590>
References: <20220922061734.21625-1-ZiyangZhang@linux.alibaba.com>
 <20220922061734.21625-4-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922061734.21625-4-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 22, 2022 at 02:17:30PM +0800, ZiyangZhang wrote:
> With recovery feature enabled, in ublk_queue_rq or task work
> (in exit_task_work or fallback wq), we requeue rqs instead of
> ending(aborting) them. Besides, No matter recovery feature is enabled
> or disabled, we schedule monitor_work immediately.
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> ---
>  drivers/block/ublk_drv.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 05bfbaa49696..a1cbcc5e9285 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -655,6 +655,16 @@ static void ubq_complete_io_cmd(struct ublk_io *io, int res)
>  
>  #define UBLK_REQUEUE_DELAY_MS	3
>  
> +static inline void __ublk_abort_rq_in_task_work(struct ublk_queue *ubq,
> +		struct request *rq)
> +{
> +	/* We cannot process this rq so just requeue it. */
> +	if (ublk_queue_can_use_recovery(ubq))
> +		blk_mq_requeue_request(rq, false);
> +	else
> +		blk_mq_end_request(rq, BLK_STS_IOERR);
> +}

__ublk_abort_rq_in_task_work() can be renamed as __ublk_abort_rq(), then
be reused for the user of ublk_queue_rq(). 

> +
>  static inline void __ublk_rq_task_work(struct request *req)
>  {
>  	struct ublk_queue *ubq = req->mq_hctx->driver_data;
> @@ -677,7 +687,7 @@ static inline void __ublk_rq_task_work(struct request *req)
>  	 * (2) current->flags & PF_EXITING.
>  	 */
>  	if (unlikely(current != ubq->ubq_daemon || current->flags & PF_EXITING)) {
> -		blk_mq_end_request(req, BLK_STS_IOERR);
> +		__ublk_abort_rq_in_task_work(ubq, req);
>  		mod_delayed_work(system_wq, &ub->monitor_work, 0);
>  		return;
>  	}
> @@ -752,6 +762,17 @@ static void ublk_rq_task_work_fn(struct callback_head *work)
>  	__ublk_rq_task_work(req);
>  }
>  
> +static inline blk_status_t __ublk_abort_rq(struct ublk_queue *ubq,
> +		struct request *rq)
> +{
> +	/* We cannot process this rq so just requeue it. */
> +	if (ublk_queue_can_use_recovery(ubq)) {
> +		blk_mq_requeue_request(rq, false);
> +		return BLK_STS_OK;
> +	}
> +	return BLK_STS_IOERR;
> +}

The above helper isn't needed.

> +
>  static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
>  		const struct blk_mq_queue_data *bd)
>  {
> @@ -769,7 +790,7 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	if (unlikely(ubq_daemon_is_dying(ubq))) {
>   fail:
>  		mod_delayed_work(system_wq, &ubq->dev->monitor_work, 0);
> -		return BLK_STS_IOERR;
> +		return __ublk_abort_rq(ubq, rq);

Then you can call __ublk_abort_rq(), and return BLK_STS_OK.


thanks.
Ming

