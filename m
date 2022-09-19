Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAAEC54EE9
	for <linux-block@archiver.kernel.org>; Mon, 19 Sep 2022 03:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiISD4H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Sep 2022 23:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiISD4G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Sep 2022 23:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9577183A9
        for <linux-block@vger.kernel.org>; Sun, 18 Sep 2022 20:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663559760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HG8HMEb/cIOfLhOlbf6Pwfu6E0VxjMhXeVXcIWhs/kI=;
        b=dc4B4NU+P/nvfbNMSpCxm5l8ut2sZ4RCkGuV4gFObhLO9bcihQmcmgvBCXkZLRATnv4a6n
        dyRcbtMnxTPHUte1GryS4JDXitaObIjvqe4LpZ3YumcmQLJKa5mn2hYoY8dnsOUAX3OHZL
        e0GFKNIMwpJjmvEvNmcv2E+OGVvW0Dg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-LuEc13XHNUK5sbGAqxxa6w-1; Sun, 18 Sep 2022 23:55:57 -0400
X-MC-Unique: LuEc13XHNUK5sbGAqxxa6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04A0D82A68B;
        Mon, 19 Sep 2022 03:55:57 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 757772166B26;
        Mon, 19 Sep 2022 03:55:51 +0000 (UTC)
Date:   Mon, 19 Sep 2022 11:55:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, ming.lei@redhat.com
Subject: Re: [PATCH V3 4/7] ublk_drv: requeue rqs with recovery feature
 enabled
Message-ID: <YyfoQuw18kOynxcC@T590>
References: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
 <20220913041707.197334-5-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913041707.197334-5-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 13, 2022 at 12:17:04PM +0800, ZiyangZhang wrote:
> With recovery feature enabled, in ublk_queue_rq or task work
> (in exit_task_work or fallback wq), we requeue rqs instead of
> ending(aborting) them. Besides, No matter recovery feature is enabled
> or disabled, we schedule monitor_work immediately.
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> ---
>  drivers/block/ublk_drv.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 23337bd7c105..b067f33a1913 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -682,6 +682,21 @@ static void ubq_complete_io_cmd(struct ublk_io *io, int res)
>  
>  #define UBLK_REQUEUE_DELAY_MS	3
>  
> +static inline void __ublk_abort_rq_in_task_work(struct ublk_queue *ubq,
> +		struct request *rq)
> +{
> +	pr_devel("%s: %s q_id %d tag %d io_flags %x.\n", __func__,
> +			(ublk_queue_can_use_recovery(ubq)) ? "requeue" : "abort",
> +			ubq->q_id, rq->tag, ubq->ios[rq->tag].flags);
> +	/* We cannot process this rq so just requeue it. */
> +	if (ublk_queue_can_use_recovery(ubq)) {
> +		blk_mq_requeue_request(rq, false);
> +		blk_mq_delay_kick_requeue_list(rq->q, UBLK_REQUEUE_DELAY_MS);

Here you needn't to kick requeue list since we know it can't make
progress. And you can do that once before deleting gendisk
or the queue is recovered.

> +	} else {
> +		blk_mq_end_request(rq, BLK_STS_IOERR);
> +	}
> +}
> +
>  static inline void __ublk_rq_task_work(struct request *req)
>  {
>  	struct ublk_queue *ubq = req->mq_hctx->driver_data;
> @@ -704,7 +719,7 @@ static inline void __ublk_rq_task_work(struct request *req)
>  	 * (2) current->flags & PF_EXITING.
>  	 */
>  	if (unlikely(current != ubq->ubq_daemon || current->flags & PF_EXITING)) {
> -		blk_mq_end_request(req, BLK_STS_IOERR);
> +		__ublk_abort_rq_in_task_work(ubq, req);
>  		mod_delayed_work(system_wq, &ub->monitor_work, 0);
>  		return;
>  	}
> @@ -779,6 +794,21 @@ static void ublk_rq_task_work_fn(struct callback_head *work)
>  	__ublk_rq_task_work(req);
>  }
>  
> +static inline blk_status_t __ublk_abort_rq(struct ublk_queue *ubq,
> +		struct request *rq)
> +{
> +	pr_devel("%s: %s q_id %d tag %d io_flags %x.\n", __func__,
> +			(ublk_queue_can_use_recovery(ubq)) ? "requeue" : "abort",
> +			ubq->q_id, rq->tag, ubq->ios[rq->tag].flags);
> +	/* We cannot process this rq so just requeue it. */
> +	if (ublk_queue_can_use_recovery(ubq)) {
> +		blk_mq_requeue_request(rq, false);
> +		blk_mq_delay_kick_requeue_list(rq->q, UBLK_REQUEUE_DELAY_MS);

Same with above.


Thanks,
Ming

