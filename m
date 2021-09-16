Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3FFC433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 08:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B8FF61209
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 08:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbhIPIFg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Sep 2021 04:05:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234968AbhIPIFe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Sep 2021 04:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631779453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pwNZJ4rNg2Bbq40eOmQLhg4v/7JOjLDWypf+dMjwfo4=;
        b=FEGF8teIInliDi2Jh+VJoFc+2D+1R04vQpgtA23p/D0hE9lp5nI6GJQ5hTXuNyHPiw2pE4
        TFVTCN8Mffc4ISCIAxFx9DoSegObmHYkhg/zuZ1ePfIV0EoGQuv7fhS2RXFlq52F0YnHRg
        42bLEy3s9auoQs7OkALjW04y9TfcHzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-RAYFqjLUNw6spN_5yVw8cw-1; Thu, 16 Sep 2021 04:04:12 -0400
X-MC-Unique: RAYFqjLUNw6spN_5yVw8cw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38726802928;
        Thu, 16 Sep 2021 08:04:11 +0000 (UTC)
Received: from T590 (ovpn-12-89.pek2.redhat.com [10.72.12.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A41CE60C82;
        Thu, 16 Sep 2021 08:04:04 +0000 (UTC)
Date:   Thu, 16 Sep 2021 16:04:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, hch@infradead.org,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v7 6/6] nbd: fix uaf in nbd_handle_reply()
Message-ID: <YUL6gJhaNy58Il3v@T590>
References: <20210915092010.2087371-1-yukuai3@huawei.com>
 <20210915092010.2087371-7-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915092010.2087371-7-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 15, 2021 at 05:20:10PM +0800, Yu Kuai wrote:
> There is a problem that nbd_handle_reply() might access freed request:
> 
> 1) At first, a normal io is submitted and completed with scheduler:
> 
> internel_tag = blk_mq_get_tag -> get tag from sched_tags
>  blk_mq_rq_ctx_init
>   sched_tags->rq[internel_tag] = sched_tag->static_rq[internel_tag]
> ...
> blk_mq_get_driver_tag
>  __blk_mq_get_driver_tag -> get tag from tags
>  tags->rq[tag] = sched_tag->static_rq[internel_tag]
> 
> So, both tags->rq[tag] and sched_tags->rq[internel_tag] are pointing
> to the request: sched_tags->static_rq[internal_tag]. Even if the
> io is finished.
> 
> 2) nbd server send a reply with random tag directly:
> 
> recv_work
>  nbd_handle_reply
>   blk_mq_tag_to_rq(tags, tag)
>    rq = tags->rq[tag]
> 
> 3) if the sched_tags->static_rq is freed:
> 
> blk_mq_sched_free_requests
>  blk_mq_free_rqs(q->tag_set, hctx->sched_tags, i)
>   -> step 2) access rq before clearing rq mapping
>   blk_mq_clear_rq_mapping(set, tags, hctx_idx);
>   __free_pages() -> rq is freed here
> 
> 4) Then, nbd continue to use the freed request in nbd_handle_reply
> 
> Fix the problem by get 'q_usage_counter' before blk_mq_tag_to_rq(),
> thus request is ensured not to be freed because 'q_usage_counter' is
> not zero.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/block/nbd.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 9a7bbf8ebe74..3e8b70b5d4f9 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -824,6 +824,7 @@ static void recv_work(struct work_struct *work)
>  						     work);
>  	struct nbd_device *nbd = args->nbd;
>  	struct nbd_config *config = nbd->config;
> +	struct request_queue *q = nbd->disk->queue;
>  	struct nbd_sock *nsock;
>  	struct nbd_cmd *cmd;
>  	struct request *rq;
> @@ -834,7 +835,24 @@ static void recv_work(struct work_struct *work)
>  		if (nbd_read_reply(nbd, args->index, &reply))
>  			break;
>  
> +		/*
> +		 * Grab ref of q_usage_counter can prevent request being freed
> +		 * during nbd_handle_reply(). If q_usage_counter is zero, then
> +		 * no request is inflight, which means something is wrong since
> +		 * we expect to find a request to complete here.
> +		 */

The above comment is wrong, the purpose is simply for avoiding request
pool freed, such as elevator switching won't happen once
->q_usage_counter is grabbed. So no any request UAF can be triggered
when calling into nbd_handle_reply().

> +		if (!percpu_ref_tryget(&q->q_usage_counter)) {
> +			dev_err(disk_to_dev(nbd->disk), "%s: no io inflight\n",
> +				__func__);
> +			break;
> +		}
> +
>  		cmd = nbd_handle_reply(nbd, args->index, &reply);
> +		/*
> +		 * It's safe to drop ref before request completion, inflight
> +		 * request will ensure q_usage_counter won't be zero.
> +		 */

The above comment is useless actually.

-- 
Ming

