Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13064C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 01:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15AF2082F
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 01:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15AF2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeK1Miy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 07:38:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbeK1Miy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 07:38:54 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 008A33082DDC;
        Wed, 28 Nov 2018 01:39:06 +0000 (UTC)
Received: from ming.t460p (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 782C96266E;
        Wed, 28 Nov 2018 01:39:00 +0000 (UTC)
Date:   Wed, 28 Nov 2018 09:38:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/8] blk-mq: add mq_ops->commit_rqs()
Message-ID: <20181128013852.GD11128@ming.t460p>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126163556.5181-4-axboe@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 28 Nov 2018 01:39:06 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 09:35:51AM -0700, Jens Axboe wrote:
> blk-mq passes information to the hardware about any given request being
> the last that we will issue in this sequence. The point is that hardware
> can defer costly doorbell type writes to the last request. But if we run
> into errors issuing a sequence of requests, we may never send the request
> with bd->last == true set. For that case, we need a hook that tells the
> hardware that nothing else is coming right now.
> 
> For failures returned by the drivers ->queue_rq() hook, the driver is
> responsible for flushing pending requests, if it uses bd->last to
> optimize that part. This works like before, no changes there.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  include/linux/blk-mq.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index ca0520ca6437..1fd139b65a6e 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -117,6 +117,7 @@ struct blk_mq_queue_data {
>  
>  typedef blk_status_t (queue_rq_fn)(struct blk_mq_hw_ctx *,
>  		const struct blk_mq_queue_data *);
> +typedef void (commit_rqs_fn)(struct blk_mq_hw_ctx *);
>  /* takes rq->cmd_flags as input, returns a hardware type index */
>  typedef int (rq_flags_to_type_fn)(struct request_queue *, unsigned int);
>  typedef bool (get_budget_fn)(struct blk_mq_hw_ctx *);
> @@ -144,6 +145,15 @@ struct blk_mq_ops {
>  	 */
>  	queue_rq_fn		*queue_rq;
>  
> +	/*
> +	 * If a driver uses bd->last to judge when to submit requests to
> +	 * hardware, it must define this function. In case of errors that
> +	 * make us stop issuing further requests, this hook serves the
> +	 * purpose of kicking the hardware (which the last request otherwise
> +	 * would have done).
> +	 */
> +	commit_rqs_fn		*commit_rqs;
> +
>  	/*
>  	 * Return a queue map type for the given request/bio flags
>  	 */
> -- 
> 2.17.1
>

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
