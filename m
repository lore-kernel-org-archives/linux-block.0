Return-Path: <SRS0=z7Fj=3Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3719FC35249
	for <linux-block@archiver.kernel.org>; Wed,  5 Feb 2020 04:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE7921D7D
	for <linux-block@archiver.kernel.org>; Wed,  5 Feb 2020 04:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFfnXhfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgBEEzs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Feb 2020 23:55:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59717 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgBEEzp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Feb 2020 23:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580878543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RvwGCxc+2x79KFTn2BUwnQKkDy86bKUgsN+JhQMZL30=;
        b=hFfnXhfZmCiHf8/djTqsLGLVzru1fomzHwpyAyezFqKGjZp+iO6ObxNeiEuH0UJNVvRXAX
        8E/9gwh1Ry0fSCFudj5K0K4WidQFo69uqOEvBy4pYi8998rSxZJJz06f023BZdWB0vThU1
        mEsHTLYAxwFMyiGLNt4bTjkPPSzpOmE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-sM65a1e_NsyRmHF8gQQK9A-1; Tue, 04 Feb 2020 23:55:39 -0500
X-MC-Unique: sM65a1e_NsyRmHF8gQQK9A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A5C42F62;
        Wed,  5 Feb 2020 04:55:38 +0000 (UTC)
Received: from ming.t460p (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F8B95C1B5;
        Wed,  5 Feb 2020 04:55:30 +0000 (UTC)
Date:   Wed, 5 Feb 2020 12:55:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Salman Qazi <sqazi@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: Limit number of items taken from the I/O
 scheduler in one go
Message-ID: <20200205045526.GA15286@ming.t460p>
References: <CAKUOC8Xvxa8nixstFOdjuf7_sCZNV6EqSDxTAQZjLhvf86LESA@mail.gmail.com>
 <20200204193711.257285-1-sqazi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204193711.257285-1-sqazi@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 04, 2020 at 11:37:11AM -0800, Salman Qazi wrote:
> Flushes bypass the I/O scheduler and get added to hctx->dispatch
> in blk_mq_sched_bypass_insert.  This can happen while a kworker is running
> hctx->run_work work item and is past the point in
> blk_mq_sched_dispatch_requests where hctx->dispatch is checked.
> 
> The blk_mq_do_dispatch_sched call is not guaranteed to end in bounded time,
> because the I/O scheduler can feed an arbitrary number of commands.
> 
> Since we have only one hctx->run_work, the commands waiting in
> hctx->dispatch will wait an arbitrary length of time for run_work to be
> rerun.
> 
> A similar phenomenon exists with dispatches from the software queue.
> 
> The solution is to poll hctx->dispatch in blk_mq_do_dispatch_sched and
> blk_mq_do_dispatch_ctx and return from the run_work handler and let it
> rerun.
> 
> Signed-off-by: Salman Qazi <sqazi@google.com>
> ---
>  block/blk-mq-sched.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index ca22afd47b3d..d1b8b31bc3d4 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -97,6 +97,9 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>  		if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
>  			break;
>  
> +		if (!list_empty_careful(&hctx->dispatch))
> +			break;
> +
>  		if (!blk_mq_get_dispatch_budget(hctx))
>  			break;
>  
> @@ -140,6 +143,9 @@ static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
>  	do {
>  		struct request *rq;
>  
> +		if (!list_empty_careful(&hctx->dispatch))
> +			break;
> +
>  		if (!sbitmap_any_bit_set(&hctx->ctx_map))
>  			break;

This approach looks good, given actually we retrieved request this way in
legacy IO request path, see __elv_next_request().

However,  blk_mq_request_bypass_insert() may be run at the same time, so
this patch may cause requests stalled in scheduler queue.

How about returning if there is request available in hctx->dispatch from
the two helpers, then re-dispatch requests in blk_mq_sched_dispatch_requests()
if yes.

Thanks,
Ming

