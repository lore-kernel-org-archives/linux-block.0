Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3EAC433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2743C610E9
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244139AbhIGOaV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 10:30:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59727 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244261AbhIGOaR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Sep 2021 10:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631024950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bwKTd47i7RBa12xeUNR/6CrUBOuGg/JR9ZR1J/Ypibo=;
        b=bhXIqgjp2K/p/1iv4QVkP5LE21Amo/f8CvaZunEZjcFQ95NDH5Nbszz1kTGvXwhlZhJLdq
        l9pSgHxZvTqFCzqdqicJHhlQyD42k1PM2ECtI+aQ61PIiItTmcZeTYsNU1wyKDvs2H4jvo
        RjjUz7lztlL6mE1poZfUPCUyhpWweMA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-IBQW7cj3MASWVxR6N_F0gg-1; Tue, 07 Sep 2021 10:29:09 -0400
X-MC-Unique: IBQW7cj3MASWVxR6N_F0gg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39976824FAD;
        Tue,  7 Sep 2021 14:29:08 +0000 (UTC)
Received: from T590 (ovpn-12-93.pek2.redhat.com [10.72.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 03BE710013D7;
        Tue,  7 Sep 2021 14:29:00 +0000 (UTC)
Date:   Tue, 7 Sep 2021 22:29:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] blk-mq: don't call callbacks for requests that
 bypassed the scheduler
Message-ID: <YTd3LRI8A7K+Ctin@T590>
References: <20210907142145.112096-1-Niklas.Cassel@wdc.com>
 <20210907142145.112096-2-Niklas.Cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907142145.112096-2-Niklas.Cassel@wdc.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 07, 2021 at 02:21:55PM +0000, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> Currently, __blk_mq_alloc_request() (via blk_mq_rq_ctx_init()) calls the
> I/O scheduler callback e->type->ops.prepare_request(), which will set
> RQF_ELVPRIV, even though passthrough (and flush) requests will later
> bypass the I/O scheduler in blk_mq_submit_bio().
> 
> Later, blk_mq_free_request() checks if the RQF_ELVPRIV flag is set,
> if it is, the e->type->ops.finish_request() I/O scheduler callback
> will be called.
> 
> i.e., the prepare_request and finish_request I/O scheduler callbacks
> will be called for requests which were never inserted to the I/O
> scheduler.
> 
> Fix this by not calling e->type->ops.prepare_request(), nor setting
> the RQF_ELVPRIV flag for passthrough requests.
> Since the RQF_ELVPRIV flag will not get set for passthrough requests,
> e->type->ops.prepare_request() will no longer get called for
> passthrough requests which were never inserted to the I/O scheduler.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>  block/blk-mq.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 65d3a63aecc6..0816af125059 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -328,7 +328,12 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>  	data->ctx->rq_dispatched[op_is_sync(data->cmd_flags)]++;
>  	refcount_set(&rq->ref, 1);
>  
> -	if (!op_is_flush(data->cmd_flags)) {
> +	/*
> +	 * Flush/passthrough requests are special and go directly to the
> +	 * dispatch list, bypassing the scheduler.
> +	 */
> +	if (!op_is_flush(data->cmd_flags) &&
> +	    !blk_op_is_passthrough(data->cmd_flags)) {

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

