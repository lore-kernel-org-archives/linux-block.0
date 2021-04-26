Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E072C433ED
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 06:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E63E061249
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 06:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhDZGff (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 02:35:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53294 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231616AbhDZGff (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 02:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619418894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b0//KiwrXJCAQEbZh6v7UYUMFjngDAQ0xEhOxI4LuvE=;
        b=D4NhT1sQJiOB/+JYbY5QBRBnEcQk97lQRCNtqDeatpDiQ1AdKU1KK15a0GRUtYaWSFb0uO
        3Tb+9wzBiKn2fSkMxT1aPr1F6j+275gwFtBtMZ0f5iNuNZhLmdX72nXxT3jM8jVahnrOAe
        J/GDAaqcE36sekoi0DO1mnfHYlDx1Tc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-RMzoaL0fPCCLtl3TPtgv4Q-1; Mon, 26 Apr 2021 02:34:52 -0400
X-MC-Unique: RMzoaL0fPCCLtl3TPtgv4Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A63BC343AA;
        Mon, 26 Apr 2021 06:34:50 +0000 (UTC)
Received: from T590 (ovpn-13-194.pek2.redhat.com [10.72.13.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6748D61F38;
        Mon, 26 Apr 2021 06:34:43 +0000 (UTC)
Date:   Mon, 26 Apr 2021 14:34:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv2 1/5] block: support polling through blk_execute_rq
Message-ID: <YIZfCBYvH1hm+QM4@T590>
References: <20210423220558.40764-1-kbusch@kernel.org>
 <20210423220558.40764-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423220558.40764-2-kbusch@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 23, 2021 at 03:05:54PM -0700, Keith Busch wrote:
> Poll for completions if the request's hctx is a polling type.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-exec.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-exec.c b/block/blk-exec.c
> index beae70a0e5e5..b960ad187ba5 100644
> --- a/block/blk-exec.c
> +++ b/block/blk-exec.c
> @@ -63,6 +63,11 @@ void blk_execute_rq_nowait(struct gendisk *bd_disk, struct request *rq,
>  }
>  EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
>  
> +static bool blk_rq_is_poll(struct request *rq)
> +{
> +	return rq->mq_hctx && rq->mq_hctx->type == HCTX_TYPE_POLL;
> +}
> +
>  /**
>   * blk_execute_rq - insert a request into queue for execution
>   * @bd_disk:	matching gendisk
> @@ -83,7 +88,12 @@ void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
>  
>  	/* Prevent hang_check timer from firing at us during very long I/O */
>  	hang_check = sysctl_hung_task_timeout_secs;
> -	if (hang_check)
> +	if (blk_rq_is_poll(rq)) {
> +		do {
> +			blk_poll(rq->q, request_to_qc_t(rq->mq_hctx, rq), true);
> +			cond_resched();
> +		} while (!completion_done(&wait));
> +	} else if (hang_check)
>  		while (!wait_for_completion_io_timeout(&wait, hang_check * (HZ/2)));
>  	else
>  		wait_for_completion_io(&wait);
> -- 
> 2.25.4
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

