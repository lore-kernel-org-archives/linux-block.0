Return-Path: <SRS0=LVe3=A4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5CEC433E0
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 08:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C554B2074B
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 08:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RD6Zn3x6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgGQIGc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:06:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52112 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726166AbgGQIGb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jul 2020 04:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594973190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SVn45F9fKoHzeiQMUcE/XhzFBYwoC9Z8im+L0XQIiq0=;
        b=RD6Zn3x6WFM2UVnn/maUveIT9bCtfy7UQPCFZjv1BIsvcp1O9ZlCCYKOi9uqiBvQTxSW31
        FA4bczFSaxHCOdRt13YdGKiXN9oq1Yypxu4qGOwFC6aJlofjY4ed28y8V1k4yOFo5EcVfj
        MawqrZ1ZCr/7ML5eOSnLcv9B+vpjmiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-acOrZOYROuKe-GsXIsNmSQ-1; Fri, 17 Jul 2020 04:06:28 -0400
X-MC-Unique: acOrZOYROuKe-GsXIsNmSQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80F201DE1;
        Fri, 17 Jul 2020 08:06:27 +0000 (UTC)
Received: from T590 (ovpn-13-1.pek2.redhat.com [10.72.13.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 590E661982;
        Fri, 17 Jul 2020 08:06:20 +0000 (UTC)
Date:   Fri, 17 Jul 2020 16:06:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org,
        hch@lst.de
Subject: Re: [RFC PATCH] block: defer flush request no matter whether we have
 elevator
Message-ID: <20200717080616.GB670561@T590>
References: <20200716065201.3213045-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716065201.3213045-1-yuyufen@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 16, 2020 at 02:52:01AM -0400, Yufen Yu wrote:
> Commit 7520872c0cf4 ("block: don't defer flushes on blk-mq + scheduling")
> tried to fix deadlock for cycled wait between flush requests and data
> request into flush_data_in_flight. The former holded all driver tags
> and wait for data request completion, but the latter can not complete
> for waiting free driver tags.
> 
> After commit 923218f6166a ("blk-mq: don't allocate driver tag upfront
> for flush rq"), flush requests will not get driver tag before queuing
> into flush queue.
> 
> * With elevator, flush request just get sched_tags before inserting
>   flush queue. It will not get driver tag until issue them to driver.
>   data request on list fq->flush_data_in_flight will complete in
>   the end.
> 
> * Without elevator, each flush request will get a driver tag when
>   allocate request. Then data request on fq->flush_data_in_flight
>   don't worry about lacking driver tag.
> 
> In both of these cases, cycled wait cannot be true. So we may allow
> to defer flush request.
> 
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>  block/blk-flush.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 15ae0155ec07..24c208d21793 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -286,13 +286,8 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
>  	if (fq->flush_pending_idx != fq->flush_running_idx || list_empty(pending))
>  		return;
>  
> -	/* C2 and C3
> -	 *
> -	 * For blk-mq + scheduling, we can risk having all driver tags
> -	 * assigned to empty flushes, and we deadlock if we are expecting
> -	 * other requests to make progress. Don't defer for that case.
> -	 */
> -	if (!list_empty(&fq->flush_data_in_flight) && q->elevator &&
> +	/* C2 and C3 */
> +	if (!list_empty(&fq->flush_data_in_flight) &&
>  	    time_before(jiffies,
>  			fq->flush_pending_since + FLUSH_PENDING_TIMEOUT))
>  		return;
> -- 
> 2.25.4
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

