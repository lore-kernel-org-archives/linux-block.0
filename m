Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60775C6FA82
	for <linux-block@archiver.kernel.org>; Fri, 23 Sep 2022 13:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiIWNrc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Sep 2022 09:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiIWNrb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2022 09:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB5FE7432
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 06:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663940850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0579qvX0HGpnBAQFQUK14SSdLlhSYCQSWVZG6yWXJ50=;
        b=EAwRZHOk/BH24T5heFKHUgUlwa45qRZtsaMXdgRvegRfMfwfagZVvwV4RlexB0ioXIAk7N
        jFRYHu+nk1WWMXlI86k9GNafJIZJdfWYDkmdbwiV8BfrC4z5yJW531UkGi939BltKfOwKA
        qy+6w8eQ24jGVVC9tsEoQ51N062UBsQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-rqojxbcnOWm6bP4XK5jBlQ-1; Fri, 23 Sep 2022 09:47:27 -0400
X-MC-Unique: rqojxbcnOWm6bP4XK5jBlQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22B7E3810D47;
        Fri, 23 Sep 2022 13:47:26 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C3BEA4B4013;
        Fri, 23 Sep 2022 13:47:19 +0000 (UTC)
Date:   Fri, 23 Sep 2022 21:47:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [RESEND PATCH V5 3/7] ublk_drv: requeue rqs with recovery
 feature enabled
Message-ID: <Yy244pPF+iQrorE3@T590>
References: <20220923061505.52007-1-ZiyangZhang@linux.alibaba.com>
 <20220923061505.52007-4-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923061505.52007-4-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 23, 2022 at 02:15:01PM +0800, ZiyangZhang wrote:
> With recovery feature enabled, in ublk_queue_rq or task work
> (in exit_task_work or fallback wq), we requeue rqs instead of
> ending(aborting) them. Besides, No matter recovery feature is enabled
> or disabled, we schedule monitor_work immediately.
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> ---
>  drivers/block/ublk_drv.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 05bfbaa49696..3ae13e46ece6 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -655,6 +655,16 @@ static void ubq_complete_io_cmd(struct ublk_io *io, int res)
>  
>  #define UBLK_REQUEUE_DELAY_MS	3
>  
> +static inline void __ublk_abort_rq(struct ublk_queue *ubq,
> +		struct request *rq)
> +{
> +	/* We cannot process this rq so just requeue it. */
> +	if (ublk_queue_can_use_recovery(ubq))
> +		blk_mq_requeue_request(rq, false);
> +	else
> +		blk_mq_end_request(rq, BLK_STS_IOERR);
> +}
> +
>  static inline void __ublk_rq_task_work(struct request *req)
>  {
>  	struct ublk_queue *ubq = req->mq_hctx->driver_data;
> @@ -677,7 +687,7 @@ static inline void __ublk_rq_task_work(struct request *req)
>  	 * (2) current->flags & PF_EXITING.
>  	 */
>  	if (unlikely(current != ubq->ubq_daemon || current->flags & PF_EXITING)) {
> -		blk_mq_end_request(req, BLK_STS_IOERR);
> +		__ublk_abort_rq(ubq, req);
>  		mod_delayed_work(system_wq, &ub->monitor_work, 0);
>  		return;
>  	}
> @@ -769,7 +779,8 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	if (unlikely(ubq_daemon_is_dying(ubq))) {
>   fail:
>  		mod_delayed_work(system_wq, &ubq->dev->monitor_work, 0);
> -		return BLK_STS_IOERR;
> +		__ublk_abort_rq(ubq, rq);

mod_delayed_work() can be put into __ublk_abort_rq() too, otherwise
looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


thanks,
Ming

