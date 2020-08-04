Return-Path: <SRS0=uCqz=BO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE86BC433DF
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 07:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D955A2086A
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 07:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijjbYU7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgHDHli (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 03:41:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35938 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726808AbgHDHlh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Aug 2020 03:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596526896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NE/UJAiKpXy/Dm/mPPJvgmpdh1gtVl1Xihj3lhbvOko=;
        b=ijjbYU7JScBtvX2Oxluuy4r6XNk/siOeq3E9NGUe/z+pUZb9eU8X9iJM8SnYE/fiKFExjZ
        o+BRMDDsDyXOHXZUjAZer68RG3UrI3UhM73wORxFelOZQEK+rkcv44MR2SR/WrtXHLOoUz
        dJCwLL5JN42nBio4541i1/YrI/LUHuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-N-tm3TnRO_aYxDnz_RU-sA-1; Tue, 04 Aug 2020 03:41:34 -0400
X-MC-Unique: N-tm3TnRO_aYxDnz_RU-sA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49D5B58;
        Tue,  4 Aug 2020 07:41:33 +0000 (UTC)
Received: from T590 (ovpn-13-169.pek2.redhat.com [10.72.13.169])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B85AB90E76;
        Tue,  4 Aug 2020 07:41:23 +0000 (UTC)
Date:   Tue, 4 Aug 2020 15:41:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH] blk-mq: insert request not through ->queue_rq into
 sw/scheduler queue
Message-ID: <20200804074119.GA1919500@T590>
References: <20200729072449.1583785-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729072449.1583785-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 29, 2020 at 03:24:49PM +0800, Ming Lei wrote:
> c616cbee97ae ("blk-mq: punt failed direct issue to dispatch list") supposed
> to add request which has been through ->queue_rq() to the hw queue dispatch
> list, however it adds request running out of budget or driver tag to hw queue
> too. This way basically bypasses request merge, and causes too many request
> dispatched to LLD, and system% is unnecessary increased.
> 
> Fixes this issue by adding request not through ->queue_rq into sw/scheduler
> queue, and this way is safe because no ->queue_rq is called on this request
> yet.
> 
> High %system can be observed on Azure storvsc device, and even soft lock
> is observed. This patch reduces %system during heavy sequential IO,
> meantime decreases soft lockup risk.
> 
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Fixes: c616cbee97ae ("blk-mq: punt failed direct issue to dispatch list")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c3856377b961..b356d4d3ca0b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2016,7 +2016,8 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  	if (bypass_insert)
>  		return BLK_STS_RESOURCE;
>  
> -	blk_mq_request_bypass_insert(rq, false, run_queue);
> +	blk_mq_sched_insert_request(rq, false, run_queue, false);
> +
>  	return BLK_STS_OK;
>  }
>  

Hello Guys,

Ping...


thanks, 
Ming

