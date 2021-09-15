Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8159C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 08:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B10D360ED8
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 08:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbhIOIaW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:30:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52523 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236761AbhIOIaV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 04:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631694543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=//B91axD0ypI2eVxOXRXcHc2jjqxoBa5PfgCorhP02o=;
        b=hIL3kD5kGgZZuPsfYYlEBQluK4G65Hv5SfyH0sOHS9JIfhzxK8ELMj0D111VwiJwtVjm7H
        QO5tsj5BNpOa+KCXYX5btZP/quPyQzEtVF1l6zetnzcSteYSKyGEW30AVXjIC4Uwb0A/LM
        SJeZIjsWVNSwpZdX4ahIUBB1kSCeQ1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-x4oz8l3SOWW74nl0TrNguA-1; Wed, 15 Sep 2021 04:28:58 -0400
X-MC-Unique: x4oz8l3SOWW74nl0TrNguA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09197DF8A7;
        Wed, 15 Sep 2021 08:28:56 +0000 (UTC)
Received: from T590 (ovpn-12-59.pek2.redhat.com [10.72.12.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 81F24196E2;
        Wed, 15 Sep 2021 08:28:48 +0000 (UTC)
Date:   Wed, 15 Sep 2021 16:28:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nbd@other.debian.org, yi.zhang@huawei.com
Subject: Re: [PATCH v6 6/6] nbd: fix uaf in nbd_handle_reply()
Message-ID: <YUGuykbPt+Oxt2nk@T590>
References: <20210915081537.1684327-1-yukuai3@huawei.com>
 <20210915081537.1684327-7-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915081537.1684327-7-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 15, 2021 at 04:15:37PM +0800, Yu Kuai wrote:
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
>  block/blk-core.c    |  1 +
>  drivers/block/nbd.c | 19 ++++++++++++++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 5454db2fa263..2008e6903166 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -489,6 +489,7 @@ void blk_queue_exit(struct request_queue *q)
>  {
>  	percpu_ref_put(&q->q_usage_counter);
>  }
> +EXPORT_SYMBOL(blk_queue_exit);
>  
>  static void blk_queue_usage_counter_release(struct percpu_ref *ref)
>  {
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 9a7bbf8ebe74..f065afcc7586 100644
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
> @@ -834,13 +835,29 @@ static void recv_work(struct work_struct *work)
>  		if (nbd_read_reply(nbd, args->index, &reply))
>  			break;
>  
> +		/*
> +		 * Get q_usage_counter can prevent accessing freed request
> +		 * through blk_mq_tag_to_rq() in nbd_handle_reply(). If
> +		 * q_usage_counter is zero, then no request is inflight, which
> +		 * means something is wrong since we expect to find a request to
> +		 * complete here.
> +		 */
> +		if (!percpu_ref_tryget(&q->q_usage_counter)) {
> +			dev_err(disk_to_dev(nbd->disk), "%s: no io inflight\n",
> +				__func__);
> +			break;
> +		}
> +
>  		cmd = nbd_handle_reply(nbd, args->index, &reply);
> -		if (IS_ERR(cmd))
> +		if (IS_ERR(cmd)) {
> +			blk_queue_exit(q);
>  			break;
> +		}
>  
>  		rq = blk_mq_rq_from_pdu(cmd);
>  		if (likely(!blk_should_fake_timeout(rq->q)))
>  			blk_mq_complete_request(rq);
> +		blk_queue_exit(q);

You can simply call percpu_ref_put() directly just like what scsi_end_request()
is doing.

-- 
Ming

